Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVGVVw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVGVVw4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVGVVuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:50:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43786 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261281AbVGVVtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:49:19 -0400
Date: Fri, 22 Jul 2005 23:49:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/sx8.c: fix warnings with -Wundef
Message-ID: <20050722214914.GZ3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warnings with -Wundef:

<--  snip  -->

...
  CC      drivers/block/sx8.o
drivers/block/sx8.c:1585:5: warning: "IF_64BIT_DMA_IS_POSSIBLE" is not defined
drivers/block/sx8.c:1604:5: warning: "IF_64BIT_DMA_IS_POSSIBLE" is not defined
...

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/drivers/block/sx8.c.old	2005-07-22 18:13:45.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/block/sx8.c	2005-07-22 18:14:05.000000000 +0200
@@ -1582,7 +1582,7 @@
 	if (rc)
 		goto err_out;
 
-#if IF_64BIT_DMA_IS_POSSIBLE /* grrrr... */
+#ifdef IF_64BIT_DMA_IS_POSSIBLE /* grrrr... */
 	rc = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
 	if (!rc) {
 		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
@@ -1601,7 +1601,7 @@
 			goto err_out_regions;
 		}
 		pci_dac = 0;
-#if IF_64BIT_DMA_IS_POSSIBLE /* grrrr... */
+#ifdef IF_64BIT_DMA_IS_POSSIBLE /* grrrr... */
 	}
 #endif
 

