Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUHWT1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUHWT1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267176AbUHWT1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:27:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:59843 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266912AbUHWSgj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:39 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860851730@kroah.com>
Date: Mon, 23 Aug 2004 11:34:45 -0700
Message-Id: <10932860852622@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.9, 2004/08/04 07:59:31-04:00, ralf@linux-mips.org

[4/3] PCI quirks -- MIPS.

Remove the bazillion of pcibios_fixups[] arrays on MIPS and replace them
with DECLARE_PCI_FIXUP_HEADER / DECLARE_PCI_FIXUP_FINAL where the array
definition was non-empty.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/mips/pci/fixup-atlas.c        |   10 ++--------
 arch/mips/pci/fixup-au1000.c       |    4 ----
 arch/mips/pci/fixup-capcella.c     |    4 ----
 arch/mips/pci/fixup-cobalt.c       |   12 +++++-------
 arch/mips/pci/fixup-ddb5074.c      |    7 ++-----
 arch/mips/pci/fixup-ddb5477.c      |   16 +++++++---------
 arch/mips/pci/fixup-ip32.c         |    4 ----
 arch/mips/pci/fixup-jaguar.c       |    4 ----
 arch/mips/pci/fixup-lasat.c        |    4 ----
 arch/mips/pci/fixup-malta.c        |   11 ++++-------
 arch/mips/pci/fixup-mpc30x.c       |    4 ----
 arch/mips/pci/fixup-ocelot-c.c     |    4 ----
 arch/mips/pci/fixup-ocelot-g.c     |    4 ----
 arch/mips/pci/fixup-sni.c          |    4 ----
 arch/mips/pci/fixup-tb0219.c       |    4 ----
 arch/mips/pci/fixup-tb0226.c       |    4 ----
 arch/mips/pci/fixup-yosemite.c     |    4 ----
 arch/mips/pci/pci-ip27.c           |   21 ++++++++++-----------
 arch/mips/pci/pci-sb1250.c         |    4 ----
 arch/mips/pmc-sierra/yosemite/ht.c |    5 -----
 20 files changed, 30 insertions(+), 104 deletions(-)


diff -Nru a/arch/mips/pci/fixup-atlas.c b/arch/mips/pci/fixup-atlas.c
--- a/arch/mips/pci/fixup-atlas.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-atlas.c	2004-08-23 11:06:29 -07:00
@@ -60,13 +60,7 @@
 	printk ("saa9730_base = %x\n", saa9730_base);
 }
 
-#endif
-
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PHILIPS, PCI_DEVICE_ID_PHILIPS_SAA9730,
+	atlas_saa9730_base_fixup);
 
-struct pci_fixup pcibios_fixups[] __initdata = {
-#ifdef CONFIG_KGDB
-	{PCI_FIXUP_HEADER, PCI_VENDOR_ID_PHILIPS, PCI_DEVICE_ID_PHILIPS_SAA9730,
-	 atlas_saa9730_base_fixup},
 #endif
-	{ 0 }
-};
diff -Nru a/arch/mips/pci/fixup-au1000.c b/arch/mips/pci/fixup-au1000.c
--- a/arch/mips/pci/fixup-au1000.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-au1000.c	2004-08-23 11:06:29 -07:00
@@ -102,7 +102,3 @@
 {
 return irq_tab_alchemy[slot][pin];
 }
-
-struct pci_fixup pcibios_fixups[] __initdata = {
-{ 0 }
-};
diff -Nru a/arch/mips/pci/fixup-capcella.c b/arch/mips/pci/fixup-capcella.c
--- a/arch/mips/pci/fixup-capcella.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-capcella.c	2004-08-23 11:06:29 -07:00
@@ -42,7 +42,3 @@
 {
 	return irq_tab_capcella[slot][pin];
 }
-
-struct pci_fixup pcibios_fixups[] __initdata = {
-	{	.pass = 0,	},
-};
diff -Nru a/arch/mips/pci/fixup-cobalt.c b/arch/mips/pci/fixup-cobalt.c
--- a/arch/mips/pci/fixup-cobalt.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-cobalt.c	2004-08-23 11:06:29 -07:00
@@ -41,6 +41,9 @@
 	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, 7);
 }
 
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,
+	 qube_raq_via_bmIDE_fixup);
+
 static void qube_raq_galileo_fixup(struct pci_dev *dev)
 {
 	unsigned short galileo_id;
@@ -73,13 +76,8 @@
 	}
 }
 
-struct pci_fixup pcibios_fixups[] __initdata = {
-	{PCI_FIXUP_HEADER, PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1,
-	 qube_raq_via_bmIDE_fixup},
-	{PCI_FIXUP_HEADER, PCI_VENDOR_ID_GALILEO, PCI_ANY_ID,
-	 qube_raq_galileo_fixup},
-	0
-};
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GALILEO, PCI_ANY_ID,
+	qube_raq_galileo_fixup);
 
 static char irq_tab_cobalt[] __initdata = {
   [COBALT_PCICONF_CPU]     = 0,
diff -Nru a/arch/mips/pci/fixup-ddb5074.c b/arch/mips/pci/fixup-ddb5074.c
--- a/arch/mips/pci/fixup-ddb5074.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-ddb5074.c	2004-08-23 11:06:29 -07:00
@@ -17,8 +17,5 @@
 	pci_write_config_byte(dev, 0x7e, t8);
 }
 
