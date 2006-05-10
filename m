Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWEJDEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWEJDEP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 23:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWEJC4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:56:35 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:52029 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932431AbWEJC40
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:26 -0400
Date: Tue, 9 May 2006 19:56:06 -0700
Message-Id: <200605100256.k4A2u6Hu031761@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: jeremy@sgi.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] sata_vsc gcc 4.1 warning fix 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning,

drivers/scsi/sata_vsc.c:152: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:153: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:154: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:155: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:156: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:158: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:159: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:160: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:161: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:162: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:166: warning: passing argument 2 of 'writeb' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c: In function 'vsc_sata_tf_read':
drivers/scsi/sata_vsc.c:178: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:179: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:180: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:181: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:182: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:183: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c: In function 'vsc_sata_setup_port':
drivers/scsi/sata_vsc.c:320: warning: passing argument 2 of 'writel' makes pointer from integer without a cast
drivers/scsi/sata_vsc.c:321: warning: passing argument 2 of 'writel' makes pointer from integer without a cast

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/scsi/sata_vsc.c
===================================================================
--- linux-2.6.16.orig/drivers/scsi/sata_vsc.c
+++ linux-2.6.16/drivers/scsi/sata_vsc.c
@@ -149,21 +149,21 @@ static void vsc_sata_tf_load(struct ata_
 		vsc_intr_mask_update(ap, tf->ctl & ATA_NIEN);
 	}
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
-		writew(tf->feature | (((u16)tf->hob_feature) << 8), ioaddr->feature_addr);
-		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), ioaddr->nsect_addr);
-		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), ioaddr->lbal_addr);
-		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), ioaddr->lbam_addr);
-		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), ioaddr->lbah_addr);
+		writew(tf->feature | (((u16)tf->hob_feature) << 8), (void *)ioaddr->feature_addr);
+		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), (void *)ioaddr->nsect_addr);
+		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), (void *)ioaddr->lbal_addr);
+		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), (void *)ioaddr->lbam_addr);
+		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), (void *)ioaddr->lbah_addr);
 	} else if (is_addr) {
-		writew(tf->feature, ioaddr->feature_addr);
-		writew(tf->nsect, ioaddr->nsect_addr);
-		writew(tf->lbal, ioaddr->lbal_addr);
-		writew(tf->lbam, ioaddr->lbam_addr);
-		writew(tf->lbah, ioaddr->lbah_addr);
+		writew(tf->feature, (void *)ioaddr->feature_addr);
+		writew(tf->nsect, (void *)ioaddr->nsect_addr);
+		writew(tf->lbal, (void *)ioaddr->lbal_addr);
+		writew(tf->lbam, (void *)ioaddr->lbam_addr);
+		writew(tf->lbah, (void *)ioaddr->lbah_addr);
 	}
 
 	if (tf->flags & ATA_TFLAG_DEVICE)
-		writeb(tf->device, ioaddr->device_addr);
+		writeb(tf->device, (void *)ioaddr->device_addr);
 
 	ata_wait_idle(ap);
 }
@@ -175,12 +175,12 @@ static void vsc_sata_tf_read(struct ata_
 	u16 nsect, lbal, lbam, lbah, feature;
 
 	tf->command = ata_check_status(ap);
-	tf->device = readw(ioaddr->device_addr);
-	feature = readw(ioaddr->error_addr);
-	nsect = readw(ioaddr->nsect_addr);
-	lbal = readw(ioaddr->lbal_addr);
-	lbam = readw(ioaddr->lbam_addr);
-	lbah = readw(ioaddr->lbah_addr);
+	tf->device = readw((void *)ioaddr->device_addr);
+	feature = readw((void *)ioaddr->error_addr);
+	nsect = readw((void *)ioaddr->nsect_addr);
+	lbal = readw((void *)ioaddr->lbal_addr);
+	lbam = readw((void *)ioaddr->lbam_addr);
+	lbah = readw((void *)ioaddr->lbah_addr);
 
 	tf->feature = feature;
 	tf->nsect = nsect;
@@ -317,8 +317,8 @@ static void __devinit vsc_sata_setup_por
 	port->ctl_addr		= base + VSC_SATA_TF_CTL_OFFSET;
 	port->bmdma_addr	= base + VSC_SATA_DMA_CMD_OFFSET;
 	port->scr_addr		= base + VSC_SATA_SCR_STATUS_OFFSET;
-	writel(0, base + VSC_SATA_UP_DESCRIPTOR_OFFSET);
-	writel(0, base + VSC_SATA_UP_DATA_BUFFER_OFFSET);
+	writel(0, (void *)(base + VSC_SATA_UP_DESCRIPTOR_OFFSET));
+	writel(0, (void *)(base + VSC_SATA_UP_DATA_BUFFER_OFFSET));
 }
 
 
