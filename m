Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWEWSyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWEWSyH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWEWSyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:54:07 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:26552 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932268AbWEWSyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:54:05 -0400
Date: Tue, 23 May 2006 20:54:04 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] -mm: constify arch/i386/pci/irq.c
Message-ID: <20060523185404.GD10827@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

constify structs and add one __initdata.

patch run-tested on linux-2.6.17-rc4-mm3.


Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc4-mm3.orig/arch/i386/pci/irq.c linux-2.6.17-rc4-mm3.my/arch/i386/pci/irq.c
--- linux-2.6.17-rc4-mm3.orig/arch/i386/pci/irq.c	2006-05-23 19:14:13.000000000 +0200
+++ linux-2.6.17-rc4-mm3/arch/i386/pci/irq.c	2006-05-23 17:21:13.000000000 +0200
@@ -198,14 +198,14 @@
  */
 static int pirq_ali_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 {
-	static unsigned char irqmap[16] = { 0, 9, 3, 10, 4, 5, 7, 6, 1, 11, 0, 12, 0, 14, 0, 15 };
+	static const unsigned char irqmap[16] = { 0, 9, 3, 10, 4, 5, 7, 6, 1, 11, 0, 12, 0, 14, 0, 15 };
 
 	return irqmap[read_config_nybble(router, 0x48, pirq-1)];
 }
 
 static int pirq_ali_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
 {
-	static unsigned char irqmap[16] = { 0, 8, 0, 2, 4, 5, 7, 6, 0, 1, 3, 9, 11, 0, 13, 15 };
+	static const unsigned char irqmap[16] = { 0, 8, 0, 2, 4, 5, 7, 6, 0, 1, 3, 9, 11, 0, 13, 15 };
 	unsigned int val = irqmap[irq];
 		
 	if (val) {
@@ -256,13 +256,13 @@
  */
 static int pirq_via586_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 {
-	static unsigned int pirqmap[4] = { 3, 2, 5, 1 };
+	static const unsigned int pirqmap[4] = { 3, 2, 5, 1 };
 	return read_config_nybble(router, 0x55, pirqmap[pirq-1]);
 }
 
 static int pirq_via586_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
 {
-	static unsigned int pirqmap[4] = { 3, 2, 5, 1 };
+	static const unsigned int pirqmap[4] = { 3, 2, 5, 1 };
 	write_config_nybble(router, 0x55, pirqmap[pirq-1], irq);
 	return 1;
 }
@@ -274,13 +274,13 @@
  */
 static int pirq_ite_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 {
-	static unsigned char pirqmap[4] = { 1, 0, 2, 3 };
+	static const unsigned char pirqmap[4] = { 1, 0, 2, 3 };
 	return read_config_nybble(router,0x43, pirqmap[pirq-1]);
 }
 
 static int pirq_ite_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
 {
-	static unsigned char pirqmap[4] = { 1, 0, 2, 3 };
+	static const unsigned char pirqmap[4] = { 1, 0, 2, 3 };
 	write_config_nybble(router, 0x43, pirqmap[pirq-1], irq);
 	return 1;
 }
@@ -505,7 +505,7 @@
 
 static __init int intel_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
 {
-	static struct pci_device_id pirq_440gx[] = {
+	static struct pci_device_id __initdata pirq_440gx[] = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443GX_0) },
 		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443GX_2) },
 		{ },
