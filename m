Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUHWTWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUHWTWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267248AbUHWTVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:21:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:3780 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267238AbUHWSgt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:49 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860843026@kroah.com>
Date: Mon, 23 Aug 2004 11:34:45 -0700
Message-Id: <10932860851730@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.8, 2004/08/04 07:57:35-04:00, dwmw2@shinybook.infradead.org

[3/3] PCI quirks -- i386.

Probably best to make i386 build again too... people bitch if their
favourite legacy architecture breaks.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/pci/fixup.c |  129 ++++++--------------------------------------------
 1 files changed, 18 insertions(+), 111 deletions(-)


diff -Nru a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
--- a/arch/i386/pci/fixup.c	2004-08-23 11:06:34 -07:00
+++ b/arch/i386/pci/fixup.c	2004-08-23 11:06:34 -07:00
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
@@ -86,6 +90,7 @@
 		}
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_ide_bases);
 
 static void __devinit  pci_fixup_ide_trash(struct pci_dev *d)
 {
@@ -108,6 +113,10 @@
 	for(i=0; i<4; i++)
 		d->resource[i].start = d->resource[i].end = d->resource[i].flags = 0;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, pci_fixup_ide_trash);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, pci_fixup_ide_trash);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_11, pci_fixup_ide_trash);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_9, pci_fixup_ide_trash);
 
 static void __devinit  pci_fixup_latency(struct pci_dev *d)
 {
@@ -118,6 +127,8 @@
 	DBG("PCI: Setting max latency to 32\n");
 	pcibios_max_latency = 32;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5597, pci_fixup_latency);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5598, pci_fixup_latency);
 
 static void __devinit pci_fixup_piix4_acpi(struct pci_dev *d)
 {
@@ -126,6 +137,7 @@
 	 */
 	d->irq = 9;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3, pci_fixup_piix4_acpi);
 
 /*
  * Addresses issues with problems in the memory write queue timer in
@@ -179,6 +191,10 @@
 		pci_write_config_byte(d, where, v);
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8363_0, pci_fixup_via_northbridge_bug);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8622, pci_fixup_via_northbridge_bug);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8361, pci_fixup_via_northbridge_bug);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8367_0, pci_fixup_via_northbridge_bug);
 
 /*
  * For some reasons Intel decided that certain parts of their
@@ -195,6 +211,7 @@
 	    (dev->device & 0xff00) == 0x2400)
 		dev->transparent = 1;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_fixup_transparent_bridge);
 
 /*
  * Fixup for C1 Halt Disconnect problem on nForce2 systems.
@@ -236,115 +253,5 @@
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

