Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbVHDWF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVHDWF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVHDWD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:03:59 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:11224 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S262744AbVHDWDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:03:40 -0400
Date: Fri, 5 Aug 2005 00:03:31 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Regression: radeonfb: No synchronisation on CRT with linux-2.6.13-rc5
Message-ID: <Pine.LNX.4.58.0508040103100.2220@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My CRT is out of sync after radeonfb from 2.6.13-rc5 is initialized. 
2.6.12 does not show this behaviour.

dmesg from both systems, trimmed down:

2.6.13-rc5:

PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: e8000000-e9ffffff
  PREFETCH window: d0000000-dfffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Machine check exception polling timer started.
...
Applying VIA southbridge workaround.
radeonfb_pci_register BEGIN
radeonfb (0000:01:00.0): Found 131072k of DDR 128 bits wide videoram
radeonfb (0000:01:00.0): mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.00 MHz
radeonfb: PLL min 20000 max 40000
1 chips in connector info
 - chip 1 has 2 connectors
  * connector 0 of type 2 (CRT) : 2300
  * connector 1 of type 3 (DVI-I) : 3201
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
hStart = 694, hEnd = 757, hTotal = 795
vStart = 402, vEnd = 408, vTotal = 418
h_total_disp = 0x590062	   hsync_strt_wid = 0x8702c0
v_total_disp = 0x18f01a1	   vsync_strt_wid = 0x860191
pixclock = 85925
freq = 1163
freq = 1666, PLL min = 20000, PLL max = 40000
ref_div = 12, ref_clk = 2700, output_freq = 26656
ref_div = 12, ref_clk = 2700, output_freq = 26656
post div = 0x5
fb_div = 0x76
ppll_div_3 = 0x50076
Console: switching to colour frame buffer device 90x25
radeonfb (0000:01:00.0): ATI Radeon AS 
radeonfb_pci_register END
PCI: Enabling device 0000:00:09.0 (0000 -> 0003)
PCI: Found IRQ 5 for device 0000:00:09.0
PCI: Sharing IRQ 5 with 0000:00:0d.0
fb: 3Dfx Banshee memory = 16384K
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized drm 1.0.0 20040925
PCI: Found IRQ 5 for device 0000:00:09.0
PCI: Sharing IRQ 5 with 0000:00:0d.0
[drm] Initialized tdfx 1.0.0 20010216 on minor 0: 
[drm] Initialized radeon 1.16.0 20050311 on minor 1: 

2.6.12:

PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
...
Applying VIA southbridge workaround.
radeonfb_pci_register BEGIN
radeonfb (0000:01:00.0): Found 131072k of DDR 128 bits wide videoram
radeonfb (0000:01:00.0): mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.00 MHz
radeonfb: PLL min 20000 max 40000
1 chips in connector info
 - chip 1 has 2 connectors
  * connector 0 of type 2 (CRT) : 2300
  * connector 1 of type 3 (DVI-I) : 3201
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
hStart = 737, hEnd = 808, hTotal = 896
vStart = 401, vEnd = 404, vTotal = 417
h_total_disp = 0x59006f	   hsync_strt_wid = 0x8802eb
v_total_disp = 0x18f01a0	   vsync_strt_wid = 0x830190
pixclock = 38210
freq = 2617
freq = 2617, PLL min = 20000, PLL max = 40000
ref_div = 12, ref_clk = 2700, output_freq = 20936
ref_div = 12, ref_clk = 2700, output_freq = 20936
post div = 0x3
fb_div = 0x5d
ppll_div_3 = 0x3005d
Console: switching to colour frame buffer device 90x25
radeonfb (0000:01:00.0): ATI Radeon AS 
radeonfb_pci_register END
...
fb: 3Dfx Banshee memory = 16384K
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized drm 1.0.0 20040925
PCI: Found IRQ 5 for device 0000:00:09.0
PCI: Sharing IRQ 5 with 0000:00:0d.0
[drm] Initialized tdfx 1.0.0 20010216 on minor 0: 
[drm] Initialized radeon 1.16.0 20050311 on minor 1: 
-- 
Top 100 things you don't want the sysadmin to say:
10. I don't care what he says, I'm _NOT_ having it on _my_ network
