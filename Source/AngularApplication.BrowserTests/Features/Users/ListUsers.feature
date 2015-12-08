﻿@BrowserTest
Feature: ListUsers

Background: 
	Given the test user is logged in
	And an organization exists with the name 'Organisaatio A'
	And the user is starting to add a new user
	When last name 'Testaaja' is typed
	And first name 'Teppo' is typed
	And email address 'teppo@testaaja.com' is typed
	And password 'password' is typed
	And password 'password' is typed again
	And organization 'Organisaatio A' is selected
	And role 'Ylläpitäjä' is selected
	And the user is saved
	
Scenario: New user is listed when its own organization is selected
	When user navigates to users list page
	And organization 'Organisaatio A' is selected from drop down list
	Then the list should contain the new user 'teppo@testaaja.com'

Scenario: New user is not listed when other organization is selected
	When user navigates to users list page
	And organization 'Testkäyttäjän organisaatio' is selected from drop down list
	Then the list should not contain the new user 'teppo@testaaja.com'

Scenario: organization admin user cannot change organization in user list page
	Given the user is starting to add a new user
	And last name 'Koeistaja' is typed
	And first name 'Keijo' is typed
	And email address 'keijo@koeistaja.com' is typed
	And password 'password' is typed
	And password 'password' is typed again
	And organization 'Organisaatio A' is selected
	And role 'Organisaation pääkäyttäjä' is selected
	And the user is saved
	And current user logs out
	Given the user 'keijo@koeistaja.com' / 'password' is logged in
	And user navigates to users list page
	Then page should not contain organization drop down element
	And the list should contain the new user 'keijo@koeistaja.com'
	
Scenario: User without user maintanance permission cannot see add user button
	Given current user logs out 
	And the user 'teppo@testaaja.com' / 'password' is logged in
	And user navigates to users list page
	Then page should not contain add new user button


