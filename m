Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbUARSf4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 13:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUARSf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 13:35:56 -0500
Received: from mail.convergence.de ([212.84.236.4]:45036 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262848AbUARSfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 13:35:37 -0500
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hunold@linuxtv.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 1/5] Update DVB documentation
In-Reply-To: <10744509222284@convergence.de>
Message-Id: <10744509221553@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Sun, 18 Jan 2004 13:35:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] update contributors
- [DVB] documentation update for recent DVB TTUSB driver changes
diff -uraNbBw xx-linux-2.6.1-mm4/Documentation/dvb/contributors.txt linux-2.6.1-mm4.patched/Documentation/dvb/contributors.txt
--- xx-linux-2.6.1-mm4/Documentation/dvb/contributors.txt	2004-01-16 19:49:27.000000000 +0100
+++ linux-2.6.1-mm4.patched/Documentation/dvb/contributors.txt	2004-01-09 20:27:26.000000000 +0100
@@ -8,7 +8,7 @@
 
 Marcus Metzler <mocm@metzlerbros.de>
 Ralph Metzler <rjkm@metzlerbros.de>
-  for their contining work on the DVB driver
+  for their continuing work on the DVB driver
 
 Michael Holzt <kju@debian.org>
   for his contributions to the dvb-net driver
@@ -58,5 +58,9 @@
   for his work on the budget drivers, the demux code,
   the module unloading problems, ...
   
+Hans-Frieder Vogt <hfvogt@arcor.de>
+  for his work on calculating and checking the crc's for the
+  TechnoTrend/Hauppauge DEC driver firmware
+
 (If you think you should be in this list, but you are not, drop a
  line to the DVB mailing list)
diff -uraNbBw xx-linux-2.6.1-mm4/Documentation/dvb/ttusb-dec.txt linux-2.6.1-mm4.patched/Documentation/dvb/ttusb-dec.txt
--- xx-linux-2.6.1-mm4/Documentation/dvb/ttusb-dec.txt	2004-01-16 19:49:27.000000000 +0100
+++ linux-2.6.1-mm4.patched/Documentation/dvb/ttusb-dec.txt	2004-01-16 18:21:55.000000000 +0100
@@ -14,6 +14,7 @@
 	Hotplug firmware loader under 2.6 kernels
 
 In Progress:
+	DEC2540-t
 	DEC3000-s
 
 To Do:
@@ -23,21 +24,34 @@
 
 Getting the Firmware
 --------------------
-Currently, the driver only works with v2.15a of the firmware.  The firmwares
-can be obtained in this way:
+The firmware can be found in the software update zip files on this page:
+http://www.hauppauge.de/sw_dec.htm
 
-wget http://hauppauge.lightpath.net/de/dec215a.exe
-unzip -j dec215a.exe Software/Oem/STB/App/Boot/STB_PC_T.bin
-unzip -j dec215a.exe Software/Oem/STB/App/Boot/STB_PC_S.bin
+The firmwares are named as follows:
+DEC2000-t:	STB_PC_T.bin
+DEC2540-t:	STB_PC_X.bin
+DEC3000-s:	STB_PC_S.bin
+
+Note that firmwares since version 2.16 beta2 for the DEC2000-t give the device
+the USB ID of the DEC3000-s.  The driver copes with this.
+
+Instructions follow for retrieving version 2.16 of the firmware:
+
+wget http://hauppauge.lightpath.net/de/dec216.exe
+unzip -j dec216.exe software/OEM/STB/App/Boot/STB_PC_T.bin
+unzip -j dec216.exe software/OEM/STB/App/Boot/STB_PC_X.bin
+unzip -j dec216.exe software/OEM/STB/App/Boot/STB_PC_S.bin
 
 
 Compilation Notes for 2.4 kernels
 ---------------------------------
 For 2.4 kernels the firmware for the DECs is compiled into the driver itself.
-The firmwares are expected to be in /etc/dvb at compilation time.
+The firmwares are expected to be in the build-2.4 directory at compilation
+time.
 
-mv STB_PC_T.bin /etc/dvb/dec2000t.bin
-mv STB_PC_S.bin /etc/dvb/dec3000s.bin
+mv STB_PC_T.bin build-2.4/dvb-ttusb-dec-2000t.fw
+mv STB_PC_X.bin build-2.4/dvb-ttusb-dec-2540t.fw
+mv STB_PC_S.bin build-2.4/dvb-ttusb-dec-3000s.fw
 
 
 Hotplug Firmware Loading for 2.6 kernels
@@ -45,5 +59,6 @@
 For 2.6 kernels the firmware is loaded at the point that the driver module is
 loaded.  See linux/Documentation/dvb/firmware.txt for more information.
 
-mv STB_PC_T.bin /usr/lib/hotplug/firmware/dvb-ttusb-dec-2000t-2.15a.fw
-mv STB_PC_S.bin /usr/lib/hotplug/firmware/dvb-ttusb-dec-3000s-2.15a.fw
+mv STB_PC_T.bin /usr/lib/hotplug/firmware/dvb-ttusb-dec-2000t.fw
+mv STB_PC_X.bin /usr/lib/hotplug/firmware/dvb-ttusb-dec-2540t.fw
+mv STB_PC_S.bin /usr/lib/hotplug/firmware/dvb-ttusb-dec-3000s.fw


