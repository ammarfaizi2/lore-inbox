Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTLJNmA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 08:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbTLJNmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 08:42:00 -0500
Received: from smtp1.vsnl.net ([203.200.235.231]:14030 "EHLO smtp1.vsnl.net")
	by vger.kernel.org with ESMTP id S262323AbTLJNl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 08:41:56 -0500
Date: Wed, 10 Dec 2003 19:23:30 +0530 (IST)
From: Rahul Sawarkar <torahuls@vsnl.com>
Subject: tridentfb problem in 2.6
X-X-Sender: owl@owl.lfs
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.56.0312101917180.276@owl.lfs>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Kernel 2.6.0-test11 has a problem with tridentfb:
-----------------------------------------------------------------
Dec 10 15:16:24 (none) kernel: tridentfb: Trident framebuffer 0.7.8-NEWAPI initializing
Dec 10 15:16:24 (none) kernel: tridentfb: framebuffer size = 8192 Kb
Dec 10 15:16:24 (none) kernel: tridentfb: 0000:01:00.0 board found
Dec 10 15:16:24 (none) kernel: tridentfb: probe of 0000:01:00.0 failed with error -22
Dec 10 15:16:24 (none) kernel: vesafb: abort, cannot reserve video memory at 0xd9800000
Dec 10 15:16:25 (none) kernel: vesafb: framebuffer at 0xd9800000, mapped to 0xc8828000, size 8128k
Dec 10 15:16:25 (none) kernel: vesafb: mode is 1024x768x16, linelength=2048, pages=4
Dec 10 15:16:25 (none) kernel: vesafb: protected mode interface info at c000:65d6
Dec 10 15:16:25 (none) kernel: vesafb: scrolling: redraw
Dec 10 15:16:25 (none) kernel: vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Dec 10 15:16:25 (none) kernel: fb0: VESA VGA frame buffer device

Problem not seen in 2.4.19. Console does work in 1024x768 mode in both
kernels, however I think due to vesafb in 2.6?...
Here is the dmesg output for 2.4.19:

Dec 10 17:37:40 (none) kernel: tridentfb: Trident framebuffer 0.7.5 initializing
Dec 10 17:37:40 (none) kernel: tridentfb: framebuffer size = 8192 Kb
Dec 10 17:37:40 (none) kernel: tridentfb: Trident Microsystems CyberBlade/i7 board found
Dec 10 17:37:40 (none) kernel: Console: switching to colour frame buffer device 128x48
Dec 10 17:37:40 (none) kernel: tridentfb: fb0: Trident frame buffer device 1024x768-16bpp
Dec 10 17:37:40 (none) kernel: pty: 256 Unix98 ptys configured

No problems there ...

-----------------------------------------------------------------
Result:
Running links browser from console in graphics mode with svgalib gives :

Using Trident 9440 driver (2048K)
c015e
Using VESA driver, 16320KB. VBE1.2
svgalib 1.4.3

Links opens in a horizontal band of 1.5 cm height at about 1/3rd the way down from top of monitor.
I am able to use the menu of links browser  although I cant see the menu's complete  drop  down list in 1.5cm.

Links works fine with 2.4.19
------------------------------------------------------------------
My 2.6.0-test11 kernel config file reads (--snipped--)
------------------------------------------------------------------
CONFIG_FB_VESA=y
# CONFIG_FB_VGA16 is not set
CONFIG_VGA_CONSOLE=y
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_LP_CONSOLE is not set
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
------------------------------------------------------------------
Lilo.conf reads:
--snip--
image="/boot/bzImage-2.6.0-test11"
	append="video=tridentfb:1024x768-16@85"
	label="LFS2.6"
	root=/dev/hdb3
	read-only
	vga=791 /* 2.4.19 console switches to 1024x768 mode *without* this
		line,But not 2.6.0-test11 */
-------------------------------------------------------------------
Chipset BIOSTAR VIA MVP4 running a K62-500. Gcc 3.2

Is this a bug with trident 0.7.8-NEWAPI?
Please CC reply to me, as I'm not subscribed. Thanks


Regards
Rahul Sawarkar
<torahuls@vsnl.com>
