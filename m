Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVAGBNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVAGBNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVAGBK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:10:59 -0500
Received: from mail.dif.dk ([193.138.115.101]:55231 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261240AbVAGBG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:06:58 -0500
Date: Fri, 7 Jan 2005 02:18:24 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][1/4] let's kill verify_area - deprecate verify_area across
 the board 
Message-ID: <Pine.LNX.4.61.0501070143140.3430@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch deprecates verify_area() for all arch's. 
New code should use access_ok() and for old code still using verify_area() 
there's no real reason not to convert now (or soon'ish).


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk> 

diff -upr linux-2.6.10-bk9-orig/include/ linux-2.6.10-bk9/include/

diff -upr linux-2.6.10-bk9-orig/include/asm-alpha/uaccess.h linux-2.6.10-bk9/include/asm-alpha/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-alpha/uaccess.h	2004-12-24 22:35:24.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-alpha/uaccess.h	2005-01-07 01:16:46.000000000 +0100
@@ -48,7 +48,8 @@
 	__access_ok(((unsigned long)(addr)),(size),get_fs());	\
 })
 
-extern inline int verify_area(int type, const void __user * addr, unsigned long size)
+/* this function will go away soon - use access_ok() instead */
+extern inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
 {
 	return access_ok(type,addr,size) ? 0 : -EFAULT;
 }
