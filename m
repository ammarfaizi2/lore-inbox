Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVBKWxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVBKWxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVBKWxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 17:53:54 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:43937 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262153AbVBKWxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 17:53:35 -0500
Subject: [PATCH] tone down pci=routeirq message
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 11 Feb 2005 15:53:30 -0700
Message-Id: <1108162410.31877.79.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tone down the message about using "pci=routeirq".  I do still get
a few reports, but most are now prompted just by the fact that
my email address appears in dmesg in an "error-type" message.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== arch/i386/pci/acpi.c 1.18 vs edited =====
--- 1.18/arch/i386/pci/acpi.c	2004-10-18 22:44:01 -06:00
+++ edited/arch/i386/pci/acpi.c	2005-02-11 15:30:22 -07:00
@@ -37,21 +37,12 @@
 		 * also do it here in case there are still broken drivers that
 		 * don't use pci_enable_device().
 		 */
-		printk(KERN_INFO "** Routing PCI interrupts for all devices because \"pci=routeirq\"\n");
-		printk(KERN_INFO "** was specified.  If this was required to make a driver work,\n");
-		printk(KERN_INFO "** please email the output of \"lspci\" to bjorn.helgaas@hp.com\n");
-		printk(KERN_INFO "** so I can fix the driver.\n");
+		printk(KERN_INFO "PCI: Routing PCI interrupts for all devices because \"pci=routeirq\" specified\n");
 		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
 			acpi_pci_irq_enable(dev);
-	} else {
-		printk(KERN_INFO "** PCI interrupts are no longer routed automatically.  If this\n");
-		printk(KERN_INFO "** causes a device to stop working, it is probably because the\n");
-		printk(KERN_INFO "** driver failed to call pci_enable_device().  As a temporary\n");
-		printk(KERN_INFO "** workaround, the \"pci=routeirq\" argument restores the old\n");
-		printk(KERN_INFO "** behavior.  If this argument makes the device work again,\n");
-		printk(KERN_INFO "** please email the output of \"lspci\" to bjorn.helgaas@hp.com\n");
-		printk(KERN_INFO "** so I can fix the driver.\n");
-	}
+	} else
+		printk(KERN_INFO "PCI: If a device doesn't work, try \"pci=routeirq\".  If it helps, post a report\n");
+
 #ifdef CONFIG_X86_IO_APIC
 	if (acpi_ioapic)
 		print_IO_APIC();
===== arch/ia64/pci/pci.c 1.67 vs edited =====
--- 1.67/arch/ia64/pci/pci.c	2005-01-25 14:23:42 -07:00
+++ edited/arch/ia64/pci/pci.c	2005-02-11 15:28:22 -07:00
@@ -160,21 +160,11 @@
 		 * also do it here in case there are still broken drivers that
 		 * don't use pci_enable_device().
 		 */
-		printk(KERN_INFO "** Routing PCI interrupts for all devices because \"pci=routeirq\"\n");
-		printk(KERN_INFO "** was specified.  If this was required to make a driver work,\n");
-		printk(KERN_INFO "** please email the output of \"lspci\" to bjorn.helgaas@hp.com\n");
-		printk(KERN_INFO "** so I can fix the driver.\n");
+		printk(KERN_INFO "PCI: Routing interrupts for all devices because \"pci=routeirq\" specified\n");
 		for_each_pci_dev(dev)
 			acpi_pci_irq_enable(dev);
-	} else {
-		printk(KERN_INFO "** PCI interrupts are no longer routed automatically.  If this\n");
-		printk(KERN_INFO "** causes a device to stop working, it is probably because the\n");
-		printk(KERN_INFO "** driver failed to call pci_enable_device().  As a temporary\n");
-		printk(KERN_INFO "** workaround, the \"pci=routeirq\" argument restores the old\n");
-		printk(KERN_INFO "** behavior.  If this argument makes the device work again,\n");
-		printk(KERN_INFO "** please email the output of \"lspci\" to bjorn.helgaas@hp.com\n");
-		printk(KERN_INFO "** so I can fix the driver.\n");
-	}
+	} else
+		printk(KERN_INFO "PCI: If a device doesn't work, try \"pci=routeirq\".  If it helps, post a report\n");
 
 	return 0;
 }


