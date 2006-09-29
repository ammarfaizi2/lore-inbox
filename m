Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161212AbWI2A04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161212AbWI2A04 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161213AbWI2A04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:26:56 -0400
Received: from havoc.gtf.org ([69.61.125.42]:31367 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161212AbWI2A0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:26:53 -0400
Date: Thu, 28 Sep 2006 20:26:53 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] libata: Use new PCI_VDEVICE() macro
Message-ID: <20060929002653.GA7458@havoc.gtf.org>
References: <20060929002601.GA7397@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929002601.GA7397@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


commit 54bb3a94b192be09feb85993b664ff118d6433d0
Author: Jeff Garzik <jeff@garzik.org>
Date:   Wed Sep 27 22:20:11 2006 -0400

    [libata] Use new PCI_VDEVICE() macro to dramatically shorten ID lists

    Signed-off-by: Jeff Garzik <jeff@garzik.org>

 drivers/ata/ahci.c         |   90 +++++++++++++++------------------------------
 drivers/ata/pdc_adma.c     |    3 -
 drivers/ata/sata_nv.c      |   50 +++++++++----------------
 drivers/ata/sata_promise.c |   55 +++++++++------------------
 drivers/ata/sata_sil.c     |   15 ++++---
 drivers/ata/sata_sil24.c   |   11 +++--
 drivers/ata/sata_sis.c     |    6 +--
 drivers/ata/sata_sx4.c     |    4 +-
 drivers/ata/sata_uli.c     |    7 ++-
 include/linux/libata.h     |    4 ++
 10 files changed, 95 insertions(+), 150 deletions(-)

