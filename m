Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266017AbUBCPwN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 10:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUBCPwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 10:52:13 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58305 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266009AbUBCPv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 10:51:56 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] remove unused __ide_dma_retune() and ide_hwif_t->ide_dma_retune
Date: Tue, 3 Feb 2004 16:56:03 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402031656.03134.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First introduced in 2.3.99-pre3 (added to ide_dmaproc) and never used.

 linux-2.6.2-rc3-bk3-root/drivers/ide/ide-dma.c     |   18 ------------------
 linux-2.6.2-rc3-bk3-root/drivers/ide/ide.c         |    1 -
 linux-2.6.2-rc3-bk3-root/drivers/ide/pci/sgiioc4.c |    1 -
 linux-2.6.2-rc3-bk3-root/drivers/ide/ppc/pmac.c    |    1 -
 linux-2.6.2-rc3-bk3-root/include/linux/ide.h       |    3 ---
 5 files changed, 24 deletions(-)

diff -puN drivers/ide/ide.c~ide_dma_retune_cleanup drivers/ide/ide.c
--- linux-2.6.2-rc3-bk3/drivers/ide/ide.c~ide_dma_retune_cleanup	2004-02-03 15:58:42.869079616 +0100
+++ linux-2.6.2-rc3-bk3-root/drivers/ide/ide.c	2004-02-03 15:58:42.890076424 +0100
@@ -846,7 +846,6 @@ void ide_unregister (unsigned int index)
 	hwif->ide_dma_good_drive	= old_hwif.ide_dma_good_drive;
 	hwif->ide_dma_count		= old_hwif.ide_dma_count;
 	hwif->ide_dma_verbose		= old_hwif.ide_dma_verbose;
-	hwif->ide_dma_retune		= old_hwif.ide_dma_retune;
 	hwif->ide_dma_lostirq		= old_hwif.ide_dma_lostirq;
 	hwif->ide_dma_timeout		= old_hwif.ide_dma_timeout;
 	hwif->ide_dma_queued_on		= old_hwif.ide_dma_queued_on;
diff -puN drivers/ide/ide-dma.c~ide_dma_retune_cleanup drivers/ide/ide-dma.c
--- linux-2.6.2-rc3-bk3/drivers/ide/ide-dma.c~ide_dma_retune_cleanup	2004-02-03 15:58:42.872079160 +0100
+++ linux-2.6.2-rc3-bk3-root/drivers/ide/ide-dma.c	2004-02-03 15:58:42.892076120 +0100
@@ -850,22 +850,6 @@ int __ide_dma_verbose (ide_drive_t *driv
 
 EXPORT_SYMBOL(__ide_dma_verbose);
 
-/**
- *	__ide_dma_retune	-	default retune handler
- *	@drive: drive to retune
- *
- *	Default behaviour when we decide to return the IDE DMA setup.
- *	The default behaviour is "we don't"
- */
- 
-int __ide_dma_retune (ide_drive_t *drive)
-{
-	printk(KERN_WARNING "%s: chipset supported call only\n", __FUNCTION__);
-	return 1;
-}
-
-EXPORT_SYMBOL(__ide_dma_retune);
-
 int __ide_dma_lostirq (ide_drive_t *drive)
 {
 	printk("%s: DMA interrupt recovery\n", drive->name);
@@ -1104,8 +1088,6 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 		hwif->ide_dma_verbose = &__ide_dma_verbose;
 	if (!hwif->ide_dma_timeout)
 		hwif->ide_dma_timeout = &__ide_dma_timeout;
-	if (!hwif->ide_dma_retune)
-		hwif->ide_dma_retune = &__ide_dma_retune;
 	if (!hwif->ide_dma_lostirq)
 		hwif->ide_dma_lostirq = &__ide_dma_lostirq;
 
diff -puN drivers/ide/pci/sgiioc4.c~ide_dma_retune_cleanup drivers/ide/pci/sgiioc4.c
--- linux-2.6.2-rc3-bk3/drivers/ide/pci/sgiioc4.c~ide_dma_retune_cleanup	2004-02-03 15:58:42.876078552 +0100
+++ linux-2.6.2-rc3-bk3-root/drivers/ide/pci/sgiioc4.c	2004-02-03 15:58:42.894075816 +0100
@@ -653,7 +653,6 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 	hwif->ide_dma_good_drive = &__ide_dma_good_drive;
 	hwif->ide_dma_count = &__ide_dma_count;
 	hwif->ide_dma_verbose = &sgiioc4_ide_dma_verbose;
-	hwif->ide_dma_retune = &__ide_dma_retune;
 	hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
 	hwif->INB = &sgiioc4_INB;
diff -puN drivers/ide/ppc/pmac.c~ide_dma_retune_cleanup drivers/ide/ppc/pmac.c
--- linux-2.6.2-rc3-bk3/drivers/ide/ppc/pmac.c~ide_dma_retune_cleanup	2004-02-03 15:58:42.880077944 +0100
+++ linux-2.6.2-rc3-bk3-root/drivers/ide/ppc/pmac.c	2004-02-03 15:58:42.895075664 +0100
@@ -2029,7 +2029,6 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
 	hwif->ide_dma_bad_drive = &__ide_dma_bad_drive;
 	hwif->ide_dma_verbose = &__ide_dma_verbose;
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
-	hwif->ide_dma_retune = &__ide_dma_retune;
 	hwif->ide_dma_lostirq = &pmac_ide_dma_lostirq;
 	hwif->ide_dma_queued_on = &__ide_dma_queued_on;
 	hwif->ide_dma_queued_off = &__ide_dma_queued_off;
diff -puN include/linux/ide.h~ide_dma_retune_cleanup include/linux/ide.h
--- linux-2.6.2-rc3-bk3/include/linux/ide.h~ide_dma_retune_cleanup	2004-02-03 15:58:42.883077488 +0100
+++ linux-2.6.2-rc3-bk3-root/include/linux/ide.h	2004-02-03 15:58:42.898075208 +0100
@@ -799,7 +799,6 @@ typedef struct ide_dma_ops_s {
 	int (*ide_dma_good_drive)(ide_drive_t *drive);
 	int (*ide_dma_count)(ide_drive_t *drive);
 	int (*ide_dma_verbose)(ide_drive_t *drive);
-	int (*ide_dma_retune)(ide_drive_t *drive);
 	int (*ide_dma_lostirq)(ide_drive_t *drive);
 	int (*ide_dma_timeout)(ide_drive_t *drive);
 	/* dma queued operations */
@@ -945,7 +944,6 @@ typedef struct hwif_s {
 	int (*ide_dma_good_drive)(ide_drive_t *drive);
 	int (*ide_dma_count)(ide_drive_t *drive);
 	int (*ide_dma_verbose)(ide_drive_t *drive);
-	int (*ide_dma_retune)(ide_drive_t *drive);
 	int (*ide_dma_lostirq)(ide_drive_t *drive);
 	int (*ide_dma_timeout)(ide_drive_t *drive);
 
@@ -1637,7 +1635,6 @@ extern int __ide_dma_bad_drive(ide_drive
 extern int __ide_dma_good_drive(ide_drive_t *);
 extern int __ide_dma_count(ide_drive_t *);
 extern int __ide_dma_verbose(ide_drive_t *);
-extern int __ide_dma_retune(ide_drive_t *);
 extern int __ide_dma_lostirq(ide_drive_t *);
 extern int __ide_dma_timeout(ide_drive_t *);
 

_

