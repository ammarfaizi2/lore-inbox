Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161223AbWI2A2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbWI2A2z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161207AbWI2A2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:28:55 -0400
Received: from havoc.gtf.org ([69.61.125.42]:33159 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161223AbWI2A2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:28:49 -0400
Date: Thu, 28 Sep 2006 20:28:48 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 5/5] libata: PCI ID table cleanups
Message-ID: <20060929002848.GE7458@havoc.gtf.org>
References: <20060929002601.GA7397@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929002601.GA7397@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


commit 2d2744fc8be620a2dc469cf48349e3e704119f1b
Author: Jeff Garzik <jeff@garzik.org>
Date:   Thu Sep 28 20:21:59 2006 -0400

    [libata] PCI ID table cleanup in various drivers

    * Use PCI_VDEVICE() macro
    * const-ify pci_device_id table
    * standardize list terminator as "{ }"
    * convert spaces to tab in pci_driver struct (Alan-ism)
    * various minor whitespace cleanups

    Signed-off-by: Jeff Garzik <jeff@garzik.org>

 drivers/ata/pata_ali.c          |    9 +++++----
 drivers/ata/pata_amd.c          |   38 +++++++++++++++++++-------------------
 drivers/ata/pata_artop.c        |   12 ++++++------
 drivers/ata/pata_atiixp.c       |   14 +++++++-------
 drivers/ata/pata_cmd64x.c       |   17 ++++++++---------
 drivers/ata/pata_cs5520.c       |   10 +++++-----
 drivers/ata/pata_cs5530.c       |   11 +++++------
 drivers/ata/pata_cs5535.c       |    9 ++++-----
 drivers/ata/pata_cypress.c      |   13 +++++++------
 drivers/ata/pata_efar.c         |    4 ++--
 drivers/ata/pata_hpt366.c       |    9 +++++----
 drivers/ata/pata_hpt37x.c       |   19 +++++++++----------
 drivers/ata/pata_hpt3x2n.c      |   17 ++++++++---------
 drivers/ata/pata_hpt3x3.c       |    9 +++++----
 drivers/ata/pata_it821x.c       |   13 ++++++-------
 drivers/ata/pata_jmicron.c      |   11 ++++++-----
 drivers/ata/pata_mpiix.c        |    9 +++------
 drivers/ata/pata_netcell.c      |    3 ++-
 drivers/ata/pata_ns87410.c      |    9 ++++-----
 drivers/ata/pata_oldpiix.c      |    4 ++--
 drivers/ata/pata_opti.c         |   10 +++++-----
 drivers/ata/pata_optidma.c      |    9 ++++-----
 drivers/ata/pata_pdc2027x.c     |   15 ++++++++-------
 drivers/ata/pata_pdc202xx_old.c |   19 +++++++++----------
 drivers/ata/pata_radisys.c      |    4 ++--
 drivers/ata/pata_rz1000.c       |   12 ++++++------
 drivers/ata/pata_sc1200.c       |   11 +++++------
 drivers/ata/pata_serverworks.c  |   17 ++++++++---------
 drivers/ata/pata_sil680.c       |    9 ++++-----
 drivers/ata/pata_sis.c          |    6 +++---
 drivers/ata/pata_sl82c105.c     |    9 ++++-----
 drivers/ata/pata_triflex.c      |   10 ++++------
 drivers/ata/pata_via.c          |   15 +++++++--------
 drivers/ata/sata_mv.c           |   27 ++++++++++++++-------------
 drivers/ata/sata_nv.c           |    3 ++-
 drivers/ata/sata_qstor.c        |    3 +--
 drivers/ata/sata_sis.c          |    2 +-
 drivers/ata/sata_svw.c          |   15 ++++++---------
 drivers/ata/sata_sx4.c          |    1 -
 drivers/ata/sata_uli.c          |    1 -
 drivers/ata/sata_via.c          |    6 +++---
 drivers/ata/sata_vsc.c          |    6 +-----
 42 files changed, 215 insertions(+), 235 deletions(-)

