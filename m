Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932678AbWAGAJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbWAGAJI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbWAGAJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:09:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38561 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932678AbWAGAJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:09:06 -0500
Date: Sat, 7 Jan 2006 01:08:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060107000826.GC20399@elf.ucw.cz>
References: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net> <Pine.LNX.4.44L0.0601061035090.5127-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L0.0601061035090.5127-100000@iolanthe.rowland.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 06-01-06 10:42:24, Alan Stern wrote:
> On Thu, 5 Jan 2006, Patrick Mochel wrote:
> > On Fri, 6 Jan 2006, Pavel Machek wrote:
> > > On 05-01-06 16:04:07, Patrick Mochel wrote:
> > 
> > > > A better point, and one that would actually be useful, would be to remove
> > > > the file altogether. Let Dominik export a power file, with complete
> > > > control over the values, for each pcmcia device. Then you never have to
> > > > worry about breaking PCMCIA again.
> > >
> > > Fine with me.
> > 
> > ACK, you beat me to it.
> > 
> > And, appended is a patch to export PM controls for PCI devices. The file
> > "pm_possible_states" exports the states a device supports, and "pm_state"
> > exports the current state (and provides the interface for entering a
> > state).
> > 
> > Eventually, some drivers will want to fix up those values so that it can
> > mask of states that it doesn't support, as well as offer possible device-
> > specific states.
> > 
> > What's interesting is that with this patch, I can see that two more
> > devices on my system support D1 and D2 -- the cardbus controllers, which
> > are actually bridges whose PM capabilities aren't exported via lspci.
> 
> This trend is extremely alarming!!

It scares me a bit, too. 

> It's a very bad idea to make bus drivers export and manage the syfs power 
> interface.  It means that lots of code gets repeated and different buses 
> do things differently.
> 
> Already we have PCI exporting "pm_possible_states" and "pm_state" while 
> PCMCIA exports "suspend".  How many other different schemes are going to 
> crop up?  How much bus-specific information will have to be built into a 
> user utility?
> 
> If possible states are represented as arrays of pointers to strings, then 
> the PM core can easily supply the sysfs interface.  If Patrick's patch 
> were re-written so that the sysfs interface were moved into the PM core, 
> leaving only the PCI-specific portions in the PCI drivers, I would be much 
> happier.  This would also mean that Dominik's patch could be replaced by 
> something a good deal smaller.
> 
> And it wouldn't hurt to add some mechanism for indicating which of the 
> possible states is the generic "suspend" state (usually D3 for PCI 
> devices, but not necessarily).

I think we should start with string-based interface, with just two
states ("on" and "off"). That is easily extensible into future, and
suits current PCMCIA nicely. It also allows us to experiment with PCI
power management... I can cook up a patch, but it will be simple
reintroduction of .../power file under different name.
								Pavel
-- 
Thanks, Sharp!
