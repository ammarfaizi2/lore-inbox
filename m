Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272386AbTHFTyi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272381AbTHFTyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:54:38 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:35998 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S272379AbTHFTy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:54:27 -0400
Message-ID: <3F315CDD.12EB17FE@hp.com>
Date: Wed, 06 Aug 2003 13:54:05 -0600
From: Alex Williamson <alex_williamson@hp.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.6.0-test2-bk5-aw-ob500 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] trivial 2.4/2.6 PCI name change/addition
Content-Type: multipart/mixed;
 boundary="------------2CDE4B7C22B2A8F6307A5E55"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2CDE4B7C22B2A8F6307A5E55
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


   This patch renames the PCI-X adapter found in HP zx1 and sx1000
ia64 systems to something more generic and descriptive.  It also
adds an ID for the PCI adapter used in sx1000.  Patches against
2.4.21+ia64 and 2.6.0-test2+ia64 attached.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab
--------------2CDE4B7C22B2A8F6307A5E55
Content-Type: text/plain; charset=us-ascii;
 name="2.4-lba-names.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4-lba-names.diff"

--- linux-2.4.21/include/linux/pci_ids.h~	2003-08-06 13:18:56.000000000 -0600
+++ linux-2.4.21/include/linux/pci_ids.h	2003-08-06 13:19:07.000000000 -0600
@@ -539,11 +539,12 @@
 #define PCI_DEVICE_ID_HP_DIVA1		0x1049
 #define PCI_DEVICE_ID_HP_DIVA2		0x104A
 #define PCI_DEVICE_ID_HP_SP2_0		0x104B
+#define PCI_DEVICE_ID_HP_PCI_LBA	0x1054
 #define PCI_DEVICE_ID_HP_REO_SBA	0x10f0
 #define PCI_DEVICE_ID_HP_REO_IOC	0x10f1
 #define PCI_DEVICE_ID_HP_ZX1_SBA	0x1229
 #define PCI_DEVICE_ID_HP_ZX1_IOC	0x122a
-#define PCI_DEVICE_ID_HP_ZX1_LBA	0x122e
+#define PCI_DEVICE_ID_HP_PCIX_LBA	0x122e
 #define PCI_DEVICE_ID_HP_SX1000_IOC	0x127c
 
 #define PCI_VENDOR_ID_PCTECH		0x1042
--- linux-2.4.21/drivers/pci/pci.ids~	2003-08-06 13:18:30.000000000 -0600
+++ linux-2.4.21/drivers/pci/pci.ids	2003-08-06 13:19:07.000000000 -0600
@@ -1212,6 +1212,7 @@
 		103c 1226  Keystone SP2
 		103c 1227  Powerbar SP2
 		103c 1282  Everest SP2
+	1054  PCI Local Bus Adapter
 	1064  79C970 PCnet Ethernet Controller
 	108b  Visualize FXe
 	10c1  NetServer Smart IRQ Router
@@ -1223,7 +1224,7 @@
 	121c  NetServer PCI COM Port Decoder
 	1229  zx1 System Bus Adapter
 	122a  zx1 I/O Controller
-	122e  zx1 Local Bus Adapter
+	122e  PCI-X/AGP Local Bus Adapter
 	1290  Auxiliary Diva Serial Port
 	2910  E2910A PCIBus Exerciser
 	2925  E2925A 32 Bit, 33 MHzPCI Exerciser & Analyzer
--- linux-2.4.21/drivers/char/agp/agpgart_be.c~	2003-08-06 13:18:20.000000000 -0600
+++ linux-2.4.21/drivers/char/agp/agpgart_be.c	2003-08-06 13:19:07.000000000 -0600
@@ -4853,7 +4853,7 @@
 	agp_bridge.type = HP_ZX1;
 
 	fake_bridge_dev.vendor = PCI_VENDOR_ID_HP;