2d2744fc8be620a2dc469cf48349e3e704119f1b
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 87af3b5..3f49e38 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -644,10 +644,11 @@ static int ali_init_one(struct pci_dev *
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
-static struct pci_device_id ali[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5228), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5229), },
-	{ 0, },
+static const struct pci_device_id ali[] = {
+	{ PCI_VDEVICE(AL, PCI_DEVICE_ID_AL_M5228), },
+	{ PCI_VDEVICE(AL, PCI_DEVICE_ID_AL_M5229), },
+
+	{ },
 };
 
 static struct pci_driver ali_pci_driver = {
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 599ee26..29234c8 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -662,27 +662,28 @@ static int amd_init_one(struct pci_dev *
 }
 
 static const struct pci_device_id amd[] = {
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_COBRA_7401,		PCI_ANY_ID, PCI_ANY_ID, 0, 0,  0 },
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7409,		PCI_ANY_ID, PCI_ANY_ID, 0, 0,  1 },
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7411,		PCI_ANY_ID, PCI_ANY_ID, 0, 0,  3 },
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_OPUS_7441,		PCI_ANY_ID, PCI_ANY_ID, 0, 0,  4 },
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8111_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0,  5 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  7 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  8 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  8 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  8 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
-	{ PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE,		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9 },
-	{ 0, },
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_COBRA_7401),		0 },
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_VIPER_7409),		1 },
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_VIPER_7411),		3 },
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_OPUS_7441),		4 },
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_8111_IDE),		5 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_IDE),	7 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE),	8 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE),	8 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE),	8 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE),	8 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE),	8 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE),	8 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_IDE),	8 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE),	8 },
+	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_IDE),	8 },
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE),		9 },
+
+	{ },
 };
 
 static struct pci_driver amd_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= amd,
 	.probe 		= amd_init_one,
 	.remove		= ata_pci_remove_one
@@ -698,7 +699,6 @@ static void __exit amd_exit(void)
 	pci_unregister_driver(&amd_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for AMD PATA IDE");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index c4ccb75..49565ef 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -475,11 +475,12 @@ static int artop_init_one (struct pci_de
 }
 
 static const struct pci_device_id artop_pci_tbl[] = {
-	{ 0x1191, 0x0005, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ 0x1191, 0x0006, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ 0x1191, 0x0007, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ 0x1191, 0x0008, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
-	{ 0x1191, 0x0009, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
+	{ PCI_VDEVICE(ARTOP, 0x0005), 0 },
+	{ PCI_VDEVICE(ARTOP, 0x0006), 1 },
+	{ PCI_VDEVICE(ARTOP, 0x0007), 1 },
+	{ PCI_VDEVICE(ARTOP, 0x0008), 2 },
+	{ PCI_VDEVICE(ARTOP, 0x0009), 2 },
+
 	{ }	/* terminate list */
 };
 
@@ -500,7 +501,6 @@ static void __exit artop_exit(void)
 	pci_unregister_driver(&artop_pci_driver);
 }
 
-
 module_init(artop_init);
 module_exit(artop_exit);
 
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 6c2269b..1ce28d2 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -267,12 +267,13 @@ static int atiixp_init_one(struct pci_de
 	return ata_pci_init_one(dev, port_info, 2);
 }
 
-static struct pci_device_id atiixp[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP200_IDE), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE), },
-	{ 0, },
+static const struct pci_device_id atiixp[] = {
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP200_IDE), },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP300_IDE), },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP400_IDE), },
+	{ PCI_VDEVICE(ATI, PCI_DEVICE_ID_ATI_IXP600_IDE), },
+
+	{ },
 };
 
 static struct pci_driver atiixp_pci_driver = {
@@ -293,7 +294,6 @@ static void __exit atiixp_exit(void)
 	pci_unregister_driver(&atiixp_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for ATI IXP200/300/400");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index e92b0ef..b9bbd1d 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -468,16 +468,17 @@ #endif
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
-static struct pci_device_id cmd64x[] = {
-	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_643, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_646, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_648, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
-	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_649, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5},
-	{ 0, },
+static const struct pci_device_id cmd64x[] = {
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_643), 0 },
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_646), 1 },
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_648), 4 },
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_649), 5 },
+
+	{ },
 };
 
 static struct pci_driver cmd64x_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= cmd64x,
 	.probe 		= cmd64x_init_one,
 	.remove		= ata_pci_remove_one
@@ -488,13 +489,11 @@ static int __init cmd64x_init(void)
 	return pci_register_driver(&cmd64x_pci_driver);
 }
 
-
 static void __exit cmd64x_exit(void)
 {
 	pci_unregister_driver(&cmd64x_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for CMD64x series PATA controllers");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index a6c6ceb..2cd3c0f 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -299,10 +299,11 @@ static void __devexit cs5520_remove_one(
 /* For now keep DMA off. We can set it for all but A rev CS5510 once the
    core ATA code can handle it */
 
-static struct pci_device_id pata_cs5520[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5510), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520), },
-	{ 0, },
+static const struct pci_device_id pata_cs5520[] = {
+	{ PCI_VDEVICE(CYRIX, PCI_DEVICE_ID_CYRIX_5510), },
+	{ PCI_VDEVICE(CYRIX, PCI_DEVICE_ID_CYRIX_5520), },
+
+	{ },
 };
 
 static struct pci_driver cs5520_pci_driver = {
@@ -312,7 +313,6 @@ static struct pci_driver cs5520_pci_driv
 	.remove		= cs5520_remove_one
 };
 
