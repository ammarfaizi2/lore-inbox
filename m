Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTFXReP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTFXReP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:34:15 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5074 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262324AbTFXReJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:34:09 -0400
Date: Tue, 24 Jun 2003 19:48:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.5 patch] ULL postfixes for tg3.c
Message-ID: <20030624174811.GW3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds ULL postfixes to three constants in tg3.c .

There's no need to create an int constant and later cast it to u64.

The second case was also incorrect since the constant was too big for an 
int.

Please apply
Adrian

--- linux-2.5.73-not-full/drivers/net/tg3.c.old	2003-06-24 19:42:20.000000000 +0200
+++ linux-2.5.73-not-full/drivers/net/tg3.c	2003-06-24 19:43:47.000000000 +0200
@@ -6679,16 +6679,16 @@
 	}
 
 	/* Configure DMA attributes. */
-	if (!pci_set_dma_mask(pdev, (u64) 0xffffffffffffffffULL)) {
+	if (!pci_set_dma_mask(pdev, 0xffffffffffffffffULL)) {
 		pci_using_dac = 1;
 		if (pci_set_consistent_dma_mask(pdev,
-						(u64) 0xffffffffffffffff)) {
+						0xffffffffffffffffULL)) {
 			printk(KERN_ERR PFX "Unable to obtain 64 bit DMA "
 			       "for consistent allocations\n");
 			goto err_out_free_res;
 		}
 	} else {
-		err = pci_set_dma_mask(pdev, (u64) 0xffffffff);
+		err = pci_set_dma_mask(pdev, 0xffffffffULL);
 		if (err) {
 			printk(KERN_ERR PFX "No usable DMA configuration, "
 			       "aborting.\n");
