Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUKKR23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUKKR23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbUKKR00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:26:26 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:40180 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262304AbUKKRRB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:17:01 -0500
Date: Thu, 11 Nov 2004 18:16:52 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 7/10] s390: crypto driver.
Message-ID: <20041111171652.GI4900@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 7/10] s390: crypto driver.

From: Eric Rossman <edrossma@us.ibm.com>

s390 crypto driver changes:
 - Small cleanup: misc -> crypto, header file defines,
   variable names and a printk message.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/crypto/Makefile      |    2 +-
 drivers/s390/crypto/z90common.h   |    8 ++++----
 drivers/s390/crypto/z90crypt.h    |   10 +++++-----
 drivers/s390/crypto/z90hardware.c |    6 +++---
 drivers/s390/crypto/z90main.c     |   16 ++++++++--------
 5 files changed, 21 insertions(+), 21 deletions(-)

diff -urN linux-2.6/drivers/s390/crypto/Makefile linux-2.6-patched/drivers/s390/crypto/Makefile
--- linux-2.6/drivers/s390/crypto/Makefile	2004-10-18 23:53:51.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/Makefile	2004-11-11 15:06:58.000000000 +0100
@@ -1,5 +1,5 @@
 #
-# S/390 miscellaneous devices
+# S/390 crypto devices
 #
 
 z90crypt-objs := z90main.o z90hardware.o
diff -urN linux-2.6/drivers/s390/crypto/z90common.h linux-2.6-patched/drivers/s390/crypto/z90common.h
--- linux-2.6/drivers/s390/crypto/z90common.h	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/z90common.h	2004-11-11 15:06:58.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/s390/misc/z90common.h
+ *  linux/drivers/s390/crypto/z90common.h
  *
  *  z90crypt 1.3.2
  *
@@ -24,10 +24,10 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#ifndef _Z90COMMON_
-#define _Z90COMMON_
+#ifndef _Z90COMMON_H_
+#define _Z90COMMON_H_
 
-#define VERSION_Z90COMMON_H "$Revision: 1.15 $"
+#define VERSION_Z90COMMON_H "$Revision: 1.16 $"
 
 
 #define RESPBUFFSIZE 256
diff -urN linux-2.6/drivers/s390/crypto/z90crypt.h linux-2.6-patched/drivers/s390/crypto/z90crypt.h
--- linux-2.6/drivers/s390/crypto/z90crypt.h	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/z90crypt.h	2004-11-11 15:06:58.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/s390/misc/z90crypt.h
+ *  linux/drivers/s390/crypto/z90crypt.h
  *
  *  z90crypt 1.3.2
  *
@@ -24,12 +24,12 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#ifndef _LINUX_Z90CRYPT_H_
-#define _LINUX_Z90CRYPT_H_
+#ifndef _Z90CRYPT_H_
+#define _Z90CRYPT_H_
 
 #include <linux/ioctl.h>
 
-#define VERSION_Z90CRYPT_H "$Revision: 1.10 $"
+#define VERSION_Z90CRYPT_H "$Revision: 1.11 $"
 
 #define z90crypt_VERSION 1
 #define z90crypt_RELEASE 3	// 2 = PCIXCC, 3 = rewrite for coding standards
@@ -255,4 +255,4 @@
 	unsigned char qdepth[MASK_LENGTH];
 };
 
-#endif /* _LINUX_Z90CRYPT_H_ */
+#endif /* _Z90CRYPT_H_ */
diff -urN linux-2.6/drivers/s390/crypto/z90hardware.c linux-2.6-patched/drivers/s390/crypto/z90hardware.c
--- linux-2.6/drivers/s390/crypto/z90hardware.c	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/z90hardware.c	2004-11-11 15:06:58.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/s390/misc/z90hardware.c
+ *  linux/drivers/s390/crypto/z90hardware.c
  *
  *  z90crypt 1.3.2
  *
@@ -32,9 +32,9 @@
 #include "z90crypt.h"
 #include "z90common.h"
 
-#define VERSION_Z90HARDWARE_C "$Revision: 1.32 $"
+#define VERSION_Z90HARDWARE_C "$Revision: 1.33 $"
 
-char z90chardware_version[] __initdata =
+char z90hardware_version[] __initdata =
 	"z90hardware.o (" VERSION_Z90HARDWARE_C "/"
 	                  VERSION_Z90COMMON_H "/" VERSION_Z90CRYPT_H ")";
 
diff -urN linux-2.6/drivers/s390/crypto/z90main.c linux-2.6-patched/drivers/s390/crypto/z90main.c
--- linux-2.6/drivers/s390/crypto/z90main.c	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/z90main.c	2004-11-11 15:06:58.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/s390/misc/z90main.c
+ *  linux/drivers/s390/crypto/z90main.c
  *
  *  z90crypt 1.3.2
  *
@@ -51,13 +51,13 @@
 #  error "This kernel is too recent: not supported by this file"
 #endif
 
-#define VERSION_Z90MAIN_C "$Revision: 1.54 $"
+#define VERSION_Z90MAIN_C "$Revision: 1.57 $"
 
-static char z90cmain_version[] __initdata =
+static char z90main_version[] __initdata =
 	"z90main.o (" VERSION_Z90MAIN_C "/"
                       VERSION_Z90COMMON_H "/" VERSION_Z90CRYPT_H ")";
 
-extern char z90chardware_version[];
+extern char z90hardware_version[];
 
 /**
  * Defaults that may be modified.
@@ -97,7 +97,7 @@
  * older than CLEANUPTIME seconds in the past.
  */
 #ifndef CLEANUPTIME
-#define CLEANUPTIME 15
+#define CLEANUPTIME 20
 #endif
 
 /**
@@ -670,8 +670,8 @@
 		PRINTKN("Version %d.%d.%d loaded, built on %s %s\n",
 			z90crypt_VERSION, z90crypt_RELEASE, z90crypt_VARIANT,
 			__DATE__, __TIME__);
-		PRINTKN("%s\n", z90cmain_version);
-		PRINTKN("%s\n", z90chardware_version);
+		PRINTKN("%s\n", z90main_version);
+		PRINTKN("%s\n", z90hardware_version);
 		PDEBUG("create_z90crypt (domain index %d) successful.\n",
 		       domain);
 	} else
@@ -2372,7 +2372,7 @@
 			break;
 		}
 		if (dev_ptr->dev_self_x != index) {
-			PRINTK("Corrupt dev ptr in receive_from_AP\n");
+			PRINTKC("Corrupt dev ptr\n");
 			z90crypt.terminating = 1;
 			rv = REC_FATAL_ERROR;
 			break;