-
 static int __init cs5520_init(void)
 {
 	return pci_register_driver(&cs5520_pci_driver);
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index 7bba4d9..a07cc81 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -353,13 +353,14 @@ fail_put:
 	return -ENODEV;
 }
 
-static struct pci_device_id cs5530[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_IDE), },
-	{ 0, },
+static const struct pci_device_id cs5530[] = {
+	{ PCI_VDEVICE(CYRIX, PCI_DEVICE_ID_CYRIX_5530_IDE), },
+
+	{ },
 };
 
 static struct pci_driver cs5530_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= cs5530,
 	.probe 		= cs5530_init_one,
 	.remove		= ata_pci_remove_one
@@ -370,13 +371,11 @@ static int __init cs5530_init(void)
 	return pci_register_driver(&cs5530_pci_driver);
 }
 
-
 static void __exit cs5530_exit(void)
 {
 	pci_unregister_driver(&cs5530_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for the Cyrix/NS/AMD 5530");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index d64fcdc..f8def3f 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -257,9 +257,10 @@ static int cs5535_init_one(struct pci_de
 	return ata_pci_init_one(dev, ports, 1);
 }
 
-static struct pci_device_id cs5535[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_NS, 0x002D), },
-	{ 0, },
+static const struct pci_device_id cs5535[] = {
+	{ PCI_VDEVICE(NS, 0x002D), },
+
+	{ },
 };
 
 static struct pci_driver cs5535_pci_driver = {
@@ -274,13 +275,11 @@ static int __init cs5535_init(void)
 	return pci_register_driver(&cs5535_pci_driver);
 }
 
-
 static void __exit cs5535_exit(void)
 {
 	pci_unregister_driver(&cs5535_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox, Jens Altmann, Wolfgan Zuleger, Alexander Kiausch");
 MODULE_DESCRIPTION("low-level driver for the NS/AMD 5530");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index dfa5ac5..247b436 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -184,8 +184,8 @@ static int cy82c693_init_one(struct pci_
 	};
 	static struct ata_port_info *port_info[1] = { &info };
 
-	/* Devfn 1 is the ATA primary. The secondary is magic and on devfn2. For the
-	   moment we don't handle the secondary. FIXME */
+	/* Devfn 1 is the ATA primary. The secondary is magic and on devfn2.
+	   For the moment we don't handle the secondary. FIXME */
 
 	if (PCI_FUNC(pdev->devfn) != 1)
 		return -ENODEV;
@@ -193,13 +193,14 @@ static int cy82c693_init_one(struct pci_
 	return ata_pci_init_one(pdev, port_info, 1);
 }
 
-static struct pci_device_id cy82c693[] = {
-	{ PCI_VENDOR_ID_CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ 0, },
+static const struct pci_device_id cy82c693[] = {
+	{ PCI_VDEVICE(CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693), },
+
+	{ },
 };
 
 static struct pci_driver cy82c693_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= cy82c693,
 	.probe 		= cy82c693_init_one,
 	.remove		= ata_pci_remove_one
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index 95cd1ca..ef18c60 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -305,7 +305,8 @@ static int efar_init_one (struct pci_dev
 }
 
 static const struct pci_device_id efar_pci_tbl[] = {
-	{ 0x1055, 0x9130, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VDEVICE(EFAR, 0x9130), },
+
 	{ }	/* terminate list */
 };
 
@@ -326,7 +327,6 @@ static void __exit efar_exit(void)
 	pci_unregister_driver(&efar_pci_driver);
 }
 
-
 module_init(efar_init);
 module_exit(efar_exit);
 
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index cf656ec..68a0e57 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -444,13 +444,14 @@ static int hpt36x_init_one(struct pci_de
 	return ata_pci_init_one(dev, port_info, 2);
 }
 
-static struct pci_device_id hpt36x[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366), },
-	{ 0, },
+static const struct pci_device_id hpt36x[] = {
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT366), },
+
+	{ },
 };
 
 static struct pci_driver hpt36x_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= hpt36x,
 	.probe 		= hpt36x_init_one,
 	.remove		= ata_pci_remove_one
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 10318c0..7350443 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -1219,17 +1219,18 @@ static int hpt37x_init_one(struct pci_de
 	return ata_pci_init_one(dev, port_info, 2);
 }
 
