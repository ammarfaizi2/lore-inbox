Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTESWfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTESWfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:35:41 -0400
Received: from tyler.snap.net.nz ([202.37.101.20]:20918 "EHLO
	tyler.snap.net.nz") by vger.kernel.org with ESMTP id S263176AbTESWfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:35:37 -0400
Message-ID: <002101c31e58$9881bae0$1d687cca@xp1800>
From: "D & E Radel" <radel@inet.net.nz>
To: <davej@codemonkey.org.uk>, <alan@redhat.com>,
       <linux-kernel@vger.kernel.org>
Cc: "Flavio Stanchina" <flavio.stanchina@tin.it>,
       "Nicolas Mailhot" <Nicolas.Mailhot@laPoste.net>
Subject: AGP Kernel Patch for VIA KM266 / KL266
Date: Tue, 20 May 2003 10:47:10 +1200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001E_01C31EBD.2A601CE0"
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_001E_01C31EBD.2A601CE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi there

I am not quite sure who to send this to.......

With much help from Nicolas Mailhot and Flavio Stanchina, I have tested a 
Kernel 2.4.20 patch for AGP support for the VIA KM266 / KL266. It 
patches cleanly, compiles and runs in full 3D H/W acceleration with my 
ATI Radeon 9000.

Who do I send this to so that it can be included in the kernel?

Regards,
D.Radel.

-------------------
dmesg now says:
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Via Apollo Pro KM266 / KL266 chipset
agpgart: AGP aperture is 64M @ 0xe0000000



------=_NextPart_000_001E_01C31EBD.2A601CE0
Content-Type: application/octet-stream;
	name="km266-kl266-agp.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="km266-kl266-agp.patch"

diff -urN linux-2.4.20/drivers/char/agp/agpgart_be.c =
linux-2.4.20+KM266/drivers/char/agp/agpgart_be.c
--- linux-2.4.20/drivers/char/agp/agpgart_be.c	2002-12-21 =
03:39:12.000000000 +0100
+++ linux-2.4.20+KM266/drivers/char/agp/agpgart_be.c	2003-05-19 =
21:57:46.000000000 +0200
@@ -4714,6 +4714,12 @@
 		"Via",
 		"Apollo Pro KT266",
 		via_generic_setup },
+        { PCI_DEVICE_ID_VIA_8375,
+		PCI_VENDOR_ID_VIA,
+		VIA_APOLLO_KM266,
+		"Via",
+		"Apollo Pro KM266 / KL266",
+		via_generic_setup },
 	{ 0,
 		PCI_VENDOR_ID_VIA,
 		VIA_GENERIC,
diff -urN linux-2.4.20/drivers/char/drm/drm_agpsupport.h =
linux-2.4.20+KM266/drivers/char/drm/drm_agpsupport.h
--- linux-2.4.20/drivers/char/drm/drm_agpsupport.h	2003-05-08 =
17:28:09.000000000 +0200
+++ linux-2.4.20+KM266/drivers/char/drm/drm_agpsupport.h	2003-05-19 =
22:05:41.000000000 +0200
@@ -279,6 +279,8 @@
 			break;
 		case VIA_APOLLO_KT133:	head->chipset =3D "VIA Apollo KT133";
 			break;
+		case VIA_APOLLO_KM266:  head->chipset =3D "VIA Apollo KM266 / KL266";
+			break;
 		case VIA_APOLLO_PRO: 	head->chipset =3D "VIA Apollo Pro";
 			break;
=20
diff -urN linux-2.4.20/drivers/char/drm-4.0/agpsupport.c =
linux-2.4.20+KM266/drivers/char/drm-4.0/agpsupport.c
--- linux-2.4.20/drivers/char/drm-4.0/agpsupport.c	2002-02-25 =
20:37:57.000000000 +0100
+++ linux-2.4.20+KM266/drivers/char/drm-4.0/agpsupport.c	2003-05-19 =
21:57:46.000000000 +0200
@@ -275,6 +275,8 @@
 			break;
 		case VIA_APOLLO_KT133:	head->chipset =3D "VIA Apollo KT133";=20
 			break;
+		case VIA_APOLLO_KM266:  head->chipset =3D "VIA Apollo KM266 / KL266";
+			break;
 #endif
=20
 		case VIA_APOLLO_PRO: 	head->chipset =3D "VIA Apollo Pro";
diff -urN linux-2.4.20/drivers/pci/pci.ids =
linux-2.4.20+KM266/drivers/pci/pci.ids
--- linux-2.4.20/drivers/pci/pci.ids	2002-11-29 00:53:14.000000000 +0100
+++ linux-2.4.20+KM266/drivers/pci/pci.ids	2003-05-19 21:57:46.000000000 =
+0200
@@ -2741,6 +2741,7 @@
 	3104  USB 2.0
 	3109  VT8233C PCI to ISA Bridge
 	3112  VT8361 [KLE133] Host Bridge
+	3116  VT8375 [KM266/KL266 AGP] Host Bridge
 	3128  VT8753 [P4X266 AGP]
 	3133  VT3133 Host Bridge
 	3147  VT8233A ISA Bridge
diff -urN linux-2.4.20/include/linux/agp_backend.h =
linux-2.4.20+KM266/include/linux/agp_backend.h
--- linux-2.4.20/include/linux/agp_backend.h	2002-11-29 =
00:53:15.000000000 +0100
+++ linux-2.4.20+KM266/include/linux/agp_backend.h	2003-05-19 =
21:57:46.000000000 +0200
@@ -60,6 +60,7 @@
 	VIA_APOLLO_PRO,
 	VIA_APOLLO_KX133,
 	VIA_APOLLO_KT133,
+	VIA_APOLLO_KM266,
 	SIS_GENERIC,
 	AMD_GENERIC,
 	AMD_IRONGATE,
diff -urN linux-2.4.20/include/linux/pci_ids.h =
linux-2.4.20+KM266/include/linux/pci_ids.h
--- linux-2.4.20/include/linux/pci_ids.h	2002-11-30 05:49:28.000000000 =
+0100
+++ linux-2.4.20+KM266/include/linux/pci_ids.h	2003-05-19 =
21:57:46.000000000 +0200
@@ -988,6 +988,7 @@
 #define PCI_DEVICE_ID_VIA_8622		0x3102
 #define PCI_DEVICE_ID_VIA_8233C_0	0x3109
 #define PCI_DEVICE_ID_VIA_8361		0x3112
+#define PCI_DEVICE_ID_VIA_8375		0x3116
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100
 #define PCI_DEVICE_ID_VIA_8231		0x8231
=00=00=00
------=_NextPart_000_001E_01C31EBD.2A601CE0--

