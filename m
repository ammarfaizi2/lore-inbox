Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbVAJRns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVAJRns (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVAJRn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:43:29 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:24721 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262350AbVAJRVC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:02 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <11053776563881@kroah.com>
Date: Mon, 10 Jan 2005 09:20:57 -0800
Message-Id: <1105377657272@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.2, 2004/12/16 15:58:45-08:00, bunk@stusta.de

[PATCH] PCI: arch/i386/pci/: make some code static

The patch below makes some needlessly global code static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/pci/fixup.c |    4 ++--
 arch/i386/pci/irq.c   |    4 +++-
 arch/i386/pci/pci.h   |    2 --
 3 files changed, 5 insertions(+), 5 deletions(-)


diff -Nru a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
--- a/arch/i386/pci/fixup.c	2005-01-10 09:06:25 -08:00
+++ b/arch/i386/pci/fixup.c	2005-01-10 09:06:25 -08:00
@@ -282,7 +282,7 @@
 	return raw_pci_ops->write(0, bus->number, devfn, where, size, value);
 }
 
-struct pci_ops quirk_pcie_aspm_ops = {
+static struct pci_ops quirk_pcie_aspm_ops = {
 	.read = quirk_pcie_aspm_read,
 	.write = quirk_pcie_aspm_write,
 };
@@ -295,7 +295,7 @@
  * the root port in an array for fast indexing. Replace the bus ops
  * with the modified one.
  */
-void pcie_rootport_aspm_quirk(struct pci_dev *pdev)
+static void pcie_rootport_aspm_quirk(struct pci_dev *pdev)
 {
 	int cap_base, i;
 	struct pci_bus  *pbus;
diff -Nru a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
--- a/arch/i386/pci/irq.c	2005-01-10 09:06:25 -08:00
+++ b/arch/i386/pci/irq.c	2005-01-10 09:06:25 -08:00
@@ -29,6 +29,8 @@
 
 static struct irq_routing_table *pirq_table;
 
+static int pirq_enable_irq(struct pci_dev *dev);
+
 /*
  * Never use: 0, 1, 2 (timer, keyboard, and cascade)
  * Avoid using: 13, 14 and 15 (FP error and IDE).
@@ -1019,7 +1021,7 @@
 		pirq_penalize_isa_irq(irq);
 }
 
-int pirq_enable_irq(struct pci_dev *dev)
+static int pirq_enable_irq(struct pci_dev *dev)
 {
 	u8 pin;
 	extern int interrupt_line_quirk;
diff -Nru a/arch/i386/pci/pci.h b/arch/i386/pci/pci.h
--- a/arch/i386/pci/pci.h	2005-01-10 09:06:25 -08:00
+++ b/arch/i386/pci/pci.h	2005-01-10 09:06:25 -08:00
@@ -71,6 +71,4 @@
 extern int pcibios_scanned;
 extern spinlock_t pci_config_lock;
 
-int pirq_enable_irq(struct pci_dev *dev);
-
 extern int (*pcibios_enable_irq)(struct pci_dev *dev);

