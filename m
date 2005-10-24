Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbVJXKd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVJXKd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 06:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVJXKd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 06:33:29 -0400
Received: from magic.adaptec.com ([216.52.22.17]:24453 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1750838AbVJXKd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 06:33:28 -0400
Subject: [PATCH] sata: Fixes several warnings in sata_vsc.c and sata_svw.c
From: Ashutosh Naik <ashutosh_naik@adaptec.com>
To: jeremy@sgi.com, benh@kernel.crashing.org, jgarzik@pobox.com,
       Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-Ce8EcRnZpxbWkN8ZVbx+"
Message-Id: <1130150013.16820.66.camel@kir9060.adaptec.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 24 Oct 2005 16:03:33 +0530
X-OriginalArrivalTime: 24 Oct 2005 10:33:18.0850 (UTC) FILETIME=[597CDE20:01C5D886]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ce8EcRnZpxbWkN8ZVbx+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes several types in sata_vsc.c and sata_svw.c and hence
fixes tons of compiler warnings.

Signed-off-by: Ashutosh Naik <ashutosh_naik@adaptec.com>

--=-Ce8EcRnZpxbWkN8ZVbx+
Content-Disposition: attachment; filename=sata-patch.txt
Content-Type: text/plain; name=sata-patch.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -ruNp linux-sata/drivers/scsi/sata_svw.c linux-2.6.14-rc5/drivers/scsi/sata_svw.c
--- linux-sata/drivers/scsi/sata_svw.c	2005-10-24 15:16:31.000000000 +0530
+++ linux-2.6.14-rc5/drivers/scsi/sata_svw.c	2005-10-24 14:36:51.000000000 +0530
@@ -108,26 +108,26 @@ static void k2_sata_tf_load(struct ata_p
 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
 
 	if (tf->ctl != ap->last_ctl) {
-		writeb(tf->ctl, (unsigned long *)ioaddr->ctl_addr);
+		writeb(tf->ctl, ioaddr->ctl_addr);
 		ap->last_ctl = tf->ctl;
 		ata_wait_idle(ap);
 	}
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
-		writew(tf->feature | (((u16)tf->hob_feature) << 8), (unsigned long *)ioaddr->feature_addr);
-		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), (unsigned long *)ioaddr->nsect_addr);
-		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), (unsigned long *)ioaddr->lbal_addr);
-		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), (unsigned long *)ioaddr->lbam_addr);
-		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), (unsigned long *)ioaddr->lbah_addr);
+		writew(tf->feature | (((u16)tf->hob_feature) << 8), ioaddr->feature_addr);
+		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), ioaddr->nsect_addr);
+		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), ioaddr->lbal_addr);
+		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), ioaddr->lbam_addr);
+		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), ioaddr->lbah_addr);
 	} else if (is_addr) {
-		writew(tf->feature, (unsigned long *)ioaddr->feature_addr);
-		writew(tf->nsect, (unsigned long *)ioaddr->nsect_addr);
-		writew(tf->lbal, (unsigned long *)ioaddr->lbal_addr);
-		writew(tf->lbam, (unsigned long *)ioaddr->lbam_addr);
-		writew(tf->lbah, (unsigned long *)ioaddr->lbah_addr);
+		writew(tf->feature, ioaddr->feature_addr);
+		writew(tf->nsect, ioaddr->nsect_addr);
+		writew(tf->lbal, ioaddr->lbal_addr);
+		writew(tf->lbam, ioaddr->lbam_addr);
+		writew(tf->lbah, ioaddr->lbah_addr);
 	}
 
 	if (tf->flags & ATA_TFLAG_DEVICE)
-		writeb(tf->device, (unsigned long *)ioaddr->device_addr);
+		writeb(tf->device, ioaddr->device_addr);
 
 	ata_wait_idle(ap);
 }