-static struct pci_device_id hpt37x[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT371), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT372), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT374), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT302), },
-	{ 0, },
+static const struct pci_device_id hpt37x[] = {
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT366), },
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT371), },
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT372), },
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT374), },
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT302), },
+
+	{ },
 };
 
 static struct pci_driver hpt37x_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= hpt37x,
 	.probe 		= hpt37x_init_one,
 	.remove		= ata_pci_remove_one
@@ -1240,13 +1241,11 @@ static int __init hpt37x_init(void)
 	return pci_register_driver(&hpt37x_pci_driver);
 }
 
-
 static void __exit hpt37x_exit(void)
 {
 	pci_unregister_driver(&hpt37x_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for the Highpoint HPT37x/30x");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 5c5d4f6..58cfb2b 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -560,16 +560,17 @@ static int hpt3x2n_init_one(struct pci_d
 	return ata_pci_init_one(dev, port_info, 2);
 }
 
-static struct pci_device_id hpt3x2n[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT372), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT302), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT372N), },
-	{ 0, },
+static const struct pci_device_id hpt3x2n[] = {
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT366), },
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT372), },
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT302), },
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT372N), },
+
+	{ },
 };
 
 static struct pci_driver hpt3x2n_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= hpt3x2n,
 	.probe 		= hpt3x2n_init_one,
 	.remove		= ata_pci_remove_one
@@ -580,13 +581,11 @@ static int __init hpt3x2n_init(void)
 	return pci_register_driver(&hpt3x2n_pci_driver);
 }
 
-
 static void __exit hpt3x2n_exit(void)
 {
 	pci_unregister_driver(&hpt3x2n_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for the Highpoint HPT3x2n/30x");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index 1f084ab..3334d72 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -192,13 +192,14 @@ static int hpt3x3_init_one(struct pci_de
 	return ata_pci_init_one(dev, port_info, 2);
 }
 
-static struct pci_device_id hpt3x3[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT343), },
-	{ 0, },
+static const struct pci_device_id hpt3x3[] = {
+	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT343), },
+
+	{ },
 };
 
 static struct pci_driver hpt3x3_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= hpt3x3,
 	.probe 		= hpt3x3_init_one,
 	.remove		= ata_pci_remove_one
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 82a46ff..18ff3e5 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -808,14 +808,15 @@ static int it821x_init_one(struct pci_de
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
-static struct pci_device_id it821x[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8211), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8212), },
-	{ 0, },
+static const struct pci_device_id it821x[] = {
+	{ PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8211), },
+	{ PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8212), },
+
+	{ },
 };
 
 static struct pci_driver it821x_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= it821x,
 	.probe 		= it821x_init_one,
 	.remove		= ata_pci_remove_one
@@ -826,13 +827,11 @@ static int __init it821x_init(void)
 	return pci_register_driver(&it821x_pci_driver);
 }
 
-
 static void __exit it821x_exit(void)
 {
 	pci_unregister_driver(&it821x_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for the IT8211/IT8212 IDE RAID controller");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index be3a866..52a2bdf 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -229,11 +229,12 @@ static int jmicron_init_one (struct pci_
 }
 
 static const struct pci_device_id jmicron_pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361), 361},
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363), 363},
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365), 365},
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366), 366},
-	{ PCI_DEVICE(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368), 368},
+	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB361), 361},
+	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB363), 363},
+	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB365), 365},
+	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB366), 366},
+	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB368), 368},
+
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index 3c65393..9dfe3e9 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -274,11 +274,10 @@ static void __devexit mpiix_remove_one(s
 	dev_set_drvdata(dev, NULL);
 }
 
-
-
 static const struct pci_device_id mpiix[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371MX), },
-	{ 0, },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82371MX), },
+
+	{ },
 };
 
 static struct pci_driver mpiix_pci_driver = {
@@ -293,13 +292,11 @@ static int __init mpiix_init(void)
 	return pci_register_driver(&mpiix_pci_driver);
 }
 
-
 static void __exit mpiix_exit(void)
 {
 	pci_unregister_driver(&mpiix_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for Intel MPIIX");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index 76eb9c9..f5672de 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -142,7 +142,8 @@ static int netcell_init_one (struct pci_
 }
 
 static const struct pci_device_id netcell_pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_NETCELL, PCI_DEVICE_ID_REVOLUTION), },
+	{ PCI_VDEVICE(NETCELL, PCI_DEVICE_ID_REVOLUTION), },
+
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 2005a95..2a3dbee 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -200,12 +200,13 @@ static int ns87410_init_one(struct pci_d
 }
 
 static const struct pci_device_id ns87410[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87410), },
