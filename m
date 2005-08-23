Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVHWVqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVHWVqD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVHWVpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:45:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24758 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932446AbVHWVpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:45:19 -0400
To: torvalds@osdl.org
Subject: [PATCH] (43/43) s390 __CHECKER__ ifdefs
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gd4-0007G4-Lz@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:48:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove the bogus games with explicit ifdefs on __CHECKER__

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-m68k-flags/drivers/s390/crypto/z90crypt.h RC13-rc6-git13-s390-ifdefs/drivers/s390/crypto/z90crypt.h
--- RC13-rc6-git13-m68k-flags/drivers/s390/crypto/z90crypt.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-s390-ifdefs/drivers/s390/crypto/z90crypt.h	2005-08-21 13:17:46.000000000 -0400
@@ -36,15 +36,6 @@
 #define z90crypt_VARIANT 2	// 2 = added PCIXCC MCL3 and CEX2C support
 
 /**
- * If we are not using the sparse checker, __user has no use.
- */
-#ifdef __CHECKER__
-# define __user		__attribute__((noderef, address_space(1)))
-#else
-# define __user
-#endif
-
-/**
  * struct ica_rsa_modexpo
  *
  * Requirements:
diff -urN RC13-rc6-git13-m68k-flags/include/asm-s390/uaccess.h RC13-rc6-git13-s390-ifdefs/include/asm-s390/uaccess.h
--- RC13-rc6-git13-m68k-flags/include/asm-s390/uaccess.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-s390-ifdefs/include/asm-s390/uaccess.h	2005-08-21 13:17:46.000000000 -0400
@@ -149,11 +149,11 @@
 })
 #endif
 
-#ifndef __CHECKER__
 #define __put_user(x, ptr) \
 ({								\
 	__typeof__(*(ptr)) __x = (x);				\
 	int __pu_err;						\
+        __chk_user_ptr(ptr);                                    \
 	switch (sizeof (*(ptr))) {				\
 	case 1:							\
 	case 2:							\
@@ -167,14 +167,6 @@
 	 }							\
 	__pu_err;						\
 })
-#else
-#define __put_user(x, ptr)			\
-({						\
-	void __user *p;				\
-	p = (ptr);				\
-	0;					\
-})
-#endif
 
 #define put_user(x, ptr)					\
 ({								\
@@ -213,11 +205,11 @@
 })
 #endif
 
-#ifndef __CHECKER__
 #define __get_user(x, ptr)					\
 ({								\
 	__typeof__(*(ptr)) __x;					\
 	int __gu_err;						\
+        __chk_user_ptr(ptr);                                    \
 	switch (sizeof(*(ptr))) {				\
 	case 1:							\
 	case 2:							\
@@ -232,15 +224,6 @@
 	(x) = __x;						\
 	__gu_err;						\
 })
-#else
-#define __get_user(x, ptr)			\
-({						\
-	void __user *p;				\
-	p = (ptr);				\
-	0;					\
-})
-#endif
-
 
 #define get_user(x, ptr)					\
 ({								\
