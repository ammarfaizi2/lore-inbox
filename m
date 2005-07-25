Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVGYF73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVGYF73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 01:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVGYF5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:57:37 -0400
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:54974 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261709AbVGYFzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:55:44 -0400
Message-Id: <20050725054531.359259000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:34:54 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 05/24] Add usb_to_input_id
Content-Disposition: inline; filename=usb-to-input-id.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: introduce usb_to_input_id() to uniformly produce
       struct input_id for USB input devices.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/input/acecad.c      |    6 ++----
 drivers/usb/input/aiptek.c      |    6 ++----
 drivers/usb/input/ati_remote.c  |    8 +++-----
 drivers/usb/input/hid-input.c   |    6 ++----
 drivers/usb/input/itmtouch.c    |    6 ++----
 drivers/usb/input/kbtab.c       |    6 ++----
 drivers/usb/input/mtouchusb.c   |    6 ++----
 drivers/usb/input/powermate.c   |    6 ++----
 drivers/usb/input/touchkitusb.c |    7 ++-----
 drivers/usb/input/usbkbd.c      |    6 ++----
 drivers/usb/input/usbmouse.c    |    6 ++----
 drivers/usb/input/wacom.c       |    6 ++----
 drivers/usb/input/xpad.c        |    6 ++----
 drivers/usb/media/konicawc.c    |    6 ++----
 include/linux/usb_input.h       |   25 +++++++++++++++++++++++++
 15 files changed, 54 insertions(+), 58 deletions(-)

