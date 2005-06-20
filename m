Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVFTVzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVFTVzb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVFTVvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:51:20 -0400
Received: from coderock.org ([193.77.147.115]:48023 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261635AbVFTVtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:49:20 -0400
Message-Id: <20050620214907.824626000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:49:08 +0200
From: domen@coderock.org
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@nuerscht.ch>,
       domen@coderock.org
Subject: [patch 1/1] drivers/block/sx8.c: Use the DMA_{64, 32}BIT_MASK constants
Content-Disposition: inline; filename=dma_mask-drivers_block_sx8.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Klauser <tklauser@nuerscht.ch>



Use the DMA_{64,32}BIT_MASK constants from dma-mapping.h when calling
pci_set_dma_mask() or pci_set_consistent_dma_mask()
These patches include dma-mapping.h explicitly because it caused errors
on some architectures otherwise.
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 sx8.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

Index: quilt/drivers/block/sx8.c
===================================================================
--- quilt.orig/drivers/block/sx8.c
+++ quilt/drivers/block/sx8.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <linux/hdreg.h>
+#include <linux/dma-mapping.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
@@ -1582,9 +1583,9 @@ static int carm_init_one (struct pci_dev
 		goto err_out;
 
 #if IF_64BIT_DMA_IS_POSSIBLE /* grrrr... */
-	rc = pci_set_dma_mask(pdev, 0xffffffffffffffffULL);
+	rc = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
 	if (!rc) {
-		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL);
+		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
 		if (rc) {
 			printk(KERN_ERR DRV_NAME "(%s): consistent DMA mask failure\n",
 				pci_name(pdev));
@@ -1593,7 +1594,7 @@ static int carm_init_one (struct pci_dev
 		pci_dac = 1;
 	} else {
 #endif
-		rc = pci_set_dma_mask(pdev, 0xffffffffULL);
+		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
 			printk(KERN_ERR DRV_NAME "(%s): DMA mask failure\n",
 				pci_name(pdev));

--
