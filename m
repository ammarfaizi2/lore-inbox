Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263255AbVCDVXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263255AbVCDVXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbVCDVUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:20:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:29345 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263106AbVCDUyM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:12 -0500
Cc: akpm@osdl.org
Subject: [PATCH] PCI: tone down pci=routeirq message
In-Reply-To: <11099696382976@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:58 -0800
Message-Id: <11099696383198@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.25, 2005/02/25 15:47:53-08:00, akpm@osdl.org

[PATCH] PCI: tone down pci=routeirq message

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Tone down the message about using "pci=routeirq".  I do still get a few
reports, but most are now prompted just by the fact that my email address
appears in dmesg in an "error-type" message.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 arch/i386/pci/acpi.c |   17 ++++-------------
 arch/ia64/pci/pci.c  |   16 +++-------------
 2 files changed, 7 insertions(+), 26 deletions(-)


diff -Nru a/arch/i386/pci/acpi.c b/arch/i386/pci/acpi.c
--- a/arch/i386/pci/acpi.c	2005-03-04 12:41:20 -08:00
+++ b/arch/i386/pci/acpi.c	2005-03-04 12:41:20 -08:00
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
diff -Nru a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c	2005-03-04 12:41:20 -08:00
+++ b/arch/ia64/pci/pci.c	2005-03-04 12:41:20 -08:00
@@ -151,21 +151,11 @@
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

