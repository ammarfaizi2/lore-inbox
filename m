Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTJCXjE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTJCXjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:39:02 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14036 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261555AbTJCXiz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:38:55 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill dummy init_dma_* from drivers/ide/pci/
Date: Sat, 4 Oct 2003 01:42:30 +0200
User-Agent: KMail/1.5.4
References: <200310040138.08690.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310040138.08690.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310040142.30881.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] cs5530: kill dummy init_dma_cs5530()

 drivers/ide/pci/cs5530.c |   13 -------------
 drivers/ide/pci/cs5530.h |    2 --
 2 files changed, 15 deletions(-)

diff -puN drivers/ide/pci/cs5530.c~ide-cs5530-init_dma drivers/ide/pci/cs5530.c
--- linux-2.6.0-test6-bk2/drivers/ide/pci/cs5530.c~ide-cs5530-init_dma	2003-10-04 00:59:46.652426952 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/cs5530.c	2003-10-04 00:59:46.658426040 +0200
@@ -404,19 +404,6 @@ static void __init init_hwif_cs5530 (ide
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-/**
- *	init_dma_cs5530		-	set up for DMA
- *	@hwif: interface
- *	@dmabase: DMA base address
- *
- *	FIXME: this can go away
- */
- 
-static void __init init_dma_cs5530 (ide_hwif_t *hwif, unsigned long dmabase)
-{
-	ide_setup_dma(hwif, dmabase, 8);
-}
-
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 
 
diff -puN drivers/ide/pci/cs5530.h~ide-cs5530-init_dma drivers/ide/pci/cs5530.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/cs5530.h~ide-cs5530-init_dma	2003-10-04 00:59:46.655426496 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/cs5530.h	2003-10-04 00:59:46.659425888 +0200
@@ -27,7 +27,6 @@ static ide_pci_host_proc_t cs5530_procs[
 
 static unsigned int init_chipset_cs5530(struct pci_dev *, const char *);
 static void init_hwif_cs5530(ide_hwif_t *);
-static void init_dma_cs5530(ide_hwif_t *, unsigned long);
 
 static ide_pci_device_t cs5530_chipsets[] __devinitdata = {
 	{	/* 0 */
@@ -37,7 +36,6 @@ static ide_pci_device_t cs5530_chipsets[
 		.init_chipset	= init_chipset_cs5530,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_cs5530,
-		.init_dma	= init_dma_cs5530,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},

_

