Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266814AbUHCTil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266814AbUHCTil (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 15:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266835AbUHCTik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 15:38:40 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:32392 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266814AbUHCThS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 15:37:18 -0400
Date: Tue, 3 Aug 2004 12:37:16 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: [PATCH][5/3][ARM] PCI quirks update for ARM
Message-ID: <20040803193716.GA16737@plexity.net>
Reply-To: dsaxena@plexity.net
References: <1091554419.4383.1611.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091554419.4383.1611.camel@hades.cambridge.redhat.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 03 2004, at 18:33, David Woodhouse was caught saying:
> It's a pain in the arse to set up platform-specific PCI quirks -- you
> have to put your platform-specific quirk into the generic (or at least
> the architecture) array. This patch fixes that, allowing you to
> DECLARE_PCI_FIXUP_HEADER() or DECLARE_PCI_FIXUP_FINAL() anywhere you
> like.

Good idea.  Following is ARM patch.

===== arch/arm/kernel/bios32.c 1.34 vs edited =====
--- 1.34/arch/arm/kernel/bios32.c	Fri Jul 16 11:35:05 2004
+++ edited/arch/arm/kernel/bios32.c	Tue Aug  3 12:22:37 2004
@@ -129,12 +129,14 @@
 	pci_write_config_word(dev, 0x44, 0xb000);
 	outb(0x08, 0x4d1);
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_83C553, pci_fixup_83c553);
 
 static void __devinit pci_fixup_unassign(struct pci_dev *dev)
 {
 	dev->resource[0].end -= dev->resource[0].start;
 	dev->resource[0].start = 0;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND2, PCI_DEVICE_ID_WINBOND2_89C940F, pci_fixup_unassign);
 
 /*
  * Prevent the PCI layer from seeing the resources allocated to this device
@@ -155,6 +157,7 @@
 		}
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_21285, pci_fixup_dec21285);
 
 /*
  * Same as above. The PrPMC800 carrier board for the PrPMC1100 
@@ -179,6 +182,7 @@
 		}
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IXP4XX, pci_fixup_prpmc1100);
 
 /*
  * PCI IDE controllers use non-standard I/O port decoding, respect it.
@@ -199,6 +203,7 @@
 		}
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_ide_bases);
 
 /*
  * Put the DEC21142 to sleep
@@ -207,6 +212,7 @@
 {
 	pci_write_config_dword(dev, 0x40, 0x80000000);
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_21142, pci_fixup_dec21142);
 
 /*
  * The CY82C693 needs some rather major fixups to ensure that it does
@@ -272,38 +278,7 @@
 		pci_write_config_byte(dev, 0x45, 0x03);
 	}
 }
-
-struct pci_fixup pcibios_fixups[] = {
-	{
-		PCI_FIXUP_HEADER,
-		PCI_VENDOR_ID_CONTAQ,	PCI_DEVICE_ID_CONTAQ_82C693,
-		pci_fixup_cy82c693
-	}, {
-		PCI_FIXUP_HEADER,
-		PCI_VENDOR_ID_DEC,	PCI_DEVICE_ID_DEC_21142,
-		pci_fixup_dec21142
-	}, {
-		PCI_FIXUP_HEADER,
-		PCI_VENDOR_ID_DEC,	PCI_DEVICE_ID_DEC_21285,
-		pci_fixup_dec21285
-	}, {
-		PCI_FIXUP_HEADER,
-		PCI_VENDOR_ID_WINBOND,	PCI_DEVICE_ID_WINBOND_83C553,
-		pci_fixup_83c553
-	}, {
-		PCI_FIXUP_HEADER,
-		PCI_VENDOR_ID_WINBOND2,	PCI_DEVICE_ID_WINBOND2_89C940F,
-		pci_fixup_unassign
-	}, {
-		PCI_FIXUP_HEADER,
-		PCI_ANY_ID,		PCI_ANY_ID,
-		pci_fixup_ide_bases
-	}, {
-		PCI_FIXUP_HEADER,
-		PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_IXP4XX,
-		pci_fixup_prpmc1100
-	}, { 0 }
-};
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693, pci_fixup_cy82c693);
 
 void __devinit pcibios_update_irq(struct pci_dev *dev, int irq)
 {

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