-	{ 0, },
+	{ PCI_VDEVICE(NS, PCI_DEVICE_ID_NS_87410), },
+
+	{ },
 };
 
 static struct pci_driver ns87410_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= ns87410,
 	.probe 		= ns87410_init_one,
 	.remove		= ata_pci_remove_one
@@ -216,13 +217,11 @@ static int __init ns87410_init(void)
 	return pci_register_driver(&ns87410_pci_driver);
 }
 
-
 static void __exit ns87410_exit(void)
 {
 	pci_unregister_driver(&ns87410_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for Nat Semi 87410");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index 31a285c..fc947df 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -303,7 +303,8 @@ static int oldpiix_init_one (struct pci_
 }
 
 static const struct pci_device_id oldpiix_pci_tbl[] = {
-	{ PCI_DEVICE(0x8086, 0x1230), },
+	{ PCI_VDEVICE(INTEL, 0x1230), },
+
 	{ }	/* terminate list */
 };
 
@@ -324,7 +325,6 @@ static void __exit oldpiix_exit(void)
 	pci_unregister_driver(&oldpiix_pci_driver);
 }
 
-
 module_init(oldpiix_init);
 module_exit(oldpiix_exit);
 
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 57fe21f..a7320ba 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -256,13 +256,14 @@ static int opti_init_one(struct pci_dev 
 }
 
 static const struct pci_device_id opti[] = {
-	{ PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C621, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ 0, },
+	{ PCI_VDEVICE(OPTI, PCI_DEVICE_ID_OPTI_82C621), 0 },
+	{ PCI_VDEVICE(OPTI, PCI_DEVICE_ID_OPTI_82C825), 1 },
+
+	{ },
 };
 
 static struct pci_driver opti_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= opti,
 	.probe 		= opti_init_one,
 	.remove		= ata_pci_remove_one
@@ -273,7 +274,6 @@ static int __init opti_init(void)
 	return pci_register_driver(&opti_pci_driver);
 }
 
-
 static void __exit opti_exit(void)
 {
 	pci_unregister_driver(&opti_pci_driver);
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index 7296a20..c6906b4 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -512,12 +512,13 @@ static int optidma_init_one(struct pci_d
 }
 
 static const struct pci_device_id optidma[] = {
-	{ PCI_DEVICE(0x1045, 0xD568), },	/* Opti 82C700 */
-	{ 0, },
+	{ PCI_VDEVICE(OPTI, 0xD568), },		/* Opti 82C700 */
+
+	{ },
 };
 
 static struct pci_driver optidma_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= optidma,
 	.probe 		= optidma_init_one,
 	.remove		= ata_pci_remove_one
@@ -528,13 +529,11 @@ static int __init optidma_init(void)
 	return pci_register_driver(&optidma_pci_driver);
 }
 
-
 static void __exit optidma_exit(void)
 {
 	pci_unregister_driver(&optidma_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for Opti Firestar/Firestar Plus");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index bd4ed67..d894d99 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -108,13 +108,14 @@ static struct pdc2027x_udma_timing {
 };
 
 static const struct pci_device_id pdc2027x_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PDC_UDMA_100 },
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20269, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PDC_UDMA_133 },
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20270, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PDC_UDMA_100 },
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20271, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PDC_UDMA_133 },
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20275, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PDC_UDMA_133 },
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20276, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PDC_UDMA_133 },
-	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20277, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PDC_UDMA_133 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20268), PDC_UDMA_100 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20269), PDC_UDMA_133 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20270), PDC_UDMA_100 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20271), PDC_UDMA_133 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20275), PDC_UDMA_133 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20276), PDC_UDMA_133 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20277), PDC_UDMA_133 },
+
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 48f4343..5ba9eb2 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -385,17 +385,18 @@ static int pdc_init_one(struct pci_dev *
 	return ata_pci_init_one(dev, port_info, 2);
 }
 
-static struct pci_device_id pdc[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20246), 0},
-	{ PCI_DEVICE(PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20262), 1},
-	{ PCI_DEVICE(PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20263), 1},
-	{ PCI_DEVICE(PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20265), 2},
-	{ PCI_DEVICE(PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20267), 2},
-	{ 0, },
+static const struct pci_device_id pdc[] = {
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20246), 0 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20262), 1 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20263), 1 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20265), 2 },
+	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20267), 2 },
+
+	{ },
 };
 
 static struct pci_driver pdc_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= pdc,
 	.probe 		= pdc_init_one,
 	.remove		= ata_pci_remove_one
@@ -406,13 +407,11 @@ static int __init pdc_init(void)
 	return pci_register_driver(&pdc_pci_driver);
 }
 
