Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274695AbRITXBz>; Thu, 20 Sep 2001 19:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274694AbRITXBo>; Thu, 20 Sep 2001 19:01:44 -0400
Received: from sushi.toad.net ([162.33.130.105]:62162 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S274689AbRITXB3>;
	Thu, 20 Sep 2001 19:01:29 -0400
Message-ID: <3BAA7539.28379E@yahoo.co.uk>
Date: Thu, 20 Sep 2001 19:01:13 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP BIOS no-irq/IRQ0 bug
Content-Type: multipart/mixed;
 boundary="------------30A05C3804B66F0E32E9CB3A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------30A05C3804B66F0E32E9CB3A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here is a one-character patch which may be self-explanatory.
The irq should be initialized to -1 (i.e., "no irq") rather
than 0 (i.e., IRQ0) so that the irq field in the pci_dev will
be -1 and not 0 if the PnP BIOS returns an irq mask with no
bits set.     // Thomas <jdthood_AT_yahoo.co.uk>

--- linux-2.4.9-ac10/drivers/pnp/pnp_bios.c_ORIG	Thu Sep 20 18:54:59 2001
+++ linux-2.4.9-ac10/drivers/pnp/pnp_bios.c	Thu Sep 20 18:55:22 2001
@@ -716,7 +716,7 @@
 static void __init pnpbios_rawdata_2_pci_dev(struct pnp_bios_node *node, struct pci_dev *pci_dev)
 {
 	unsigned char *p = node->data, *lastp=NULL;
-        int mask,i,io,irq=0,len,dma=-1;
+        int mask,i,io,irq=-1,len,dma=-1;
 
 	memset(pci_dev, 0, sizeof(struct pci_dev));
         while ( (char *)p < ((char *)node->data + node->size )) {
--------------30A05C3804B66F0E32E9CB3A
Content-Type: text/plain; charset=us-ascii;
 name="pnpbios-patch-20010920-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpbios-patch-20010920-1"

--- linux-2.4.9-ac10/drivers/pnp/pnp_bios.c_ORIG	Thu Sep 20 18:54:59 2001
+++ linux-2.4.9-ac10/drivers/pnp/pnp_bios.c	Thu Sep 20 18:55:22 2001
@@ -716,7 +716,7 @@
 static void __init pnpbios_rawdata_2_pci_dev(struct pnp_bios_node *node, struct pci_dev *pci_dev)
 {
 	unsigned char *p = node->data, *lastp=NULL;
-        int mask,i,io,irq=0,len,dma=-1;
+        int mask,i,io,irq=-1,len,dma=-1;
 
 	memset(pci_dev, 0, sizeof(struct pci_dev));
         while ( (char *)p < ((char *)node->data + node->size )) {

--------------30A05C3804B66F0E32E9CB3A--

