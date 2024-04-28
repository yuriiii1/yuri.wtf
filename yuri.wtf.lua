local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
Library:SetWatermark("yuri.wtf")

local Window = Library:CreateWindow("yuri.wtf | undetected")

local GeneralTab = Window:AddTab("Aim")
local MainBOX = GeneralTab:AddLeftTabbox("Main") do
    local Main = MainBOX:AddTab("Main")
	Main:AddButton({
		Text = "Aimbot",
		Func = function()
			local Camera = workspace.CurrentCamera
			local Players = game:GetService("Players")
			local RunService = game:GetService("RunService")
			local UserInputService = game:GetService("UserInputService")
			local TweenService = game:GetService("TweenService")
			local LocalPlayer = Players.LocalPlayer
			local Holding = false
		
			_G.AimbotEnabled = true
			_G.TeamCheck = false -- If set to true then the script would only lock your aim at enemy team members.
			_G.AimPart = "Head" -- Where the aimbot script would lock at.
			_G.Sensitivity = 0 -- How many seconds it takes for the aimbot script to officially lock onto the target's aimpart.
		
			_G.CircleSides = 64 -- How many sides the FOV circle would have.
			_G.CircleColor = Color3.fromRGB(255, 255, 255) -- (RGB) Color that the FOV circle would appear as.
			_G.CircleTransparency = 0.7 -- Transparency of the circle.
			_G.CircleRadius = 80 -- The radius of the circle / FOV.
			_G.CircleFilled = false -- Determines whether or not the circle is filled.
			_G.CircleVisible = true -- Determines whether or not the circle is visible.
			_G.CircleThickness = 0 -- The thickness of the circle.
		
			local FOVCircle = Drawing.new("Circle")
			FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
			FOVCircle.Radius = _G.CircleRadius
			FOVCircle.Filled = _G.CircleFilled
			FOVCircle.Color = _G.CircleColor
			FOVCircle.Visible = _G.CircleVisible
			FOVCircle.Radius = _G.CircleRadius
			FOVCircle.Transparency = _G.CircleTransparency
			FOVCircle.NumSides = _G.CircleSides
			FOVCircle.Thickness = _G.CircleThickness
		
			local function GetClosestPlayer()
				local MaximumDistance = _G.CircleRadius
				local Target = nil
		
				for _, v in next, Players:GetPlayers() do
					if v.Name ~= LocalPlayer.Name then
						if _G.TeamCheck == true then
							if v.Team ~= LocalPlayer.Team then
								if v.Character ~= nil then
									if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
										if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
											local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
											local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
		
											if VectorDistance < MaximumDistance then
												Target = v
											end
										end
									end
								end
							end
						else
							if v.Character ~= nil then
								if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
									if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
										local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
										local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
		
										if VectorDistance < MaximumDistance then
											Target = v
										end
									end
								end
							end
						end
					end
				end
		
				return Target
			end
		
			UserInputService.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton2 then
					Holding = true
				end
			end)
		
			UserInputService.InputEnded:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton2 then
					Holding = false
				end
			end)
		
			RunService.RenderStepped:Connect(function()
				FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
				FOVCircle.Radius = _G.CircleRadius
				FOVCircle.Filled = _G.CircleFilled
				FOVCircle.Color = _G.CircleColor
				FOVCircle.Visible = _G.CircleVisible
				FOVCircle.Radius = _G.CircleRadius
				FOVCircle.Transparency = _G.CircleTransparency
				FOVCircle.NumSides = _G.CircleSides
				FOVCircle.Thickness = _G.CircleThickness
		
				if Holding == true and _G.AimbotEnabled == true then
					TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
				end
			end)
		end
	})

	Main:AddSlider("FovCircle",{
		Text = "FovSize",
		Default = 60,
		Min = 20,
		Max = 100,
		Rounding = 1,
		Compact = false,
		
		Callback = function(Value)
			_G.CircleRadius = Value
		end
	})

	Main:AddDropdown('AimPart', {
		Values = {'Head', 'HumanoidRootPart'},
		Default = 1, -- number index of the value / string
		Multi = false, -- true / false, allows multiple choices to be selected
	
		Text = 'Aim Part',
		Tooltip = 'Choose the part that the aimbot locks onto.', -- Information shown when you hover over the dropdown
	
		Callback = function(Value)
			_G.AimPart = Value
		end
	})
