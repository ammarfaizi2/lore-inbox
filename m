Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317260AbSFXCr0>; Sun, 23 Jun 2002 22:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSFXCrZ>; Sun, 23 Jun 2002 22:47:25 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:62218 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317260AbSFXCrX>;
	Sun, 23 Jun 2002 22:47:23 -0400
Date: Sun, 23 Jun 2002 22:38:38 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.24 : drivers/net/rcpci45.c
Message-ID: <Pine.LNX.4.44.0206232236330.922-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  This patch (first patch for Documentation/DMA-mapping.txt compliance) 
adds the DMA check for the rcpci45 driver. Please review.
Regards,
Frank

--- drivers/net/rcpci45.c.old	Sun May 26 14:37:33 2002
+++ drivers/net/rcpci45.c	Sun Jun 23 22:24:17 2002
@@ -174,7 +174,11 @@
 	 * assigned to DPA; and finally, the rest will be assigned to the
 	 * the LAN API layer.
 	 */
-
+	if(pci_set_dma_mask(pdev, 0xffffffff))
+	{
+		printk(KERN_WARNING "rcpci45 : No suitable DMA available.\n");
+	}
+	
 	dev = init_etherdev (NULL, sizeof (*pDpa));
 	if (!dev) {
 		printk (KERN_ERR

