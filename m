Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSFXCnX>; Sun, 23 Jun 2002 22:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSFXCnW>; Sun, 23 Jun 2002 22:43:22 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:8713 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317253AbSFXCnV>;
	Sun, 23 Jun 2002 22:43:21 -0400
Date: Sun, 23 Jun 2002 22:34:37 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.24 : drivers/net/tlan.c 
Message-ID: <Pine.LNX.4.44.0206232229570.922-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  This patch adds the check for 32-bit DMA capability for the tlan driver. 
This is the first step for Documentation/DMA-mapping.txt compliance. As 
for the preferred action if the driver fails on pci_set_dma_mask(), I plan 
to add that in a future patch. Please review. 
Regards,
Frank

--- drivers/net/tlan.c.old	Sun May 26 14:37:35 2002
+++ drivers/net/tlan.c	Sun Jun 23 22:15:30 2002
@@ -516,6 +516,10 @@
 
 	if (pdev && pci_enable_device(pdev))
 		return -EIO;
+	if(pci_set_dma_mask(pdev, 0xffffffff))
+	{
+		printk(KERN_WARNING "tlan : No suitable DMA available.\n");
+	}
 
 	dev = init_etherdev(NULL, sizeof(TLanPrivateInfo));
 	if (dev == NULL) {

