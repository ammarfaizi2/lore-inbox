Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWA1XFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWA1XFP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 18:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWA1XFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 18:05:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48139 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750786AbWA1XE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 18:04:57 -0500
Date: Sun, 29 Jan 2006 00:04:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: [2.6 patch] always enable CONFIG_PDC202XX_FORCE
Message-ID: <20060128230456.GW3777@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the CONFIG_PDC202XX_FORCE=n case.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 22 Jan 2006
- 14 Jan 2006

 drivers/ide/Kconfig            |    7 -------
 drivers/ide/pci/pdc202xx_new.c |    6 ------
 drivers/ide/pci/pdc202xx_old.c |   15 ---------------
 3 files changed, 28 deletions(-)

--- linux-2.6.15-mm4-full/drivers/ide/Kconfig.old	2006-01-14 20:43:13.000000000 +0100
+++ linux-2.6.15-mm4-full/drivers/ide/Kconfig	2006-01-14 20:43:23.000000000 +0100
@@ -673,13 +673,6 @@
 config BLK_DEV_PDC202XX_NEW
 	tristate "PROMISE PDC202{68|69|70|71|75|76|77} support"
 
-# FIXME - probably wants to be one for old and for new
-config PDC202XX_FORCE
-	bool "Enable controller even if disabled by BIOS"
-	depends on BLK_DEV_PDC202XX_NEW
-	help
-	  Enable the PDC202xx controller even if it has been disabled in the BIOS setup.
-
 config BLK_DEV_SVWKS
 	tristate "ServerWorks OSB4/CSB5/CSB6 chipsets support"
 	help
--- linux-2.6.15-mm4-full/drivers/ide/pci/pdc202xx_new.c.old	2006-01-14 20:43:30.000000000 +0100
+++ linux-2.6.15-mm4-full/drivers/ide/pci/pdc202xx_new.c	2006-01-14 20:43:51.000000000 +0100
@@ -420,9 +420,6 @@
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 	},{	/* 3 */
 		.name		= "PDC20271",
@@ -447,9 +444,6 @@
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 	},{	/* 6 */
 		.name		= "PDC20277",
--- linux-2.6.15-mm4-full/drivers/ide/pci/pdc202xx_old.c.old	2006-01-14 20:44:01.000000000 +0100
+++ linux-2.6.15-mm4-full/drivers/ide/pci/pdc202xx_old.c	2006-01-14 20:44:21.000000000 +0100
@@ -786,9 +786,6 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 		.extra		= 16,
 	},{	/* 1 */
@@ -799,9 +796,6 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
 		.flags		= IDEPCI_FLAG_FORCE_PDC,
@@ -813,9 +807,6 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
 	},{	/* 3 */
@@ -826,9 +817,6 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
 		.flags		= IDEPCI_FLAG_FORCE_PDC,
@@ -840,9 +828,6 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
 	}