-
 static void __exit pdc_exit(void)
 {
 	pci_unregister_driver(&pdc_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for Promise 2024x and 20262-20267");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index c20bcf4..1af83d7 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -300,7 +300,8 @@ static int radisys_init_one (struct pci_
 }
 
 static const struct pci_device_id radisys_pci_tbl[] = {
-	{ 0x1331, 0x8201, PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VDEVICE(RADISYS, 0x8201), },
+
 	{ }	/* terminate list */
 };
 
@@ -321,7 +322,6 @@ static void __exit radisys_exit(void)
 	pci_unregister_driver(&radisys_pci_driver);
 }
 
-
 module_init(radisys_init);
 module_exit(radisys_exit);
 
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index eccc6fd..4533b63 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -170,20 +170,20 @@ fail:
 	return -ENODEV;
 }
 
-static struct pci_device_id pata_rz1000[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_RZ1000), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_RZ1001), },
-	{ 0, },
+static const struct pci_device_id pata_rz1000[] = {
+	{ PCI_VDEVICE(PCTECH, PCI_DEVICE_ID_PCTECH_RZ1000), },
+	{ PCI_VDEVICE(PCTECH, PCI_DEVICE_ID_PCTECH_RZ1001), },
+
+	{ },
 };
 
 static struct pci_driver rz1000_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= pata_rz1000,
 	.probe 		= rz1000_init_one,
 	.remove		= ata_pci_remove_one
 };
 
-
 static int __init rz1000_init(void)
 {
 	return pci_register_driver(&rz1000_pci_driver);
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 107e6cd..067d9d2 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -253,13 +253,14 @@ static int sc1200_init_one(struct pci_de
 	return ata_pci_init_one(dev, port_info, 1);
 }
 
-static struct pci_device_id sc1200[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_IDE), },
-	{ 0, },
+static const struct pci_device_id sc1200[] = {
+	{ PCI_VDEVICE(NS, PCI_DEVICE_ID_NS_SCx200_IDE), },
+
+	{ },
 };
 
 static struct pci_driver sc1200_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= sc1200,
 	.probe 		= sc1200_init_one,
 	.remove		= ata_pci_remove_one
@@ -270,13 +271,11 @@ static int __init sc1200_init(void)
 	return pci_register_driver(&sc1200_pci_driver);
 }
 
-
 static void __exit sc1200_exit(void)
 {
 	pci_unregister_driver(&sc1200_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox, Mark Lord");
 MODULE_DESCRIPTION("low-level driver for the NS/AMD SC1200");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index a5c8d7e..5bbf76e 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -553,13 +553,14 @@ static int serverworks_init_one(struct p
 	return ata_pci_init_one(pdev, port_info, ports);
 }
 
-static struct pci_device_id serverworks[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE), 0},
-	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE), 2},
-	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE), 2},
-	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2), 2},
-	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT1000IDE), 2},
-	{ 0, },
+static const struct pci_device_id serverworks[] = {
+	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE), 0},
+	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE), 2},
+	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE), 2},
+	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2), 2},
+	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT1000IDE), 2},
+
+	{ },
 };
 
 static struct pci_driver serverworks_pci_driver = {
@@ -574,13 +575,11 @@ static int __init serverworks_init(void)
 	return pci_register_driver(&serverworks_pci_driver);
 }
 
-
 static void __exit serverworks_exit(void)
 {
 	pci_unregister_driver(&serverworks_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for Serverworks OSB4/CSB5/CSB6");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index c8b2e26..4a2b72b 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -348,12 +348,13 @@ static int sil680_init_one(struct pci_de
 }
 
 static const struct pci_device_id sil680[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_680), },
-	{ 0, },
+	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_SII_680), },
+
+	{ },
 };
 
 static struct pci_driver sil680_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= sil680,
 	.probe 		= sil680_init_one,
 	.remove		= ata_pci_remove_one
@@ -364,13 +365,11 @@ static int __init sil680_init(void)
 	return pci_register_driver(&sil680_pci_driver);
 }
 
-
 static void __exit sil680_exit(void)
 {
 	pci_unregister_driver(&sil680_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for SI680 PATA");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 17791e2..b9ffafb 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -988,8 +988,9 @@ static int sis_init_one (struct pci_dev 
 }
 
 static const struct pci_device_id sis_pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_SI, 0x5513), },	/* SiS 5513 */
