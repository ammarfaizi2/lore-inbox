Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262181AbTCHTzB>; Sat, 8 Mar 2003 14:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262183AbTCHTzA>; Sat, 8 Mar 2003 14:55:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16132 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262181AbTCHTxg>; Sat, 8 Mar 2003 14:53:36 -0500
Date: Sat, 8 Mar 2003 12:11:03 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Register tty_devclass before use
Message-ID: <20030308121103.C29145@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch (against vanilla 2.5.64) registers the tty devclass
with sysfs before any drivers can use it - sysfs requires structures to
be registered before use.

The patch applies to bk-curr with offset.

--- orig/drivers/char/tty_io.c	Wed Mar  5 19:45:15 2003
+++ linux/drivers/char/tty_io.c	Sat Mar  8 12:01:41 2003
@@ -2307,14 +2307,19 @@
 };
 EXPORT_SYMBOL(tty_devclass);
 
+static int __init tty_devclass_init(void)
+{
+	return devclass_register(&tty_devclass);
+}
+
+postcore_initcall(tty_devclass_init);
+
 /*
  * Ok, now we can initialize the rest of the tty devices and can count
  * on memory allocations, interrupts etc..
  */
 void __init tty_init(void)
 {
-	devclass_register(&tty_devclass);
-
 	/*
 	 * dev_tty_driver and dev_console_driver are actually magic
 	 * devices which get redirected at open time.  Nevertheless,

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

