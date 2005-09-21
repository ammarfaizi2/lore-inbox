Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVIUKf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVIUKf4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 06:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVIUKf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 06:35:56 -0400
Received: from ns.firmix.at ([62.141.48.66]:1417 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750795AbVIUKfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 06:35:55 -0400
Subject: Patch: Rename vprintk define in bttpvp.h
From: Bernd Petrovitsch <bernd@firmix.at>
To: mchehab@brturbo.com.br, video4linux-list@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-Oq0984baGZNNLe36yY5S"
Organization: Firmix Software GmbH
Date: Wed, 21 Sep 2005 12:35:14 +0200
Message-Id: <1127298914.26231.46.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Oq0984baGZNNLe36yY5S
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patched againt 2.6.13 renames the (apparently) bttv intern 
#define vprintk to verbprintk to resolve a name clash.

Reason: vprintk() is defined in include/linux/kernel.h similar to printk
but with a va_list argument.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

--=-Oq0984baGZNNLe36yY5S
Content-Disposition: attachment; filename=printk.patch
Content-Type: text/x-patch; name=printk.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -uprN -X linux-2.6.13/Documentation/dontdiff linux-2.6.13/include/asm-i386/spinlock.h linux-2.6.13-patched/include/asm-i386/spinlock.h
--- linux-2.6.13/include/asm-i386/spinlock.h	2005-09-20 18:38:41.000000000 +0200
+++ linux-2.6.13-patched/include/asm-i386/spinlock.h	2005-09-20 18:44:07.000000000 +0200
@@ -7,9 +7,6 @@
 #include <linux/config.h>
 #include <linux/compiler.h>
 
-asmlinkage int printk(const char * fmt, ...)
-	__attribute__ ((format (printf, 1, 2)));
-
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  */
diff -uprN -X linux-2.6.13/Documentation/dontdiff linux-2.6.13/include/linux/kernel.h linux-2.6.13-patched/include/linux/kernel.h
--- linux-2.6.13/include/linux/kernel.h	2005-09-20 11:12:50.000000000 +0200
+++ linux-2.6.13-patched/include/linux/kernel.h	2005-09-20 11:54:02.000000000 +0200
@@ -129,12 +129,8 @@ asmlinkage int vprintk(const char *fmt, 
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 #else
-static inline int vprintk(const char *s, va_list args)
-	__attribute__ ((format (printf, 1, 0)));
-static inline int vprintk(const char *s, va_list args) { return 0; }
-static inline int printk(const char *s, ...)
-	__attribute__ ((format (printf, 1, 2)));
-static inline int printk(const char *s, ...) { return 0; }
+#define vprintk(fmt, args)      ((void)(fmt, args), 0)
+#define printk(...)             (__VA_ARGS__, 0)
 #endif
 
 unsigned long int_sqrt(unsigned long);
diff -uprN -X linux-2.6.13/Documentation/dontdiff linux-2.6.13/Makefile linux-2.6.13-patched/Makefile
--- linux-2.6.13/Makefile	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13-patched/Makefile	2005-09-20 11:45:56.000000000 +0200
@@ -350,7 +350,7 @@ CPPFLAGS        := -D__KERNEL__ $(LINUXI
 
 CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs \
 	  	   -fno-strict-aliasing -fno-common \
-		   -ffreestanding
+		   -ffreestanding -Wno-unused-value
 AFLAGS		:= -D__ASSEMBLY__
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION LOCALVERSION KERNELRELEASE \

--=-Oq0984baGZNNLe36yY5S--

