Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUHWT0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUHWT0a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267180AbUHWTZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:25:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:62147 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267176AbUHWSgl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:41 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860852622@kroah.com>
Date: Mon, 23 Aug 2004 11:34:45 -0700
Message-Id: <10932860853494@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.10, 2004/08/04 08:01:20-04:00, dsaxena@plexity.net

[5/3][ARM] PCI quirks update for ARM

Good idea.  Following is ARM patch.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/arm/kernel/bios32.c |   39 +++++++--------------------------------
 1 files changed, 7 insertions(+), 32 deletions(-)


diff -Nru a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
--- a/arch/arm/kernel/bios32.c	2004-08-23 11:06:23 -07:00
+++ b/arch/arm/kernel/bios32.c	2004-08-23 11:06:23 -07:00
@@ -128,12 +128,14 @@
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
@@ -154,6 +156,7 @@
 		}
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_21285, pci_fixup_dec21285);
 
 /*
  * Same as above. The PrPMC800 carrier board for the PrPMC1100 
@@ -178,6 +181,7 @@
 		}
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IXP4XX, pci_fixup_prpmc1100);
 
 /*
  * PCI IDE controllers use non-standard I/O port decoding, respect it.
@@ -198,6 +202,7 @@
 		}
 	}
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_ide_bases);
 
 /*
  * Put the DEC21142 to sleep
@@ -206,6 +211,7 @@
 {
 	pci_write_config_dword(dev, 0x40, 0x80000000);
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_21142, pci_fixup_dec21142);
 
 /*
  * The CY82C693 needs some rather major fixups to ensure that it does
@@ -271,38 +277,7 @@
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

