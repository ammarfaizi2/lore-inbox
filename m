Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTFYBHi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 21:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbTFYBHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 21:07:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28105 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263131AbTFYBHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 21:07:35 -0400
Date: Wed, 25 Jun 2003 03:21:42 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: ipslinux@adaptec.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.5 patch] postfix two constants in ips.c with ULL
Message-ID: <20030625012142.GF3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below postfixes two constants in ips.c with ULL, on 32 bit
archs this constant is too big for an int.
  
The cast doesn't do the right thing, 0xffffffffffffffff is in C an int
and the cast casts 0xffffffffffffffff interpreted as an int to an u64.
  
cu
Adrian

--- linux-2.5.73-not-full/drivers/scsi/ips.c.old	2003-06-24 20:07:48.000000000 +0200
+++ linux-2.5.73-not-full/drivers/scsi/ips.c	2003-06-24 20:08:34.000000000 +0200
@@ -7009,10 +7009,10 @@
      * are guaranteed to be < 4G.
      */
     if ( IPS_ENABLE_DMA64 && IPS_HAS_ENH_SGLIST(ha) &&
-         !pci_set_dma_mask(ha->pcidev, (u64)0xffffffffffffffff)) {
+         !pci_set_dma_mask(ha->pcidev, 0xffffffffffffffffULL)) {
        (ha)->flags |= IPS_HA_ENH_SG;
     } else {
-       if ( pci_set_dma_mask(ha->pcidev, (u64)0xffffffff) != 0 ) { 
+       if ( pci_set_dma_mask(ha->pcidev, 0xffffffffULL) != 0 ) { 
           printk(KERN_WARNING "Unable to set DMA Mask\n");
           return ips_abort_init(ha, index);
        }
