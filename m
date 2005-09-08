Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932671AbVIHPPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbVIHPPq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVIHPPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:15:46 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:31726 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932671AbVIHPPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:15:30 -0400
Date: Thu, 8 Sep 2005 08:15:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: IDE Mailing List <linux-ide@vger.kernel.org>
Subject: [PATCH 2.6.13] ide: ide-dma.c should always check hwif->cds before hwif->cds->foo
Message-ID: <20050908151529.GL3966@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases (such as the mips Toshiba TX4939 w/ onboard IDE, not PCI
IDE), hwif->cds can be NULL, so test that prior to testing
hwif->cds->foo

Signed-off-by: Hiroshi DOYU <hdoyu@mvista.com>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Index: linux-2.6/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma.c
+++ linux-2.6/drivers/ide/ide-dma.c
@@ -846,7 +846,7 @@ static int ide_mapped_mmio_dma(ide_hwif_
 	printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
 
 	hwif->dma_base = base;
-	if (hwif->cds->extra && hwif->channel == 0)
+	if (hwif->cds && hwif->cds->extra && hwif->channel == 0)
 		hwif->dma_extra = hwif->cds->extra;
 
 	if(hwif->mate)
@@ -865,7 +865,7 @@ static int ide_iomio_dma(ide_hwif_t *hwi
 		return 1;
 	}
 	hwif->dma_base = base;
-	if ((hwif->cds->extra) && (hwif->channel == 0)) {
+	if (hwif->cds && hwif->cds->extra && (hwif->channel == 0)) {
 		request_region(base+16, hwif->cds->extra, hwif->cds->name);
 		hwif->dma_extra = hwif->cds->extra;
 	}

-- 
Tom Rini
http://gate.crashing.org/~trini/
