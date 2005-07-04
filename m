Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVGDNzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVGDNzY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 09:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVGDNzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 09:55:24 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:19073 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S261703AbVGDNkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 09:40:11 -0400
Date: Mon, 4 Jul 2005 15:39:32 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Kconfig changes 6: Move the Fusion MPT menu
In-Reply-To: <Pine.LNX.4.58.0507041251220.8687@be1.lrz>
Message-ID: <Pine.LNX.4.58.0507041520370.11818@be1.lrz>
References: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
 <Pine.LNX.4.58.0507041134410.3798@be1.lrz> <Pine.LNX.4.58.0507041210190.6165@be1.lrz>
 <Pine.LNX.4.58.0507041231200.6165@be1.lrz> <Pine.LNX.4.58.0507041251220.8687@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2005, Bodo Eggert wrote:

> Part 4: The profiling menu.
       ^
Obviously I can't count to 5.

And now to something completely different:

The Fusion MPT controler seems to belong into the SCSI low level driver 
submenu. I may well be wrong here.

patch is for 2.6.12, 2.6.13 will be posted in a reply

--- a/./arch/arm/Kconfig	2005-07-04 12:44:17.000000000 +0200
+++ b/./arch/arm/Kconfig	2005-07-04 13:04:23.000000000 +0200
@@ -695,8 +695,6 @@ source "drivers/scsi/Kconfig"
 
 source "drivers/md/Kconfig"
 
-source "drivers/message/fusion/Kconfig"
-
 source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
--- a/./arch/v850/Kconfig	2005-05-02 02:25:41.000000000 +0200
+++ b/./arch/v850/Kconfig	2005-07-04 13:05:04.000000000 +0200
@@ -275,8 +275,6 @@ endmenu
 
 source "drivers/md/Kconfig"
 
-source "drivers/message/fusion/Kconfig"
-
 source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
--- a/./arch/sparc64/Kconfig	2005-06-19 14:16:20.000000000 +0200
+++ b/./arch/sparc64/Kconfig	2005-07-04 13:05:19.000000000 +0200
@@ -506,10 +506,6 @@ source "drivers/fc4/Kconfig"
 
 source "drivers/md/Kconfig"
 
-if PCI
-source "drivers/message/fusion/Kconfig"
-endif
-
 source "drivers/ieee1394/Kconfig"
 
 source "net/Kconfig"
--- a/./drivers/scsi/Kconfig	2005-07-04 11:10:43.000000000 +0200
+++ b/./drivers/scsi/Kconfig	2005-07-04 13:13:38.000000000 +0200
@@ -1489,19 +1489,6 @@ config SCSI_NSP32
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
@@ -1791,6 +1778,21 @@ config ZFCP
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
--- a/./drivers/Kconfig	2005-05-02 02:25:41.000000000 +0200
+++ b/./drivers/Kconfig	2005-07-04 13:05:25.000000000 +0200
@@ -20,8 +20,6 @@ source "drivers/cdrom/Kconfig"
 
 source "drivers/md/Kconfig"
 
-source "drivers/message/fusion/Kconfig"
-
 source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
-- 
S.U.Z.U.K.I.: Synthetic Unit Zoned for Ultimate Killing and Infiltration
        -- http://www.brunching.com/toys/toy-cyborger.html