-struct pci_fixup pcibios_fixups[] __initdata = {
-	{ PCI_FIXUP_FINAL, PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,
-	  ddb5074_fixup },
-	{0}
-};
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101,
+	ddb5074_fixup);
diff -Nru a/arch/mips/pci/fixup-ddb5477.c b/arch/mips/pci/fixup-ddb5477.c
--- a/arch/mips/pci/fixup-ddb5477.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-ddb5477.c	2004-08-23 11:06:29 -07:00
@@ -41,6 +41,11 @@
 	pci_write_config_byte(dev, 0x41, old | 0xd0);
 }
 
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
+	  ddb5477_fixup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1535,
+	  ddb5477_fixup);
+
 /*
  * Fixup baseboard AMD chip so that tx does not underflow.
  *      bcr_18 |= 0x0800
@@ -69,12 +74,5 @@
 	outw(temp, ioaddr + PCNET32_WIO_BDP);
 }
 
-struct pci_fixup pcibios_fixups[] __initdata = {
-	{ PCI_FIXUP_FINAL, PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
-	  ddb5477_fixup },
-	{ PCI_FIXUP_FINAL, PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1535,
-	  ddb5477_fixup },
-	{ PCI_FIXUP_FINAL, PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE,
-	  ddb5477_amd_lance_fixup },
-	{0}
-};
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE,
+          ddb5477_amd_lance_fixup);
diff -Nru a/arch/mips/pci/fixup-ip32.c b/arch/mips/pci/fixup-ip32.c
--- a/arch/mips/pci/fixup-ip32.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-ip32.c	2004-08-23 11:06:29 -07:00
@@ -44,7 +44,3 @@
 {
 	return irq_tab_mace[slot][pin];
 }
-
-struct pci_fixup pcibios_fixups[] = {
-	{0}
-};
diff -Nru a/arch/mips/pci/fixup-jaguar.c b/arch/mips/pci/fixup-jaguar.c
--- a/arch/mips/pci/fixup-jaguar.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-jaguar.c	2004-08-23 11:06:29 -07:00
@@ -36,7 +36,3 @@
 return 0;
 	panic("Whooops in pcibios_map_irq");
 }
-
-struct pci_fixup pcibios_fixups[] = {
-	{0}
-};
diff -Nru a/arch/mips/pci/fixup-lasat.c b/arch/mips/pci/fixup-lasat.c
--- a/arch/mips/pci/fixup-lasat.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-lasat.c	2004-08-23 11:06:29 -07:00
@@ -4,7 +4,3 @@
 void __init pcibios_fixup_irqs(void)
 {
 }
-
-struct pci_fixup pcibios_fixups[] __initdata = {
-    { 0 }
-};
diff -Nru a/arch/mips/pci/fixup-malta.c b/arch/mips/pci/fixup-malta.c
--- a/arch/mips/pci/fixup-malta.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-malta.c	2004-08-23 11:06:29 -07:00
@@ -79,6 +79,8 @@
 	}
 }
 
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0,
+	 malta_piix_func0_fixup);
 
 static void __init malta_piix_func1_fixup(struct pci_dev *pdev)
 {
@@ -96,10 +98,5 @@
 	}
 }
 
-struct pci_fixup pcibios_fixups[] __initdata = {
-	{PCI_FIXUP_HEADER, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0,
-	 malta_piix_func0_fixup},
-	{PCI_FIXUP_HEADER, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB,
-	 malta_piix_func1_fixup},
-	{ 0 }
-};
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB,
+	malta_piix_func1_fixup);
diff -Nru a/arch/mips/pci/fixup-mpc30x.c b/arch/mips/pci/fixup-mpc30x.c
--- a/arch/mips/pci/fixup-mpc30x.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-mpc30x.c	2004-08-23 11:06:29 -07:00
@@ -42,7 +42,3 @@
 
 	return irq_tab_mpc30x[slot];
 }
-
-struct pci_fixup pcibios_fixups[] __initdata = {
-	{	.pass = 0,	},
-};
diff -Nru a/arch/mips/pci/fixup-ocelot-c.c b/arch/mips/pci/fixup-ocelot-c.c
--- a/arch/mips/pci/fixup-ocelot-c.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-ocelot-c.c	2004-08-23 11:06:29 -07:00
@@ -33,7 +33,3 @@
 return 0;
 	panic("Whooops in pcibios_map_irq");
 }
-
-struct pci_fixup pcibios_fixups[] = {
-	{0}
-};
diff -Nru a/arch/mips/pci/fixup-ocelot-g.c b/arch/mips/pci/fixup-ocelot-g.c
--- a/arch/mips/pci/fixup-ocelot-g.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-ocelot-g.c	2004-08-23 11:06:29 -07:00
@@ -29,7 +29,3 @@
 
 	return -1;
 }
-
-struct pci_fixup pcibios_fixups[] = {
-	{0}
-};
diff -Nru a/arch/mips/pci/fixup-sni.c b/arch/mips/pci/fixup-sni.c
--- a/arch/mips/pci/fixup-sni.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-sni.c	2004-08-23 11:06:29 -07:00
@@ -82,7 +82,3 @@
 
 	return irq_tab_rm200[slot][pin];
 }
-
-struct pci_fixup pcibios_fixups[] = {
-	{0}
-};
diff -Nru a/arch/mips/pci/fixup-tb0219.c b/arch/mips/pci/fixup-tb0219.c
--- a/arch/mips/pci/fixup-tb0219.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-tb0219.c	2004-08-23 11:06:29 -07:00
@@ -58,7 +58,3 @@
 
 	return irq;
 }
-
-struct pci_fixup pcibios_fixups[] __initdata = {
-	{	.pass = 0,	},
-};
diff -Nru a/arch/mips/pci/fixup-tb0226.c b/arch/mips/pci/fixup-tb0226.c
--- a/arch/mips/pci/fixup-tb0226.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-tb0226.c	2004-08-23 11:06:29 -07:00
@@ -77,7 +77,3 @@
 
 	return irq;
 }
-
-struct pci_fixup pcibios_fixups[] __initdata = {
-	{	.pass = 0,	},
-};
diff -Nru a/arch/mips/pci/fixup-yosemite.c b/arch/mips/pci/fixup-yosemite.c
--- a/arch/mips/pci/fixup-yosemite.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/fixup-yosemite.c	2004-08-23 11:06:29 -07:00
@@ -33,7 +33,3 @@
 
 	return 3;			/* Everything goes to one irq bit */
 }
