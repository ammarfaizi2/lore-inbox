Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUADB1j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 20:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUADB1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 20:27:39 -0500
Received: from gizmo05bw.bigpond.com ([144.140.70.15]:408 "HELO
	gizmo05bw.bigpond.com") by vger.kernel.org with SMTP
	id S264286AbUADB1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 20:27:36 -0500
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: linux-kernel@vger.kernel.org
Subject: agpgart issue on 2.6.1-rc1-bk3 (x86-64)
Date: Sun, 4 Jan 2004 12:28:22 +1100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401041228.22987.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I see this message in the 2.6.1-rc3-bk3 kernel log:
agpgart: Detected AGP bridge 0
agpgart: Too many northbridges for AGP

This results in <100 FPS in glxgears, and I am unable to play the tuxracer 
game :-). With 2.6.0-x8664-1 however I get 450 FPS (approx), and all was 
well.

Upon applying this patch (making it identical to 2.6.0-x86-64 that is):
--- 2.6.1-rc1-bk3/drivers/char/agp/amd64-agp.c.orig     2004-01-04 
01:06:20.000000000 +1100
+++ 2.6.1-rc1-bk3/drivers/char/agp/amd64-agp.c  2004-01-04 01:06:50.000000000 
+1100
@@ -16,11 +16,7 @@
 #include "agp.h"

 /* Will need to be increased if AMD64 ever goes >8-way. */
-#ifdef CONFIG_SMP
 #define MAX_HAMMER_GARTS   8
-#else
-#define MAX_HAMMER_GARTS   1
-#endif

 /* PTE bits. */
 #define GPTE_VALID     1

Of course that maybe a wrong approach. But that makes things a lot better, and 
I see this message in the kernel log:
agpgart: Detected AGP bridge 0
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 128M @ 0xd0000000

And the number of FPS in glxgears is back to normal (450 FPS approx).

Here is the 'lspci' information from my K8T800 chipset based Gigabyte 
GA-K8VNXP board (and there seems to be 4 AMD K8 north bridges):
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3188 (rev 01)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b188
00:0e.0 RAID bus controller: Integrated Technology Express, Inc.: Unknown 
device 8212 (rev 11)
00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3149 (rev 
80)
00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. USB (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 
Audio Controller (rev 60)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 (rev 10)
00:14.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8025 (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY 
[Radeon 7000/VE]

Of course CONFIG_SMP is not set in my .config.

Thanks
Hari