@@ -138,14 +138,14 @@ static void k2_sata_tf_read(struct ata_p
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	u16 nsect, lbal, lbam, lbah;
 
-	nsect = tf->nsect = readw((unsigned long *)ioaddr->nsect_addr);
-	lbal = tf->lbal = readw((unsigned long *)ioaddr->lbal_addr);
-	lbam = tf->lbam = readw((unsigned long *)ioaddr->lbam_addr);
-	lbah = tf->lbah = readw((unsigned long *)ioaddr->lbah_addr);
-	tf->device = readw((unsigned long *)ioaddr->device_addr);
+	nsect = tf->nsect = readw(ioaddr->nsect_addr);
+	lbal = tf->lbal = readw(ioaddr->lbal_addr);
+	lbam = tf->lbam = readw(ioaddr->lbam_addr);
+	lbah = tf->lbah = readw(ioaddr->lbah_addr);
+	tf->device = readw(ioaddr->device_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		tf->hob_feature = readw((unsigned long *)ioaddr->error_addr) >> 8;
+		tf->hob_feature = readw(ioaddr->error_addr) >> 8;
 		tf->hob_nsect = nsect >> 8;
 		tf->hob_lbal = lbal >> 8;
 		tf->hob_lbam = lbam >> 8;
diff -ruNp linux-sata/drivers/scsi/sata_vsc.c linux-2.6.14-rc5/drivers/scsi/sata_vsc.c
--- linux-sata/drivers/scsi/sata_vsc.c	2005-10-24 15:16:30.000000000 +0530
+++ linux-2.6.14-rc5/drivers/scsi/sata_vsc.c	2005-10-24 14:36:51.000000000 +0530
@@ -106,12 +106,12 @@ static void vsc_intr_mask_update(struct 
 
 	mask_addr = (unsigned long) ap->host_set->mmio_base +
 		VSC_SATA_INT_MASK_OFFSET + ap->port_no;
-	mask = readb((unsigned long *)mask_addr);
+	mask = readb(mask_addr);
 	if (ctl & ATA_NIEN)
 		mask |= 0x80;
 	else
 		mask &= 0x7F;
-	writeb(mask, (unsigned long *)mask_addr);
+	writeb(mask, mask_addr);
 }
 
 
@@ -130,21 +130,21 @@ static void vsc_sata_tf_load(struct ata_
 		vsc_intr_mask_update(ap, tf->ctl & ATA_NIEN);
 	}
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
-		writew(tf->feature | (((u16)tf->hob_feature) << 8), (unsigned long *)ioaddr->feature_addr);
-		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), (unsigned long *)ioaddr->nsect_addr);
-		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), (unsigned long *)ioaddr->lbal_addr);
-		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), (unsigned long *)ioaddr->lbam_addr);
-		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), (unsigned long *)ioaddr->lbah_addr);
+		writew(tf->feature | (((u16)tf->hob_feature) << 8), ioaddr->feature_addr);
+		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), ioaddr->nsect_addr);
+		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), ioaddr->lbal_addr);
+		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), ioaddr->lbam_addr);
+		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), ioaddr->lbah_addr);
 	} else if (is_addr) {
-		writew(tf->feature, (unsigned long *)ioaddr->feature_addr);
-		writew(tf->nsect, (unsigned long *)ioaddr->nsect_addr);
-		writew(tf->lbal, (unsigned long *)ioaddr->lbal_addr);
-		writew(tf->lbam, (unsigned long *)ioaddr->lbam_addr);
-		writew(tf->lbah, (unsigned long *)ioaddr->lbah_addr);
+		writew(tf->feature, ioaddr->feature_addr);
+		writew(tf->nsect, ioaddr->nsect_addr);
+		writew(tf->lbal, ioaddr->lbal_addr);
+		writew(tf->lbam, ioaddr->lbam_addr);
+		writew(tf->lbah, ioaddr->lbah_addr);
 	}
 
 	if (tf->flags & ATA_TFLAG_DEVICE)
-		writeb(tf->device, (unsigned long *)ioaddr->device_addr);
+		writeb(tf->device, ioaddr->device_addr);
 
 	ata_wait_idle(ap);
 }
@@ -155,14 +155,14 @@ static void vsc_sata_tf_read(struct ata_
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	u16 nsect, lbal, lbam, lbah;
 
-	nsect = tf->nsect = readw((unsigned long *)ioaddr->nsect_addr);
-	lbal = tf->lbal = readw((unsigned long *)ioaddr->lbal_addr);
-	lbam = tf->lbam = readw((unsigned long *)ioaddr->lbam_addr);
-	lbah = tf->lbah = readw((unsigned long *)ioaddr->lbah_addr);
-	tf->device = readw((unsigned long *)ioaddr->device_addr);
+	nsect = tf->nsect = readw(ioaddr->nsect_addr);
+	lbal = tf->lbal = readw(ioaddr->lbal_addr);
+	lbam = tf->lbam = readw(ioaddr->lbam_addr);
+	lbah = tf->lbah = readw(ioaddr->lbah_addr);
+	tf->device = readw(ioaddr->device_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		tf->hob_feature = readb((unsigned long *)ioaddr->error_addr);
+		tf->hob_feature = readb(ioaddr->error_addr);
 		tf->hob_nsect = nsect >> 8;
 		tf->hob_lbal = lbal >> 8;
 		tf->hob_lbam = lbam >> 8;
@@ -272,8 +272,8 @@ static void __devinit vsc_sata_setup_por
 	port->ctl_addr		= base + VSC_SATA_TF_CTL_OFFSET;
 	port->bmdma_addr	= base + VSC_SATA_DMA_CMD_OFFSET;
 	port->scr_addr		= base + VSC_SATA_SCR_STATUS_OFFSET;
-	writel(0, (unsigned long *)base + VSC_SATA_UP_DESCRIPTOR_OFFSET);
-	writel(0, (unsigned long *)base + VSC_SATA_UP_DATA_BUFFER_OFFSET);
+	writel(0, base + VSC_SATA_UP_DESCRIPTOR_OFFSET);
+	writel(0, base + VSC_SATA_UP_DATA_BUFFER_OFFSET);
 }
 
 

--=-Ce8EcRnZpxbWkN8ZVbx+--


