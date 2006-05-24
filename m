Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbWEXHFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbWEXHFI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 03:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbWEXHFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 03:05:08 -0400
Received: from havoc.gtf.org ([69.61.125.42]:42895 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932625AbWEXHFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 03:05:05 -0400
Date: Wed, 24 May 2006 03:05:05 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata fixes
Message-ID: <20060524070505.GA11218@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/libata-core.c |    5 +++++
 1 file changed, 5 insertions(+)

Albert Lee:
      libata: add pio flush for via atapi (was: Re: TR: ASUS A8V Deluxe, x86_64)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 823dfa7..fa476e7 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3643,6 +3643,8 @@ static void ata_pio_block(struct ata_por
 
 		ata_pio_sector(qc);
 	}
+
+	ata_altstatus(ap); /* flush */
 }
 
 static void ata_pio_error(struct ata_port *ap)
@@ -3759,11 +3761,14 @@ static void atapi_packet_task(void *_dat
 		spin_lock_irqsave(&ap->host_set->lock, flags);
 		ap->flags &= ~ATA_FLAG_NOINTR;
 		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
+		ata_altstatus(ap); /* flush */
+
 		if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
 			ap->ops->bmdma_start(qc);	/* initiate bmdma */
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	} else {
 		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
+		ata_altstatus(ap); /* flush */
 
 		/* PIO commands are handled by polling */
 		ap->hsm_task_state = HSM_ST;
