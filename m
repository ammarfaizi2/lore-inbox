Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTKCJEq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 04:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTKCJEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 04:04:46 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:53919 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261731AbTKCJEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 04:04:44 -0500
Subject: Re: Re:No backlight control on PowerBook G4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dustin Lang <dalang@cs.ubc.ca>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.53.0311021647410.17357@columbia.cs.ubc.ca>
References: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca>
	 <1067820334.692.38.camel@gaston>
	 <Pine.GSO.4.53.0311021647410.17357@columbia.cs.ubc.ca>
Content-Type: text/plain
Message-Id: <1067850243.680.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 03 Nov 2003 20:04:04 +1100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Actually, it's got a GeForce FX Go 5200.

Ouch !

Well... This will be a bigger problem then. For some reason, nVidia
can't (or don't want) to tell us how to do fine backlight control. We
know how to switch the backlight on/off though since recently and Mark
just pushed a patch doing that for DPMS in XFree CVS "nv" driver.

Another bad new with nVidia based laptops is that there is little chance
we ever support sleep mode on these as so far, it doesn't seem nVidia
would be willing to give us the necessary informations to reboot the
chip on wakeup.

> Cool.  I think backlight control, drive spindown, and CPU frequency
> scaling should go a fairly long way on the battery life front.  Speaking
> of CPU scaling, do you know if it should work on this machine?  I selected
> it in the kernel config, but /sys/devices/system/cpu/cpu0 is empty.

For finer backlight control, it may be possible to figure it out by
either tapping registers, looking at the nVidia OF driver, or examining
register contents in MacOS X (or tracing through MacOS X drivers).

> cpu             : 7457, altivec supported
> clock           : 999MHz
> revision        : 1.1 (pvr 8002 0101)
> bogomips        : 761.85
> machine         : PowerBook6,2
> motherboard     : PowerBook6,2 MacRISC3 Power Macintosh
> board revision  : 00000002
> detected as     : 287 (Unknown Intrepid-based)
> pmac flags      : 00000008
> L2 cache        : 512K unified
> memory          : 256MB
> pmac-generation : NewWorld

Hrm... Bogompips is a bit low for a G4... I suspect it may be running at
the lower speed. I don't know for sure how speed control work on these
new models based on the 7457...

> Oh, I just noticed something else in dmesg:
>     PMU driver 2 initialized for Core99, firmware: 0c
> 
> *shrug*

What's wrong ?

> I grabbed the newest Darwin/xnu source I could find from Apple, and I can
> no longer find where they do the backlight control - it used to be in
> iokit/Drivers/platform/drvApplePMU .  I'll have to look more closely
> tomorrow...
> 
> Again, many thanks for your work on this platform.

It's scattered. For recent machines, it's done by the video driver itself
(the video chip controls the backlight on the LVDS lines afaik)

Ben.


