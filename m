Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275990AbRI1Jv4>; Fri, 28 Sep 2001 05:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275994AbRI1Jvt>; Fri, 28 Sep 2001 05:51:49 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:1284 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S275990AbRI1Jvj>;
	Fri, 28 Sep 2001 05:51:39 -0400
Date: Fri, 28 Sep 2001 11:52:03 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.9-ac16] usb serial compile error.
Message-ID: <20010928115203.F21524@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling a USB serial driver (mct_u232 in my case) 
without USB generic serial support, the compile process
stops because of undefined 'vendor' and 'product'
symbols.

The attached patch corrects this issue.

Stelian.

--- linux-2.4.9-ac16/drivers/usb/serial/usbserial.c.orig	Fri Sep 28 11:35:39 2001
+++ linux-2.4.9-ac16/drivers/usb/serial/usbserial.c	Fri Sep 28 11:35:52 2001
@@ -323,11 +323,10 @@
 static void generic_write_bulk_callback	(struct urb *urb);
 static void generic_shutdown		(struct usb_serial *serial);
 
-
-#ifdef CONFIG_USB_SERIAL_GENERIC
 static __u16	vendor	= 0x05f9;
 static __u16	product	= 0xffff;
 
+#ifdef CONFIG_USB_SERIAL_GENERIC
 static struct usb_device_id generic_device_ids[2]; /* Initially all zeroes. */
 
 /* All of the device info needed for the Generic Serial Converter */

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
