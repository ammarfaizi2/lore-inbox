Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbTJCXw7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTJCXms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:42:48 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25044 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261574AbTJCXkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:40:06 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill dummy init_dma_* from drivers/ide/pci/
Date: Sat, 4 Oct 2003 01:43:32 +0200
User-Agent: KMail/1.5.4
References: <200310040138.08690.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310040138.08690.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310040143.32386.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] ns87415: kill dummy init_dma_ns87415()

 drivers/ide/pci/ns87415.c |    5 -----
 drivers/ide/pci/ns87415.h |    2 --
 2 files changed, 7 deletions(-)

diff -puN drivers/ide/pci/ns87415.c~ide-ns87415-init_dma drivers/ide/pci/ns87415.c
--- linux-2.6.0-test6-bk2/drivers/ide/pci/ns87415.c~ide-ns87415-init_dma	2003-10-04 01:00:59.548345088 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/ns87415.c	2003-10-04 01:00:59.554344176 +0200
@@ -217,11 +217,6 @@ static void __init init_hwif_ns87415 (id
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-static void __init init_dma_ns87415 (ide_hwif_t *hwif, unsigned long dmabase)
-{
-	ide_setup_dma(hwif, dmabase, 8);
-}
-
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 
 static int __devinit ns87415_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff -puN drivers/ide/pci/ns87415.h~ide-ns87415-init_dma drivers/ide/pci/ns87415.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/ns87415.h~ide-ns87415-init_dma	2003-10-04 01:00:59.550344784 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/ns87415.h	2003-10-04 01:01:36.634707104 +0200
@@ -6,7 +6,6 @@
 #include <linux/ide.h>
 
 static void init_hwif_ns87415(ide_hwif_t *);
-static void init_dma_ns87415(ide_hwif_t *, unsigned long);
 
 static ide_pci_device_t ns87415_chipsets[] __devinitdata = {
 	{	/* 0 */
@@ -16,7 +15,6 @@ static ide_pci_device_t ns87415_chipsets
 		.init_chipset	= NULL,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_ns87415,
-                .init_dma	= init_dma_ns87415,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},

_