end

local visualsTab = Window:AddTab("Visuals")
local visualBox = visualsTab:AddLeftTabbox("Visuals") do
	local visuals = visualBox:AddTab("Visuals")

	local ESPButton = visuals:AddButton({
		Text = "ESP",
		Func = function()
				--//Toggle\\--
	getgenv().Toggle = true -- This toggles the esp, turning it to false will turn it off
	getgenv().TC = false -- This toggles team check, turning it on will turn on team check
	local PlayerName = "Name" -- You can decide if you want the Player's name to be a display name which is "DisplayName", or username which is "Name"

	--//Variables\\--
	local P = game:GetService("Players")
	local LP = P.LocalPlayer

	--//Debounce\\--
	local DB = false

	--//Loop\\--
	while task.wait() do
		if not getgenv().Toggle then
			break
		end
		if DB then 
			return 
		end
		DB = true

		pcall(function()
			for i,v in pairs(P:GetChildren()) do
				if v:IsA("Player") then
					if v ~= LP then
						if v.Character then

							local pos = math.floor(((LP.Character:FindFirstChild("HumanoidRootPart")).Position - (v.Character:FindFirstChild("HumanoidRootPart")).Position).magnitude)
							-- Credits to Infinite Yield for this part (pos) ^^^^^^

							if v.Character:FindFirstChild("Totally NOT Esp") == nil and v.Character:FindFirstChild("Icon") == nil and getgenv().TC == false then
								--//ESP-Highlight\\--
								local ESP = Instance.new("Highlight", v.Character)

								ESP.Name = "Totally NOT Esp"
								ESP.Adornee = v.Character
								ESP.Archivable = true
								ESP.Enabled = true
								ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
								ESP.FillColor = v.TeamColor.Color
								ESP.FillTransparency = 0.5
								ESP.OutlineColor = Color3.fromRGB(255, 255, 255)
								ESP.OutlineTransparency = 0

								--//ESP-Text\\--
								local Icon = Instance.new("BillboardGui", v.Character)
								local ESPText = Instance.new("TextLabel")

								Icon.Name = "Icon"
								Icon.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
								Icon.Active = true
								Icon.AlwaysOnTop = true
								Icon.ExtentsOffset = Vector3.new(0, 1, 0)
								Icon.LightInfluence = 1.000
								Icon.Size = UDim2.new(0, 800, 0, 50)

								ESPText.Name = "ESP Text"
								ESPText.Parent = Icon
								ESPText.BackgroundColor3 = v.TeamColor.Color
								ESPText.BackgroundTransparency = 1.000
								ESPText.Size = UDim2.new(0, 800, 0, 50)
								ESPText.Font = Enum.Font.Arial
								ESPText.Text = v[PlayerName].." | Distance: "..pos
								ESPText.TextColor3 = v.TeamColor.Color
								ESPText.TextSize = 18.000
								ESPText.TextWrapped = true
							else
								if v.TeamColor ~= LP.TeamColor and v.Character:FindFirstChild("Totally NOT Esp") == nil and v.Character:FindFirstChild("Icon") == nil and getgenv().TC == true then
									--//ESP-Highlight\\--
									local ESP = Instance.new("Highlight", v.Character)

									ESP.Name = "Totally NOT Esp"
									ESP.Adornee = v.Character
									ESP.Archivable = true
									ESP.Enabled = true
									ESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
									ESP.FillColor = v.TeamColor.Color
									ESP.FillTransparency = 0.5
									ESP.OutlineColor = Color3.fromRGB(255, 255, 255)
									ESP.OutlineTransparency = 0

									--//ESP-Text\\--
									local Icon = Instance.new("BillboardGui", v.Character)
									local ESPText = Instance.new("TextLabel")

									Icon.Name = "Icon"
									Icon.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
									Icon.Active = true
									Icon.AlwaysOnTop = true
									Icon.ExtentsOffset = Vector3.new(0, 1, 0)
									Icon.LightInfluence = 1.000
									Icon.Size = UDim2.new(0, 800, 0, 50)

									ESPText.Name = "ESP Text"
									ESPText.Parent = Icon
									ESPText.BackgroundColor3 = v.TeamColor.Color
									ESPText.BackgroundTransparency = 1.000
									ESPText.Size = UDim2.new(0, 800, 0, 50)
									ESPText.Font = Enum.Font.SciFi
									ESPText.Text = v[PlayerName].." | Distance: "..pos
									ESPText.TextColor3 = v.TeamColor.Color
									ESPText.TextSize = 18.000
									ESPText.TextWrapped = true
								else
									if not v.Character:FindFirstChild("Totally NOT Esp").FillColor == v.TeamColor.Color and not v.Character:FindFirstChild("Icon").TextColor3 == v.TeamColor.Color then
										v.Character:FindFirstChild("Totally NOT Esp").FillColor = v.TeamColor.Color
										v.Character:FindFirstChild("Icon").TextColor3 = v.TeamColor.Color
									else
										if v.Character:FindFirstChild("Totally NOT Esp").Enabled == false and v.Character:FindFirstChild("Icon").Enabled == false then
											v.Character:FindFirstChild("Totally NOT Esp").Enabled = true
											v.Character:FindFirstChild("Icon").Enabled = true
										else
											if v.Character:FindFirstChild("Icon") then
												v.Character:FindFirstChild("Icon")["ESP Text"].Text = v[PlayerName].." | Distance: "..pos
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end)

		wait()

		DB = false
	end
		end,
	})
