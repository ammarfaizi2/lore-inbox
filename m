Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbTJCXoe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTJCXo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:44:27 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26580 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261606AbTJCXlP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:41:15 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill dummy init_dma_* from drivers/ide/pci/
Date: Sat, 4 Oct 2003 01:44:43 +0200
User-Agent: KMail/1.5.4
References: <200310040138.08690.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310040138.08690.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310040144.43302.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] siimage: kill dummy init_dma_siimage()

 drivers/ide/pci/siimage.c |   14 --------------
 drivers/ide/pci/siimage.h |    4 ----
 2 files changed, 18 deletions(-)

diff -puN drivers/ide/pci/siimage.c~ide-siimage-init_dma drivers/ide/pci/siimage.c
--- linux-2.6.0-test6-bk2/drivers/ide/pci/siimage.c~ide-siimage-init_dma	2003-10-04 01:12:23.480371616 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/siimage.c	2003-10-04 01:12:23.486370704 +0200
@@ -1150,20 +1150,6 @@ static void __init init_hwif_siimage (id
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-/**
- *	init_dma_siimage	-	set up IDE DMA
- *	@hwif: interface
- *	@dmabase: DMA base address to use
- *	
- *	For the SI chips this requires no special set up so we can just
- *	let the IDE DMA core do the usual work.
- */
- 
-static void __init init_dma_siimage (ide_hwif_t *hwif, unsigned long dmabase)
-{
-	ide_setup_dma(hwif, dmabase, 8);
-}
-
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 
 
diff -puN drivers/ide/pci/siimage.h~ide-siimage-init_dma drivers/ide/pci/siimage.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/siimage.h~ide-siimage-init_dma	2003-10-04 01:12:23.483371160 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/siimage.h	2003-10-04 01:12:23.487370552 +0200
@@ -44,7 +44,6 @@ static ide_pci_host_proc_t siimage_procs
 static unsigned int init_chipset_siimage(struct pci_dev *, const char *);
 static void init_iops_siimage(ide_hwif_t *);
 static void init_hwif_siimage(ide_hwif_t *);
-static void init_dma_siimage(ide_hwif_t *, unsigned long);
 
 static ide_pci_device_t siimage_chipsets[] __devinitdata = {
 	{	/* 0 */
@@ -54,7 +53,6 @@ static ide_pci_device_t siimage_chipsets
 		.init_chipset	= init_chipset_siimage,
 		.init_iops	= init_iops_siimage,
 		.init_hwif	= init_hwif_siimage,
-		.init_dma	= init_dma_siimage,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -67,7 +65,6 @@ static ide_pci_device_t siimage_chipsets
 		.init_chipset	= init_chipset_siimage,
 		.init_iops	= init_iops_siimage,
 		.init_hwif	= init_hwif_siimage,
-		.init_dma	= init_dma_siimage,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
@@ -80,7 +77,6 @@ static ide_pci_device_t siimage_chipsets
 		.init_chipset	= init_chipset_siimage,
 		.init_iops	= init_iops_siimage,
 		.init_hwif	= init_hwif_siimage,
-		.init_dma	= init_dma_siimage,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},

_

