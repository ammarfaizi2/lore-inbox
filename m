Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266752AbUHCRlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266752AbUHCRlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 13:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266762AbUHCRlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 13:41:10 -0400
Received: from [213.146.154.40] ([213.146.154.40]:22735 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266752AbUHCRiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 13:38:24 -0400
Subject: [PATCH] [3/3] PCI quirks -- i386.
From: David Woodhouse <dwmw2@infradead.org>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org
In-Reply-To: <1091554599.4383.1619.camel@hades.cambridge.redhat.com>
References: <1091554419.4383.1611.camel@hades.cambridge.redhat.com>
	 <1091554599.4383.1619.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1091554700.4383.1625.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 03 Aug 2004 18:38:21 +0100
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 UPPERCASE_25_50        message body is 25-50% uppercase
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Probably best to make i386 build again too... people bitch if their
favourite legacy architecture breaks.

===== arch/i386/pci/fixup.c 1.19 vs edited =====
--- 1.19/arch/i386/pci/fixup.c	2004-06-03 15:58:17 +01:00
+++ edited/arch/i386/pci/fixup.c	2004-08-03 18:01:38 +01:00
@@ -29,6 +29,7 @@
 	}
 	pcibios_last_bus = -1;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82451NX, pci_fixup_i450nx);
 
 static void __devinit pci_fixup_i450gx(struct pci_dev *d)
 {
@@ -42,6 +43,7 @@
 	pci_scan_bus(busno, &pci_root_ops, NULL);
 	pcibios_last_bus = -1;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454GX, pci_fixup_i450gx);
 
 static void __devinit  pci_fixup_umc_ide(struct pci_dev *d)
 {
@@ -55,6 +57,7 @@
 	for(i=0; i<4; i++)
 		d->resource[i].flags |= PCI_BASE_ADDRESS_SPACE_IO;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8886BF, pci_fixup_umc_ide);
 
 static void __devinit  pci_fixup_ncr53c810(struct pci_dev *d)
 {
@@ -67,6 +70,7 @@
 		d->class = PCI_CLASS_STORAGE_SCSI << 8;
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C810, pci_fixup_ncr53c810);
 
 static void __devinit pci_fixup_ide_bases(struct pci_dev *d)
 {
@@ -85,7 +89,9 @@
 			r->end = r->start;
 		}
 	}
+
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_ide_bases);
 
 static void __devinit  pci_fixup_ide_trash(struct pci_dev *d)
 {
@@ -108,6 +114,10 @@
 	for(i=0; i<4; i++)
 		d->resource[i].start = d->resource[i].end = d->resource[i].flags = 0;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, pci_fixup_ide_trash);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, pci_fixup_ide_trash);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_11, pci_fixup_ide_trash);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_9, pci_fixup_ide_trash);
 
 static void __devinit  pci_fixup_latency(struct pci_dev *d)
 {
@@ -118,6 +128,8 @@
 	DBG("PCI: Setting max latency to 32\n");
 	pcibios_max_latency = 32;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5597, pci_fixup_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5598, pci_fixup_latency);
 
 static void __devinit pci_fixup_piix4_acpi(struct pci_dev *d)
 {
@@ -126,6 +138,7 @@
 	 */
 	d->irq = 9;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3, pci_fixup_piix4_acpi);
 
 /*
  * Addresses issues with problems in the memory write queue timer in
@@ -179,6 +192,10 @@
 		pci_write_config_byte(d, where, v);
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8363_0, pci_fixup_via_northbridge_bug);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8622, pci_fixup_via_northbridge_bug);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8361, pci_fixup_via_northbridge_bug);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8367_0, pci_fixup_via_northbridge_bug);
 
 /*
  * For some reasons Intel decided that certain parts of their
@@ -195,6 +212,7 @@
 	    (dev->device & 0xff00) == 0x2400)
 		dev->transparent = 1;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_fixup_transparent_bridge);
 
 /*
  * Fixup for C1 Halt Disconnect problem on nForce2 systems.
@@ -236,115 +254,5 @@
 		pci_write_config_dword(dev, 0x6c, fixed_val);
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2, pci_fixup_nforce2);
 
-struct pci_fixup pcibios_fixups[] = {
-	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_82451NX,
-		.hook		= pci_fixup_i450nx
-	},
-	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_82454GX,
-		.hook		= pci_fixup_i450gx
-	},
-	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_UMC,
-		.device		= PCI_DEVICE_ID_UMC_UM8886BF,
-		.hook		= pci_fixup_umc_ide
-	},
-	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_SI,
-		.device		= PCI_DEVICE_ID_SI_5513,
-		.hook		= pci_fixup_ide_trash
-	},
-	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_ANY_ID,
-		.device		= PCI_ANY_ID,
-		.hook		= pci_fixup_ide_bases
-	},
-	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_SI,
-		.device		= PCI_DEVICE_ID_SI_5597,
-		.hook		= pci_fixup_latency
-	},
-	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_SI,
-		.device		= PCI_DEVICE_ID_SI_5598,
-		.hook		= pci_fixup_latency
-	},
- 	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_82371AB_3,
-		.hook		= pci_fixup_piix4_acpi
-	},
- 	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_82801CA_10,
-		.hook		= pci_fixup_ide_trash
-	},
- 	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_82801CA_11,
-		.hook		= pci_fixup_ide_trash
-	},
- 	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_DEVICE_ID_INTEL_82801DB_9,
-		.hook		= pci_fixup_ide_trash
-	},
-	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device		= PCI_DEVICE_ID_VIA_8363_0,
-		.hook		= pci_fixup_via_northbridge_bug
-	},
-	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device		= PCI_DEVICE_ID_VIA_8622,
-		.hook		= pci_fixup_via_northbridge_bug
-	},
-	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device		= PCI_DEVICE_ID_VIA_8361,
-		.hook		= pci_fixup_via_northbridge_bug
-	},
-	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_VIA,
-		.device		= PCI_DEVICE_ID_VIA_8367_0,
-		.hook		= pci_fixup_via_northbridge_bug
-	},
-	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_NCR,
-		.device		= PCI_DEVICE_ID_NCR_53C810,
-		.hook		= pci_fixup_ncr53c810
-	},
-	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_INTEL,
-		.device		= PCI_ANY_ID,
-		.hook		= pci_fixup_transparent_bridge
-	},
-	{
-		.pass		= PCI_FIXUP_HEADER,
-		.vendor		= PCI_VENDOR_ID_NVIDIA,
-		.device		= PCI_DEVICE_ID_NVIDIA_NFORCE2,
-		.hook		= pci_fixup_nforce2
-	},
-	{ .pass = 0 }
-};


-- 
dwmw2