54bb3a94b192be09feb85993b664ff118d6433d0
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1aabc81..54e1f38 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -299,76 +299,46 @@ static const struct ata_port_info ahci_p
 
 static const struct pci_device_id ahci_pci_tbl[] = {
 	/* Intel */
-	{ PCI_VENDOR_ID_INTEL, 0x2652, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ICH6 */
-	{ PCI_VENDOR_ID_INTEL, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ICH6M */
-	{ PCI_VENDOR_ID_INTEL, 0x27c1, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ICH7 */
-	{ PCI_VENDOR_ID_INTEL, 0x27c5, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ICH7M */
-	{ PCI_VENDOR_ID_INTEL, 0x27c3, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ICH7R */
-	{ PCI_VENDOR_ID_AL, 0x5288, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ULi M5288 */
-	{ PCI_VENDOR_ID_INTEL, 0x2681, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ESB2 */
-	{ PCI_VENDOR_ID_INTEL, 0x2682, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ESB2 */
-	{ PCI_VENDOR_ID_INTEL, 0x2683, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ESB2 */
-	{ PCI_VENDOR_ID_INTEL, 0x27c6, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ICH7-M DH */
-	{ PCI_VENDOR_ID_INTEL, 0x2821, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ICH8 */
-	{ PCI_VENDOR_ID_INTEL, 0x2822, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ICH8 */
-	{ PCI_VENDOR_ID_INTEL, 0x2824, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ICH8 */
-	{ PCI_VENDOR_ID_INTEL, 0x2829, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ICH8M */
-	{ PCI_VENDOR_ID_INTEL, 0x282a, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ICH8M */
+	{ PCI_VDEVICE(INTEL, 0x2652), board_ahci }, /* ICH6 */
+	{ PCI_VDEVICE(INTEL, 0x2653), board_ahci }, /* ICH6M */
+	{ PCI_VDEVICE(INTEL, 0x27c1), board_ahci }, /* ICH7 */
+	{ PCI_VDEVICE(INTEL, 0x27c5), board_ahci }, /* ICH7M */
+	{ PCI_VDEVICE(INTEL, 0x27c3), board_ahci }, /* ICH7R */
+	{ PCI_VDEVICE(AL, 0x5288), board_ahci }, /* ULi M5288 */
+	{ PCI_VDEVICE(INTEL, 0x2681), board_ahci }, /* ESB2 */
+	{ PCI_VDEVICE(INTEL, 0x2682), board_ahci }, /* ESB2 */
+	{ PCI_VDEVICE(INTEL, 0x2683), board_ahci }, /* ESB2 */
+	{ PCI_VDEVICE(INTEL, 0x27c6), board_ahci }, /* ICH7-M DH */
+	{ PCI_VDEVICE(INTEL, 0x2821), board_ahci }, /* ICH8 */
+	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* ICH8 */
+	{ PCI_VDEVICE(INTEL, 0x2824), board_ahci }, /* ICH8 */
+	{ PCI_VDEVICE(INTEL, 0x2829), board_ahci }, /* ICH8M */
+	{ PCI_VDEVICE(INTEL, 0x282a), board_ahci }, /* ICH8M */
 
 	/* JMicron */
-	{ 0x197b, 0x2360, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* JMicron JMB360 */
-	{ 0x197b, 0x2361, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* JMicron JMB361 */
-	{ 0x197b, 0x2363, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* JMicron JMB363 */
-	{ 0x197b, 0x2365, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* JMicron JMB365 */
-	{ 0x197b, 0x2366, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* JMicron JMB366 */
+	{ PCI_VDEVICE(JMICRON, 0x2360), board_ahci }, /* JMicron JMB360 */
+	{ PCI_VDEVICE(JMICRON, 0x2361), board_ahci }, /* JMicron JMB361 */
+	{ PCI_VDEVICE(JMICRON, 0x2363), board_ahci }, /* JMicron JMB363 */
+	{ PCI_VDEVICE(JMICRON, 0x2365), board_ahci }, /* JMicron JMB365 */
+	{ PCI_VDEVICE(JMICRON, 0x2366), board_ahci }, /* JMicron JMB366 */
 
 	/* ATI */
-	{ PCI_VENDOR_ID_ATI, 0x4380, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ATI SB600 non-raid */
-	{ PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ATI SB600 raid */
+	{ PCI_VDEVICE(ATI, 0x4380), board_ahci }, /* ATI SB600 non-raid */
+	{ PCI_VDEVICE(ATI, 0x4381), board_ahci }, /* ATI SB600 raid */
 
 	/* VIA */
-	{ PCI_VENDOR_ID_VIA, 0x3349, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci_vt8251 }, /* VIA VT8251 */
+	{ PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */
 
 	/* NVIDIA */
-	{ PCI_VENDOR_ID_NVIDIA, 0x044c, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci },		/* MCP65 */
-	{ PCI_VENDOR_ID_NVIDIA, 0x044d, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci },		/* MCP65 */
-	{ PCI_VENDOR_ID_NVIDIA, 0x044e, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci },		/* MCP65 */
-	{ PCI_VENDOR_ID_NVIDIA, 0x044f, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci },		/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x044c), board_ahci },		/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x044d), board_ahci },		/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x044e), board_ahci },		/* MCP65 */
+	{ PCI_VDEVICE(NVIDIA, 0x044f), board_ahci },		/* MCP65 */
 
 	/* SiS */
-	{ PCI_VENDOR_ID_SI, 0x1184, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* SiS 966 */
-	{ PCI_VENDOR_ID_SI, 0x1185, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* SiS 966 */
-	{ PCI_VENDOR_ID_SI, 0x0186, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* SiS 968 */
+	{ PCI_VDEVICE(SI, 0x1184), board_ahci }, /* SiS 966 */
+	{ PCI_VDEVICE(SI, 0x1185), board_ahci }, /* SiS 966 */
+	{ PCI_VDEVICE(SI, 0x0186), board_ahci }, /* SiS 968 */
 
 	{ }	/* terminate list */
 };
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 0e23ecb..81f3d21 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -192,8 +192,7 @@ static struct ata_port_info adma_port_in
 };
 
 static const struct pci_device_id adma_ata_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PDC, 0x1841, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_1841_idx },
+	{ PCI_VDEVICE(PDC, 0x1841), board_1841_idx },
 
 	{ }	/* terminate list */
 };
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 8cd730f..bbf2959 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -106,38 +106,24 @@ enum nv_host_type
 };
 
 static const struct pci_device_id nv_pci_tbl[] = {
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE2 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE3 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE3 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, 0x045c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, 0x045d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, 0x045e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
-	{ PCI_VENDOR_ID_NVIDIA, 0x045f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA), NFORCE2 },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA), NFORCE3 },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2), NFORCE3 },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA), CK804 },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2), CK804 },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA), CK804 },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2), CK804 },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA2), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SATA3), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, 0x045c), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, 0x045d), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, 0x045e), GENERIC },
+	{ PCI_VDEVICE(NVIDIA, 0x045f), GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index d627812..15c9437 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -234,48 +234,31 @@ static const struct ata_port_info pdc_po
 };
 
 static const struct pci_device_id pdc_ata_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PROMISE, 0x3371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_2037x },