Index: work/drivers/usb/input/acecad.c
===================================================================
--- work.orig/drivers/usb/input/acecad.c
+++ work/drivers/usb/input/acecad.c
@@ -31,6 +31,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/usb.h>
+#include <linux/usb_input.h>
 
 /*
  * Version Information
@@ -212,10 +213,7 @@ static int usb_acecad_probe(struct usb_i
 
 	acecad->dev.name = acecad->name;
 	acecad->dev.phys = acecad->phys;
-	acecad->dev.id.bustype = BUS_USB;
-	acecad->dev.id.vendor = le16_to_cpu(dev->descriptor.idVendor);
-	acecad->dev.id.product = le16_to_cpu(dev->descriptor.idProduct);
-	acecad->dev.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
+	usb_to_input_id(dev, &acecad->dev.id);
 	acecad->dev.dev = &intf->dev;
 
 	usb_fill_int_urb(acecad->irq, dev, pipe,
Index: work/drivers/usb/input/aiptek.c
===================================================================
--- work.orig/drivers/usb/input/aiptek.c
+++ work/drivers/usb/input/aiptek.c
@@ -77,6 +77,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/usb.h>
+#include <linux/usb_input.h>
 #include <linux/sched.h>
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
@@ -2125,10 +2126,7 @@ aiptek_probe(struct usb_interface *intf,
 	aiptek->inputdev.absflat[ABS_WHEEL] = 0;
 	aiptek->inputdev.name = "Aiptek";
 	aiptek->inputdev.phys = aiptek->features.usbPath;
-	aiptek->inputdev.id.bustype = BUS_USB;
-	aiptek->inputdev.id.vendor = le16_to_cpu(usbdev->descriptor.idVendor);
-	aiptek->inputdev.id.product = le16_to_cpu(usbdev->descriptor.idProduct);
-	aiptek->inputdev.id.version = le16_to_cpu(usbdev->descriptor.bcdDevice);
+	usb_to_input_id(usbdev, &aiptek->inputdev.id);
 	aiptek->inputdev.dev = &intf->dev;
 
 	aiptek->usbdev = usbdev;
Index: work/drivers/usb/input/usbkbd.c
===================================================================
--- work.orig/drivers/usb/input/usbkbd.c
+++ work/drivers/usb/input/usbkbd.c
@@ -32,6 +32,7 @@
 #include <linux/input.h>
 #include <linux/init.h>
 #include <linux/usb.h>
+#include <linux/usb_input.h>
 
 /*
  * Version Information
@@ -288,10 +289,7 @@ static int usb_kbd_probe(struct usb_inte
 
 	kbd->dev.name = kbd->name;
 	kbd->dev.phys = kbd->phys;
-	kbd->dev.id.bustype = BUS_USB;
-	kbd->dev.id.vendor = le16_to_cpu(dev->descriptor.idVendor);
-	kbd->dev.id.product = le16_to_cpu(dev->descriptor.idProduct);
-	kbd->dev.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
+	usb_to_input_id(dev, &kbd->dev.id);
 	kbd->dev.dev = &iface->dev;
 
 	if (dev->manufacturer)
Index: work/drivers/usb/input/usbmouse.c
===================================================================
--- work.orig/drivers/usb/input/usbmouse.c
+++ work/drivers/usb/input/usbmouse.c
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/usb.h>
+#include <linux/usb_input.h>
 
 /*
  * Version Information
@@ -171,10 +172,7 @@ static int usb_mouse_probe(struct usb_in
 
 	mouse->dev.name = mouse->name;
 	mouse->dev.phys = mouse->phys;
-	mouse->dev.id.bustype = BUS_USB;
-	mouse->dev.id.vendor = le16_to_cpu(dev->descriptor.idVendor);
-	mouse->dev.id.product = le16_to_cpu(dev->descriptor.idProduct);
-	mouse->dev.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
+	usb_to_input_id(dev, &mouse->dev.id);
 	mouse->dev.dev = &intf->dev;
 
 	if (dev->manufacturer)
Index: work/drivers/usb/input/wacom.c
===================================================================
--- work.orig/drivers/usb/input/wacom.c
+++ work/drivers/usb/input/wacom.c
@@ -69,6 +69,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/usb.h>
+#include <linux/usb_input.h>
 #include <asm/unaligned.h>
 #include <asm/byteorder.h>
 
@@ -823,10 +824,7 @@ static int wacom_probe(struct usb_interf
 
 	wacom->dev.name = wacom->features->name;
 	wacom->dev.phys = wacom->phys;
-	wacom->dev.id.bustype = BUS_USB;
-	wacom->dev.id.vendor = le16_to_cpu(dev->descriptor.idVendor);
-	wacom->dev.id.product = le16_to_cpu(dev->descriptor.idProduct);
-	wacom->dev.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
+	usb_to_input_id(dev, &wacom->dev.id);
 	wacom->dev.dev = &intf->dev;
 	wacom->usbdev = dev;
 
Index: work/drivers/usb/input/ati_remote.c
===================================================================
--- work.orig/drivers/usb/input/ati_remote.c
+++ work/drivers/usb/input/ati_remote.c
@@ -94,6 +94,7 @@
 #include <linux/moduleparam.h>
 #include <linux/input.h>
 #include <linux/usb.h>
+#include <linux/usb_input.h>
 #include <linux/wait.h>
 
 /*
@@ -635,11 +636,8 @@ static void ati_remote_input_init(struct
 	idev->name = ati_remote->name;
 	idev->phys = ati_remote->phys;
 
-	idev->id.bustype = BUS_USB;
-	idev->id.vendor = le16_to_cpu(ati_remote->udev->descriptor.idVendor);
-	idev->id.product = le16_to_cpu(ati_remote->udev->descriptor.idProduct);
-	idev->id.version = le16_to_cpu(ati_remote->udev->descriptor.bcdDevice);
-	idev->dev = &(ati_remote->udev->dev);
+	usb_to_input_id(ati_remote->udev, &idev->id);
+	idev->dev = &ati_remote->udev->dev;
 }
 
 static int ati_remote_initialize(struct ati_remote *ati_remote)
Index: work/drivers/usb/input/hid-input.c
===================================================================
--- work.orig/drivers/usb/input/hid-input.c
+++ work/drivers/usb/input/hid-input.c
@@ -31,6 +31,7 @@
 #include <linux/kernel.h>
 #include <linux/input.h>
 #include <linux/usb.h>
+#include <linux/usb_input.h>
 
 #undef DEBUG
 
@@ -581,10 +582,7 @@ int hidinput_connect(struct hid_device *
 				hidinput->input.name = hid->name;
 				hidinput->input.phys = hid->phys;
 				hidinput->input.uniq = hid->uniq;
-				hidinput->input.id.bustype = BUS_USB;
-				hidinput->input.id.vendor = le16_to_cpu(dev->descriptor.idVendor);
-				hidinput->input.id.product = le16_to_cpu(dev->descriptor.idProduct);
-				hidinput->input.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
+				usb_to_input_id(dev, &hidinput->input.id);
 				hidinput->input.dev = &hid->intf->dev;
 			}
 
Index: work/drivers/usb/input/itmtouch.c
===================================================================
--- work.orig/drivers/usb/input/itmtouch.c
+++ work/drivers/usb/input/itmtouch.c
@@ -53,6 +53,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/usb.h>
+#include <linux/usb_input.h>
 
 /* only an 8 byte buffer necessary for a single packet */
 #define ITM_BUFSIZE			8
