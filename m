Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbTI1Pi0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 11:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbTI1Pi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 11:38:26 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4841 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262531AbTI1PiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 11:38:23 -0400
Date: Sun, 28 Sep 2003 17:38:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] select for drivers/mtd
Message-ID: <20030928153817.GH15338@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below switches fs/Kconfig to use select where appropriate.

One of the dependencies of MTD_GEN_PROBE was on MTD_INTELPROBE that 
isn't in Linus' tree. If this symbol is present in the mtd cvs, a 
similar select is needed there.

diffstat output:

 drivers/mtd/chips/Kconfig   |    4 ++--
 drivers/mtd/devices/Kconfig |   10 ++++++----
 drivers/mtd/nand/Kconfig    |    3 +--
 3 files changed, 9 insertions(+), 8 deletions(-)


cu
Adrian

--- linux-2.6.0-test6-full/drivers/mtd/devices/Kconfig.old	2003-09-28 17:20:06.000000000 +0200
+++ linux-2.6.0-test6-full/drivers/mtd/devices/Kconfig	2003-09-28 17:26:15.000000000 +0200
@@ -117,6 +117,8 @@
 config MTD_DOC2000
 	tristate "M-Systems Disk-On-Chip 2000 and Millennium"
 	depends on MTD
+	select MTD_DOCPROBE
+	select MTD_NAND_IDS
 	---help---
 	  This provides an MTD device driver for the M-Systems DiskOnChip
 	  2000 and Millennium devices.  Originally designed for the DiskOnChip
@@ -134,6 +136,8 @@
 config MTD_DOC2001
 	tristate "M-Systems Disk-On-Chip Millennium-only alternative driver (see help)"
 	depends on MTD
+	select MTD_DOCPROBE
+	select MTD_NAND_IDS
 	---help---
 	  This provides an alternative MTD device driver for the M-Systems 
 	  DiskOnChip Millennium devices.  Use this if you have problems with
@@ -150,6 +154,8 @@
 config MTD_DOC2001PLUS
 	tristate "M-Systems Disk-On-Chip Millennium Plus"
 	depends on MTD
+	select MTD_DOCPROBE
+	select MTD_NAND_IDS
 	---help---
 	  This provides an MTD device driver for the M-Systems DiskOnChip
 	  Millennium Plus devices.
@@ -161,10 +167,6 @@
 
 config MTD_DOCPROBE
 	tristate
-	default m if MTD_DOC2001!=y && MTD_DOC2000!=y && MTD_DOC2001PLUS!=y && (MTD_DOC2001=m || MTD_DOC2000=m || MOD_DOC2001PLUS=m)
-	default y if MTD_DOC2001=y || MTD_DOC2000=y || MTD_DOC2001PLUS=y
-	help
-	  This isn't a real config option, it's derived.
 
 config MTD_DOCPROBE_ADVANCED
 	bool "Advanced detection options for DiskOnChip"
--- linux-2.6.0-test6-full/drivers/mtd/nand/Kconfig.old	2003-09-28 17:24:56.000000000 +0200
+++ linux-2.6.0-test6-full/drivers/mtd/nand/Kconfig	2003-09-28 17:26:57.000000000 +0200
@@ -7,6 +7,7 @@
 config MTD_NAND
 	tristate "NAND Device Support"
 	depends on MTD
+	select MTD_NAND_IDS
 	help
 	  This enables support for accessing all type of NAND flash
 	  devices with an 8-bit data bus interface. For further 
@@ -44,8 +45,6 @@
 
 config MTD_NAND_IDS
 	tristate
-	default y if MTD_NAND = y || MTD_DOC2000 = y || MTD_DOC2001 = y || MTD_DOC2001PLUS = y
-	default m if MTD_NAND = m || MTD_DOC2000 = m || MTD_DOC2001 = m || MTD_DOC2001PLUS = m
 	
 endmenu
 
--- linux-2.6.0-test6-full/drivers/mtd/chips/Kconfig.old	2003-09-28 17:27:26.000000000 +0200
+++ linux-2.6.0-test6-full/drivers/mtd/chips/Kconfig	2003-09-28 17:33:42.000000000 +0200
@@ -7,6 +7,7 @@
 config MTD_CFI
 	tristate "Detect flash chips by Common Flash Interface (CFI) probe"
 	depends on MTD
+	select MTD_GEN_PROBE
 	help
 	  The Common Flash Interface specification was developed by Intel,
 	  AMD and other flash manufactures that provides a universal method
@@ -18,6 +19,7 @@
 config MTD_JEDECPROBE
 	tristate "Detect non-CFI AMD/JEDEC-compatible flash chips"
 	depends on MTD
+	select MTD_GEN_PROBE
 	help
 	  This option enables JEDEC-style probing of flash chips which are not
 	  compatible with the Common Flash Interface, but will use the common
@@ -29,8 +31,6 @@
 
 config MTD_GEN_PROBE
 	tristate
-	default m if MTD_CFI!=y && !MTD_INTELPROBE && MTD_JEDECPROBE!=y && (MTD_CFI=m || MTD_JEDECPROBE=m)
-	default y if MTD_CFI=y || MTD_INTELPROBE || MTD_JEDECPROBE=y
 
 config MTD_CFI_ADV_OPTIONS
 	bool "Flash chip driver advanced configuration options"
