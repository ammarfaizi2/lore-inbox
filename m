Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbVLDDMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVLDDMe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 22:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVLDDMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 22:12:34 -0500
Received: from pakuro.is.sci.toho-u.ac.jp ([202.16.210.67]:51718 "EHLO
	pakuro.n.is.sci.toho-u.ac.jp") by vger.kernel.org with ESMTP
	id S932199AbVLDDMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 22:12:34 -0500
Date: Sun, 04 Dec 2005 12:14:31 +0900 (JST)
Message-Id: <20051204.121431.74723725.his@kuro.is.sci.toho-u.ac.jp>
To: linux-kernel@vger.kernel.org
Cc: mike-@cinci.rr.com
Subject: [PATCH 2.6.14.3] hid-core: add HID quirks for Morphy USB-IO
From: "ITO N. Hisashi" <his@kuro.is.sci.toho-u.ac.jp>
Reply-To: his@kuro.is.sci.toho-u.ac.jp
X-Mailer: Mew version 4.2 on Emacs 21.1 / Mule 5.0
 =?iso-2022-jp?B?KBskQjgtTFobKEIp?=
In-Reply-To: <20051204.111420.74726127.his@kuro.is.sci.toho-u.ac.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morphy USB-IO (and its clones made by Km2Net or Techno Kit) reports 
the type to be an HID, but this is wrong because it is a general
purpose I/O device.

Signed-off-by: Hisashi Ito <kuro@neko.ac>

diff -U 5 -rpN linux-2.6.14.3-vanilla/drivers/usb/input/hid-core.c linux-2.6.14.3/drivers/usb/input/hid-core.c
--- linux-2.6.14.3-vanilla/drivers/usb/input/hid-core.c	2005-11-25 07:10:21.000000000 +0900
+++ linux-2.6.14.3/drivers/usb/input/hid-core.c	2005-12-04 11:43:38.000000000 +0900
@@ -1445,10 +1445,19 @@ void hid_init_reports(struct hid_device 
 #define USB_DEVICE_ID_POWERCONTROL	0x2030
 
 #define USB_VENDOR_ID_APPLE		0x05ac
 #define USB_DEVICE_ID_APPLE_POWERMOUSE	0x0304
 
+#define USB_VENDOR_ID_KM2NET		0x1352
+#define USB_DEVICE_ID_KM2NET_USBIO	0x0100
+
+#define USB_VENDOR_ID_MORPHY		0x0BFE
+#define USB_DEVICE_ID_MORPHY_USBIO	0x1000
+
+#define USB_VENDOR_ID_TECHNOKIT		0x12ED
+#define USB_DEVICE_ID_TECHNOKIT_USBIO	0x1003
+
 /*
  * Alphabetically sorted blacklist by quirk type.
  */
 
 static struct hid_blacklist {
@@ -1480,10 +1489,11 @@ static struct hid_blacklist {
 	{ USB_VENDOR_ID_GLAB, USB_DEVICE_ID_0_0_4_IF_KIT, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GLAB, USB_DEVICE_ID_0_8_8_IF_KIT, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_POWERMATE, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_SOUNDKNOB, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_KBGEAR, USB_DEVICE_ID_KBGEAR_JAMSTUDIO, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_KM2NET, USB_DEVICE_ID_KM2NET_USBIO, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_LD, USB_DEVICE_ID_CASSY, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_LD, USB_DEVICE_ID_POCKETCASSY, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_LD, USB_DEVICE_ID_MOBILECASSY, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_LD, USB_DEVICE_ID_JWM, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_LD, USB_DEVICE_ID_DMMP, HID_QUIRK_IGNORE },
@@ -1495,16 +1505,21 @@ static struct hid_blacklist {
 	{ USB_VENDOR_ID_LD, USB_DEVICE_ID_POWERCONTROL, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_MCC, USB_DEVICE_ID_MCC_PMD1024LS, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_MCC, USB_DEVICE_ID_MCC_PMD1208LS, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS1, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_MORPHY, USB_DEVICE_ID_MORPHY_USBIO, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_MORPHY, USB_DEVICE_ID_MORPHY_USBIO + 1, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_MORPHY, USB_DEVICE_ID_MORPHY_USBIO + 2, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_MORPHY, USB_DEVICE_ID_MORPHY_USBIO + 3, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 100, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 200, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 300, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 400, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 500, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_TECHNOKIT, USB_DEVICE_ID_TECHNOKIT_USBIO, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_LABPRO, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_GOTEMP, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_SKIP, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_VERNIER, USB_DEVICE_ID_VERNIER_CYCLOPS, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PENPARTNER, HID_QUIRK_IGNORE },
