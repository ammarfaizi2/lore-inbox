Return-Path: <linux-kernel-owner+w=401wt.eu-S1752418AbWLSENk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbWLSENk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 23:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbWLSENj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 23:13:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4470 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752418AbWLSENP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 23:13:15 -0500
Date: Tue, 19 Dec 2006 05:13:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: greg@kroah.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/pci/quirks.c: cleanup
Message-ID: <20061219041315.GE6993@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- move all EXPORT_SYMBOL's directly below the code they are exporting
- move all DECLARE_PCI_FIXUP_*'s directly below the functions they
  are calling

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/pci/pci.c    |    4 ----
 drivers/pci/quirks.c |   42 +++++++++++++++++-------------------------
 2 files changed, 17 insertions(+), 29 deletions(-)

--- linux-2.6.20-rc1-mm1/drivers/pci/quirks.c.old	2006-12-19 04:12:39.000000000 +0100
+++ linux-2.6.20-rc1-mm1/drivers/pci/quirks.c	2006-12-19 04:59:22.000000000 +0100
@@ -61,7 +61,8 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_I
     
     This appears to be BIOS not version dependent. So presumably there is a 
     chipset level fix */
-int isa_dma_bridge_buggy;		/* Exported */
+int isa_dma_bridge_buggy;
+EXPORT_SYMBOL(isa_dma_bridge_buggy);
     
 static void __devinit quirk_isa_dma_hangs(struct pci_dev *dev)
 {
@@ -83,6 +84,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NE
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	quirk_isa_dma_hangs );
 
 int pci_pci_problems;
+EXPORT_SYMBOL(pci_pci_problems);
 
 /*
  *	Chipsets where PCI->PCI transfers vanish or hang
@@ -94,6 +96,8 @@ static void __devinit quirk_nopcipci(str
 		pci_pci_problems |= PCIPCI_FAIL;
 	}
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci );
 
 static void __devinit quirk_nopciamd(struct pci_dev *dev)
 {
@@ -105,9 +109,6 @@ static void __devinit quirk_nopciamd(str
 		pci_pci_problems |= PCIAGP_FAIL;
 	}
 }
-
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci );
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci );
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopciamd );
 
 /*
@@ -1122,6 +1123,14 @@ static void quirk_sis_96x_smbus(struct p
 	pci_write_config_byte(dev, 0x77, val & ~0x10);
 	pci_read_config_byte(dev, 0x77, &val);
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
 
 /*
  * ... This is further complicated by the fact that some SiS96x south
@@ -1158,6 +1167,8 @@ static void quirk_sis_503(struct pci_dev
 	 */
 	dev->device = devid;
 }
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
 
 static void __init quirk_sis_96x_compatible(struct pci_dev *dev)
 {
@@ -1170,8 +1181,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_651,		quirk_sis_96x_compatible );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_735,		quirk_sis_96x_compatible );
 
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503 );
 /*
  * On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
  * and MC97 modem controller are disabled when a second PCI soundcard is
@@ -1202,21 +1211,8 @@ static void asus_hides_ac97_lpc(struct p
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc );
-
-
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
-
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237, asus_hides_ac97_lpc );
 
-
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus );
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus );
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus );
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_LPC,		quirk_sis_96x_smbus );
-
 #if defined(CONFIG_ATA) || defined(CONFIG_ATA_MODULE)
 
 /*
@@ -1261,7 +1257,6 @@ static void quirk_jmicron_dualfn(struct 
 			break;
 	}
 }
-
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, quirk_jmicron_dualfn);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, quirk_jmicron_dualfn);
 
@@ -1405,6 +1400,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
 
 
 int pcie_mch_quirk;
+EXPORT_SYMBOL(pcie_mch_quirk);
 
 static void __devinit quirk_pcie_mch(struct pci_dev *pdev)
 {
@@ -1649,6 +1645,7 @@ void pci_fixup_device(enum pci_fixup_pas
 	}
 	pci_do_fixups(dev, start, end);
 }
+EXPORT_SYMBOL(pci_fixup_device);
 
 /* Enable 1k I/O space granularity on the Intel P64H2 */
 static void __devinit quirk_p64h2_1k_io(struct pci_dev *dev)
@@ -1791,8 +1788,3 @@ static void __devinit quirk_nvidia_ck804
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_CK804_PCIE,
 			quirk_nvidia_ck804_msi_ht_cap);
 #endif /* CONFIG_PCI_MSI */
-
-EXPORT_SYMBOL(pcie_mch_quirk);
-#ifdef CONFIG_HOTPLUG
-EXPORT_SYMBOL(pci_fixup_device);
-#endif
--- linux-2.6.20-rc1-mm1/drivers/pci/pci.c.old	2006-12-19 04:15:52.000000000 +0100
+++ linux-2.6.20-rc1-mm1/drivers/pci/pci.c	2006-12-19 04:16:00.000000000 +0100
@@ -1210,7 +1210,3 @@ EXPORT_SYMBOL(pci_save_state);
 EXPORT_SYMBOL(pci_restore_state);
 EXPORT_SYMBOL(pci_enable_wake);
 
-/* Quirk info */
-
-EXPORT_SYMBOL(isa_dma_bridge_buggy);
-EXPORT_SYMBOL(pci_pci_problems);
