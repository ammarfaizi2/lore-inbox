Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbSL3JAs>; Mon, 30 Dec 2002 04:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266804AbSL3JAq>; Mon, 30 Dec 2002 04:00:46 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:30478 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266795AbSL3JAj>;
	Mon, 30 Dec 2002 04:00:39 -0500
Date: Mon, 30 Dec 2002 01:04:09 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] minor TTY changes for 2.5.53
Message-ID: <20021230090409.GC29926@kroah.com>
References: <20021230090221.GA29926@kroah.com> <20021230090303.GB29926@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021230090303.GB29926@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.956.3.2, 2002/12/29 23:34:36-08:00, greg@kroah.com

TTY: add tty_devclass to the tty core.


diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Mon Dec 30 01:04:47 2002
+++ b/drivers/char/tty_io.c	Mon Dec 30 01:04:47 2002
@@ -90,6 +90,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -2271,12 +2272,19 @@
 extern int vty_init(void);
 #endif
 
+struct device_class tty_devclass = {
+	.name	= "tty",
+};
+EXPORT_SYMBOL(tty_devclass);
+
 /*
  * Ok, now we can initialize the rest of the tty devices and can count
  * on memory allocations, interrupts etc..
  */
 void __init tty_init(void)
 {
+	devclass_register(&tty_devclass);
+
 	/*
 	 * dev_tty_driver and dev_console_driver are actually magic
 	 * devices which get redirected at open time.  Nevertheless,
diff -Nru a/include/linux/tty_driver.h b/include/linux/tty_driver.h
--- a/include/linux/tty_driver.h	Mon Dec 30 01:04:47 2002
+++ b/include/linux/tty_driver.h	Mon Dec 30 01:04:47 2002
@@ -227,4 +227,6 @@
 #define SERIAL_TYPE_NORMAL	1
 #define SERIAL_TYPE_CALLOUT	2
 
+extern struct device_class tty_devclass;
+
 #endif /* #ifdef _LINUX_TTY_DRIVER_H */
