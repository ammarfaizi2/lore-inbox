Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262859AbUKSBME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbUKSBME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 20:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUKSBKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 20:10:52 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:4224
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S262959AbUKSBFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 20:05:45 -0500
From: John Mock <kd6pag@qsl.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc2 on VAIO laptop and PowerMac 8500/G3
Message-Id: <E1CUxDU-0000XP-00@penngrove.fdns.net>
Date: Thu, 18 Nov 2004 17:05:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for the quick response on the PowerPC issues!!

> You lack CONFIG_FRAMEBUFFER_CONSOLE maybe ? You should use the
> pmac_defconfig ... Now, if controlfb still doesn't work, then I'll have
> to dig out my old 8500, it's possible that the recent changes to the
> fbdev layer broke some of those old drivers.

> As for serial, check out CONFIG_SERIAL_PMACZILOG and
> CONFIG_SERIAL_PMACZILOG_CONSOLE.

Rats!  I was hoping you'd suggest a CONFIG_... i'd missed for either issue. 
As far as the video problem is concerned, i copied the '.config' from 2.6.8
to 2.6.9-rc1, and the resultant Linux works on 2.6.8 but 2.6.9-rc1 fails.

I do have both of the PMACZILOG switches set (see previously attached
'.config' if there's anything else worth checking for), and if i run
'gtkterm' on both machines, the keyboard of one appears in the terminal
window of the other.  While the serial console on the laptop (Intel) will
appear in the Mac screen, the reverse does not work.   The Linux command 
line is:

       root=/dev/md0 md=0,/dev/sda7,/dev/sdb7,/dev/sdc7 md=1,/dev/sda8,/dev/sdb8,/dev/sdc8,console=ttyS0,9600 console=tty0

Note this doesn't seem to work under 2.4.27, with

    CONFIG_MAC_SERIAL=y
    CONFIG_SERIAL_CONSOLE=y

Is the Mac side fussy about CTS/RTS?  I didn't make all of the adapters
myself, so i can't be absolutely certain that all three modem control
lines are propagated properly.

If there's anything i can try which will save you the trouble of digging
out your Old World Mac, please do let me know!

> Yes, that is due to the 2.6 changes in fbdev/fbcon, the loss of the per
> VT mode data structure, the driver is now sort-of supposed to re-invent
> a mode based on bogus stuff sent by fbcon on console switch. I don't
> like it much, but I suppose I'll have to fix controlfb (and platinumfb
> etc...).

If you might be so kind as to tell me which function and/or file that the
video mode is being resynthesized in, then i can probably come with some
kind of work-around.  Then you can feel like you can fix this issue when
it's convenient to do so.  I looked for this once before but bogged down
before i got anywhere.
				     -- JM