-	{ PCI_VENDOR_ID_PROMISE, 0x3570, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_2037x },
-	{ PCI_VENDOR_ID_PROMISE, 0x3571, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_2037x },
-	{ PCI_VENDOR_ID_PROMISE, 0x3373, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_2037x },
-	{ PCI_VENDOR_ID_PROMISE, 0x3375, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_2037x },
-	{ PCI_VENDOR_ID_PROMISE, 0x3376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_2037x },
-	{ PCI_VENDOR_ID_PROMISE, 0x3574, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_2057x },
-	{ PCI_VENDOR_ID_PROMISE, 0x3d75, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_2057x },
-	{ PCI_VENDOR_ID_PROMISE, 0x3d73, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_2037x },
-
-	{ PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_20319 },
-	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_20319 },
-	{ PCI_VENDOR_ID_PROMISE, 0x3515, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_20319 },
-	{ PCI_VENDOR_ID_PROMISE, 0x3519, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_20319 },
-	{ PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_20319 },
-	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_40518 },
-
-	{ PCI_VENDOR_ID_PROMISE, 0x6629, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_20619 },
+	{ PCI_VDEVICE(PROMISE, 0x3371), board_2037x },
+	{ PCI_VDEVICE(PROMISE, 0x3570), board_2037x },
+	{ PCI_VDEVICE(PROMISE, 0x3571), board_2037x },
+	{ PCI_VDEVICE(PROMISE, 0x3373), board_2037x },
+	{ PCI_VDEVICE(PROMISE, 0x3375), board_2037x },
+	{ PCI_VDEVICE(PROMISE, 0x3376), board_2037x },
+	{ PCI_VDEVICE(PROMISE, 0x3574), board_2057x },
+	{ PCI_VDEVICE(PROMISE, 0x3d75), board_2057x },
+	{ PCI_VDEVICE(PROMISE, 0x3d73), board_2037x },
+
+	{ PCI_VDEVICE(PROMISE, 0x3318), board_20319 },
+	{ PCI_VDEVICE(PROMISE, 0x3319), board_20319 },
+	{ PCI_VDEVICE(PROMISE, 0x3515), board_20319 },
+	{ PCI_VDEVICE(PROMISE, 0x3519), board_20319 },
+	{ PCI_VDEVICE(PROMISE, 0x3d17), board_20319 },
+	{ PCI_VDEVICE(PROMISE, 0x3d18), board_40518 },
+
+	{ PCI_VDEVICE(PROMISE, 0x6629), board_20619 },
 
 /* TODO: remove all associated board_20771 code, as it completely
  * duplicates board_2037x code, unless reason for separation can be
  * divined.
  */
 #if 0
