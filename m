Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUK1W4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUK1W4c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 17:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbUK1W4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 17:56:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49936 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261156AbUK1W4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 17:56:18 -0500
Date: Sun, 28 Nov 2004 23:56:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] select for drivers/mtd
Message-ID: <20041128225616.GG4390@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below switches options to use select where appropriate.

One of the dependencies of MTD_GEN_PROBE was on MTD_INTELPROBE that
isn't in Linus' tree. If this symbol is present in the mtd cvs, a
similar select is needed there.

What's the purpose of the MTD_DOCECC option, which has always the same 
value as the MTD_DOCPROBE option?


diffstat output:
 drivers/mtd/chips/Kconfig   |    9 +++++----
 drivers/mtd/devices/Kconfig |   15 +++++++--------
 drivers/mtd/nand/Kconfig    |    3 +--
 3 files changed, 13 insertions(+), 14 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/drivers/mtd/chips/Kconfig.old	2004-11-28 23:43:52.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/mtd/chips/Kconfig	2004-11-28 23:46:59.000000000 +0100
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
@@ -158,6 +158,7 @@
 config MTD_CFI_INTELEXT
 	tristate "Support for Intel/Sharp flash chips"
 	depends on MTD_GEN_PROBE
+	select MTD_CFI_UTIL
 	help
 	  The Common Flash Interface defines a number of different command
 	  sets which a CFI-compliant chip may claim to implement. This code
@@ -167,6 +168,7 @@
 config MTD_CFI_AMDSTD
 	tristate "Support for AMD/Fujitsu flash chips"
 	depends on MTD_GEN_PROBE
+	select MTD_CFI_UTIL
 	help
 	  The Common Flash Interface defines a number of different command
 	  sets which a CFI-compliant chip may claim to implement. This code
@@ -197,6 +199,7 @@
 config MTD_CFI_STAA
 	tristate "Support for ST (Advanced Architecture) flash chips"
 	depends on MTD_GEN_PROBE
+	select MTD_CFI_UTIL
 	help
 	  The Common Flash Interface defines a number of different command
 	  sets which a CFI-compliant chip may claim to implement. This code
@@ -204,8 +207,6 @@
 
 config MTD_CFI_UTIL
 	tristate
-	default y if MTD_CFI_INTELEXT=y || MTD_CFI_AMDSTD=y || MTD_CFI_STAA=y
-	default m if MTD_CFI_INTELEXT=m || MTD_CFI_AMDSTD=m || MTD_CFI_STAA=m
 
 config MTD_RAM
 	tristate "Support for RAM chips in bus mapping"
--- linux-2.6.10-rc2-mm3-full/drivers/mtd/devices/Kconfig.old	2004-11-28 23:44:18.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/mtd/devices/Kconfig	2004-11-28 23:50:46.000000000 +0100
@@ -130,6 +130,8 @@
 config MTD_DOC2000
 	tristate "M-Systems Disk-On-Chip 2000 and Millennium (DEPRECATED)"
 	depends on MTD
+	select MTD_DOCPROBE
+	select MTD_NAND_IDS
 	---help---
 	  This provides an MTD device driver for the M-Systems DiskOnChip
 	  2000 and Millennium devices.  Originally designed for the DiskOnChip
@@ -151,6 +153,8 @@
 config MTD_DOC2001
 	tristate "M-Systems Disk-On-Chip Millennium-only alternative driver (DEPRECATED)"
 	depends on MTD
+	select MTD_DOCPROBE
+	select MTD_NAND_IDS
 	---help---
 	  This provides an alternative MTD device driver for the M-Systems 
 	  DiskOnChip Millennium devices.  Use this if you have problems with
@@ -171,6 +175,8 @@
 config MTD_DOC2001PLUS
 	tristate "M-Systems Disk-On-Chip Millennium Plus"
 	depends on MTD
+	select MTD_DOCPROBE
+	select MTD_NAND_IDS
 	---help---
 	  This provides an MTD device driver for the M-Systems DiskOnChip
 	  Millennium Plus devices.
@@ -186,17 +192,10 @@
 
 config MTD_DOCPROBE
 	tristate
-	default m if MTD_DOC2001!=y && MTD_DOC2000!=y && MTD_DOC2001PLUS!=y && (MTD_DOC2001=m || MTD_DOC2000=m || MTD_DOC2001PLUS=m)
-	default y if MTD_DOC2001=y || MTD_DOC2000=y || MTD_DOC2001PLUS=y
-	help
-	  This isn't a real config option; it's derived.
+	select MTD_DOCECC
 
 config MTD_DOCECC
 	tristate
-	default m if MTD_DOCPROBE=m
-	default y if MTD_DOCPROBE=y
-	help
-	  This isn't a real config option; it's derived.
 
 config MTD_DOCPROBE_ADVANCED
 	bool "Advanced detection options for DiskOnChip"
--- linux-2.6.10-rc2-mm3-full/drivers/mtd/nand/Kconfig.old	2004-11-28 23:44:33.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/mtd/nand/Kconfig	2004-11-28 23:53:30.000000000 +0100
@@ -7,6 +7,7 @@
 config MTD_NAND
 	tristate "NAND Device Support"
 	depends on MTD
+	select MTD_NAND_IDS
 	help
 	  This enables support for accessing all type of NAND flash
 	  devices. For further information see
@@ -56,8 +57,6 @@
 
 config MTD_NAND_IDS
 	tristate
-	default y if MTD_NAND = y || MTD_DOC2000 = y || MTD_DOC2001 = y || MTD_DOC2001PLUS = y
-	default m if MTD_NAND = m || MTD_DOC2000 = m || MTD_DOC2001 = m || MTD_DOC2001PLUS = m
 
 config MTD_NAND_TX4925NDFMC
 	tristate "SmartMedia Card on Toshiba RBTX4925 reference board"

