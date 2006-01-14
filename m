Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWANQZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWANQZQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWANQZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:25:15 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:9085 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964792AbWANQZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:25:14 -0500
Message-Id: <20060114154833.237457000.dtor_core@ameritech.net>
References: <20060114151645.035957000.dtor_core@ameritech.net>
Date: Sat, 14 Jan 2006 10:16:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [git pull 6/7] Wacom: fix compile on PowerPC
Content-Disposition: inline; filename=wacom-fix-powerpc-compile.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: wacom - fix compile on PowerPC

Rename G4 (new Graphire4) to WACOM_G4 to avoid clashes on PowerPC

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/input/wacom.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

Index: work/drivers/usb/input/wacom.c
===================================================================
--- work.orig/drivers/usb/input/wacom.c
+++ work/drivers/usb/input/wacom.c
@@ -95,7 +95,7 @@ MODULE_LICENSE(DRIVER_LICENSE);
 enum {
 	PENPARTNER = 0,
 	GRAPHIRE,
-	G4,
+	WACOM_G4,
 	PL,
 	INTUOS,
 	INTUOS3,
@@ -373,7 +373,7 @@ static void wacom_graphire_irq(struct ur
 
 			case 2: /* Mouse with wheel */
 				input_report_key(dev, BTN_MIDDLE, data[1] & 0x04);
-				if (wacom->features->type == G4) {
+				if (wacom->features->type == WACOM_G4) {
 					rw = data[7] & 0x04 ? -(data[7] & 0x03) : (data[7] & 0x03);
 					input_report_rel(dev, REL_WHEEL, rw);
 				} else
@@ -385,7 +385,7 @@ static void wacom_graphire_irq(struct ur
 				id = CURSOR_DEVICE_ID;
 				input_report_key(dev, BTN_LEFT, data[1] & 0x01);
 				input_report_key(dev, BTN_RIGHT, data[1] & 0x02);
-				if (wacom->features->type == G4)
+				if (wacom->features->type == WACOM_G4)
 					input_report_abs(dev, ABS_DISTANCE, data[6]);
 				else
 					input_report_abs(dev, ABS_DISTANCE, data[7]);
@@ -410,7 +410,7 @@ static void wacom_graphire_irq(struct ur
 	input_sync(dev);
 
 	/* send pad data */
-	if (wacom->features->type == G4) {
+	if (wacom->features->type == WACOM_G4) {
 		/* fist time sending pad data */
 		if (wacom->tool[1] != BTN_TOOL_FINGER) {
 			wacom->id[1] = 0;
@@ -713,8 +713,8 @@ static struct wacom_features wacom_featu
 	{ "Wacom Graphire2 5x7", 8,  13918, 10206,  511, 32, GRAPHIRE,   wacom_graphire_irq },
 	{ "Wacom Graphire3",     8,  10208,  7424,  511, 32, GRAPHIRE,   wacom_graphire_irq },
 	{ "Wacom Graphire3 6x8", 8,  16704, 12064,  511, 32, GRAPHIRE,   wacom_graphire_irq },
-	{ "Wacom Graphire4 4x5", 8,  10208,  7424,  511, 32, G4,	 wacom_graphire_irq },
-	{ "Wacom Graphire4 6x8", 8,  16704, 12064,  511, 32, G4,	 wacom_graphire_irq },
+	{ "Wacom Graphire4 4x5", 8,  10208,  7424,  511, 32, WACOM_G4,	 wacom_graphire_irq },
+	{ "Wacom Graphire4 6x8", 8,  16704, 12064,  511, 32, WACOM_G4,	 wacom_graphire_irq },
 	{ "Wacom Volito",        8,   5104,  3712,  511, 32, GRAPHIRE,   wacom_graphire_irq },
 	{ "Wacom PenStation2",   8,   3250,  2320,  255, 32, GRAPHIRE,   wacom_graphire_irq },
 	{ "Wacom Volito2 4x5",   8,   5104,  3712,  511, 32, GRAPHIRE,   wacom_graphire_irq },
@@ -859,7 +859,7 @@ static int wacom_probe(struct usb_interf
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, wacom->features->pressure_max, 0, 0);
 
 	switch (wacom->features->type) {
-		case G4:
+		case WACOM_G4:
 			input_dev->evbit[0] |= BIT(EV_MSC);
 			input_dev->mscbit[0] |= BIT(MSC_SERIAL);
 			input_dev->keybit[LONG(BTN_DIGI)] |= BIT(BTN_TOOL_FINGER);