-	fake_bridge_dev.device = PCI_DEVICE_ID_HP_ZX1_LBA;
+	fake_bridge_dev.device = PCI_DEVICE_ID_HP_PCIX_LBA;
 
 	return hp_zx1_ioc_init(ioc_hpa, lba_hpa);
 }

--------------2CDE4B7C22B2A8F6307A5E55
Content-Type: text/plain; charset=us-ascii;
 name="2.6-lba-names.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6-lba-names.diff"

--- linux-2.6.0-test2/include/linux/pci_ids.h~	2003-08-06 13:32:28.000000000 -0600
+++ linux-2.6.0-test2/include/linux/pci_ids.h	2003-08-06 13:34:53.000000000 -0600
@@ -608,6 +608,7 @@
 #define PCI_DEVICE_ID_HP_DIVA_TOSCA1	0x1049
 #define PCI_DEVICE_ID_HP_DIVA_TOSCA2	0x104A
 #define PCI_DEVICE_ID_HP_DIVA_MAESTRO	0x104B
+#define PCI_DEVICE_ID_HP_PCI_LBA	0x1054
 #define PCI_DEVICE_ID_HP_REO_SBA	0x10f0
 #define PCI_DEVICE_ID_HP_REO_IOC	0x10f1
 #define PCI_DEVICE_ID_HP_VISUALIZE_FXE	0x108b
@@ -616,7 +617,7 @@
 #define PCI_DEVICE_ID_HP_DIVA_POWERBAR	0x1227
 #define PCI_DEVICE_ID_HP_ZX1_SBA	0x1229
 #define PCI_DEVICE_ID_HP_ZX1_IOC	0x122a
-#define PCI_DEVICE_ID_HP_ZX1_LBA	0x122e
+#define PCI_DEVICE_ID_HP_PCIX_LBA	0x122e
 #define PCI_DEVICE_ID_HP_SX1000_IOC	0x127c
 #define PCI_DEVICE_ID_HP_DIVA_EVEREST	0x1282
 #define PCI_DEVICE_ID_HP_DIVA_AUX	0x1290
--- linux-2.6.0-test2/drivers/pci/pci.ids~	2003-08-06 13:32:08.000000000 -0600
+++ linux-2.6.0-test2/drivers/pci/pci.ids	2003-08-06 13:32:59.000000000 -0600
@@ -1286,6 +1286,7 @@
 		103c 1226  Keystone SP2
 		103c 1227  Powerbar SP2
 		103c 1282  Everest SP2
+	1054  PCI Local Bus Adapter
 	1064  79C970 PCnet Ethernet Controller
 	108b  Visualize FXe
 	10c1  NetServer Smart IRQ Router
@@ -1297,7 +1298,7 @@
 	121c  NetServer PCI COM Port Decoder
 	1229  zx1 System Bus Adapter
 	122a  zx1 I/O Controller
-	122e  zx1 Local Bus Adapter
+	122e  PCI-X/AGP Local Bus Adapter
 	1290  Auxiliary Diva Serial Port
 	2910  E2910A PCIBus Exerciser
 	2925  E2925A 32 Bit, 33 MHzPCI Exerciser & Analyzer
--- linux-2.6.0-test2/drivers/char/agp/hp-agp.c~	2003-08-06 13:32:54.000000000 -0600
+++ linux-2.6.0-test2/drivers/char/agp/hp-agp.c	2003-08-06 13:33:56.000000000 -0600
@@ -398,7 +398,7 @@
 	bridge->driver = &hp_zx1_driver;
 
 	fake_bridge_dev.vendor = PCI_VENDOR_ID_HP;
-	fake_bridge_dev.device = PCI_DEVICE_ID_HP_ZX1_LBA;
+	fake_bridge_dev.device = PCI_DEVICE_ID_HP_PCIX_LBA;
 	bridge->dev = &fake_bridge_dev;
 
 	return agp_add_bridge(bridge);

--------------2CDE4B7C22B2A8F6307A5E55--

