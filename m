Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVIEScx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVIEScx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVIEScx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:32:53 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:54883 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932389AbVIEScw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:32:52 -0400
Message-Id: <20050905183247.593067000@kohtala.home.org>
References: <20050905183109.284672000@kohtala.home.org>
Date: Mon, 05 Sep 2005 21:31:17 +0300
From: marko.kohtala@gmail.com
To: akpm@osdl.org
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [patch 08/10] parport: ieee1284 fixes and cleanups
Content-Disposition: inline; filename=parport-correct-dependency-on-parport-pc-rather-than-just-parport.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make drivers that use directly PC parport HW depend on PARPORT_PC
rather than HW independent PARPORT.

Signed-off-by: Marko Kohtala <marko.kohtala@gmail.com>

---

 drivers/block/Kconfig        |    2 +-
 drivers/block/paride/Kconfig |    5 +++--
 drivers/scsi/Kconfig         |    8 ++++----
 3 files changed, 8 insertions(+), 7 deletions(-)

Index: linux-dvb/drivers/block/Kconfig
===================================================================
--- linux-dvb.orig/drivers/block/Kconfig	2005-06-23 22:12:45.000000000 +0300
+++ linux-dvb/drivers/block/Kconfig	2005-06-24 13:03:46.000000000 +0300
@@ -117,7 +117,7 @@ config BLK_DEV_XD
 
 config PARIDE
 	tristate "Parallel port IDE device support"
-	depends on PARPORT
+	depends on PARPORT_PC
 	---help---
 	  There are many external CD-ROM and disk devices that connect through
 	  your computer's parallel port. Most of them are actually IDE devices
Index: linux-dvb/drivers/block/paride/Kconfig
===================================================================
--- linux-dvb.orig/drivers/block/paride/Kconfig	2005-06-23 22:12:45.000000000 +0300
+++ linux-dvb/drivers/block/paride/Kconfig	2005-06-24 13:03:46.000000000 +0300
@@ -4,11 +4,12 @@
 # PARIDE doesn't need PARPORT, but if PARPORT is configured as a module,
 # PARIDE must also be a module.  The bogus CONFIG_PARIDE_PARPORT option
 # controls the choices given to the user ...
+# PARIDE only supports PC style parports. Tough for USB or other parports...
 config PARIDE_PARPORT
 	tristate
 	depends on PARIDE!=n
-	default m if PARPORT=m
-	default y if PARPORT!=m
+	default m if PARPORT_PC=m
+	default y if PARPORT_PC!=m
 
 comment "Parallel IDE high-level drivers"
 	depends on PARIDE
Index: linux-dvb/drivers/scsi/Kconfig
===================================================================
--- linux-dvb.orig/drivers/scsi/Kconfig	2005-06-24 10:41:40.000000000 +0300
+++ linux-dvb/drivers/scsi/Kconfig	2005-06-24 13:03:46.000000000 +0300
@@ -855,7 +855,7 @@ config SCSI_INIA100
 
 config SCSI_PPA
 	tristate "IOMEGA parallel port (ppa - older drives)"
-	depends on SCSI && PARPORT
+	depends on SCSI && PARPORT_PC
 	---help---
 	  This driver supports older versions of IOMEGA's parallel port ZIP
 	  drive (a 100 MB removable media device).
@@ -882,7 +882,7 @@ config SCSI_PPA
 
 config SCSI_IMM
 	tristate "IOMEGA parallel port (imm - newer drives)"
-	depends on SCSI && PARPORT
+	depends on SCSI && PARPORT_PC
 	---help---
 	  This driver supports newer versions of IOMEGA's parallel port ZIP
 	  drive (a 100 MB removable media device).
@@ -909,7 +909,7 @@ config SCSI_IMM
 
 config SCSI_IZIP_EPP16
 	bool "ppa/imm option - Use slow (but safe) EPP-16"
-	depends on PARPORT && (SCSI_PPA || SCSI_IMM)
+	depends on SCSI_PPA || SCSI_IMM
 	---help---
 	  EPP (Enhanced Parallel Port) is a standard for parallel ports which
 	  allows them to act as expansion buses that can handle up to 64
@@ -924,7 +924,7 @@ config SCSI_IZIP_EPP16
 
 config SCSI_IZIP_SLOW_CTR
 	bool "ppa/imm option - Assume slow parport control register"
-	depends on PARPORT && (SCSI_PPA || SCSI_IMM)
+	depends on SCSI_PPA || SCSI_IMM
 	help
 	  Some parallel ports are known to have excessive delays between
 	  changing the parallel port control register and good data being

--
