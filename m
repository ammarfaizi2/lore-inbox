Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbULLCM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbULLCM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 21:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbULLCLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 21:11:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33797 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262043AbULLCLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 21:11:07 -0500
Date: Sun, 12 Dec 2004 03:10:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/pci/: make some code static
Message-ID: <20041212021058.GM22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 arch/i386/pci/fixup.c |    4 ++--
 arch/i386/pci/irq.c   |    4 +++-
 arch/i386/pci/pci.h   |    2 --
 3 files changed, 5 insertions(+), 5 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/arch/i386/pci/fixup.c.old	2004-12-12 00:04:24.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/pci/fixup.c	2004-12-12 00:04:46.000000000 +0100
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
--- linux-2.6.10-rc2-mm4-full/arch/i386/pci/pci.h.old	2004-12-12 00:05:01.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/pci/pci.h	2004-12-12 00:05:09.000000000 +0100
@@ -71,6 +71,4 @@
 extern int pcibios_scanned;
 extern spinlock_t pci_config_lock;
 
-int pirq_enable_irq(struct pci_dev *dev);
-
 extern int (*pcibios_enable_irq)(struct pci_dev *dev);
--- linux-2.6.10-rc2-mm4-full/arch/i386/pci/irq.c.old	2004-12-12 00:05:16.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/pci/irq.c	2004-12-12 00:11:24.000000000 +0100
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

