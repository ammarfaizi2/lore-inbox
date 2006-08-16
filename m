Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750720AbWHPCJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWHPCJf (ORCPT <rfc822;akpm@zip.com.au>);
	Tue, 15 Aug 2006 22:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWHPCJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:09:34 -0400
Received: from m5-82.163.com ([202.108.5.82]:31967 "HELO m5-82.163.com")
	by vger.kernel.org with SMTP id S1750720AbWHPCJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:09:34 -0400
Date: Wed, 16 Aug 2006 10:09:10 +0800
From: "liyu" <raise_sail@163.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Greg" <greg@kroah.com>,
        "linux-usb-devel" <linux-usb-devel@lists.sourceforge.net>
Subject: [PATCH] usb: HID Simple Driver Interface 0.3.1 (Kconfig and Makefile)
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-Id: <44E27D24.04D60F.25280>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



For simple, I merge the changes with two drivers. you can use two drivers as example.

It also can apply on 2.6.17.6 and 2.6.17.8 at least. 

PS: I have not Subscribe linux-usb-devel maillist, please CC me your reply, thanks. 
	
Signed-off-by: Liyu <raise.sail@gmail.com>

diff -Naurp linux-2.6.17.7/drivers/usb/input.orig/Kconfig linux-2.6.17.7/drivers/usb/input/Kconfig
--- linux-2.6.17.7/drivers/usb/input.orig/Kconfig	2006-07-25 11:36:01.000000000 +0800
+++ linux-2.6.17.7/drivers/usb/input/Kconfig	2006-08-08 08:48:58.000000000 +0800
@@ -326,3 +326,31 @@ config USB_APPLETOUCH
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called appletouch.
+
+config HID_SIMPLE
+	bool "HID simple driver interface"
+	depends on USB_HIDINPUT
+	help
+	  This simple interface let the writing HID driver more easier. Moreover,
+	  this allow you write force-feedback driver without touch HID input 
+	  implementation code. Also, it can be used as input filter.
+
+config HID_SIMPLE_MSNEK4K
+	tristate "Microsoft Natural Ergonomic Keyboard 4000 Driver"
+	depends on HID_SIMPLE
+	help
+	  Microsoft Natural Ergonomic Keyboard 4000 extend keys support. These
+  	  may not work without change user space configration, e.g, XKB conf-
+	  iguration in X.
+
+config HID_SIMPLE_FF
+	bool "HID simple driver interface force feedback support"
+	depends on HID_SIMPLE && !HID_FF
+	help
+	  This feature can not be compatible with "Force feedback support" (HID_FF).
+
+config HID_SIMPLE_FF_BTP2118
+	tristate "Betop 2118 joystick force feedback support"
+	depends on HID_SIMPLE_FF
+	help
+	  This can enable Betop 2118 joystick force feedback feature.
diff -Naurp linux-2.6.17.7/drivers/usb/input.orig/Makefile linux-2.6.17.7/drivers/usb/input/Makefile
--- linux-2.6.17.7/drivers/usb/input.orig/Makefile	2006-07-25 11:36:01.000000000 +0800
+++ linux-2.6.17.7/drivers/usb/input/Makefile	2006-08-07 21:11:03.000000000 +0800
@@ -44,6 +44,8 @@ obj-$(CONFIG_USB_ACECAD)	+= acecad.o
 obj-$(CONFIG_USB_YEALINK)	+= yealink.o
 obj-$(CONFIG_USB_XPAD)		+= xpad.o
 obj-$(CONFIG_USB_APPLETOUCH)	+= appletouch.o
+obj-$(CONFIG_HID_SIMPLE_MSNEK4K)	+= usbnek4k.o
+obj-$(CONFIG_HID_SIMPLE_FF_BTP2118)	+= btp2118.o
 
 ifeq ($(CONFIG_USB_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG



