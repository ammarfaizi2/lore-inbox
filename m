Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311339AbSCLUmK>; Tue, 12 Mar 2002 15:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311340AbSCLUmA>; Tue, 12 Mar 2002 15:42:00 -0500
Received: from air-2.osdl.org ([65.201.151.6]:29321 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S311339AbSCLUlm>;
	Tue, 12 Mar 2002 15:41:42 -0500
Date: Tue, 12 Mar 2002 12:40:01 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'Mario 'BitKoenig' Holbe'" <Mario.Holbe@RZ.TU-Ilmenau.DE>,
        Pavel Machek <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch] ACPI: kbd-pw-on/WOL don't work anymore since 2.4.14
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7CDB@orsmsx111.jf.intel.com>
Message-ID: <Pine.LNX.4.33.0203121234360.3237-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Mar 2002, Grover, Andrew wrote:

> > From: Mario 'BitKoenig' Holbe [mailto:Mario.Holbe@RZ.TU-Ilmenau.DE]
> > However, if someone of the ACPI developers or someone of the
> > patch-acceptors (:)) tells me 'do it, we'll patch it in', I'll do
> > it.
> > If it has no chance to get in, I wont do it - for me myself, my
> > patch is quite enough :)
> 
> Basically we have to disable non-wake GPEs prior to sleeping - I agree with
> Pavel that this should not be a config option. The real problem is that the
> keyboard GPE should be flagged as a wake GPE, but it isn't yet.
> 
> What needs to happen is, when we are entering a sleep state, we need to
> evaluate _PRW and _PSW objects for devices, and take the appropriate action
> - I would bet that a result of doing this would be that keyboard (WOL too?
> maybe) would be properly flagged as a wake device, so the call to that
> function would but turn off its GPE bit.

It seems like this would ideally be specified in the config file for the 
power management agent. So, before the transition to sleep began, the 
agent would enable those devices to wake the system (probably by writing a 
value to a driverfs file). 

The only thing is that you probably want all devices of a particular class 
to wake a system - like all keyboards or all net devices. I don't know 
what the config file format for ospmd looks like, but it might articulated 
like:

/* devices to wake the system when we go to sleep */
wake {
	keyboard
	network
	mouse
}

Right?

	-pat

