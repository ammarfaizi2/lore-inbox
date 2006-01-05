Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWAEVPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWAEVPN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWAEVPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:15:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63685 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932208AbWAEVPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:15:11 -0500
Date: Thu, 5 Jan 2006 22:14:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Scott E. Preece" <preece@motorola.com>, akpm@osdl.org,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060105211446.GD2095@elf.ucw.cz>
References: <200601051516.k05FGC5d023781@olwen.urbana.css.mot.com> <Pine.LNX.4.44L0.0601051136230.5520-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L0.0601051136230.5520-100000@iolanthe.rowland.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 05-01-06 11:41:34, Alan Stern wrote:
> On Thu, 5 Jan 2006, Scott E. Preece wrote:
> 
> > My inclination would be to have the sysfs interface know generic terms,
> > with the implementation mapping them to device-specific terms. It ought
> > to be possible to build portable tools that don't have to know about
> > device-specific states and have the device interfaces (in sysfs) do the
> > necessary translation.
> > 
> > However, I also think there is value in having the sysfs interface
> > recognize the device-specific values as well, so that device-specific
> > tools can also be written (offering the option of taking advantage of
> > special capabilities of a particular device).
> 
> Yes, that was part of my point.
> 
> > | > It would be good to make the details available so that they are there when
> > | > needed.  For instance, we might export "D0", "on", "D1", "D2", "D3", and
> > | > "suspend", treating "on" as a synonym for "D0" and "suspend" as a synonym
> > | > for "D3".
> > | 
> > | Why to make it this complex?
> > | 
> > | I do not think there's any confusion possible. "on" always corresponds
> > | to "D0", and "suspend" is "D3". Anyone who knows what "D2" means,
> > | should know that, too...
> 
> Not necessarily.  For instance, a particular driver might want to map 
> "suspend" to D1 instead of to D3.

Ok, lets change that to "on" and "off". That way, hopefully all the
drivers will agree that "off" means as low Dstate as possible.
 
> Given that "on" and "suspend" are generic names and not actual states (at 
> least, not for PCI devices and presumably not for others as well), I think 
> it makes sense to treat them specially.
> 
> And it's not all that complex.  Certainly no more complex than forcing
> userspace tools to use {"on", "D1, "D2", "suspend"} instead of the
> much-more-logical {"D0", "D1", "D2", "D3"}.

It is not much more logical. First, noone really needs D1 and
D2. Plus, people want to turn their devices on and off, and don't want
and should not have to care about details like D1.
							Pavel
-- 
Thanks, Sharp!
