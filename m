Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVCSN30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVCSN30 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbVCSNXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:23:18 -0500
Received: from coderock.org ([193.77.147.115]:12424 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262493AbVCSNSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:18:11 -0500
Subject: [patch 1/1] drivers/block/sx8.c: Use the DMA_{64, 32}BIT_MASK constants
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, tklauser@nuerscht.ch
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:18:03 +0100
Message-Id: <20050319131803.E8BAE1F23D@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use the DMA_{64,32}BIT_MASK constants from dma-mapping.h when calling
pci_set_dma_mask() or pci_set_consistent_dma_mask()
These patches include dma-mapping.h explicitly because it caused errors
on some architectures otherwise.
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/sx8.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/block/sx8.c~dma_mask-drivers_block_sx8 drivers/block/sx8.c
--- kj/drivers/block/sx8.c~dma_mask-drivers_block_sx8	2005-03-18 20:05:46.000000000 +0100
+++ kj-domen/drivers/block/sx8.c	2005-03-18 20:05:46.000000000 +0100
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
_
