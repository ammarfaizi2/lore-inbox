Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVAGT4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVAGT4F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVAGTyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:54:06 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:55438 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261554AbVAGTvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:51:00 -0500
Subject: [PATCH] use modern format for PCI->APIC IRQ transform printks
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 07 Jan 2005 12:50:52 -0700
Message-Id: <1105127452.25267.35.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use pci_name() rather than "(B%d,I%d,P%d)" when printing PCI
IRQ information.  Compiled but untested.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== arch/i386/pci/irq.c 1.53 vs edited =====
--- 1.53/arch/i386/pci/irq.c	2004-12-30 16:22:56 -07:00
+++ edited/arch/i386/pci/irq.c	2005-01-07 11:11:11 -07:00
@@ -735,7 +735,7 @@
 	if (!pirq_table)
 		return 0;
 	
-	DBG("IRQ for %s:%d", pci_name(dev), pin);
+	DBG("IRQ for %s[%c]", pci_name(dev), 'A' + pin);
 	info = pirq_get_info(dev);
 	if (!info) {
 		DBG(" -> not found in routing table\n");
@@ -892,16 +892,16 @@
 					irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
 							PCI_SLOT(bridge->devfn), pin);
 					if (irq >= 0)
-						printk(KERN_WARNING "PCI: using PPB(B%d,I%d,P%d) to get irq %d\n", 
-							bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
+						printk(KERN_WARNING "PCI: using PPB %s[%c] to get irq %d\n", 
+							pci_name(bridge), 'A' + pin, irq);
 				}
 				if (irq >= 0) {
 					if (use_pci_vector() &&
 						!platform_legacy_irq(irq))
 						irq = IO_APIC_VECTOR(irq);
 
-					printk(KERN_INFO "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
-						dev->bus->number, PCI_SLOT(dev->devfn), pin, irq);
+					printk(KERN_INFO "PCI->APIC IRQ transform: %s[%c] -> IRQ %d\n",
+						pci_name(dev), 'A' + pin, irq);
 					dev->irq = irq;
 				}
 			}
@@ -1051,8 +1051,8 @@
 					irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
 							PCI_SLOT(bridge->devfn), pin);
 					if (irq >= 0)
-						printk(KERN_WARNING "PCI: using PPB(B%d,I%d,P%d) to get irq %d\n", 
-							bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
+						printk(KERN_WARNING "PCI: using PPB %s[%c] to get irq %d\n", 
+							pci_name(bridge), 'A' + pin, irq);
 					dev = bridge;
 				}
 				dev = temp_dev;
@@ -1061,8 +1061,8 @@
 					if (!platform_legacy_irq(irq))
 						irq = IO_APIC_VECTOR(irq);
 #endif
-					printk(KERN_INFO "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
-						dev->bus->number, PCI_SLOT(dev->devfn), pin, irq);
+					printk(KERN_INFO "PCI->APIC IRQ transform: %s[%c] -> IRQ %d\n",
+						pci_name(dev), 'A' + pin, irq);
 					dev->irq = irq;
 					return 0;
 				} else


