Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWHCV5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWHCV5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWHCV5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:57:13 -0400
Received: from havoc.gtf.org ([69.61.125.42]:7041 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030209AbWHCV5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:57:12 -0400
Date: Thu, 3 Aug 2006 17:57:11 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] libata fix
Message-ID: <20060803215711.GA16229@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/scsi/ahci.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

Unicorn Chang:
      ahci: skip protocol test altogether in spurious interrupt code

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 77e7202..904c25f 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -940,14 +940,8 @@ static void ahci_host_intr(struct ata_po
 		return;
 
 	/* ignore interim PIO setup fis interrupts */
-	if (ata_tag_valid(ap->active_tag)) {
-		struct ata_queued_cmd *qc =
-			ata_qc_from_tag(ap, ap->active_tag);
-
-		if (qc && qc->tf.protocol == ATA_PROT_PIO &&
-		    (status & PORT_IRQ_PIOS_FIS))
-			return;
-	}
+	if (ata_tag_valid(ap->active_tag) && (status & PORT_IRQ_PIOS_FIS)) 
+		return;
 
 	if (ata_ratelimit())
 		ata_port_printk(ap, KERN_INFO, "spurious interrupt "
