Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVGDOD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVGDOD6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 10:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVGDODy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 10:03:54 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:58542 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S261726AbVGDNpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 09:45:52 -0400
Date: Mon, 4 Jul 2005 15:45:04 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig changes 6: Move the Fusion MPT menu
In-Reply-To: <Pine.LNX.4.58.0507041520370.11818@be1.lrz>
Message-ID: <Pine.LNX.4.58.0507041541510.11818@be1.lrz>
References: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
 <Pine.LNX.4.58.0507041134410.3798@be1.lrz> <Pine.LNX.4.58.0507041210190.6165@be1.lrz>
 <Pine.LNX.4.58.0507041231200.6165@be1.lrz> <Pine.LNX.4.58.0507041251220.8687@be1.lrz>
 <Pine.LNX.4.58.0507041520370.11818@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2005, Bodo Eggert wrote:

> And now to something completely different:
> 
> The Fusion MPT controler seems to belong into the SCSI low level driver 
> submenu. I may well be wrong here.

patch is for 2.6.13

--- rc1-a/arch/arm/Kconfig	2005-07-04 15:28:02.000000000 +0200
+++ rc1-b/arch/arm/Kconfig	2005-07-04 13:14:57.000000000 +0200
@@ -720,8 +720,6 @@ source "drivers/scsi/Kconfig"
 
 source "drivers/md/Kconfig"
 
-source "drivers/message/fusion/Kconfig"
-
 source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
--- rc1-a/arch/v850/Kconfig	2005-07-04 15:28:02.000000000 +0200
+++ rc1-b/arch/v850/Kconfig	2005-07-04 13:14:57.000000000 +0200
@@ -277,8 +277,6 @@ endmenu
 
 source "drivers/md/Kconfig"
 
-source "drivers/message/fusion/Kconfig"
-
 source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
--- rc1-a/arch/sparc64/Kconfig	2005-07-04 15:28:02.000000000 +0200
+++ rc1-b/arch/sparc64/Kconfig	2005-07-04 13:14:57.000000000 +0200
@@ -508,10 +508,6 @@ source "drivers/fc4/Kconfig"
 
 source "drivers/md/Kconfig"
 
-if PCI
-source "drivers/message/fusion/Kconfig"
-endif
-
 source "drivers/ieee1394/Kconfig"
 
 source "net/Kconfig"
--- rc1-a/drivers/scsi/Kconfig	2005-07-04 15:28:02.000000000 +0200
+++ rc1-b/drivers/scsi/Kconfig	2005-07-04 14:39:15.000000000 +0200
@@ -1485,19 +1485,6 @@ config SCSI_NSP32
 	  To compile this driver as a module, choose M here: the
 	  module will be called nsp32.
 
-config SCSI_DEBUG
-	tristate "SCSI debugging host simulator"
-	depends on SCSI
-	help
-	  This is a host adapter simulator that can simulate multiple hosts
-	  each with multiple dummy SCSI devices (disks). It defaults to one
-	  host adapter with one dummy SCSI disk. Each dummy disk uses kernel
-	  RAM as storage (i.e. it is a ramdisk). To save space when multiple
-	  dummy disks are simulated, they share the same kernel RAM for 
-	  their storage. See <http://www.torque.net/sg/sdebug.html> for more
-	  information. This driver is primarily of use to those testing the
-	  SCSI and block subsystems. If unsure, say N.
-
 config SCSI_MESH
 	tristate "MESH (Power Mac internal SCSI) support"
 	depends on PPC32 && PPC_PMAC && SCSI
@@ -1787,6 +1774,21 @@ config ZFCP
           called zfcp. If you want to compile it as a module, say M here
           and read <file:Documentation/modules.txt>.
 
-endmenu
+source "drivers/message/fusion/Kconfig"
 
 source "drivers/scsi/pcmcia/Kconfig"
+
+config SCSI_DEBUG
+	tristate "SCSI debugging host simulator"
+	depends on SCSI
+	help
+	  This is a host adapter simulator that can simulate multiple hosts
+	  each with multiple dummy SCSI devices (disks). It defaults to one
+	  host adapter with one dummy SCSI disk. Each dummy disk uses kernel
+	  RAM as storage (i.e. it is a ramdisk). To save space when multiple
+	  dummy disks are simulated, they share the same kernel RAM for 
+	  their storage. See <http://www.torque.net/sg/sdebug.html> for more
+	  information. This driver is primarily of use to those testing the
+	  SCSI and block subsystems. If unsure, say N.
+
+endmenu
--- rc1-a/drivers/cpufreq/Kconfig	2005-06-30 11:21:33.000000000 +0200
+++ rc1-b/drivers/cpufreq/Kconfig	2005-07-04 14:51:28.000000000 +0200
@@ -1,4 +1,4 @@
-config CPU_FREQ
+menuconfig CPU_FREQ
 	bool "CPU Frequency scaling"
 	help
 	  CPU Frequency scaling allows you to change the clock speed of 
--- rc1-a/drivers/message/fusion/Kconfig	2005-07-04 14:39:33.000000000 +0200
+++ rc1-b/drivers/message/fusion/Kconfig	2005-07-04 15:25:41.000000000 +0200
@@ -1,6 +1,7 @@
 
 menuconfig FUSION_DEVICES
 	bool "Fusion MPT device support"
+	depends on PCI && SCSI
 
 if FUSION_DEVICES
 
@@ -10,7 +11,6 @@ config FUSION
 
 config FUSION_SPI
 	tristate "Fusion MPT ScsiHost drivers for SPI"
-	depends on PCI && SCSI
 	select FUSION
 	---help---
 	  SCSI HOST support for a parallel SCSI host adapters.
@@ -24,7 +24,6 @@ config FUSION_SPI
 
 config FUSION_FC
 	tristate "Fusion MPT ScsiHost drivers for FC"
-	depends on PCI && SCSI
 	select FUSION
 	---help---
 	  SCSI HOST support for a Fiber Channel host adapters.
--- rc1-a/drivers/Kconfig	2005-07-04 15:28:02.000000000 +0200
+++ rc1-b/drivers/Kconfig	2005-07-04 13:14:57.000000000 +0200
@@ -20,8 +20,6 @@ source "drivers/cdrom/Kconfig"
 
 source "drivers/md/Kconfig"
 
-source "drivers/message/fusion/Kconfig"
-
 source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
-- 
Top 100 things you don't want the sysadmin to say:
26. What happens to a Hard Disk when you drop it?
