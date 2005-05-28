Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVE1XSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVE1XSN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 19:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVE1XSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 19:18:12 -0400
Received: from coderock.org ([193.77.147.115]:43910 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261198AbVE1XRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 19:17:44 -0400
Message-Id: <20050528231728.472430000@nd47.coderock.org>
Date: Sun, 29 May 2005 01:17:29 +0200
From: domen@coderock.org
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@nuerscht.ch>,
       domen@coderock.org
Subject: [patch 1/1] sound/oss/via82cxxx_audio: Use the DMA_32BIT_MASK constant
Content-Disposition: inline; filename=dma_mask-sound_oss_via82cxxx_audio
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Klauser <tklauser@nuerscht.ch>


Use the DMA_32BIT_MASK constant from dma-mapping.h
when calling pci_set_dma_mask() or pci_set_consistent_dma_mask()
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 via82cxxx_audio.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

Index: quilt/sound/oss/via82cxxx_audio.c
===================================================================
--- quilt.orig/sound/oss/via82cxxx_audio.c
+++ quilt/sound/oss/via82cxxx_audio.c
@@ -35,6 +35,7 @@
 #include <linux/smp_lock.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
@@ -3391,10 +3392,10 @@ static int __devinit via_init_one (struc
 	if (rc)
 		goto err_out_disable;
 
-	rc = pci_set_dma_mask(pdev, 0xffffffffULL);
+	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc)
 		goto err_out_res;
-	rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+	rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc)
 		goto err_out_res;
 

--
