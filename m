Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbVIIQCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbVIIQCx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 12:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVIIQCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 12:02:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49852 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932569AbVIIQCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 12:02:52 -0400
Date: Fri, 9 Sep 2005 17:02:51 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, rmk+serial@arm.linux.org.uk,
       paulkf@microgate.com
Subject: [PATCH] gratitious includes of asm/serial.h
Message-ID: <20050909160251.GH9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed gratitious includes of asm/serial.h in synklinkmp and ip2main.
Allows to remove the rest of "broken on sparc32" in drivers/char - this
stuff doesn't break the build anymore.  Since it got zero testing, it almost
certainly won't work there, though...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git7-ppc44x-pm/drivers/char/Kconfig RC13-git7-serial/drivers/char/Kconfig
--- RC13-git7-ppc44x-pm/drivers/char/Kconfig	2005-09-07 13:55:10.000000000 -0400
+++ RC13-git7-serial/drivers/char/Kconfig	2005-09-07 13:55:31.000000000 -0400
@@ -80,7 +80,7 @@
 
 config COMPUTONE
 	tristate "Computone IntelliPort Plus serial support"
-	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP && (BROKEN || !SPARC32)
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	---help---
 	  This driver supports the entire family of Intelliport II/Plus
 	  controllers with the exception of the MicroChannel controllers and
@@ -208,7 +208,7 @@
 
 config SYNCLINKMP
 	tristate "SyncLink Multiport support"
-	depends on SERIAL_NONSTANDARD && (BROKEN || !SPARC32)
+	depends on SERIAL_NONSTANDARD
 	help
 	  Enable support for the SyncLink Multiport (2 or 4 ports)
 	  serial adapter, running asynchronous and HDLC communications up
diff -urN RC13-git7-ppc44x-pm/drivers/char/ip2main.c RC13-git7-serial/drivers/char/ip2main.c
--- RC13-git7-ppc44x-pm/drivers/char/ip2main.c	2005-08-28 23:09:41.000000000 -0400
+++ RC13-git7-serial/drivers/char/ip2main.c	2005-09-07 13:55:31.000000000 -0400
@@ -120,7 +120,6 @@
 
 #include <linux/vmalloc.h>
 #include <linux/init.h>
-#include <asm/serial.h>
 
 #include <asm/uaccess.h>
 
diff -urN RC13-git7-ppc44x-pm/drivers/char/synclinkmp.c RC13-git7-serial/drivers/char/synclinkmp.c
--- RC13-git7-ppc44x-pm/drivers/char/synclinkmp.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-git7-serial/drivers/char/synclinkmp.c	2005-09-07 13:55:31.000000000 -0400
@@ -55,7 +55,6 @@
 #include <linux/netdevice.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
-#include <asm/serial.h>
 #include <linux/delay.h>
 #include <linux/ioctl.h>
 
