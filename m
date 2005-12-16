Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVLPObj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVLPObj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVLPObj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:31:39 -0500
Received: from verein.lst.de ([213.95.11.210]:11674 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932290AbVLPObi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:31:38 -0500
Date: Fri, 16 Dec 2005 15:31:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, schwidefsky@de.ibm.com, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] build dasd_cmd into dasd_mod
Message-ID: <20051216143120.GA19541@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dasd_cmd is just a tiny compat shim.  Building it into dasd_mod if
enabled makes fixing some ioctl mess a lot easier (see patch 2).


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6.15-rc5/drivers/s390/block/Kconfig
===================================================================
--- linux-2.6.15-rc5.orig/drivers/s390/block/Kconfig	2005-12-12 18:31:37.000000000 +0100
+++ linux-2.6.15-rc5/drivers/s390/block/Kconfig	2005-12-16 15:18:16.000000000 +0100
@@ -56,7 +56,7 @@
 	  say "N".
 
 config DASD_CMB
-	tristate "Compatibility interface for DASD channel measurement blocks"
+	bool "Compatibility interface for DASD channel measurement blocks"
 	depends on DASD
 	help
 	  This driver provides an additional interface to the channel measurement
Index: linux-2.6.15-rc5/drivers/s390/block/Makefile
===================================================================
--- linux-2.6.15-rc5.orig/drivers/s390/block/Makefile	2005-12-12 18:31:37.000000000 +0100
+++ linux-2.6.15-rc5/drivers/s390/block/Makefile	2005-12-16 15:19:24.000000000 +0100
@@ -2,16 +2,17 @@
 # S/390 block devices
 #
 
-dasd_eckd_mod-objs := dasd_eckd.o dasd_3990_erp.o dasd_9343_erp.o
-dasd_fba_mod-objs  := dasd_fba.o dasd_3370_erp.o dasd_9336_erp.o
-dasd_diag_mod-objs := dasd_diag.o
-dasd_mod-objs      := dasd.o dasd_ioctl.o dasd_proc.o dasd_devmap.o \
-			dasd_genhd.o dasd_erp.o
+dasd_eckd_mod-y	+= dasd_eckd.o dasd_3990_erp.o dasd_9343_erp.o
+dasd_fba_mod-y	+= dasd_fba.o dasd_3370_erp.o dasd_9336_erp.o
+dasd_diag_mod-y	+= dasd_diag.o
+dasd_mod-y	+= dasd.o dasd_ioctl.o dasd_proc.o dasd_devmap.o \
+		   dasd_genhd.o dasd_erp.o
+
+dasd_mod-$(CONFIG_DASD_CMB) += dasd_cmb.o
 
 obj-$(CONFIG_DASD) += dasd_mod.o
 obj-$(CONFIG_DASD_DIAG) += dasd_diag_mod.o
 obj-$(CONFIG_DASD_ECKD) += dasd_eckd_mod.o
 obj-$(CONFIG_DASD_FBA)  += dasd_fba_mod.o
-obj-$(CONFIG_DASD_CMB)  += dasd_cmb.o
 obj-$(CONFIG_BLK_DEV_XPRAM) += xpram.o
 obj-$(CONFIG_DCSSBLK) += dcssblk.o
