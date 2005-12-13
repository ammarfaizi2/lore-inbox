Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbVLMFce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVLMFce (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 00:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbVLMFce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 00:32:34 -0500
Received: from havoc.gtf.org ([69.61.125.42]:37353 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751267AbVLMFce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 00:32:34 -0500
Date: Tue, 13 Dec 2005 00:32:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata fix
Message-ID: <20051213053232.GA26669@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/libata-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Mark Lord:
      libata-core.c:  fix parameter bug on kunmap_atomic() calls

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 665ae79..d0a0fdb 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2443,7 +2443,7 @@ static void ata_sg_clean(struct ata_queu
 			struct scatterlist *psg = &qc->pad_sgent;
 			void *addr = kmap_atomic(psg->page, KM_IRQ0);
 			memcpy(addr + psg->offset, pad_buf, qc->pad_len);
-			kunmap_atomic(psg->page, KM_IRQ0);
+			kunmap_atomic(addr, KM_IRQ0);
 		}
 	} else {
 		if (sg_dma_len(&sg[0]) > 0)
@@ -2717,7 +2717,7 @@ static int ata_sg_setup(struct ata_queue
 		if (qc->tf.flags & ATA_TFLAG_WRITE) {
 			void *addr = kmap_atomic(psg->page, KM_IRQ0);
 			memcpy(pad_buf, addr + psg->offset, qc->pad_len);
-			kunmap_atomic(psg->page, KM_IRQ0);
+			kunmap_atomic(addr, KM_IRQ0);
 		}
 
 		sg_dma_address(psg) = ap->pad_dma + (qc->tag * ATA_DMA_PAD_SZ);
