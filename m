Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUAYEpC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 23:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUAYEpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 23:45:02 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:12552 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S263107AbUAYEo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 23:44:59 -0500
Date: 25 Jan 2004 07:46:21 +0300
Message-Id: <87vfn063fm.fsf@mtu-net.ru>
From: Serge Belyshev <33554432@mtu-net.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add_*_randomness calls in usbkbd.c and usbmouse.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please comment on struct usb_kbd. Did I choose right place to get
'randomness' from?

diff -urN vanilla/drivers/usb/input/usbkbd.c hack/drivers/usb/input/usbkbd.c
--- vanilla/drivers/usb/input/usbkbd.c	Sat Aug 23 19:34:14 2003
+++ hack/drivers/usb/input/usbkbd.c	Tue Nov 11 23:15:54 2003
@@ -32,6 +32,7 @@
 #include <linux/input.h>
 #include <linux/init.h>
 #include <linux/usb.h>
+#include <linux/random.h>
 
 /*
  * Version Information
@@ -125,6 +126,7 @@
 
 	memcpy(kbd->old, kbd->new, 8);
 
+	add_keyboard_randomness (kbd->new[0]);
 resubmit:
 	i = usb_submit_urb (urb, SLAB_ATOMIC);
 	if (i)
diff -urN vanilla/drivers/usb/input/usbmouse.c hack/drivers/usb/input/usbmouse.c
--- vanilla/drivers/usb/input/usbmouse.c	Sat Aug 23 19:34:14 2003
+++ hack/drivers/usb/input/usbmouse.c	Tue Nov 11 23:16:04 2003
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/usb.h>
+#include <linux/random.h>
 
 /*
  * Version Information
@@ -89,6 +90,7 @@
 	input_report_rel(dev, REL_WHEEL, data[3]);
 
 	input_sync(dev);
+	add_mouse_randomness (*(u32 *) data);
 resubmit:
 	status = usb_submit_urb (urb, SLAB_ATOMIC);
 	if (status)
