Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275852AbRJPJ2v>; Tue, 16 Oct 2001 05:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275853AbRJPJ2l>; Tue, 16 Oct 2001 05:28:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63873 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S275852AbRJPJ2h>;
	Tue, 16 Oct 2001 05:28:37 -0400
Date: Tue, 16 Oct 2001 02:29:02 -0700 (PDT)
Message-Id: <20011016.022902.74752070.davem@redhat.com>
To: jbglaw@lug-owl.de
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Oops while inserting sym53c8xx.o
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011016110925.B27144@lug-owl.de>
In-Reply-To: <20011016110925.B27144@lug-owl.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This should fix it, Linux please apply.

--- drivers/scsi/sym53c8xx.c.~1~	Mon Oct  8 21:04:56 2001
+++ drivers/scsi/sym53c8xx.c	Tue Oct 16 02:27:44 2001
@@ -13168,14 +13168,14 @@
 	** in the size field.  We use normal 32-bit PCI addresses for
 	** descriptors.
 	*/
-	if (chip->features & FE_DAC) {
+	if (chip && (chip->features & FE_DAC)) {
 		if (pci_set_dma_mask(pdev, (u64) 0xffffffffff))
 			chip->features &= ~FE_DAC_IN_USE;
 		else
 			chip->features |= FE_DAC_IN_USE;
 	}
 
-	if (!(chip->features & FE_DAC_IN_USE)) {
+	if (chip && !(chip->features & FE_DAC_IN_USE)) {
 		if (pci_set_dma_mask(pdev, (u64) 0xffffffff)) {
 			printk(KERN_WARNING NAME53C8XX
 			       "32 BIT PCI BUS DMA ADDRESSING NOT SUPPORTED\n");
