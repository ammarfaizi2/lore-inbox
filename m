Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWANTzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWANTzn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 14:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWANTzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 14:55:41 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3593 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750854AbWANTzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 14:55:21 -0500
Date: Sat, 14 Jan 2006 20:55:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, "Andrey J. Melnikoff" <temnota@kmv.ru>
Subject: [2.6 patch] always enable CONFIG_PDC202XX_FORCE
Message-ID: <20060114195521.GS29663@stusta.de>
References: <20060114152119.GN29663@stusta.de> <1137255183.20915.0.camel@localhost.localdomain> <58cb370e0601140947medcb66flf6b7281976683765@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0601140947medcb66flf6b7281976683765@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2006 at 06:47:31PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On 1/14/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Sad, 2006-01-14 at 16:21 +0100, Adrian Bunk wrote:
> > > Split PDC202XX_FORCE selection into two independ option and allow user
> > > select it only for specific driver.
> >
> > Seems pointless. We should always grab the raid cards. The option itself
> > is a mistake
> 
> Alan is right, these cards should always be grabbed in 2.6.x kernels.
> This option is a leftover from earlier 2.4.x days when Promise binary
> driver was available for using software RAID.
> 
> Could somebody submit a patch removing CONFIG_PDC202XX_FORCE?

Patch below.

> Bartlomiej

cu
Adrian


<--  snip  -->


This patch removes the CONFIG_PDC202XX_FORCE=n case.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

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

