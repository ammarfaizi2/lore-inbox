Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbUCPOrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbUCPOp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:45:27 -0500
Received: from styx.suse.cz ([82.208.2.94]:30593 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261900AbUCPOTa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:30 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <1079446776461@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 4/44] HID quirk for another A4Tech dual-wheel mouse
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:36 +0100
In-Reply-To: <10794467763549@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1474.188.4, 2004-01-26 13:18:17+01:00, vojtech@suse.cz
  input: Add support for another a4tech 2-wheel USB mouse, with
         a Cypress ID this time. Also rearrange the HID blacklist
         a bit - it has grown too long.


 hid-core.c  |   48 +++++++++++++++++++++++++++++-------------------
 hid-input.c |    7 ++++---
 2 files changed, 33 insertions(+), 22 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Tue Mar 16 13:20:05 2004
+++ b/drivers/usb/input/hid-core.c	Tue Mar 16 13:20:05 2004
@@ -1322,7 +1322,6 @@
 #define USB_VENDOR_ID_KBGEAR            0x084e
 #define USB_DEVICE_ID_KBGEAR_JAMSTUDIO  0x1001
 
-
 #define USB_VENDOR_ID_AIPTEK		0x08ca
 #define USB_DEVICE_ID_AIPTEK_6000	0x0020
 
@@ -1361,6 +1360,9 @@
 #define USB_VENDOR_ID_A4TECH		0x09DA
 #define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
 
+#define USB_VENDOR_ID_CYPRESS		0x04b4
+#define USB_DEVICE_ID_CYPRESS_MOUSE	0x0001
+
 #define USB_VENDOR_ID_BERKSHIRE		0x0c98
 #define USB_DEVICE_ID_BERKSHIRE_PCWD	0x1140
 
@@ -1375,6 +1377,23 @@
 	__u16 idProduct;
 	unsigned quirks;
 } hid_blacklist[] = {
+
+	{ USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_6000, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_KBGEAR, USB_DEVICE_ID_KBGEAR_JAMSTUDIO, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_POWERMATE, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_SOUNDKNOB, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS1, HID_QUIRK_IGNORE },
+
+	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 100, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 200, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 300, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 400, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 500, HID_QUIRK_IGNORE },
+
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PENPARTNER, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 1, HID_QUIRK_IGNORE },
@@ -1396,33 +1415,24 @@
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 2, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 3, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 4, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_KBGEAR, USB_DEVICE_ID_KBGEAR_JAMSTUDIO, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_6000, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_POWERMATE, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_SOUNDKNOB, HID_QUIRK_IGNORE },
+
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVMC, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS1, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
-	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD|HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING, HID_QUIRK_BADPAD|HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING, HID_QUIRK_BADPAD|HID_QUIRK_MULTI_INPUT },
-	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 100, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 200, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 300, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 400, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_ONTRAK, USB_DEVICE_ID_ONTRAK_ADU100 + 500, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_TANGTOP, USB_DEVICE_ID_TANGTOP_USBPS2, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },
+
 	{ USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU, HID_QUIRK_2WHEEL_MOUSE_HACK },
-	{ USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE, HID_QUIRK_2WHEEL_MOUSE_HACK },
+
 	{ USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BADPAD },
+	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
+	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD, HID_QUIRK_BADPAD },
+	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD },
+
 	{ 0, 0 }
 };
 
diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	Tue Mar 16 13:20:05 2004
+++ b/drivers/usb/input/hid-input.c	Tue Mar 16 13:20:05 2004
@@ -432,20 +432,21 @@
 	input_regs(input, regs);
 
 	if ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK)
-			&& (usage->code == BTN_BACK)) {
+			&& (usage->code == BTN_BACK || usage->code == BTN_EXTRA)) {
 		if (value)
 			hid->quirks |= HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
 		else
 			hid->quirks &= ~HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
 		return;
 	}
+
 	if ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_ON)
 			&& (usage->code == REL_WHEEL)) {
 		input_event(input, usage->type, REL_HWHEEL, value);
 		return;
 	}
 
-	if (usage->hat_min != usage->hat_max) {
+	if (usage->hat_min != usage->hat_max ) { /* FIXME: hat_max can be 0 and hat_min 1 */
 		value = (value - usage->hat_min) * 8 / (usage->hat_max - usage->hat_min + 1) + 1;
 		if (value < 0 || value > 8) value = 0;
 		input_event(input, usage->type, usage->code    , hid_hat_to_axis[value].x);
@@ -484,7 +485,7 @@
 		return;
 	}
 
-	if((usage->type == EV_KEY) && (usage->code == 0)) /* Key 0 is "unassigned", not KEY_UKNOWN */
+	if((usage->type == EV_KEY) && (usage->code == 0)) /* Key 0 is "unassigned", not KEY_UNKNOWN */
 		return;
 
 	input_event(input, usage->type, usage->code, value);