end

local localTab = Window:AddTab("Local")
local localBox = localTab:AddLeftTabbox("Local") do
	local locals = localBox:AddTab("Local")

	local FOVSlider = locals:AddSlider("FOVSlider",{
		Text = "FOV",
		Default = 70,
		Min = 70,
		Max = 120,
		Rounding = 1,
		Compact = false,

		Callback = function(Value)
			game.Workspace.CurrentCamera.FieldOfView = Value
		end
	})

	local WalkspeedSlider = locals:AddSlider("WalkspeedSlider",{
		Text = "Walkspeed",
		Default = 16,
		Min = 16,
		Max = 500,
		Rounding = 1,
		Compact = false,

		Callback = function(Value)
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
		end
	})

	local InfJump = locals:AddButton({
		Text = "Infinite Jump",
		Func = function()
			game:GetService("UserInputService").JumpRequest:Connect(function()
				game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):ChangeState("Jumping")
			end)
		end
	})

	local PlayerTP = locals:AddInput("PlayerTP",{
		Default = "",
		Numeric = false,
		Finished = true,

		Text = "Player Teleportation",
		Tooltip = "Input a player's username to teleport to them.",

		Placeholder = "Username",

		Callback = function(Value)
			local TweenService = game:GetService("TweenService")
			local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		
			local targetPlayer = Value
			if targetPlayer then
				local targetRoot = game.Players[targetPlayer].Character.HumanoidRootPart
				if targetRoot then
					local tweenInfo = TweenInfo.new(
						3,
						Enum.EasingStyle.Linear,
						Enum.EasingDirection.InOut,
						0,
						false,
						0
					)
		
					local tween = TweenService:Create(root, tweenInfo, {CFrame = targetRoot.CFrame})
					tween:Play()
				else
					warn("Target player does not have a HumanoidRootPart")
				end
			else
				warn("Player not found")
			end
		end
	})
end