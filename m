Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270094AbUJTGsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270094AbUJTGsW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 02:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270084AbUJSXKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:10:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:58505 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269614AbUJSWqR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:17 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257394160@kroah.com>
Date: Tue, 19 Oct 2004 15:42:19 -0700
Message-Id: <10982257393394@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.58, 2004/10/06 14:00:18-07:00, greg@kroah.com

[PATCH] PCI: remove all usages of pci_dma_sync_sg as it's obsolete.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/scsi/megaraid/megaraid_mbox.c |    4 ++--
 include/linux/pci.h                   |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)


diff -Nru a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
--- a/drivers/scsi/megaraid/megaraid_mbox.c	2004-10-19 15:22:22 -07:00
+++ b/drivers/scsi/megaraid/megaraid_mbox.c	2004-10-19 15:22:22 -07:00
@@ -1559,7 +1559,7 @@
 					PCI_DMA_TODEVICE);
 		}
 		else {
-			pci_dma_sync_sg(adapter->pdev, scb->scp->request_buffer,
+			pci_dma_sync_sg_for_cpu(adapter->pdev, scb->scp->request_buffer,
 				scb->scp->use_sg, PCI_DMA_TODEVICE);
 		}
 	}
@@ -2345,7 +2345,7 @@
 
 	case MRAID_DMA_WSG:
 		if (scb->dma_direction == PCI_DMA_FROMDEVICE) {
-			pci_dma_sync_sg(adapter->pdev,
+			pci_dma_sync_sg_for_cpu(adapter->pdev,
 					scb->scp->request_buffer,
 					scb->scp->use_sg, PCI_DMA_FROMDEVICE);
 		}
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-10-19 15:22:22 -07:00
+++ b/include/linux/pci.h	2004-10-19 15:22:22 -07:00
@@ -860,7 +860,6 @@
 
 /* Backwards compat, remove in 2.7.x */
 #define pci_dma_sync_single	pci_dma_sync_single_for_cpu
-#define pci_dma_sync_sg		pci_dma_sync_sg_for_cpu
 
 /*
  *  If the system does not have PCI, clearly these return errors.  Define

