Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266887AbUHCVv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266887AbUHCVv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUHCVvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:51:10 -0400
Received: from p508B65A8.dip.t-dialin.net ([80.139.101.168]:50799 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S266887AbUHCVsQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:48:16 -0400
Date: Tue, 3 Aug 2004 23:47:49 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH] [4/3] PCI quirks -- MIPS.
Message-ID: <20040803214749.GA6817@linux-mips.org>
References: <1091554419.4383.1611.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091554419.4383.1611.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the bazillion of pcibios_fixups[] arrays on MIPS and replace them
with DECLARE_PCI_FIXUP_HEADER / DECLARE_PCI_FIXUP_FINAL where the array
definition was non-empty.

===== arch/mips/pci/fixup-atlas.c 1.1 vs edited =====
--- 1.1/arch/mips/pci/fixup-atlas.c	Sat Feb 21 02:33:02 2004
+++ edited/arch/mips/pci/fixup-atlas.c	Tue Aug  3 23:30:45 2004
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
===== arch/mips/pci/fixup-au1000.c 1.4 vs edited =====
--- 1.4/arch/mips/pci/fixup-au1000.c	Mon May 10 13:25:30 2004
+++ edited/arch/mips/pci/fixup-au1000.c	Tue Aug  3 23:25:20 2004
@@ -102,7 +102,3 @@
 {
 return irq_tab_alchemy[slot][pin];
 }
-
-struct pci_fixup pcibios_fixups[] __initdata = {
-{ 0 }
-};
===== arch/mips/pci/fixup-capcella.c 1.3 vs edited =====
--- 1.3/arch/mips/pci/fixup-capcella.c	Thu Jun 24 10:55:59 2004
+++ edited/arch/mips/pci/fixup-capcella.c	Tue Aug  3 23:26:13 2004
@@ -42,7 +42,3 @@
 {
 	return irq_tab_capcella[slot][pin];
 }
-
-struct pci_fixup pcibios_fixups[] __initdata = {
-	{	.pass = 0,	},
-};
===== arch/mips/pci/fixup-cobalt.c 1.1 vs edited =====
--- 1.1/arch/mips/pci/fixup-cobalt.c	Sat Feb 21 02:33:02 2004
+++ edited/arch/mips/pci/fixup-cobalt.c	Tue Aug  3 23:40:45 2004
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
===== arch/mips/pci/fixup-ddb5074.c 1.1 vs edited =====
--- 1.1/arch/mips/pci/fixup-ddb5074.c	Sat Feb 21 02:33:02 2004
+++ edited/arch/mips/pci/fixup-ddb5074.c	Tue Aug  3 23:28:41 2004
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
===== arch/mips/pci/fixup-ddb5477.c 1.1 vs edited =====
--- 1.1/arch/mips/pci/fixup-ddb5477.c	Sat Feb 21 02:33:02 2004
+++ edited/arch/mips/pci/fixup-ddb5477.c	Tue Aug  3 23:31:54 2004
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
===== arch/mips/pci/fixup-ip32.c 1.1 vs edited =====
--- 1.1/arch/mips/pci/fixup-ip32.c	Sat Feb 21 02:33:02 2004
+++ edited/arch/mips/pci/fixup-ip32.c	Tue Aug  3 23:20:03 2004
@@ -44,7 +44,3 @@
 {
 	return irq_tab_mace[slot][pin];
 }
-
-struct pci_fixup pcibios_fixups[] = {
-	{0}
-};
===== arch/mips/pci/fixup-jaguar.c 1.1 vs edited =====
--- 1.1/arch/mips/pci/fixup-jaguar.c	Thu Jun 24 18:19:45 2004
+++ edited/arch/mips/pci/fixup-jaguar.c	Tue Aug  3 23:20:03 2004
@@ -36,7 +36,3 @@
 return 0;
 	panic("Whooops in pcibios_map_irq");
 }
-
-struct pci_fixup pcibios_fixups[] = {
-	{0}
-};
===== arch/mips/pci/fixup-lasat.c 1.1 vs edited =====
--- 1.1/arch/mips/pci/fixup-lasat.c	Tue Apr 20 16:59:48 2004
+++ edited/arch/mips/pci/fixup-lasat.c	Tue Aug  3 23:23:02 2004
@@ -4,7 +4,3 @@
 void __init pcibios_fixup_irqs(void)
 {
 }
