Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbTBBAhH>; Sat, 1 Feb 2003 19:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbTBBAhH>; Sat, 1 Feb 2003 19:37:07 -0500
Received: from smtp1.EUnet.yu ([194.247.192.50]:52646 "EHLO smtp1.eunet.yu")
	by vger.kernel.org with ESMTP id <S265074AbTBBAhF>;
	Sat, 1 Feb 2003 19:37:05 -0500
Message-ID: <3E3C6A64.5020009@EUnet.yu>
Date: Sun, 02 Feb 2003 01:46:28 +0100
From: Toplica =?ISO-8859-2?Q?Tanaskovi=E6?= <toptan@EUnet.yu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us, sr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: [ PATCH ] radeonfb and ATI Radeon R9000 (2.4.18)]
Content-Type: multipart/mixed;
 boundary="------------030203000102060401080308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030203000102060401080308
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit



-------- Original Message --------
Subject: [ PATCH ] radeonfb and ATI Radeon R9000 (2.4.18)
Date: Sat, 01 Feb 2003 15:02:05 +0100
From: Toplica Tanaskoviæ <toptan@EUnet.yu>
Organization: Public news server of EUnet Yugoslavia
Newsgroups: comp.os.linux.development

	Hi,

	Here is the patch for 2.4.18 kernel that adds ATI Radeon R9000 support to
the Radeon Framebuffer driver, also fixes annoying console corruption
when using fglrx and switching from X to console.

	As I said this is a patch for 2.4.18, but I think that it will work with
2.4.19 and 2.4.20 too.

	Best regards,
	Toplica


--------------030203000102060401080308
Content-Type: text/plain;
 name="radeonfb_patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeonfb_patch.diff"

--- orig/usr/src/linux/drivers/video/radeon.h	Sat Feb  1 14:08:53 2003
+++ linux/drivers/video/radeon.h	Sat Feb  1 14:21:39 2003
@@ -14,6 +14,7 @@
 #define PCI_DEVICE_ID_RADEON_LZ		0x4c5a
 #define PCI_DEVICE_ID_RADEON_QL		0x514c
 #define PCI_DEVICE_ID_RADEON_QW		0x5157
+#define PCI_DEVICE_ID_RADEON_IG		0x4966

 #define RADEON_REGSIZE			0x4000

--- orig/usr/src/linux/drivers/video/radeonfb.c	Sat Feb  1 14:08:53 2003
+++ linux/drivers/video/radeonfb.c	Sat Feb  1 14:23:40 2003
@@ -19,6 +19,7 @@
  *	2001-11-18	DFP fixes, Kevin Hendricks, 0.1.3
  *	2001-11-29	more cmap, backlight fixes, Benjamin Herrenschmidt
  *	2002-01-18	DFP panel detection via BIOS, Michael Clark, 0.1.4
+ *	2003-01-30	Added Radeon R9000, Tanaskovic Toplica <toptan@EUnet.yu>
  *
  *	Special thanks to ATI DevRel team for their hardware donations.
  *
@@ -100,7 +100,8 @@
 	RADEON_QW,	/* Radeon RV200 (7500) */
 	RADEON_LW,	/* Radeon Mobility M7 */
 	RADEON_LY,	/* Radeon Mobility M6 */
-	RADEON_LZ	/* Radeon Mobility M6 */
+	RADEON_LZ,	/* Radeon Mobility M6 */
+	RADEON_IG,	/* Radeon RV250 (9000) */
 };


@@ -127,6 +128,7 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LW, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_LW},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LY, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_LY},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LZ, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_LZ},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_IG, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_IG},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, radeonfb_pci_table);
@@ -856,6 +858,10 @@
 			strcpy(rinfo->name, "Radeon M6 LZ ");
 			rinfo->hasCRTC2 = 1;
 			break;
+		case PCI_DEVICE_ID_RADEON_IG:
+			strcpy(rinfo->name, "Radeon R9000 IG ");
+			rinfo->hasCRTC2 = 1;
+			break;
 		default:
 			return -ENODEV;
 	}


--------------030203000102060401080308--

