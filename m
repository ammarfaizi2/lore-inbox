Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752027AbWKBQig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbWKBQig (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 11:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbWKBQig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 11:38:36 -0500
Received: from palrel10.hp.com ([156.153.255.245]:51347 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1752000AbWKBQif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 11:38:35 -0500
Date: Thu, 2 Nov 2006 10:38:29 -0600
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: akpm@osdl.org, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 11/8] cciss: cleanups for cciss_interrupt_mode
Message-ID: <20061102163829.GC23148@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PATCH 11 of 8

Sorry for messed up sequence. This is the last of this patch set.
This patch is a cleanup for cciss_interrupt_mode.
Please consider this for inclusion.

Thanks,
mikem

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)
--------------------------------------------------------------------------------
diff -urNp linux-2.6-p00010/drivers/block/cciss.c linux-2.6-p00011/drivers/block/cciss.c
--- linux-2.6-p00010/drivers/block/cciss.c	2006-11-02 09:54:35.000000000 -0600
+++ linux-2.6-p00011/drivers/block/cciss.c	2006-11-02 10:03:47.000000000 -0600
@@ -2785,23 +2785,21 @@ static void __devinit cciss_interrupt_mo
 		if (err > 0) {
 			printk(KERN_WARNING "cciss: only %d MSI-X vectors "
 			       "available\n", err);
+			goto default_int_mode;
 		} else {
 			printk(KERN_WARNING "cciss: MSI-X init failed %d\n",
 			       err);
+			goto default_int_mode;
 		}
 	}
 	if (pci_find_capability(pdev, PCI_CAP_ID_MSI)) {
 		if (!pci_enable_msi(pdev)) {
-			c->intr[SIMPLE_MODE_INT] = pdev->irq;
 			c->msi_vector = 1;
-			return;
 		} else {
 			printk(KERN_WARNING "cciss: MSI init failed\n");
-			c->intr[SIMPLE_MODE_INT] = pdev->irq;
-			return;
 		}
 	}
-      default_int_mode:
+default_int_mode:
 #endif				/* CONFIG_PCI_MSI */
 	/* if we get here we're going to use the default interrupt mode */
 	c->intr[SIMPLE_MODE_INT] = pdev->irq;