-
-struct pci_fixup pcibios_fixups[] __initdata = {
-    { 0 }
-};
===== arch/mips/pci/fixup-malta.c 1.1 vs edited =====
--- 1.1/arch/mips/pci/fixup-malta.c	Sat Feb 21 02:33:02 2004
+++ edited/arch/mips/pci/fixup-malta.c	Tue Aug  3 23:23:52 2004
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
===== arch/mips/pci/fixup-mpc30x.c 1.1 vs edited =====
--- 1.1/arch/mips/pci/fixup-mpc30x.c	Thu Jun 24 18:19:45 2004
+++ edited/arch/mips/pci/fixup-mpc30x.c	Tue Aug  3 23:21:46 2004
@@ -42,7 +42,3 @@
 
 	return irq_tab_mpc30x[slot];
 }
-
-struct pci_fixup pcibios_fixups[] __initdata = {
-	{	.pass = 0,	},
-};
===== arch/mips/pci/fixup-ocelot-c.c 1.1 vs edited =====
--- 1.1/arch/mips/pci/fixup-ocelot-c.c	Thu Jun 24 18:19:45 2004
+++ edited/arch/mips/pci/fixup-ocelot-c.c	Tue Aug  3 23:20:03 2004
@@ -33,7 +33,3 @@
 return 0;
 	panic("Whooops in pcibios_map_irq");
 }
-
-struct pci_fixup pcibios_fixups[] = {
-	{0}
-};
===== arch/mips/pci/fixup-ocelot-g.c 1.1 vs edited =====
--- 1.1/arch/mips/pci/fixup-ocelot-g.c	Thu Jun 24 18:19:45 2004
+++ edited/arch/mips/pci/fixup-ocelot-g.c	Tue Aug  3 23:20:03 2004
@@ -29,7 +29,3 @@
 
 	return -1;
 }
-
-struct pci_fixup pcibios_fixups[] = {
-	{0}
-};
===== arch/mips/pci/fixup-sni.c 1.1 vs edited =====
--- 1.1/arch/mips/pci/fixup-sni.c	Sat Feb 21 02:33:02 2004
+++ edited/arch/mips/pci/fixup-sni.c	Tue Aug  3 23:20:03 2004
@@ -82,7 +82,3 @@
 
 	return irq_tab_rm200[slot][pin];
 }
-
-struct pci_fixup pcibios_fixups[] = {
-	{0}
-};
===== arch/mips/pci/fixup-tb0219.c 1.1 vs edited =====
--- 1.1/arch/mips/pci/fixup-tb0219.c	Thu Jun 24 18:19:45 2004
+++ edited/arch/mips/pci/fixup-tb0219.c	Tue Aug  3 23:21:22 2004
@@ -58,7 +58,3 @@
 
 	return irq;
 }
-
-struct pci_fixup pcibios_fixups[] __initdata = {
-	{	.pass = 0,	},
-};
===== arch/mips/pci/fixup-tb0226.c 1.3 vs edited =====
--- 1.3/arch/mips/pci/fixup-tb0226.c	Thu Jun 24 10:55:59 2004
+++ edited/arch/mips/pci/fixup-tb0226.c	Tue Aug  3 23:20:51 2004
@@ -77,7 +77,3 @@
 
 	return irq;
 }
-
-struct pci_fixup pcibios_fixups[] __initdata = {
-	{	.pass = 0,	},
-};
===== arch/mips/pci/fixup-yosemite.c 1.2 vs edited =====
--- 1.2/arch/mips/pci/fixup-yosemite.c	Thu Jun 24 10:55:59 2004
+++ edited/arch/mips/pci/fixup-yosemite.c	Tue Aug  3 23:20:03 2004
@@ -33,7 +33,3 @@
 
 	return 3;			/* Everything goes to one irq bit */
 }
-
-struct pci_fixup pcibios_fixups[] = {
-	{0}
-};
===== arch/mips/pci/pci-ip27.c 1.4 vs edited =====
--- 1.4/arch/mips/pci/pci-ip27.c	Tue Apr 20 08:53:22 2004
+++ edited/arch/mips/pci/pci-ip27.c	Tue Aug  3 23:20:03 2004
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
===== arch/mips/pci/pci-sb1250.c 1.3 vs edited =====
--- 1.3/arch/mips/pci/pci-sb1250.c	Tue Apr 20 08:53:22 2004
+++ edited/arch/mips/pci/pci-sb1250.c	Tue Aug  3 23:20:03 2004
@@ -279,7 +279,3 @@
 	return 0;
 }
 arch_initcall(sb1250_pcibios_init);
-
-struct pci_fixup pcibios_fixups[] = {
-	{0}
-};
===== arch/mips/pmc-sierra/yosemite/ht.c 1.2 vs edited =====
--- 1.2/arch/mips/pmc-sierra/yosemite/ht.c	Tue Apr 20 08:53:22 2004
+++ edited/arch/mips/pmc-sierra/yosemite/ht.c	Tue Aug  3 23:35:38 2004
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