diff -upr linux-2.6.10-bk9-orig/include/asm-arm/uaccess.h linux-2.6.10-bk9/include/asm-arm/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-arm/uaccess.h	2004-12-24 22:35:00.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-arm/uaccess.h	2005-01-07 01:26:24.000000000 +0100
@@ -77,7 +77,8 @@ static inline void set_fs (mm_segment_t 
 
 #define access_ok(type,addr,size)	(__range_ok(addr,size) == 0)
 
-static inline int verify_area(int type, const void __user *addr, unsigned long size)
+/* this function will go away soon - use access_ok() instead */
+static inline int __deprecated verify_area(int type, const void __user *addr, unsigned long size)
 {
 	return access_ok(type, addr, size) ? 0 : -EFAULT;
 }
diff -upr linux-2.6.10-bk9-orig/include/asm-arm26/uaccess.h linux-2.6.10-bk9/include/asm-arm26/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-arm26/uaccess.h	2005-01-06 22:19:12.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-arm26/uaccess.h	2005-01-07 01:17:39.000000000 +0100
@@ -40,7 +40,8 @@ extern int fixup_exception(struct pt_reg
 
 #define access_ok(type,addr,size)	(__range_ok(addr,size) == 0)
 
-static inline int verify_area(int type, const void * addr, unsigned long size)
+/* this function will go away soon - use access_ok() instead */
+static inline int __deprecated verify_area(int type, const void * addr, unsigned long size)
 {
 	return access_ok(type, addr, size) ? 0 : -EFAULT;
 }
diff -upr linux-2.6.10-bk9-orig/include/asm-cris/uaccess.h linux-2.6.10-bk9/include/asm-cris/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-cris/uaccess.h	2004-12-24 22:34:00.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-cris/uaccess.h	2005-01-07 01:21:12.000000000 +0100
@@ -91,7 +91,8 @@
 #define __access_ok(addr,size) (__kernel_ok || __user_ok((addr),(size)))
 #define access_ok(type,addr,size) __access_ok((unsigned long)(addr),(size))
 
-extern inline int verify_area(int type, const void __user * addr, unsigned long size)
+/* this function will go away soon - use access_ok() instead */
+extern inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
 {
 	return access_ok(type,addr,size) ? 0 : -EFAULT;
 }
diff -upr linux-2.6.10-bk9-orig/include/asm-frv/uaccess.h linux-2.6.10-bk9/include/asm-frv/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-frv/uaccess.h	2005-01-06 22:19:12.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-frv/uaccess.h	2005-01-07 01:28:03.000000000 +0100
@@ -67,7 +67,8 @@ static inline int ___range_ok(unsigned l
 #define access_ok(type,addr,size) (__range_ok((addr), (size)) == 0)
 #define __access_ok(addr,size) (__range_ok((addr), (size)) == 0)
 
-static inline int verify_area(int type, const void * addr, unsigned long size)
+/* this function will go away soon - use access_ok() / __range_ok() instead */
+static inline int __deprecated verify_area(int type, const void * addr, unsigned long size)
 {
 	return __range_ok(addr, size);
 }
diff -upr linux-2.6.10-bk9-orig/include/asm-h8300/uaccess.h linux-2.6.10-bk9/include/asm-h8300/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-h8300/uaccess.h	2004-12-24 22:34:30.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-h8300/uaccess.h	2005-01-07 01:18:11.000000000 +0100
@@ -24,7 +24,8 @@ static inline int __access_ok(unsigned l
 	return(RANGE_CHECK_OK(addr, size, 0L, (unsigned long)&_ramend));
 }
 
-static inline int verify_area(int type, const void *addr, unsigned long size)
+/* this function will go away soon - use access_ok() instead */
+static inline int __deprecated verify_area(int type, const void *addr, unsigned long size)
 {
 	return access_ok(type,addr,size)?0:-EFAULT;
 }
diff -upr linux-2.6.10-bk9-orig/include/asm-i386/uaccess.h linux-2.6.10-bk9/include/asm-i386/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-i386/uaccess.h	2005-01-06 22:19:12.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-i386/uaccess.h	2005-01-07 00:59:35.000000000 +0100
@@ -84,7 +84,8 @@ extern struct movsl_mask {
 #define access_ok(type,addr,size) (likely(__range_ok(addr,size) == 0))
 
 /**
- * verify_area: - Obsolete, use access_ok()
+ * verify_area: - Obsolete/deprecated and will go away soon, 
+ * use access_ok() instead.
  * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE
  * @addr: User space pointer to start of block to check
  * @size: Size of block to check
@@ -100,7 +101,7 @@ extern struct movsl_mask {
  *
  * See access_ok() for more details.
  */
-static inline int verify_area(int type, const void __user * addr, unsigned long size)
+static inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
 {
 	return access_ok(type,addr,size) ? 0 : -EFAULT;
 }
diff -upr linux-2.6.10-bk9-orig/include/asm-ia64/uaccess.h linux-2.6.10-bk9/include/asm-ia64/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-ia64/uaccess.h	2004-12-24 22:34:30.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-ia64/uaccess.h	2005-01-07 01:22:59.000000000 +0100
@@ -69,7 +69,8 @@
 })
 #define access_ok(type, addr, size)	__access_ok((addr), (size), get_fs())
 
-static inline int
+/* this function will go away soon - use access_ok() instead */
+static inline int __deprecated 
 verify_area (int type, const void __user *addr, unsigned long size)
 {
 	return access_ok(type, addr, size) ? 0 : -EFAULT;
diff -upr linux-2.6.10-bk9-orig/include/asm-m32r/uaccess.h linux-2.6.10-bk9/include/asm-m32r/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-m32r/uaccess.h	2004-12-24 22:35:27.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-m32r/uaccess.h	2005-01-07 01:22:03.000000000 +0100
@@ -121,7 +121,8 @@ static inline int access_ok(int type, co
 #endif /* CONFIG_MMU */
 
 /**
- * verify_area: - Obsolete, use access_ok()
+ * verify_area: - Obsolete/deprecated and will go away soon,
+ * use access_ok() instead.
  * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE
  * @addr: User space pointer to start of block to check
  * @size: Size of block to check
@@ -137,7 +138,7 @@ static inline int access_ok(int type, co
  *
  * See access_ok() for more details.
  */
-static inline int verify_area(int type, const void __user *addr,
+static inline int __deprecated verify_area(int type, const void __user *addr,
 			      unsigned long size)
 {
 	return access_ok(type, addr, size) ? 0 : -EFAULT;
diff -upr linux-2.6.10-bk9-orig/include/asm-m68k/uaccess.h linux-2.6.10-bk9/include/asm-m68k/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-m68k/uaccess.h	2004-12-24 22:34:26.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-m68k/uaccess.h	2005-01-07 01:39:48.000000000 +0100
@@ -14,9 +14,10 @@
 /* We let the MMU do all checking */
 #define access_ok(type,addr,size) 1
 
-static inline int verify_area(int type, const void *addr, unsigned long size)
+/* this function will go away soon - use access_ok() instead */
+static inline int __deprecated verify_area(int type, const void *addr, unsigned long size)
 {
-	return access_ok(type,addr,size)?0:-EFAULT;
+	return access_ok(type,addr,size) ? 0 : -EFAULT;
 }
 
 /*
diff -upr linux-2.6.10-bk9-orig/include/asm-m68knommu/uaccess.h linux-2.6.10-bk9/include/asm-m68knommu/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-m68knommu/uaccess.h	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-m68knommu/uaccess.h	2005-01-07 01:11:15.000000000 +0100
@@ -23,7 +23,8 @@ static inline int _access_ok(unsigned lo
 		(is_in_rom(addr) && is_in_rom(addr+size)));
 }
 
-extern inline int verify_area(int type, const void * addr, unsigned long size)
+/* this function will go away soon - use access_ok() instead */
+extern inline int __deprecated verify_area(int type, const void * addr, unsigned long size)
 {
 	return access_ok(type,addr,size)?0:-EFAULT;
 }
diff -upr linux-2.6.10-bk9-orig/include/asm-mips/uaccess.h linux-2.6.10-bk9/include/asm-mips/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-mips/uaccess.h	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-mips/uaccess.h	2005-01-07 01:24:07.000000000 +0100
@@ -112,7 +112,8 @@
 	likely(__access_ok((unsigned long)(addr), (size),__access_mask))
 
 /*
- * verify_area: - Obsolete, use access_ok()
+ * verify_area: - Obsolete/deprecated and will go away soon,
+ * use access_ok() instead.
  * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE
  * @addr: User space pointer to start of block to check
  * @size: Size of block to check
@@ -128,7 +129,7 @@
  *
  * See access_ok() for more details.
  */
-static inline int verify_area(int type, const void * addr, unsigned long size)
+static inline int __deprecated verify_area(int type, const void * addr, unsigned long size)
 {
 	return access_ok(type, addr, size) ? 0 : -EFAULT;
 }
diff -upr linux-2.6.10-bk9-orig/include/asm-parisc/uaccess.h linux-2.6.10-bk9/include/asm-parisc/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-parisc/uaccess.h	2004-12-24 22:34:26.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-parisc/uaccess.h	2005-01-07 01:15:31.000000000 +0100
@@ -35,7 +35,9 @@ extern int __put_kernel_bad(void);
 extern int __put_user_bad(void);
 
 #define access_ok(type,addr,size)   (1)
-#define verify_area(type,addr,size) (0)
+#define verify_area(type,addr,size) (0)	/* FIXME: all users should go away soon,
+                                         * and use access_ok instead, then this 
+                                         * should be removed. */
 
 #define put_user __put_user
 #define get_user __get_user
diff -upr linux-2.6.10-bk9-orig/include/asm-ppc/uaccess.h linux-2.6.10-bk9/include/asm-ppc/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-ppc/uaccess.h	2005-01-06 22:19:12.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-ppc/uaccess.h	2005-01-07 01:28:34.000000000 +0100
@@ -37,7 +37,8 @@
 #define access_ok(type, addr, size) \
 	(__chk_user_ptr(addr),__access_ok((unsigned long)(addr),(size)))
 
-extern inline int verify_area(int type, const void __user * addr, unsigned long size)
+/* this function will go away soon - use access_ok() instead */
+extern inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
 {
 	return access_ok(type, addr, size) ? 0 : -EFAULT;
 }
diff -upr linux-2.6.10-bk9-orig/include/asm-ppc64/uaccess.h linux-2.6.10-bk9/include/asm-ppc64/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-ppc64/uaccess.h	2004-12-24 22:34:57.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-ppc64/uaccess.h	2005-01-07 01:18:56.000000000 +0100
@@ -56,7 +56,8 @@
 #define access_ok(type,addr,size) \
 	__access_ok(((__force unsigned long)(addr)),(size),get_fs())
 
-static inline int verify_area(int type, const void __user *addr, unsigned long size)
+/* this function will go away soon - use access_ok() instead */
+static inline int __deprecated verify_area(int type, const void __user *addr, unsigned long size)
 {
 	return access_ok(type,addr,size) ? 0 : -EFAULT;
 }
diff -upr linux-2.6.10-bk9-orig/include/asm-s390/uaccess.h linux-2.6.10-bk9/include/asm-s390/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-s390/uaccess.h	2004-12-24 22:34:26.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-s390/uaccess.h	2005-01-07 01:24:49.000000000 +0100
@@ -65,7 +65,8 @@
 
 #define access_ok(type,addr,size) __access_ok(addr,size)
 
-extern inline int verify_area(int type, const void __user *addr,
+/* this function will go away soon - use access_ok() instead */
+extern inline int __deprecated verify_area(int type, const void __user *addr,
 						unsigned long size)
 {
 	return access_ok(type, addr, size) ? 0 : -EFAULT;
diff -upr linux-2.6.10-bk9-orig/include/asm-sh/uaccess.h linux-2.6.10-bk9/include/asm-sh/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-sh/uaccess.h	2004-12-24 22:34:44.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-sh/uaccess.h	2005-01-07 01:12:18.000000000 +0100
@@ -146,7 +146,8 @@ static inline int access_ok(int type, co
 	return __access_ok(addr, size);
 }
 
-static inline int verify_area(int type, const void __user * addr, unsigned long size)
+/* this function will go away soon - use access_ok() instead */
+static inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
 {
 	return access_ok(type,addr,size) ? 0 : -EFAULT;
 }
diff -upr linux-2.6.10-bk9-orig/include/asm-sh64/uaccess.h linux-2.6.10-bk9/include/asm-sh64/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-sh64/uaccess.h	2004-12-24 22:34:29.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-sh64/uaccess.h	2005-01-07 01:25:55.000000000 +0100
@@ -60,7 +60,8 @@
 #define access_ok(type,addr,size) (__range_ok(addr,size) == 0)
 #define __access_ok(addr,size) (__range_ok(addr,size) == 0)
 
-extern inline int verify_area(int type, const void __user * addr, unsigned long size)
+/* this function will go away soon - use access_ok() instead */
+extern inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
 {
 	return access_ok(type,addr,size) ? 0 : -EFAULT;
 }
diff -upr linux-2.6.10-bk9-orig/include/asm-sparc/uaccess.h linux-2.6.10-bk9/include/asm-sparc/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-sparc/uaccess.h	2004-12-24 22:35:27.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-sparc/uaccess.h	2005-01-07 01:20:30.000000000 +0100
@@ -46,9 +46,10 @@
 #define __access_ok(addr,size) (__user_ok((addr) & get_fs().seg,(size)))
 #define access_ok(type,addr,size) __access_ok((unsigned long)(addr),(size))
 
-static inline int verify_area(int type, const void __user * addr, unsigned long size)
+/* this function will go away soon - use access_ok() instead */
+static inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
 {
-	return access_ok(type,addr,size)?0:-EFAULT;
+	return access_ok(type,addr,size) ? 0 : -EFAULT;
 }
 
 /*
diff -upr linux-2.6.10-bk9-orig/include/asm-sparc64/uaccess.h linux-2.6.10-bk9/include/asm-sparc64/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-sparc64/uaccess.h	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-sparc64/uaccess.h	2005-01-07 01:29:17.000000000 +0100
@@ -54,7 +54,8 @@ do {										\
 #define __access_ok(addr,size) 1
 #define access_ok(type,addr,size) 1
 
-static inline int verify_area(int type, const void __user * addr, unsigned long size)
+/* this function will go away soon - use access_ok() instead */
+static inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
 {
 	return 0;
 }
diff -upr linux-2.6.10-bk9-orig/include/asm-v850/uaccess.h linux-2.6.10-bk9/include/asm-v850/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-v850/uaccess.h	2004-12-24 22:35:24.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-v850/uaccess.h	2005-01-07 01:25:18.000000000 +0100
@@ -27,7 +27,8 @@ extern inline int access_ok (int type, c
 	return val >= (0x80 + NUM_CPU_IRQS*16) && val < 0xFFFFF000;
 }
 
-extern inline int verify_area (int type, const void *addr, unsigned long size)
+/* this function will go away soon - use access_ok() instead */
+extern inline int __deprecated verify_area (int type, const void *addr, unsigned long size)
 {
 	return access_ok (type, addr, size) ? 0 : -EFAULT;
 }
diff -upr linux-2.6.10-bk9-orig/include/asm-x86_64/uaccess.h linux-2.6.10-bk9/include/asm-x86_64/uaccess.h
--- linux-2.6.10-bk9-orig/include/asm-x86_64/uaccess.h	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.10-bk9/include/asm-x86_64/uaccess.h	2005-01-07 01:16:08.000000000 +0100
@@ -49,7 +49,8 @@
 
 #define access_ok(type, addr, size) (__range_not_ok(addr,size) == 0)
 
-extern inline int verify_area(int type, const void __user * addr, unsigned long size)
+/* this function will go away soon - use access_ok() instead */
+extern inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
 {
 	return access_ok(type,addr,size) ? 0 : -EFAULT;
 }