-	{ PCI_DEVICE(PCI_VENDOR_ID_SI, 0x5518), },	/* SiS 5518 */
+	{ PCI_VDEVICE(SI, 0x5513), },	/* SiS 5513 */
+	{ PCI_VDEVICE(SI, 0x5518), },	/* SiS 5518 */
+
 	{ }
 };
 
@@ -1010,7 +1011,6 @@ static void __exit sis_exit(void)
 	pci_unregister_driver(&sis_pci_driver);
 }
 
-
 module_init(sis_init);
 module_exit(sis_exit);
 
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index 5b762ac..08a6dc8 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -351,9 +351,10 @@ static int sl82c105_init_one(struct pci_
 	return ata_pci_init_one(dev, port_info, 1); /* For now */
 }
 
-static struct pci_device_id sl82c105[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105), },
-	{ 0, },
+static const struct pci_device_id sl82c105[] = {
+	{ PCI_VDEVICE(WINBOND, PCI_DEVICE_ID_WINBOND_82C105), },
+
+	{ },
 };
 
 static struct pci_driver sl82c105_pci_driver = {
@@ -368,13 +369,11 @@ static int __init sl82c105_init(void)
 	return pci_register_driver(&sl82c105_pci_driver);
 }
 
-
 static void __exit sl82c105_exit(void)
 {
 	pci_unregister_driver(&sl82c105_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for Sl82c105");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index a954ed9..9640f80 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -248,13 +248,13 @@ static int triflex_init_one(struct pci_d
 }
 
 static const struct pci_device_id triflex[] = {
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE,
-				  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0, },
+	{ PCI_VDEVICE(COMPAQ, PCI_DEVICE_ID_COMPAQ_TRIFLEX_IDE), },
+
+	{ },
 };
 
 static struct pci_driver triflex_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= triflex,
 	.probe 		= triflex_init_one,
 	.remove		= ata_pci_remove_one
@@ -265,13 +265,11 @@ static int __init triflex_init(void)
 	return pci_register_driver(&triflex_pci_driver);
 }
 
-
 static void __exit triflex_exit(void)
 {
 	pci_unregister_driver(&triflex_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for Compaq Triflex");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 7b5dd23..1e7be9e 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -529,15 +529,16 @@ static int via_init_one(struct pci_dev *
 }
 
 static const struct pci_device_id via[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C576_1), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_6410), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_SATA_EIDE), },
-	{ 0, },
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_82C576_1), },
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_82C586_1), },
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_6410), },
+	{ PCI_VDEVICE(VIA, PCI_DEVICE_ID_VIA_SATA_EIDE), },
+
+	{ },
 };
 
 static struct pci_driver via_pci_driver = {
-        .name 		= DRV_NAME,
+	.name 		= DRV_NAME,
 	.id_table	= via,
 	.probe 		= via_init_one,
 	.remove		= ata_pci_remove_one
@@ -548,13 +549,11 @@ static int __init via_init(void)
 	return pci_register_driver(&via_pci_driver);
 }
 
-
 static void __exit via_exit(void)
 {
 	pci_unregister_driver(&via_pci_driver);
 }
 
-
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("low-level driver for VIA PATA");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index c01496d..e6aa1a8 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -533,19 +533,20 @@ static const struct ata_port_info mv_por
 };
 
 static const struct pci_device_id mv_pci_tbl[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5040), 0, 0, chip_504x},
-	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5041), 0, 0, chip_504x},
-	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5080), 0, 0, chip_5080},
-	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x5081), 0, 0, chip_508x},
-
-	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6040), 0, 0, chip_604x},
-	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6041), 0, 0, chip_604x},
-	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6042), 0, 0, chip_6042},
-	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6080), 0, 0, chip_608x},
-	{PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x6081), 0, 0, chip_608x},
-
-	{PCI_DEVICE(PCI_VENDOR_ID_ADAPTEC2, 0x0241), 0, 0, chip_604x},
-	{}			/* terminate list */
+	{ PCI_VDEVICE(MARVELL, 0x5040), chip_504x },
+	{ PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
+	{ PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
+	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
+
+	{ PCI_VDEVICE(MARVELL, 0x6040), chip_604x },
+	{ PCI_VDEVICE(MARVELL, 0x6041), chip_604x },
+	{ PCI_VDEVICE(MARVELL, 0x6042), chip_6042 },
+	{ PCI_VDEVICE(MARVELL, 0x6080), chip_608x },
+	{ PCI_VDEVICE(MARVELL, 0x6081), chip_608x },
+
+	{ PCI_VDEVICE(ADAPTEC2, 0x0241), chip_604x },
+
+	{ }			/* terminate list */
 };
 
 static struct pci_driver mv_pci_driver = {
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index bbf2959..d09d20a 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -130,7 +130,8 @@ static const struct pci_device_id nv_pci
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_RAID<<8, 0xffff00, GENERIC },
-	{ 0, } /* terminate list */
+
+	{ } /* terminate list */
 };
 
 static struct pci_driver nv_pci_driver = {
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index fa29dfe..7f6cc3c 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -185,8 +185,7 @@ static const struct ata_port_info qs_por
 };
 
 static const struct pci_device_id qs_ata_pci_tbl[] = {
-	{ PCI_VENDOR_ID_PDC, 0x2068, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_2068_idx },
+	{ PCI_VDEVICE(PDC, 0x2068), board_2068_idx },
 
 	{ }	/* terminate list */
 };
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 8e8dc3f..0738f52 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -70,10 +70,10 @@ static const struct pci_device_id sis_pc
 	{ PCI_VDEVICE(SI, 0x180), sis_180 },
 	{ PCI_VDEVICE(SI, 0x181), sis_180 },
 	{ PCI_VDEVICE(SI, 0x182), sis_180 },
