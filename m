Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262508AbRENVgM>; Mon, 14 May 2001 17:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262509AbRENVgC>; Mon, 14 May 2001 17:36:02 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:5895 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262508AbRENVfo>; Mon, 14 May 2001 17:35:44 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105142140.XAA20274@green.mif.pg.gda.pl>
Subject: [PATCH] net PCI_ID fixes
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 14 May 2001 23:40:57 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch renames some PCI_IDS in net drivers to use namespace from
pci_ids.h.

Also the "__{dev,}initdata" variables in pcnet32.c put together.
It seems that the "section type conflict" in pcnet32.c some -ac kernels ago
was caused by __initdata variables not declared together (some public /
static variables between them). 
[ However I have no idea why separated __initdata vars break sometimes -
  a gcc error? ]

Andrzej

*************************************************************************
diff -ur linux-2.4.4-ac9/drivers/net/pcnet32.c linux/drivers/net/pcnet32.c
--- linux-2.4.4-ac9/drivers/net/pcnet32.c	Tue May  1 21:14:32 2001
+++ linux/drivers/net/pcnet32.c	Mon May 14 22:19:01 2001
@@ -45,6 +45,16 @@
 
 static unsigned int pcnet32_portlist[] __initdata = {0x300, 0x320, 0x340, 0x360, 0};
 
+/*
+ * PCI device identifiers for "new style" Linux PCI Device Drivers
+ */
+static struct pci_device_id pcnet32_pci_tbl[] __devinitdata = {
+    { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE_HOME, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+    { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+    { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE, 0x1014, 0x2000, 0, 0, 0 },
+    { 0, }
+};
+
 static int pcnet32_debug = 1;
 static int tx_start = 1; /* Mapping -- 0:20, 1:64, 2:128, 3:~220 (depends on chip vers) */
 
@@ -204,16 +214,6 @@
 
 #define PCNET32_TOTAL_SIZE 0x20
 
-/* some PCI ids */
-#ifndef PCI_DEVICE_ID_AMD_LANCE
-#define PCI_VENDOR_ID_AMD	      0x1022
-#define PCI_DEVICE_ID_AMD_LANCE	      0x2000
-#endif
-#ifndef PCI_DEVICE_ID_AMD_PCNETHOME
-#define PCI_DEVICE_ID_AMD_PCNETHOME   0x2001
-#endif
-
-
 #define CRC_POLYNOMIAL_LE 0xedb88320UL	/* Ethernet CRC, little endian */
 
 /* The PCNET32 Rx and Tx ring descriptors. */
@@ -318,16 +318,6 @@
     int (*probe1) (unsigned long, unsigned char, int, int, struct pci_dev *);
 };
 
-
-/*
- * PCI device identifiers for "new style" Linux PCI Device Drivers
- */
-static struct pci_device_id pcnet32_pci_tbl[] __devinitdata = {
-    { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PCNETHOME, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-    { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-    { PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LANCE, 0x1014, 0x2000, 0, 0, 0 },
-    { 0, }
-};
 
 MODULE_DEVICE_TABLE (pci, pcnet32_pci_tbl);
 
Only in linux/drivers/net: pcnet32.c.orig
diff -ur linux-2.4.4-ac9/drivers/net/tlan.c linux/drivers/net/tlan.c
--- linux-2.4.4-ac9/drivers/net/tlan.c	Tue May  1 21:14:33 2001
+++ linux/drivers/net/tlan.c	Mon May 14 22:19:01 2001
@@ -241,21 +241,21 @@
 };
 
 static struct pci_device_id tlan_pci_tbl[] __devinitdata = {
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_NETELLIGENT_10,
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL10,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_NETELLIGENT_10_100,
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_NETFLEX_3P_INTEGRATED,
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETFLEX3I,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_NETFLEX_3P,
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_THUNDER,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_NETFLEX_3P_BNC,
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETFLEX3B,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_NETELLIGENT_10_100_PROLIANT,
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100PI,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 5 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_NETELLIGENT_10_100_DUAL,
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100D,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6 },
-	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_DESKPRO_4000_5233MMX,
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_NETEL100I,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7 },
 	{ PCI_VENDOR_ID_OLICOM, PCI_DEVICE_ID_OLICOM_OC2183,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
diff -ur linux-2.4.4-ac9/drivers/net/tlan.h linux/drivers/net/tlan.h
--- linux-2.4.4-ac9/drivers/net/tlan.h	Thu Apr 26 23:50:56 2001
+++ linux/drivers/net/tlan.h	Mon May 14 22:19:01 2001
@@ -61,14 +61,6 @@
 	 *
 	 ****************************************************************/
 		
-#define PCI_DEVICE_ID_NETELLIGENT_10			0xAE34
-#define PCI_DEVICE_ID_NETELLIGENT_10_100		0xAE32
-#define PCI_DEVICE_ID_NETFLEX_3P_INTEGRATED		0xAE35
-#define PCI_DEVICE_ID_NETFLEX_3P			0xF130
-#define PCI_DEVICE_ID_NETFLEX_3P_BNC			0xF150
-#define PCI_DEVICE_ID_NETELLIGENT_10_100_PROLIANT	0xAE43
-#define PCI_DEVICE_ID_NETELLIGENT_10_100_DUAL		0xAE40
-#define PCI_DEVICE_ID_DESKPRO_4000_5233MMX		0xB011
 #define PCI_DEVICE_ID_NETELLIGENT_10_T2			0xB012
 #define PCI_DEVICE_ID_NETELLIGENT_10_100_WS_5100	0xB030
 #ifndef PCI_DEVICE_ID_OLICOM_OC2183

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
