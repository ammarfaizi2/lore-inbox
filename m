Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265482AbTFRUhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 16:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265525AbTFRUhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 16:37:16 -0400
Received: from frontb-d.sezampro.yu ([194.106.188.52]:23816 "HELO
	frontb-d.sezampro.yu") by vger.kernel.org with SMTP id S265482AbTFRUgQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 16:36:16 -0400
From: Toplica =?utf-8?q?Tanaskovi=C4=87?= <toptan@sezampro.yu>
To: linux-kernel@vger.kernel.org
Subject: Radeonfb update and fix
Date: Wed, 18 Jun 2003 22:38:09 +0200
User-Agent: KMail/1.5.9
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_x2M8+MjcQ57N57b"
Message-Id: <200306182238.09581.toptan@sezampro.yu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_x2M8+MjcQ57N57b
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

	Hi, everyone!

	This patch does two things:

	1. Adds RV250 (R9000 series) Radeon to radeon framebuffer files.
	2. Fixes small but annoying bug for Radeon P/M users. The brake was missin=
g=20
in case so -ENODEV was returned for this card.

	It applies to 2.4.21 and 2.4.21-ac1, both.

	Alan and Marcelo please apply.
=2D-=20
Pozdrav,
Toplica Tanaskovi=C4=87

--Boundary-00=_x2M8+MjcQ57N57b
Content-Type: text/x-diff;
  charset="utf-8";
  name="radeonfb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="radeonfb.diff"

diff -ruN orig/linux-2.4.21/drivers/video/radeonfb.c linux/drivers/video/radeonfb.c
--- orig/linux-2.4.21/drivers/video/radeonfb.c	2003-06-14 00:38:58.000000000 +0200
+++ linux/drivers/video/radeonfb.c	2003-06-14 01:46:30.000000000 +0200
@@ -101,7 +101,8 @@
 	RADEON_LW,	/* Radeon Mobility M7 */
 	RADEON_LY,	/* Radeon Mobility M6 */
 	RADEON_LZ,	/* Radeon Mobility M6 */
-	RADEON_PM	/* Radeon Mobility P/M */
+	RADEON_PM,	/* Radeon Mobility P/M */
+	RADEON_IF	/* Radeon RV250 (9000) */
 };


@@ -129,6 +130,7 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LY, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_LY},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LZ, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_LZ},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_PM, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_PM},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_IF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_IF},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, radeonfb_pci_table);
@@ -861,6 +863,11 @@
 	        case PCI_DEVICE_ID_RADEON_PM:
 			strcpy(rinfo->name, "Radeon P/M ");
 			rinfo->hasCRTC2 = 1;
+			break;
+		case PCI_DEVICE_ID_RADEON_IF:
+			strcpy(rinfo->name, "Radeon R9000 IF ");
+			rinfo->hasCRTC2 = 1;
+			break;
 		default:
 			return -ENODEV;
 	}
diff -ruN orig/linux-2.4.21/drivers/video/radeon.h linux/drivers/video/radeon.h
--- orig/linux-2.4.21/drivers/video/radeon.h	2002-11-29 00:53:15.000000000 +0100
+++ linux/drivers/video/radeon.h	2003-06-14 01:43:46.000000000 +0200
@@ -15,6 +15,7 @@
 #define PCI_DEVICE_ID_RADEON_PM		0x4c52
 #define PCI_DEVICE_ID_RADEON_QL		0x514c
 #define PCI_DEVICE_ID_RADEON_QW		0x5157
+#define PCI_DEVICE_ID_RADEON_IF		0x4966

 #define RADEON_REGSIZE			0x4000


--Boundary-00=_x2M8+MjcQ57N57b--

