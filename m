Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSFJMZn>; Mon, 10 Jun 2002 08:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSFJMZm>; Mon, 10 Jun 2002 08:25:42 -0400
Received: from [195.63.194.11] ([195.63.194.11]:40454 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312973AbSFJMZf>; Mon, 10 Jun 2002 08:25:35 -0400
Message-ID: <3D048CFD.2090201@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:26:53 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------000504020605000800050008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000504020605000800050008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fix improper usage of __FUNCTION__ in usb code.
Fix unpleasant results from some code formatting
editor (propably emacs) in i2c, which broke
an error message altogether.

--------------000504020605000800050008
Content-Type: text/plain;
 name="warn-2.5.21-4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="warn-2.5.21-4.diff"

diff -urN linux-2.5.21/drivers/hotplug/pci_hotplug_core.c linux/drivers/hotplug/pci_hotplug_core.c
--- linux-2.5.21/drivers/hotplug/pci_hotplug_core.c	2002-06-09 07:28:23.000000000 +0200
+++ linux/drivers/hotplug/pci_hotplug_core.c	2002-06-09 20:48:07.000000000 +0200
@@ -48,7 +48,7 @@
 	#define MY_NAME	THIS_MODULE->name
 #endif
 
-#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: "__FUNCTION__": " fmt , MY_NAME , ## arg); } while (0)
+#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt, MY_NAME, __FUNCTION__, ## arg); } while (0)
 #define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
 #define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)
diff -urN linux-2.5.21/drivers/hotplug/pci_hotplug_util.c linux/drivers/hotplug/pci_hotplug_util.c
--- linux-2.5.21/drivers/hotplug/pci_hotplug_util.c	2002-06-09 07:30:52.000000000 +0200
+++ linux/drivers/hotplug/pci_hotplug_util.c	2002-06-09 19:20:08.000000000 +0200
@@ -41,7 +41,7 @@
 	#define MY_NAME	THIS_MODULE->name
 #endif
 
-#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: "__FUNCTION__": " fmt , MY_NAME , ## arg); } while (0)
+#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt, MY_NAME, __FUNCTION__, ## arg); } while (0)
 #define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
 #define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)
diff -urN linux-2.5.21/drivers/i2c/i2c-core.c linux/drivers/i2c/i2c-core.c
--- linux-2.5.21/drivers/i2c/i2c-core.c	2002-06-09 07:27:35.000000000 +0200
+++ linux/drivers/i2c/i2c-core.c	2002-06-09 19:21:30.000000000 +0200
@@ -381,10 +381,10 @@
 						printk("i2c-core.o: while "
 						       "unregistering driver "
 						       "`%s', the client at "
-						       "address %02x of
-						       adapter `%s' could not
-						       be detached; driver
-						       not unloaded!",
+						       "address %02x of "
+						       "adapter `%s' could not "
+						       "be detached; driver "
+						       "not unloaded!",
 						       driver->name,
 						       client->addr,
 						       adap->name);

--------------000504020605000800050008--

