Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbTFXRQv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTFXRQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:16:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:31186 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262645AbTFXRQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:16:31 -0400
Date: Tue, 24 Jun 2003 19:30:32 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Cciss-discuss@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] postfix a constant in cciss.c with ULL
Message-ID: <20030624173032.GT3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below postfixes a constant in cciss.h with ULL, on 32 bit
archs this constant is too big for an int.

The cast doesn't do the right thing, 0xffffffffffffffff is in C an int 
and the cast casts 0xffffffffffffffff interpreted as an int to an u64.

Please apply
Adrian

--- linux-2.5.73-not-full/drivers/block/cciss.c.old	2003-06-23 21:35:15.000000000 +0200
+++ linux-2.5.73-not-full/drivers/block/cciss.c	2003-06-23 21:36:07.000000000 +0200
@@ -2457,7 +2457,7 @@
 	hba[i]->pdev = pdev;
 
 	/* configure PCI DMA stuff */
-	if (!pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff))
+	if (!pci_set_dma_mask(pdev, 0xffffffffffffffffULL))
 		printk("cciss: using DAC cycles\n");
 	else if (!pci_set_dma_mask(pdev, 0xffffffff))
 		printk("cciss: not using DAC cycles\n");