-
-struct pci_fixup pcibios_fixups[] = {
-	{0}
-};
diff -Nru a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
--- a/arch/mips/pci/pci-ip27.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/pci-ip27.c	2004-08-23 11:06:29 -07:00
@@ -329,6 +329,9 @@
 	pci_disable_swapping(d);
 }
 
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3,
+	 pci_fixup_ioc3);
+
 static void __init pci_fixup_isp1020(struct pci_dev *d)
 {
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(d->bus);
@@ -353,6 +356,9 @@
 	pci_enable_swapping(d);
 }
 
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QLOGIC, PCI_DEVICE_ID_QLOGIC_ISP1020,
+	 pci_fixup_isp1020);
+
 static void __init pci_fixup_isp2x00(struct pci_dev *d)
 {
 	struct bridge_controller *bc = BRIDGE_CONTROLLER(d->bus);
@@ -427,14 +433,7 @@
 	/*d->resource[1].flags |= 1; */
 }
 
-struct pci_fixup pcibios_fixups[] = {
-	{PCI_FIXUP_HEADER, PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3,
-	 pci_fixup_ioc3},
-	{PCI_FIXUP_HEADER, PCI_VENDOR_ID_QLOGIC, PCI_DEVICE_ID_QLOGIC_ISP1020,
-	 pci_fixup_isp1020},
-	{PCI_FIXUP_HEADER, PCI_VENDOR_ID_QLOGIC, PCI_DEVICE_ID_QLOGIC_ISP2100,
-	 pci_fixup_isp2x00},
-	{PCI_FIXUP_HEADER, PCI_VENDOR_ID_QLOGIC, PCI_DEVICE_ID_QLOGIC_ISP2200,
-	 pci_fixup_isp2x00},
-	{0}
-};
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QLOGIC, PCI_DEVICE_ID_QLOGIC_ISP2100,
+	 pci_fixup_isp2x00);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QLOGIC, PCI_DEVICE_ID_QLOGIC_ISP2200,
+	 pci_fixup_isp2x00);
diff -Nru a/arch/mips/pci/pci-sb1250.c b/arch/mips/pci/pci-sb1250.c
--- a/arch/mips/pci/pci-sb1250.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pci/pci-sb1250.c	2004-08-23 11:06:29 -07:00
@@ -279,7 +279,3 @@
 	return 0;
 }
 arch_initcall(sb1250_pcibios_init);
-
-struct pci_fixup pcibios_fixups[] = {
-	{0}
-};
diff -Nru a/arch/mips/pmc-sierra/yosemite/ht.c b/arch/mips/pmc-sierra/yosemite/ht.c
--- a/arch/mips/pmc-sierra/yosemite/ht.c	2004-08-23 11:06:29 -07:00
+++ b/arch/mips/pmc-sierra/yosemite/ht.c	2004-08-23 11:06:29 -07:00
@@ -414,11 +414,6 @@
         titan_ht_config_write_dword
 };
 
-
-struct pci_fixup pcibios_fixups[] = {
-        {0}
-};
-
 void __init pcibios_fixup_bus(struct pci_bus *c)
 {
         titan_ht_pcibios_fixup_bus(c);