-	{ PCI_VENDOR_ID_PROMISE, 0x3570, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_20771 },
+	{ PCI_VDEVICE(PROMISE, 0x3570), board_20771 },
 #endif
 
 	{ }	/* terminate list */
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index c63dbab..3d9fa1c 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -123,13 +123,14 @@ static void sil_thaw(struct ata_port *ap
 
 
 static const struct pci_device_id sil_pci_tbl[] = {
-	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3512 },
-	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
-	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_no_sata_irq },
-	{ 0x1002, 0x437a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_no_sata_irq },
+	{ PCI_VDEVICE(CMD, 0x3112), sil_3112 },
+	{ PCI_VDEVICE(CMD, 0x0240), sil_3112 },
+	{ PCI_VDEVICE(CMD, 0x3512), sil_3512 },
+	{ PCI_VDEVICE(CMD, 0x3114), sil_3114 },
+	{ PCI_VDEVICE(ATI, 0x436e), sil_3112 },
+	{ PCI_VDEVICE(ATI, 0x4379), sil_3112_no_sata_irq },
+	{ PCI_VDEVICE(ATI, 0x437a), sil_3112_no_sata_irq },
+
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 39cb07b..a951f40 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -344,11 +344,12 @@ static int sil24_pci_device_resume(struc
 #endif
 
 static const struct pci_device_id sil24_pci_tbl[] = {
-	{ 0x1095, 0x3124, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3124 },
-	{ 0x8086, 0x3124, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3124 },
-	{ 0x1095, 0x3132, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3132 },
-	{ 0x1095, 0x3131, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3131 },
-	{ 0x1095, 0x3531, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3131 },
+	{ PCI_VDEVICE(CMD, 0x3124), BID_SIL3124 },
+	{ PCI_VDEVICE(INTEL, 0x3124), BID_SIL3124 },
+	{ PCI_VDEVICE(CMD, 0x3132), BID_SIL3132 },
+	{ PCI_VDEVICE(CMD, 0x3131), BID_SIL3131 },
+	{ PCI_VDEVICE(CMD, 0x3531), BID_SIL3131 },
+
 	{ } /* terminate list */
 };
 
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 18d49ff..8e8dc3f 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -67,9 +67,9 @@ static u32 sis_scr_read (struct ata_port
 static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static const struct pci_device_id sis_pci_tbl[] = {
-	{ PCI_VENDOR_ID_SI, 0x180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
-	{ PCI_VENDOR_ID_SI, 0x181, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
-	{ PCI_VENDOR_ID_SI, 0x182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
+	{ PCI_VDEVICE(SI, 0x180), sis_180 },
+	{ PCI_VDEVICE(SI, 0x181), sis_180 },
+	{ PCI_VDEVICE(SI, 0x182), sis_180 },
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 091867e..2b3d44b 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -230,8 +230,8 @@ static const struct ata_port_info pdc_po
 };
 
 static const struct pci_device_id pdc_sata_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PROMISE, 0x6622, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_20621 },
+	{ PCI_VDEVICE(PROMISE, 0x6622), board_20621 },
+
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index dd76f37..c2e6b7e 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -61,9 +61,10 @@ static u32 uli_scr_read (struct ata_port
 static void uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static const struct pci_device_id uli_pci_tbl[] = {
-	{ PCI_VENDOR_ID_AL, 0x5289, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5289 },
-	{ PCI_VENDOR_ID_AL, 0x5287, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5287 },
-	{ PCI_VENDOR_ID_AL, 0x5281, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5281 },
+	{ PCI_VDEVICE(AL, 0x5289), uli_5289 },
+	{ PCI_VDEVICE(AL, 0x5287), uli_5287 },
+	{ PCI_VDEVICE(AL, 0x5281), uli_5281 },
+
 	{ }	/* terminate list */
 };
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d6a3d4b..df44b09 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -109,6 +109,10 @@ static inline u32 ata_msg_init(int dval,
 #define ATA_TAG_POISON		0xfafbfcfdU
 
 /* move to PCI layer? */
+#define PCI_VDEVICE(vendor, device)		\
+	PCI_VENDOR_ID_##vendor, (device),	\
+	PCI_ANY_ID, PCI_ANY_ID, 0, 0
+
 static inline struct device *pci_dev_to_dev(struct pci_dev *pdev)
 {
 	return &pdev->dev;
