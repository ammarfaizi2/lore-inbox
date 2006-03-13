Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751952AbWCMA3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbWCMA3P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 19:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWCMA3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 19:29:15 -0500
Received: from havoc.gtf.org ([69.61.125.42]:10467 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751940AbWCMA3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 19:29:14 -0500
Date: Sun, 12 Mar 2006 19:29:10 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patch] libata fix
Message-ID: <20060313002910.GA1840@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/ahci.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

Tejun Heo:
      ahci: fix NULL pointer dereference detected by Coverity

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index a800fb5..559ff7a 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -742,23 +742,17 @@ static irqreturn_t ahci_interrupt (int i
 			struct ata_queued_cmd *qc;
 			qc = ata_qc_from_tag(ap, ap->active_tag);
 			if (!ahci_host_intr(ap, qc))
-				if (ata_ratelimit()) {
-					struct pci_dev *pdev =
-						to_pci_dev(ap->host_set->dev);
-					dev_printk(KERN_WARNING, &pdev->dev,
+				if (ata_ratelimit())
+					dev_printk(KERN_WARNING, host_set->dev,
 					  "unhandled interrupt on port %u\n",
 					  i);
-				}
 
 			VPRINTK("port %u\n", i);
 		} else {
 			VPRINTK("port %u (no irq)\n", i);
-			if (ata_ratelimit()) {
-				struct pci_dev *pdev =
-					to_pci_dev(ap->host_set->dev);
-				dev_printk(KERN_WARNING, &pdev->dev,
+			if (ata_ratelimit())
+				dev_printk(KERN_WARNING, host_set->dev,
 					"interrupt on disabled port %u\n", i);
-			}
 		}
 
 		irq_ack |= (1 << i);
