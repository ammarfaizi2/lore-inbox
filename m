Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBIKmV>; Fri, 9 Feb 2001 05:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129030AbRBIKmA>; Fri, 9 Feb 2001 05:42:00 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:46861 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S129027AbRBIKlw>;
	Fri, 9 Feb 2001 05:41:52 -0500
Message-ID: <3A83C963.4070602@megapathdsl.net>
Date: Fri, 09 Feb 2001 02:41:39 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-pre2 i686; en-US; m18) Gecko/20010207
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.2-pre2 -- vesafb gives broken virtual terminals.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just gave 2.4.2-pre2 a spin on my laptop.  This machine
has a Neomagic MagicGraph 128XD (2160) video chip.
My .config included:

	#
	# Console drivers
	#
	CONFIG_VGA_CONSOLE=y
	CONFIG_VIDEO_SELECT=y

	#
	# Frame-buffer support
	#
	CONFIG_FB=y
	CONFIG_DUMMY_CONSOLE=y
	CONFIG_FB_VESA=y
	CONFIG_VIDEO_SELECT=y

Notice that "CONFIG_VIDEO_SELECT=y" is defined twice
(not that this has anything to do with my VTs not
working).

This config fails to give usable VTs.  When I try to
switch virtual terminals, all I get is an underscore
in the top left part of the screen.  Also, XFree86
won't load.  It keeps giving me an error about
being unable to use VT number 2.

The broken config gives this log output:

Feb  9 01:16:36 agate kernel: Console: colour dummy device 80x25
Feb  9 01:16:49 agate kernel: vesafb: framebuffer at 0xfd000000, mapped 
to 0xc5800000, size 1984k
Feb  9 01:16:49 agate kernel: vesafb: mode is 1024x768x16, 
linelength=2048, pages=0
Feb  9 01:16:50 agate kernel: vesafb: protected mode interface info at 
c000:8d50
Feb  9 01:16:50 agate kernel: vesafb: scrolling: redraw
Feb  9 01:16:50 agate kernel: vesafb: directcolor: size=0:5:6:5, 
shift=0:11:5:0
Feb  9 01:16:50 agate kernel: Console: switching to colour frame buffer 
device 128x48
Feb  9 01:16:51 agate kernel: fb0: VESA VGA frame buffer device


If I turn off the framebuffer stuff, I can boot fine and
the virtual terminals work.

Ciao,
	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
