Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVCYM0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVCYM0k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 07:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVCYM0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 07:26:40 -0500
Received: from aun.it.uu.se ([130.238.12.36]:36589 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261309AbVCYM0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 07:26:35 -0500
Date: Fri, 25 Mar 2005 13:25:59 +0100 (MET)
Message-Id: <200503251225.j2PCPxPo010837@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: adaplas@pol.net, benh@kernel.crashing.org
Subject: Mach64 framebuffer console distorted on PMac G3 with recent 2.6 kernels
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My Beige PowerMac G3 has a Mach64 GT chip. The display is an old 15" PC monitor.
In recent 2.6 kernels, the framebuffer console suffers from distortions,
where pixels in several columns around 50% and 75% into the lines (all lines)
flicker on/off all the time.

All kernels up to and including 2.6.10-rc1-bk3 were Ok and did not have
this problem, but 2.6.10-rc1-bk8 and newer all do.
(The intermediate 2.6.10-rc1-bk[4-7] ones don't compile on my pmac.)

There were major updates to the Mach64 driver between 2.6.10-rc1-bk3 and -bk8,
so I can only conclude that the new driver misprograms the chip somehow.

Below is a dmesg diff between bk3 (working) and bk8 (distortions).
I'm willing to run test/debug patches if you need more information.

BTW, who is the maintainer for Mach64? I couldn't find anything specific
in MAINTAINERS.

/Mikael

--- dmesg-2.6.10-rc1-bk3	2005-03-25 12:36:26.000000000 +0100
+++ dmesg-2.6.10-rc1-bk8	2005-03-25 12:36:27.000000000 +0100
@@ -31,13 +31,54 @@
 Registering pmac pic with sysfs...
 SCSI subsystem initialized
 usbcore: registered new driver hub
-atyfb: 3D RAGE (GT) [0x4754 rev 0x9a] 2M SGRAM, 14.31818 MHz XTAL, 200 MHz PLL, 67 Mhz MCLK
-BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
-7b23a040 86010182 004215b3 25010001     03000200      004808e2   009c0666
-PLL ad d5 21 44 e8 03 82 d1 8e 9e 98 14 a6 1b 00 00
+PCI: Enabling device 0000:00:12.0 (0086 -> 0087)
+atyfb: using auxiliary register aperture
+atyfb: 3D RAGE (Mach64 GT) [0x4754 rev 0x02]
+atyfb: 2M SGRAM (1:1), 14.31818 MHz XTAL, 200 MHz PLL, 67 Mhz MCLK, 67 MHz XCLK
 atyfb: monitor sense=73f, mode 6
+atyfb: setting up CRTC
+atyfb: set primary CRT to 640x480 PP composite N
+atyfb: CRTC_H_TOTAL_DISP: 4f006b
+atyfb: CRTC_H_SYNC_STRT_WID: 80059
+atyfb: CRTC_V_TOTAL_DISP: 1df020c
+atyfb: CRTC_V_SYNC_STRT_WID: 301e2
+atyfb: CRTC_OFF_PITCH: 14000000
+atyfb: CRTC_VLINE_CRNT_VLINE: 0
+atyfb: CRTC_GEN_CNTL: b000200
+atyfb: atyfb_set_par
+atyfb:  Set Visible Mode to 640x480-8
+atyfb:  Virtual resolution 640x3251, pixclock_in_ps 33523 (calculated 33523)
+atyfb:  Dot clock:           29 MHz
+atyfb:  Horizontal sync:     34 kHz
+atyfb:  Vertical refresh:    64 Hz
+atyfb:  x  style: 29.27833 640 720 784 864   480 483 486 525
+atyfb:  fb style: 33523  80 640 80 64 39 480 3 3
+debug atyfb: Mach64 non-shadow register values:
+debug atyfb: 0x2000:  004F006B 00080059 01DF020C 000301E2
+debug atyfb: 0x2010:  00C40000 14000000 00000002 0B000200
+debug atyfb: 0x2020:  004805FA 00B4043B 00000000 92100000
+debug atyfb: 0x2030:  00000000 00000031 00000000 00000000
+debug atyfb: 0x2040:  00000000 00000000 00000000 00000000
+debug atyfb: 0x2050:  00000000 00000000 00000000 00000000
+debug atyfb: 0x2060:  FFFFFF00 00000001 00000008 07FF07FF
+debug atyfb: 0x2070:  00000000 00000000 00003720 00000040
+debug atyfb: 0x2080:  00000000 00000000 00000000 00000000
+debug atyfb: 0x2090:  00A63003 00000000 00000000 00000000
+debug atyfb: 0x20A0:  7B23A050 00000000 00000000 25010001
+debug atyfb: 0x20B0:  004215B3 00010000 00010000 00000000
+debug atyfb: 0x20C0:  00FF0001 86010182 00000000 00000000
+debug atyfb: 0x20D0:  00000180 00000000 00000000 00002082
+debug atyfb: 0x20E0:  9A004754 0000001D 00000000 00000000
+debug atyfb: 0x20F0:  00000000 0000000B 800004F8 00000000
+
+debug atyfb: Mach64 PLL register values:
+debug atyfb: 0x00:  ADD52414 A80382D1 8E829601 A61B0000
+debug atyfb: 0x10:  ADD52414 A80382D1 8E829601 A61B0000
+debug atyfb: 0x20:  ADD52414 A80382D1 8E829601 A61B0000
+debug atyfb: 0x30:  ADD52414 A80382D1 8E829601 A61B0000
+
 Console: switching to colour frame buffer device 80x30
-fb0: ATY Mach64 frame buffer device on PCI
+atyfb: fb0: ATY Mach64 frame buffer device on PCI
 Generic RTC Driver v1.07
 Macintosh non-volatile memory driver v1.1
 io scheduler noop registered
