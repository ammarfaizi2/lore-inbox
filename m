Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbVHORpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVHORpY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 13:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbVHORpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 13:45:23 -0400
Received: from s243.chello.upc.cz ([62.24.84.243]:55477 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S964863AbVHORpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 13:45:22 -0400
Date: Mon, 15 Aug 2005 19:45:58 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Joe Peterson <joe@skyrush.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] to drivers/input/evdev.c to add mixer device "/dev/input/events"
Message-ID: <20050815174558.GB1450@ucw.cz>
References: <4300D09C.4030702@skyrush.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4300D09C.4030702@skyrush.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 11:27:56AM -0600, Joe Peterson wrote:

> I, and a growing number of others, have been having trouble with using
> touch screen devices in Linux, particularly the motorized ones that fit
> into car dashboards.  The problem is that these devices, which have a
> USB touchscreen (often the eGalax brand), turn off when the screen is
> retracted, causing Linux to remove and/or disconnect the event device
> in /dev/input.
> 
> Using udev to assign a persistent symlink to the device was the first
> thing I tried, but it does not solve the problem, since X windows does
> not see the device when it turns back on, even if it's the same name.  I
> (and others) have tried hacks like changing virtual terminals, etc. to
> get it back, but these are not elegant solutions are are problematic.
> 
> Anyway, I finally decided the thing I needed was something like
> /dev/input/mice, since it is always there for X to see, even if the
> device is off during boot.  But the mousedev devices are not the
> right data format for use with the touch screens (you need "event"
> ones).  So I hacked evdev.c and added "/dev/input/events", which is a
> mixer as well and catches all events from event0, event1, etc.

> Anyway, I hope my change is valuable.  I (and others) would love to see
> it appear in the official kernel source.  I attached the patch.

I really think this is the wrong way to go. Much better would be to fix
the X driver (are you using evtouch or something else?) to notice the
disconnect of the device (it'll get -ENODEV) and connect of the device
(a hotplug event is issued, a select() on /proc/bus/input/devices
returns as readable) and re-open the device.

It's not really possible to mix the events from all devices together,
namely touchscreens, since mixing of ABS_* events is undefined.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
