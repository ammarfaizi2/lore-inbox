Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030485AbWJJVpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030485AbWJJVpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbWJJVpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:45:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32452 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030500AbWJJVpS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:45:18 -0400
To: torvalds@osdl.org
Subject: [PATCH] misc sata __iomem annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPPZ-0007KW-5V@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:45:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/ata/sata_sil.c |    2 +-
 drivers/ata/sata_svw.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index ae5edb8..ca8d993 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -349,7 +349,7 @@ static u32 sil_scr_read (struct ata_port
 
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
-	void *mmio = (void __iomem *) sil_scr_addr(ap, sc_reg);
+	void __iomem *mmio = (void __iomem *) sil_scr_addr(ap, sc_reg);
 	if (mmio)
 		writel(val, mmio);
 }
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 84025a2..db32d15 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -177,7 +177,7 @@ static void k2_bmdma_setup_mmio (struct 
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
 	u8 dmactl;
-	void *mmio = (void *) ap->ioaddr.bmdma_addr;
+	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
 	/* load PRD table addr. */
 	mb();	/* make sure PRD table writes are visible to controller */
 	writel(ap->prd_dma, mmio + ATA_DMA_TABLE_OFS);
@@ -205,7 +205,7 @@ static void k2_bmdma_setup_mmio (struct 
 static void k2_bmdma_start_mmio (struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	void *mmio = (void *) ap->ioaddr.bmdma_addr;
+	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
 	u8 dmactl;
 
 	/* start host DMA transaction */
-- 
1.4.2.GIT


