Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266548AbSKLMea>; Tue, 12 Nov 2002 07:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266552AbSKLMdb>; Tue, 12 Nov 2002 07:33:31 -0500
Received: from holomorphy.com ([66.224.33.161]:48570 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266545AbSKLMd0>;
	Tue, 12 Nov 2002 07:33:26 -0500
To: linux-kernel@vger.kernel.org
Subject: [3/4] NUMA-Q: use quad numbers passed to low-level PCI config helpers
Message-Id: <E18BaIc-0006Zy-00@holomorphy>
From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 12 Nov 2002 04:37:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the PCI configuration read/write helpers use their (currently
unused) seg argument as the PCI domain argument.


 numa.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)


diff -urpN pci-2.5.47-2/arch/i386/pci/numa.c pci-2.5.47-3/arch/i386/pci/numa.c
--- pci-2.5.47-2/arch/i386/pci/numa.c	2002-11-12 03:22:17.000000000 -0800
+++ pci-2.5.47-3/arch/i386/pci/numa.c	2002-11-12 03:25:35.000000000 -0800
@@ -27,17 +27,17 @@ static int __pci_conf1_mq_read (int seg,
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
+	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, seg);
 
 	switch (len) {
 	case 1:
-		*value = inb_quad(0xCFC + (reg & 3), BUS2QUAD(bus));
+		*value = inb_quad(0xCFC + (reg & 3), seg);
 		break;
 	case 2:
-		*value = inw_quad(0xCFC + (reg & 2), BUS2QUAD(bus));
+		*value = inw_quad(0xCFC + (reg & 2), seg);
 		break;
 	case 4:
-		*value = inl_quad(0xCFC, BUS2QUAD(bus));
+		*value = inl_quad(0xCFC, seg);
 		break;
 	}
 
@@ -55,17 +55,17 @@ static int __pci_conf1_mq_write (int seg
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
+	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, seg);
 
 	switch (len) {
 	case 1:
-		outb_quad((u8)value, 0xCFC + (reg & 3), BUS2QUAD(bus));
+		outb_quad((u8)value, 0xCFC + (reg & 3), seg);
 		break;
 	case 2:
-		outw_quad((u16)value, 0xCFC + (reg & 2), BUS2QUAD(bus));
+		outw_quad((u16)value, 0xCFC + (reg & 2), seg);
 		break;
 	case 4:
-		outl_quad((u32)value, 0xCFC, BUS2QUAD(bus));
+		outl_quad((u32)value, 0xCFC, seg);
 		break;
 	}
 
