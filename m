Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTKSOl6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 09:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbTKSOl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 09:41:58 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8329 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264095AbTKSOly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 09:41:54 -0500
Date: Mon, 17 Nov 2003 09:42:43 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: Pavel Machek <pavel@ucw.cz>, mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Patrick's Test9 suspend code.
Message-ID: <20031117084242.GE643@openzaurus.ucw.cz>
References: <200311090404.40327.rob@landley.net> <200311151830.45731.rob@landley.net> <20031116131314.GC199@elf.ucw.cz> <200311162038.31091.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311162038.31091.rob@landley.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Strange, they should be pretty much the same, functionality-wise.
> 
> Well, I gave your code another try.  It blanked the screen during the 
> "powering down devices" stage so I didn't see what it did after that, but a 
> full minute later it had stopped accessing the hard drive for rather a long 
> time, but the power was still on (except for the screen), so I switched it 
> off.  On reboot, it didn't resume from swap (normal boot with fsck instead) 
> but I had to do a mkswap to get my swap file back.

If you had to re-mkswap, that means suspend was indeed
successfull. Did you pass right resume= option? What did
kernel say when it refused to resume?

> covernor, probably.  If I tell it to use the userspace governor, there's 
> still nothing in /sys/devices/system/cpu/cpu0, the directory is empty.  Maybe 
> the documentation isn't up to date anymore, I don't know...)  When I tried to 
> suspend with it, it sort of worked but the writing to disk phase (which never 
> caused a problem before) had a visible pause between each sector written, and 
> writing out the 3000 sectors took over 5 minutes, and the end result wasn't 
> something it could resume from anyway.  Sigh...

Hmm, I've seen something similar, but result was ok at the end.
It only took very long time.

> > * go with minimal config, turn off drivers like USB, AGP you don't
> > really need
> 
> usb and agp were both compiled in to the kernel that worked (not modular).  It 
> never seemed to be dying due to the HARDWARE, it always shut all the hardware 
> down just fine...

You really should try without AGP. It has no support => it
will happily crash your machine at unrelated point during
resume.
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

