Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262993AbUJ1MCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbUJ1MCq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 08:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbUJ1MCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 08:02:04 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:45535 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262992AbUJ1L7B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:59:01 -0400
Subject: [PATCH] Fix deprecated MODULE_PARM for CAPI subsystem
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Karsten Keil <kkeil@suse.de>
Content-Type: multipart/mixed; boundary="=-ZOZPI/6PjeHzY/j3mJH3"
Date: Thu, 28 Oct 2004 13:58:40 +0200
Message-Id: <1098964720.6636.21.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZOZPI/6PjeHzY/j3mJH3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The MODULE_PARM is deprecated now and should be replaced by
module_param() or module_param_named().

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>


--=-ZOZPI/6PjeHzY/j3mJH3
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/isdn/capi/capi.c 1.61 vs edited =====
--- 1.61/drivers/isdn/capi/capi.c	2004-10-21 19:03:22 +02:00
+++ edited/drivers/isdn/capi/capi.c	2004-10-28 13:22:23 +02:00
@@ -38,6 +38,7 @@
 #include <linux/kernelcapi.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/moduleparam.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/isdn/capiutil.h>
 #include <linux/isdn/capicmd.h>
@@ -67,10 +68,10 @@
 int capi_ttyminors = CAPINC_NR_PORTS;
 #endif /* CONFIG_ISDN_CAPI_MIDDLEWARE */
 
-MODULE_PARM(capi_major, "i");
+module_param_named(major, capi_major, uint, 0);
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
-MODULE_PARM(capi_ttymajor, "i");
-MODULE_PARM(capi_ttyminors, "i");
+module_param_named(ttymajor, capi_ttymajor, uint, 0);
+module_param_named(ttyminors, capi_ttyminors, uint, 0);
 #endif /* CONFIG_ISDN_CAPI_MIDDLEWARE */
 
 /* -------- defines ------------------------------------------------- */
===== drivers/isdn/capi/capidrv.c 1.31 vs edited =====
--- 1.31/drivers/isdn/capi/capidrv.c	2004-08-27 21:27:24 +02:00
+++ edited/drivers/isdn/capi/capidrv.c	2004-10-28 13:25:40 +02:00
@@ -29,6 +29,7 @@
 #include <linux/kernelcapi.h>
 #include <linux/ctype.h>
 #include <linux/init.h>
+#include <linux/moduleparam.h>
 
 #include <linux/isdn/capiutil.h>
 #include <linux/isdn/capicmd.h>
@@ -40,7 +41,7 @@
 MODULE_DESCRIPTION("CAPI4Linux: Interface to ISDN4Linux");
 MODULE_AUTHOR("Carsten Paeth");
 MODULE_LICENSE("GPL");
-MODULE_PARM(debugmode, "i");
+module_param(debugmode, uint, 0);
 
 /* -------- type definitions ----------------------------------------- */
 
===== drivers/isdn/capi/kcapi.c 1.55 vs edited =====
--- 1.55/drivers/isdn/capi/kcapi.c	2004-10-19 11:40:35 +02:00
+++ edited/drivers/isdn/capi/kcapi.c	2004-10-28 13:25:56 +02:00
@@ -24,6 +24,7 @@
 #include <linux/capi.h>
 #include <linux/kernelcapi.h>
 #include <linux/init.h>
+#include <linux/moduleparam.h>
 #include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <linux/isdn/capicmd.h>
@@ -41,7 +42,7 @@
 MODULE_DESCRIPTION("CAPI4Linux: kernel CAPI layer");
 MODULE_AUTHOR("Carsten Paeth");
 MODULE_LICENSE("GPL");
-MODULE_PARM(showcapimsgs, "i");
+module_param(showcapimsgs, uint, 0);
 
 /* ------------------------------------------------------------- */
 

--=-ZOZPI/6PjeHzY/j3mJH3--

