Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265297AbTLMV3s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 16:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265299AbTLMV3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 16:29:48 -0500
Received: from linux-bt.org ([217.160.111.169]:65002 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S265297AbTLMV3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 16:29:46 -0500
Subject: [PATCH 2.4] Fix LED's for input subsystem keyboards
From: Marcel Holtmann <marcel@holtmann.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-ZlhBd35nEC+riu5VrxZl"
Message-Id: <1071350935.16387.8.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 13 Dec 2003 22:28:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZlhBd35nEC+riu5VrxZl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch propagates the current LED's to every new keyboard device
that is attached through the input subsystem.


--=-ZlhBd35nEC+riu5VrxZl
Content-Disposition: attachment; filename=patch-2.4.23-keybdev-led-fix
Content-Type: text/plain; name=patch-2.4.23-keybdev-led-fix; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.4.23/drivers/input/keybdev.c	2003-08-25 13:44:42.000000000 +0200
+++ linux-2.4.23-mh/drivers/input/keybdev.c	2003-12-13 21:51:54.000000000 +0100
@@ -154,16 +154,18 @@
 
 static struct input_handler keybdev_handler;
 
+static unsigned int ledstate = 0xff;
+
 void keybdev_ledfunc(unsigned int led)
 {
 	struct input_handle *handle;	
 
-	for (handle = keybdev_handler.handle; handle; handle = handle->hnext) {
+	ledstate = led;
 
+	for (handle = keybdev_handler.handle; handle; handle = handle->hnext) {
 		input_event(handle->dev, EV_LED, LED_SCROLLL, !!(led & 0x01));
 		input_event(handle->dev, EV_LED, LED_NUML,    !!(led & 0x02));
 		input_event(handle->dev, EV_LED, LED_CAPSL,   !!(led & 0x04));
-
 	}
 }
 
@@ -204,6 +206,12 @@
 //	printk(KERN_INFO "keybdev.c: Adding keyboard: input%d\n", dev->number);
 	kbd_refresh_leds();
 
+	if (ledstate != 0xff) {
+		input_event(dev, EV_LED, LED_SCROLLL, !!(ledstate & 0x01));
+		input_event(dev, EV_LED, LED_NUML,    !!(ledstate & 0x02));
+		input_event(dev, EV_LED, LED_CAPSL,   !!(ledstate & 0x04));
+	}
+
 	return handle;
 }
 

--=-ZlhBd35nEC+riu5VrxZl--

