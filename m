Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWCDRfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWCDRfI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 12:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWCDRfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 12:35:08 -0500
Received: from havoc.gtf.org ([69.61.125.42]:53644 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932243AbWCDRfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 12:35:06 -0500
Date: Sat, 4 Mar 2006 12:35:05 -0500
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] AHCI prefetch
Message-ID: <20060304173505.GA28643@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch has been sitting in my tmp directory for ages.

We should probably turn this on, though the practical difference is
probably minimal.


diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 4e96ec5..973a794 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -64,8 +64,10 @@ enum {
 	AHCI_PORT_PRIV_DMA_SZ	= AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_SZ +
 				  AHCI_RX_FIS_SZ,
 	AHCI_IRQ_ON_SG		= (1 << 31),
+
 	AHCI_CMD_ATAPI		= (1 << 5),
 	AHCI_CMD_WRITE		= (1 << 6),
+	AHCI_CMD_PREFETCH	= (1 << 7),
 
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
 
@@ -533,7 +535,7 @@ static void ahci_qc_prep(struct ata_queu
 	if (qc->tf.flags & ATA_TFLAG_WRITE)
 		opts |= AHCI_CMD_WRITE;
 	if (is_atapi_taskfile(&qc->tf))
-		opts |= AHCI_CMD_ATAPI;
+		opts |= AHCI_CMD_ATAPI | AHCI_CMD_PREFETCH;
 
 	pp->cmd_slot[0].opts = cpu_to_le32(opts);
 	pp->cmd_slot[0].status = 0;