+
 	{ }	/* terminate list */
 };
 
-
 static struct pci_driver sis_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= sis_pci_tbl,
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index d6d6658..84025a2 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -469,15 +469,15 @@ err_out:
  * controller
  * */
 static const struct pci_device_id k2_sata_pci_tbl[] = {
-	{ 0x1166, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
-	{ 0x1166, 0x0241, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
-	{ 0x1166, 0x0242, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
-	{ 0x1166, 0x024a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
-	{ 0x1166, 0x024b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0240), 4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0241), 4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0242), 8 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x024a), 4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x024b), 4 },
+
 	{ }
 };
 
-
 static struct pci_driver k2_sata_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= k2_sata_pci_tbl,
@@ -485,19 +485,16 @@ static struct pci_driver k2_sata_pci_dri
 	.remove			= ata_pci_remove_one,
 };
 
-
 static int __init k2_sata_init(void)
 {
 	return pci_register_driver(&k2_sata_pci_driver);
 }
 
-
 static void __exit k2_sata_exit(void)
 {
 	pci_unregister_driver(&k2_sata_pci_driver);
 }
 
-
 MODULE_AUTHOR("Benjamin Herrenschmidt");
 MODULE_DESCRIPTION("low-level driver for K2 SATA controller");
 MODULE_LICENSE("GPL");
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 2b3d44b..8c74f2f 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -235,7 +235,6 @@ static const struct pci_device_id pdc_sa
 	{ }	/* terminate list */
 };
 
-
 static struct pci_driver pdc_sata_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= pdc_sata_pci_tbl,
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index c2e6b7e..5c603ca 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -68,7 +68,6 @@ static const struct pci_device_id uli_pc
 	{ }	/* terminate list */
 };
 
-
 static struct pci_driver uli_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= uli_pci_tbl,
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index a72a238..f4455a1 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -77,9 +77,9 @@ static void svia_scr_write (struct ata_p
 static void vt6420_error_handler(struct ata_port *ap);
 
 static const struct pci_device_id svia_pci_tbl[] = {
-	{ 0x1106, 0x0591, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
-	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
-	{ 0x1106, 0x3249, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6421 },
+	{ PCI_VDEVICE(VIA, 0x0591), vt6420 },
+	{ PCI_VDEVICE(VIA, 0x3149), vt6420 },
+	{ PCI_VDEVICE(VIA, 0x3249), vt6421 },
 
 	{ }	/* terminate list */
 };
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index d0d92f3..273d88f 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -442,16 +442,15 @@ err_out:
 	return rc;
 }
 
-
 static const struct pci_device_id vsc_sata_pci_tbl[] = {
 	{ PCI_VENDOR_ID_VITESSE, 0x7174,
 	  PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
 	{ PCI_VENDOR_ID_INTEL, 0x3200,
 	  PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
+
 	{ }	/* terminate list */
 };
 
-
 static struct pci_driver vsc_sata_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= vsc_sata_pci_tbl,
@@ -459,19 +458,16 @@ static struct pci_driver vsc_sata_pci_dr
 	.remove			= ata_pci_remove_one,
 };
 
-
 static int __init vsc_sata_init(void)
 {
 	return pci_register_driver(&vsc_sata_pci_driver);
 }
 
-
 static void __exit vsc_sata_exit(void)
 {
 	pci_unregister_driver(&vsc_sata_pci_driver);
 }
 
-
 MODULE_AUTHOR("Jeremy Higdon");
 MODULE_DESCRIPTION("low-level driver for Vitesse VSC7174 SATA controller");
 MODULE_LICENSE("GPL");
