Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbTAULhc>; Tue, 21 Jan 2003 06:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbTAULhc>; Tue, 21 Jan 2003 06:37:32 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:45065 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267030AbTAULha>; Tue, 21 Jan 2003 06:37:30 -0500
Date: Tue, 21 Jan 2003 12:46:22 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: small patch for Via Pro 266T agp-support
Message-ID: <20030121114622.GD25484@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a small patch to allow my motherboard to use the AGP port. It
didn't work with agp_try_unsupported=1 on the command-line.

It's a dual-tualatin motherboard, so it's  kind of exotic.

00:00.0 Host bridge: VIA Technologies, Inc. VT8653 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
00:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:0a.0 SCSI storage controller: LSI Logic / Symbios Logic 53c860 (rev 13)
00:0b.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 03)

Kind regards,
Jurriaan

diff -urN -X dontdiff linux-2.4.21p3ac4/drivers/char/agp/agpgart_be.c linux-2.4.21p3ac4-pro266t/drivers/char/agp/agpgart_be.c
--- linux-2.4.21p3ac4/drivers/char/agp/agpgart_be.c	2003-01-21 12:04:59.000000000 +0100
+++ linux-2.4.21p3ac4-pro266t/drivers/char/agp/agpgart_be.c	2003-01-15 20:07:53.000000000 +0100
@@ -4700,6 +4700,12 @@
 		"Via",
 		"Apollo Pro KT400",
 		via_generic_setup },
+        { PCI_DEVICE_ID_VIA_8653_0,
+		PCI_VENDOR_ID_VIA,
+		VIA_APOLLO_PRO266T,
+		"Via",
+		"Apollo Pro 266T",
+		via_generic_setup },
 	{ 0,
 		PCI_VENDOR_ID_VIA,
 		VIA_GENERIC,
diff -urN -X dontdiff linux-2.4.21p3ac4/drivers/char/drm/drm_agpsupport.h linux-2.4.21p3ac4-pro266t/drivers/char/drm/drm_agpsupport.h
--- linux-2.4.21p3ac4/drivers/char/drm/drm_agpsupport.h	2003-01-21 12:04:59.000000000 +0100
+++ linux-2.4.21p3ac4-pro266t/drivers/char/drm/drm_agpsupport.h	2003-01-21 12:11:39.000000000 +0100
@@ -281,6 +281,8 @@
 			break;
 		case VIA_APOLLO_KT400:  head->chipset = "VIA Apollo KT400";
 			break;
+		case VIA_APOLLO_PRO266T: head->chipset = "VIA Apollo Pro 266T";
+			break;
 		case VIA_APOLLO_PRO: 	head->chipset = "VIA Apollo Pro";
 			break;
 
diff -urN -X dontdiff linux-2.4.21p3ac4/drivers/char/drm-4.0/agpsupport.c linux-2.4.21p3ac4-pro266t/drivers/char/drm-4.0/agpsupport.c
--- linux-2.4.21p3ac4/drivers/char/drm-4.0/agpsupport.c	2003-01-21 12:05:00.000000000 +0100
+++ linux-2.4.21p3ac4-pro266t/drivers/char/drm-4.0/agpsupport.c	2003-01-15 20:07:53.000000000 +0100
@@ -277,6 +277,8 @@
 			break;
 		case VIA_APOLLO_KT400:  head->chipset = "VIA Apollo KT400";
 			break;
+		case VIA_APOLLO_PRO266T: head->chipset = "VIA Apollo PRO266T";
+			break;
 #endif
 
 		case VIA_APOLLO_PRO: 	head->chipset = "VIA Apollo Pro";
diff -urN -X dontdiff linux-2.4.21p3ac4/include/linux/agp_backend.h linux-2.4.21p3ac4-pro266t/include/linux/agp_backend.h
--- linux-2.4.21p3ac4/include/linux/agp_backend.h	2003-01-21 12:05:02.000000000 +0100
+++ linux-2.4.21p3ac4-pro266t/include/linux/agp_backend.h	2003-01-15 20:07:53.000000000 +0100
@@ -61,6 +61,7 @@
 	VIA_APOLLO_KX133,
 	VIA_APOLLO_KT133,
 	VIA_APOLLO_KT400,
+	VIA_APOLLO_PRO266T,
 	SIS_GENERIC,
 	AMD_GENERIC,
 	AMD_IRONGATE,
diff -urN -X dontdiff linux-2.4.21p3ac4/include/linux/pci_ids.h linux-2.4.21p3ac4-pro266t/include/linux/pci_ids.h
--- linux-2.4.21p3ac4/include/linux/pci_ids.h	2003-01-21 12:05:02.000000000 +0100
+++ linux-2.4.21p3ac4-pro266t/include/linux/pci_ids.h	2003-01-15 20:07:53.000000000 +0100
@@ -1011,6 +1011,7 @@
 #define PCI_DEVICE_ID_VIA_82C686_6	0x3068
 #define PCI_DEVICE_ID_VIA_8233_0	0x3074
 #define PCI_DEVICE_ID_VIA_8633_0	0x3091
+#define PCI_DEVICE_ID_VIA_8653_0	0x3101
 #define PCI_DEVICE_ID_VIA_8367_0	0x3099
 #define PCI_DEVICE_ID_VIA_8622		0x3102
 #define PCI_DEVICE_ID_VIA_8233C_0	0x3109
-- 
"And remember: Evil will always prevail, because Good is dumb."
	Spaceballs
GNU/Linux 2.4.21-pre3-ac4 SMP/ReiserFS 2x2785 bogomips load av: 0.41 0.50 0.37
