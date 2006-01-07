Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752326AbWAGPYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbWAGPYw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 10:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbWAGPYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 10:24:52 -0500
Received: from mx1.rowland.org ([192.131.102.7]:19466 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1750767AbWAGPYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 10:24:51 -0500
Date: Sat, 7 Jan 2006 10:24:49 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Adam Belay <ambx1@neo.rr.com>
cc: Patrick Mochel <mochel@digitalimplant.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
 interface
In-Reply-To: <20060107074146.GC3184@neo.rr.com>
Message-ID: <Pine.LNX.4.44L0.0601071016160.8527-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jan 2006, Adam Belay wrote:

> In short I'm suggesting the following:
> 
> 1.) Every bus and device has its own unique PM mechanisms and specifications.
> Representing this in a single unified model of any sort is nearly impossible.
> Therefore, it may be best to allow each bus to define its own PM
> infustructure and sysfs files (perhaps in a way similar to Pat's recent
> patch).

Bus and/or driver.  However even though the mechanisms and specifications 
are all different, that doesn't mean the user interfaces have to be 
different.  Using simple character string names (like Pat did and like I 
did several months ago) should be general enough to work everywhere.

Similarly, the sysfs files themselves should be uniform (even if their
contents aren't).  The core should provide the user interface mechanism
and infrastructure, while leaving it up to the bus and the device drivers
to interpret the meanings of the strings.

> 2.) Device drivers on the other hand exist at a more abstract level and,
> as a result, we have greater flexability and more options.  Therefore, I
> think this is an excellent place to define power states and driver core PM
> infustructure.

It's a good place to define and implement power states.  But the driver 
core PM infrastructure obviously should be defined and implemented in the 
core, not in the drivers.

> 3.) System suspend and runtime power management are not even close to
> similar.  Trying to use the same ->suspend and ->resume API is
> ridiculious because it prevents intermediate power states and doesn't
> properly perpare devices and device classes for a runtime environment.
> Therefore, I'm in favor of a seperate interface tailored specifically for
> runtime power management.

Personally I don't care much one way or another.  The APIs can be kept 
separate or overlapped somehow; it doesn't really matter.  Just so long as 
it's done the same way in all drivers and in the core.

> 4.) If we're going to make any meaningful progress, we need to also
> focus on device classes and class orriented power policy.  For example,
> the "net" device class should provide infustructure and helper functions
> for runtime power management of that flavor.  This might include some
> generic "net" PM sysfs files.

Can you think of device classes other than "net" requiring this special
approach?  Network interfaces already get special treatment in some ways
(for example, they don't have entries in /dev).  This could just be
another form of special treatment for them.

Alan Stern

