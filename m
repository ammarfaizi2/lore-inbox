Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWANPVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWANPVW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 10:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWANPVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 10:21:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:263 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964783AbWANPVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 10:21:19 -0500
Date: Sat, 14 Jan 2006 16:21:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       "Andrey J. Melnikoff" <temnota@kmv.ru>
Subject: [2.6 patch] Fix PDC202XX_FORCE kconfig selection
Message-ID: <20060114152119.GN29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Split PDC202XX_FORCE selection into two independ option and allow user
select it only for specific driver.


Signed-off-by: Andrey Melnikov <temnota@kmv.ru>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Andrey J. Melnikoff on:
- 28 Dec 2005

 drivers/ide/Kconfig            |    9 +++++++--
 drivers/ide/pci/pdc202xx_new.c |    4 ++--
 drivers/ide/pci/pdc202xx_old.c |   10 +++++-----
 3 files changed, 14 insertions(+), 9 deletions(-)

--- linux/drivers/ide/Kconfig~	2005-12-28 21:51:52.000000000 +0300
+++ linux/drivers/ide/Kconfig	2005-12-28 21:51:52.000000000 +0300
@@ -670,11 +670,16 @@
 
 	  If unsure, say N.
 
+config PDC202XX_OLD_FORCE
+	bool "Enable controller even if disabled by BIOS"
+	depends on BLK_DEV_PDC202XX_OLD
+	help
+	  Enable the PDC202xx controller even if it has been disabled in the BIOS setup.
+
 config BLK_DEV_PDC202XX_NEW
 	tristate "PROMISE PDC202{68|69|70|71|75|76|77} support"
 
-# FIXME - probably wants to be one for old and for new
-config PDC202XX_FORCE
+config PDC202XX_NEW_FORCE
 	bool "Enable controller even if disabled by BIOS"
 	depends on BLK_DEV_PDC202XX_NEW
 	help
--- linux/drivers/ide/pci/pdc202xx_new.c~	2005-12-28 21:52:32.000000000 +0300
+++ linux/drivers/ide/pci/pdc202xx_new.c	2005-12-28 21:52:32.000000000 +0300
@@ -420,7 +420,7 @@
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
+#ifndef CONFIG_PDC202XX_NEW_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
@@ -447,7 +447,7 @@
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
+#ifndef CONFIG_PDC202XX_NEW_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
--- linux/drivers/ide/pci/pdc202xx_old.c~	2005-12-28 21:53:26.000000000 +0300
+++ linux/drivers/ide/pci/pdc202xx_old.c	2005-12-28 21:53:26.000000000 +0300
@@ -786,7 +786,7 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
+#ifndef CONFIG_PDC202XX_OLD_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
@@ -799,7 +799,7 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
+#ifndef CONFIG_PDC202XX_OLD_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
@@ -813,7 +813,7 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
+#ifndef CONFIG_PDC202XX_OLD_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
@@ -826,7 +826,7 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
+#ifndef CONFIG_PDC202XX_OLD_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
@@ -840,7 +840,7 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
+#ifndef CONFIG_PDC202XX_OLD_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,

