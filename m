Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWFQSbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWFQSbK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWFQSbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:31:09 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:44652 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750812AbWFQSbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:31:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fgp+AfeVEVSoq53Y4l2dWwy7/N4FCaN3qEOpIpDUYrYky32paxmrzp72DgsGPcjueSDs8057Gfjqo56N4d9yadk/8vKgxcd4Hx5VtOHi7GP0vwsI1v9LCAxXXQMSffkfMDEgWJjXUeIm0AehnRGnjeikSw5iAanb9fcT3W7WnoI=
Message-ID: <44944A68.4090701@gmail.com>
Date: Sat, 17 Jun 2006 12:31:04 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 10/20] chardev: GPIO for SCx200 & PC-8736x: add empty
 common-module
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

10/20. patch.nscgpio-shell

Add the nsc_gpio common-support module as an empty shell.  Next patch
starts the migration of the common gpio support routines.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.nscgpio-shell
 Makefile   |    2 +-
 nsc_gpio.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-9/drivers/char/Makefile ax-10/drivers/char/Makefile
--- ax-9/drivers/char/Makefile	2006-06-06 17:15:36.000000000 -0600
+++ ax-10/drivers/char/Makefile	2006-06-17 01:27:04.000000000 -0600
@@ -81,7 +81,7 @@ obj-$(CONFIG_COBALT_LCD)	+= lcd.o
 obj-$(CONFIG_PPDEV)		+= ppdev.o
 obj-$(CONFIG_NWBUTTON)		+= nwbutton.o
 obj-$(CONFIG_NWFLASH)		+= nwflash.o
-obj-$(CONFIG_SCx200_GPIO)	+= scx200_gpio.o
+obj-$(CONFIG_SCx200_GPIO)	+= scx200_gpio.o nsc_gpio.o
 obj-$(CONFIG_CS5535_GPIO)	+= cs5535_gpio.o
 obj-$(CONFIG_GPIO_VR41XX)	+= vr41xx_giu.o
 obj-$(CONFIG_TANBAC_TB0219)	+= tb0219.o
diff -ruNp -X dontdiff -X exclude-diffs ax-9/drivers/char/nsc_gpio.c ax-10/drivers/char/nsc_gpio.c
--- ax-9/drivers/char/nsc_gpio.c	1969-12-31 17:00:00.000000000 -0700
+++ ax-10/drivers/char/nsc_gpio.c	2006-06-17 01:27:04.000000000 -0600
@@ -0,0 +1,45 @@
+/* linux/drivers/char/nsc_gpio.c
+
+   National Semiconductor common GPIO device-file/VFS methods.
+   Allows a user space process to control the GPIO pins.
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+   Copyright (c) 2005      Jim Cromie <jim.cromie@gmail.com>
+*/
+
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/nsc_gpio.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#define NAME "nsc_gpio"
+
+MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
+MODULE_DESCRIPTION("NatSemi GPIO Common Methods");
+MODULE_LICENSE("GPL");
+
+static int __init nsc_gpio_init(void)
+{
+	printk(KERN_DEBUG NAME " initializing\n");
+	return 0;
+}
+
+static void __exit nsc_gpio_cleanup(void)
+{
+	printk(KERN_DEBUG NAME " cleanup\n");
+}
+
+/* prepare for
+   common routines for both scx200_gpio and pc87360_gpio
+EXPORT_SYMBOL(scx200_gpio_write);
+EXPORT_SYMBOL(scx200_gpio_read);
+EXPORT_SYMBOL(scx200_gpio_release);
+*/
+
+module_init(nsc_gpio_init);
+module_exit(nsc_gpio_cleanup);


