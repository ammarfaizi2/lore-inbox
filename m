Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270493AbTGZV32 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 17:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270628AbTGZV1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 17:27:20 -0400
Received: from the.earth.li ([193.201.200.66]:13465 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S270583AbTGZV0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 17:26:01 -0400
Date: Sat, 26 Jul 2003 22:41:13 +0100
From: Martin Ling <martin-lkml@earth.li>
To: linux-kernel@vger.kernel.org, usb-storage@one-eyed-alien.net
Subject: [PATCH] Acomdata MF1SM / Sitecom CN-301 USB SmartMedia support using SanDisk SDDR55 driver
Message-ID: <20030726214112.GA13619@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch to 2.4.21 (should apply cleanly to others) allows
the SDDR55 driver to recognise and use the Acomdata MF1SM (also badged
as Sitecom CN-301) USB SmartMedia reader.  I've also updated the config
& help to reflect this.

Info at http://the.earth.li/~martin/usb-smartmedia/


Martin

diff -ur linux-2.4.21/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.21/Documentation/Configure.help	Fri Jun 13 10:51:29 2003
+++ linux/Documentation/Configure.help	Sat Jul 26 17:09:20 2003
@@ -14785,10 +14785,12 @@
   Say Y here to include additional code to support the Sandisk SDDR-09
   SmartMedia reader in the USB Mass Storage driver.
 
-SanDisk SDDR-55 SmartMedia support
+SanDisk SDDR-55 (and compatible) SmartMedia support
 CONFIG_USB_STORAGE_SDDR55
   Say Y here to include additional code to support the Sandisk SDDR-55
-  SmartMedia reader in the USB Mass Storage driver.
+  SmartMedia reader in the USB Mass Storage driver. This code also
+  supports the Acomdata MF1SM reader (also badged as the Sitecom
+  CN-301).
 
 USB Diamond Rio500 support
 CONFIG_USB_RIO500
diff -ur linux-2.4.21/drivers/usb/Config.in linux/drivers/usb/Config.in
--- linux-2.4.21/drivers/usb/Config.in	Fri Jun 13 10:51:36 2003
+++ linux/drivers/usb/Config.in	Sat Jul 26 17:08:53 2003
@@ -40,7 +40,7 @@
       dep_mbool '    Microtech CompactFlash/SmartMedia support' CONFIG_USB_STORAGE_DPCM $CONFIG_USB_STORAGE
       dep_mbool '    HP CD-Writer 82xx support' CONFIG_USB_STORAGE_HP8200e $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
       dep_mbool '    SanDisk SDDR-09 (and other SmartMedia) support' CONFIG_USB_STORAGE_SDDR09 $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
-      dep_mbool '    SanDisk SDDR-55 SmartMedia support' CONFIG_USB_STORAGE_SDDR55 $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
+      dep_mbool '    SanDisk SDDR-55 (and compatible) SmartMedia support' CONFIG_USB_STORAGE_SDDR55 $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
       dep_mbool '    Lexar Jumpshot Compact Flash Reader' CONFIG_USB_STORAGE_JUMPSHOT $CONFIG_USB_STORAGE $CONFIG_EXPERIMENTAL
    dep_tristate '  USB Modem (CDC ACM) support' CONFIG_USB_ACM $CONFIG_USB
    dep_tristate '  USB Printer support' CONFIG_USB_PRINTER $CONFIG_USB
diff -ur linux-2.4.21/drivers/usb/storage/unusual_devs.h linux/drivers/usb/storage/unusual_devs.h
--- linux-2.4.21/drivers/usb/storage/unusual_devs.h	Fri Jun 13 10:51:37 2003
+++ linux/drivers/usb/storage/unusual_devs.h	Sat Jul 26 16:48:48 2003
@@ -593,4 +593,9 @@
 		"ImageMate SDDR55",
 		US_SC_SCSI, US_PR_SDDR55, NULL,
 		US_FL_SINGLE_LUN),
+UNUSUAL_DEV(  0x0c0b, 0xa103, 0x0000, 0x9999, 
+		"Acomdata",
+		"MF1SM",
+		US_SC_SCSI, US_PR_SDDR55, NULL,
+		US_FL_SINGLE_LUN),
 #endif
