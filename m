Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbTBNRRO>; Fri, 14 Feb 2003 12:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTBNRRO>; Fri, 14 Feb 2003 12:17:14 -0500
Received: from smtp1.EUnet.yu ([194.247.192.50]:11219 "EHLO smtp1.eunet.yu")
	by vger.kernel.org with ESMTP id <S262089AbTBNRQK>;
	Fri, 14 Feb 2003 12:16:10 -0500
From: Toplica Tanaskovic <toptan@EUnet.yu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.18 KT400 support
Date: Fri, 14 Feb 2003 18:25:52 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Message-Id: <200302141821.14768.toptan@EUnet.yu>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gaST+CQPQ17TbT7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_gaST+CQPQ17TbT7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


	Here is the patch that adds complete support for Via KT400 chipsets for=20
2.4.18 kernel
	Don't forget to update yours pci.ids, before applying this patch don't for=
get=20
to update your pci.ids to the latest version.
=2D-=20
	Pozdrav,=20
	Tanaskovi=C4=87 Toplica



--Boundary-00=_gaST+CQPQ17TbT7
Content-Type: text/x-diff;
  charset="utf-8";
  name="KT400.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="KT400.diff"

diff -ur orig/linux/drivers/char/agp/agpgart_be.c linux/drivers/char/agp/agpgart_be.c
--- orig/linux/drivers/char/agp/agpgart_be.c	Mon Feb 25 20:37:57 2002
+++ linux/drivers/char/agp/agpgart_be.c	Tue Feb 11 22:18:23 2003
@@ -3807,6 +3807,12 @@
 		"Via",
 		"Apollo Pro KT266",
 		via_generic_setup },
+	{ PCI_DEVICE_ID_VIA_8377_0,
+		PCI_VENDOR_ID_VIA,
+		VIA_APOLLO_KT400,
+		"Via",
+		"Apollo Pro KT400",
+		via_generic_setup },
 	{ 0,
 		PCI_VENDOR_ID_VIA,
 		VIA_GENERIC,
diff -ur orig/linux/drivers/char/drm/drm_agpsupport.h linux/drivers/char/drm/drm_agpsupport.h
--- orig/linux/drivers/char/drm/drm_agpsupport.h	Wed Mar 27 13:57:12 2002
+++ linux/drivers/char/drm/drm_agpsupport.h	Tue Feb 11 22:20:42 2003
@@ -285,6 +285,8 @@
 			break;
 		case VIA_APOLLO_KT133:	head->chipset = "VIA Apollo KT133";
 			break;
+		case VIA_APOLLO_KT400:	head->chipset = "VIA Apollo KT400";
+			break;
 
 		case VIA_APOLLO_PRO: 	head->chipset = "VIA Apollo Pro";
 			break;
diff -ur orig/linux/drivers/char/drm-4.0/agpsupport.c linux/drivers/char/drm-4.0/agpsupport.c
--- orig/linux/drivers/char/drm-4.0/agpsupport.c	Mon Feb 25 20:37:57 2002
+++ linux/drivers/char/drm-4.0/agpsupport.c	Tue Feb 11 22:23:08 2003
@@ -275,6 +275,8 @@
 			break;
 		case VIA_APOLLO_KT133:	head->chipset = "VIA Apollo KT133"; 
 			break;
+		case VIA_APOLLO_KT400:	head->chipset = "VIA Apollo KT400";
+			break;
 #endif
 
 		case VIA_APOLLO_PRO: 	head->chipset = "VIA Apollo Pro";
diff -ur orig/linux/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
--- orig/linux/drivers/ide/via82cxxx.c	Wed Mar 27 13:57:19 2002
+++ linux/drivers/ide/via82cxxx.c	Tue Feb 11 22:39:28 2003
@@ -105,8 +105,8 @@
 } via_isa_bridges[] = {
 #ifdef FUTURE_BRIDGES
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 },
-	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 },
 #endif
+	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 },
 	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },
 	{ "vt8233",	PCI_DEVICE_ID_VIA_8233_0,   0x00, 0x2f, VIA_UDMA_100 },
diff -ur orig/linux/include/linux/agp_backend.h linux/include/linux/agp_backend.h
--- orig/linux/include/linux/agp_backend.h	Fri Nov  9 23:11:15 2001
+++ linux/include/linux/agp_backend.h	Tue Feb 11 22:25:47 2003
@@ -59,6 +59,7 @@
 	VIA_APOLLO_PRO,
 	VIA_APOLLO_KX133,
 	VIA_APOLLO_KT133,
+	VIA_APOLLO_KT400,
 	SIS_GENERIC,
 	AMD_GENERIC,
 	AMD_IRONGATE,
diff -ur orig/linux/include/linux/pci_ids.h linux/include/linux/pci_ids.h
--- orig/linux/include/linux/pci_ids.h	Wed Mar 27 13:57:17 2002
+++ linux/include/linux/pci_ids.h	Tue Feb 11 22:41:40 2003
@@ -963,6 +963,8 @@
 #define PCI_DEVICE_ID_VIA_8233C_0	0x3109
 #define PCI_DEVICE_ID_VIA_8361		0x3112
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
+#define PCI_DEVICE_ID_VIA_8235		0x3177
+#define PCI_DEVICE_ID_VIA_8377_0	0x3189
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235
Only in linux/include/linux: ~

--Boundary-00=_gaST+CQPQ17TbT7--