@@ -184,10 +185,7 @@ static int itmtouch_probe(struct usb_int
 
 	itmtouch->inputdev.name = itmtouch->name;
 	itmtouch->inputdev.phys = itmtouch->phys;
-	itmtouch->inputdev.id.bustype = BUS_USB;
-	itmtouch->inputdev.id.vendor = udev->descriptor.idVendor;
-	itmtouch->inputdev.id.product = udev->descriptor.idProduct;
-	itmtouch->inputdev.id.version = udev->descriptor.bcdDevice;
+	usb_to_input_id(udev, &itmtouch->inputdev.id);
 	itmtouch->inputdev.dev = &intf->dev;
 
 	if (!strlen(itmtouch->name))
Index: work/drivers/usb/input/kbtab.c
===================================================================
--- work.orig/drivers/usb/input/kbtab.c
+++ work/drivers/usb/input/kbtab.c
@@ -4,6 +4,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/usb.h>
+#include <linux/usb_input.h>
 #include <asm/unaligned.h>
 #include <asm/byteorder.h>
 
@@ -167,10 +168,7 @@ static int kbtab_probe(struct usb_interf
 
 	kbtab->dev.name = "KB Gear Tablet";
 	kbtab->dev.phys = kbtab->phys;
-	kbtab->dev.id.bustype = BUS_USB;
-	kbtab->dev.id.vendor = le16_to_cpu(dev->descriptor.idVendor);
-	kbtab->dev.id.product = le16_to_cpu(dev->descriptor.idProduct);
-	kbtab->dev.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
+	usb_to_input_id(dev, &kbtab->dev.id);
 	kbtab->dev.dev = &intf->dev;
 	kbtab->usbdev = dev;
 
Index: work/drivers/usb/input/mtouchusb.c
===================================================================
--- work.orig/drivers/usb/input/mtouchusb.c
+++ work/drivers/usb/input/mtouchusb.c
@@ -53,6 +53,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/usb.h>
+#include <linux/usb_input.h>
 
 #define MTOUCHUSB_MIN_XC                0x0
 #define MTOUCHUSB_MAX_RAW_XC            0x4000
@@ -232,10 +233,7 @@ static int mtouchusb_probe(struct usb_in
 
 	mtouch->input.name = mtouch->name;
 	mtouch->input.phys = mtouch->phys;
-	mtouch->input.id.bustype = BUS_USB;
-	mtouch->input.id.vendor = le16_to_cpu(udev->descriptor.idVendor);
-	mtouch->input.id.product = le16_to_cpu(udev->descriptor.idProduct);
-	mtouch->input.id.version = le16_to_cpu(udev->descriptor.bcdDevice);
+	usb_to_input_id(udev, &mtouch->input.id);
 	mtouch->input.dev = &intf->dev;
 
 	mtouch->input.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
Index: work/drivers/usb/input/powermate.c
===================================================================
--- work.orig/drivers/usb/input/powermate.c
+++ work/drivers/usb/input/powermate.c
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/usb.h>
+#include <linux/usb_input.h>
 
 #define POWERMATE_VENDOR	0x077d	/* Griffin Technology, Inc. */
 #define POWERMATE_PRODUCT_NEW	0x0410	/* Griffin PowerMate */
@@ -389,10 +390,7 @@ static int powermate_probe(struct usb_in
 	pm->input.keybit[LONG(BTN_0)] = BIT(BTN_0);
 	pm->input.relbit[LONG(REL_DIAL)] = BIT(REL_DIAL);
 	pm->input.mscbit[LONG(MSC_PULSELED)] = BIT(MSC_PULSELED);
-	pm->input.id.bustype = BUS_USB;
-	pm->input.id.vendor = le16_to_cpu(udev->descriptor.idVendor);
-	pm->input.id.product = le16_to_cpu(udev->descriptor.idProduct);
-	pm->input.id.version = le16_to_cpu(udev->descriptor.bcdDevice);
+	usb_to_input_id(udev, &pm->input.id);
 	pm->input.event = powermate_input_event;
 	pm->input.dev = &intf->dev;
 	pm->input.phys = pm->phys;
Index: work/drivers/usb/input/touchkitusb.c
===================================================================
--- work.orig/drivers/usb/input/touchkitusb.c
+++ work/drivers/usb/input/touchkitusb.c
@@ -35,7 +35,7 @@
 #define DEBUG
 #endif
 #include <linux/usb.h>
-
+#include <linux/usb_input.h>
 
 #define TOUCHKIT_MIN_XC			0x0
 #define TOUCHKIT_MAX_XC			0x07ff
@@ -202,10 +202,7 @@ static int touchkit_probe(struct usb_int
 
 	touchkit->input.name = touchkit->name;
 	touchkit->input.phys = touchkit->phys;
-	touchkit->input.id.bustype = BUS_USB;
-	touchkit->input.id.vendor = le16_to_cpu(udev->descriptor.idVendor);
-	touchkit->input.id.product = le16_to_cpu(udev->descriptor.idProduct);
-	touchkit->input.id.version = le16_to_cpu(udev->descriptor.bcdDevice);
+	usb_to_input_id(udev, &touchkit->input.id);
 	touchkit->input.dev = &intf->dev;
 
 	touchkit->input.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
Index: work/drivers/usb/input/xpad.c
===================================================================
--- work.orig/drivers/usb/input/xpad.c
+++ work/drivers/usb/input/xpad.c
@@ -62,6 +62,7 @@
 #include <linux/module.h>
 #include <linux/smp_lock.h>
 #include <linux/usb.h>
+#include <linux/usb_input.h>
 
 #define DRIVER_VERSION "v0.0.5"
 #define DRIVER_AUTHOR "Marko Friedemann <mfr@bmx-chemnitz.de>"
@@ -256,10 +257,7 @@ static int xpad_probe(struct usb_interfa
 
 	xpad->udev = udev;
 
-	xpad->dev.id.bustype = BUS_USB;
-	xpad->dev.id.vendor = le16_to_cpu(udev->descriptor.idVendor);
-	xpad->dev.id.product = le16_to_cpu(udev->descriptor.idProduct);
-	xpad->dev.id.version = le16_to_cpu(udev->descriptor.bcdDevice);
+	usb_to_input_id(udev, &xpad->dev.id);
 	xpad->dev.dev = &intf->dev;
 	xpad->dev.private = xpad;
 	xpad->dev.name = xpad_device[i].name;
Index: work/include/linux/usb_input.h
===================================================================
--- /dev/null
+++ work/include/linux/usb_input.h
@@ -0,0 +1,25 @@
+#ifndef __USB_INPUT_H
+#define __USB_INPUT_H
+
+/*
+ * Copyright (C) 2005 Dmitry Torokhov
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/usb.h>
+#include <linux/input.h>
+#include <asm/byteorder.h>
+
+static inline void
+usb_to_input_id(const struct usb_device *dev, struct input_id *id)
+{
+	id->bustype = BUS_USB;
+	id->vendor = le16_to_cpu(dev->descriptor.idVendor);
+	id->product = le16_to_cpu(dev->descriptor.idProduct);
+	id->version = le16_to_cpu(dev->descriptor.bcdDevice);
+}
+
+#endif
Index: work/drivers/usb/media/konicawc.c
===================================================================
--- work.orig/drivers/usb/media/konicawc.c
+++ work/drivers/usb/media/konicawc.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <linux/usb_input.h>
 
 #include "usbvideo.h"
 
@@ -845,10 +846,7 @@ static int konicawc_probe(struct usb_int
 		cam->input.private = cam;
 		cam->input.evbit[0] = BIT(EV_KEY);
 		cam->input.keybit[LONG(BTN_0)] = BIT(BTN_0);
-		cam->input.id.bustype = BUS_USB;
-		cam->input.id.vendor = le16_to_cpu(dev->descriptor.idVendor);
-		cam->input.id.product = le16_to_cpu(dev->descriptor.idProduct);
-		cam->input.id.version = le16_to_cpu(dev->descriptor.bcdDevice);
+		usb_to_input_id(dev, &cam->input.id);
 		input_register_device(&cam->input);
 		
 		usb_make_path(dev, cam->input_physname, 56);

