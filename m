Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVH2VXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVH2VXY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 17:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVH2VXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 17:23:24 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:59747 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751142AbVH2VXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 17:23:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QusJJCa3KwzuqPZpIfrbUwokAdDnbkcq3G7NvcaM96aQ/LFv//G/COktEqnoeHjN8o9ovY0rccIZTBu19/KIbBRcyfOvjWfz9ouAxrb3xczGaeYs+bWfleH5E4uwi1U5JmEuKwfYVBpKFu1OWL+86laCKfBRcYXXLtVwd3h1wrI=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/3] remove verify_area() - remove verify_area() from various uaccess.h headers
Date: Mon, 29 Aug 2005 23:24:20 +0200
User-Agent: KMail/1.8.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508292324.20756.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove the deprecated (and unused) verify_area() from various uaccess.h 
headers.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 arch/um/include/um_uaccess.h    |    7 -------
 include/asm-alpha/uaccess.h     |    6 ------
 include/asm-arm/uaccess.h       |    6 ------
 include/asm-arm26/uaccess.h     |    6 ------
 include/asm-cris/uaccess.h      |    7 -------
 include/asm-frv/uaccess.h       |    6 ------
 include/asm-h8300/uaccess.h     |    6 ------
 include/asm-i386/uaccess.h      |   24 ------------------------
 include/asm-ia64/uaccess.h      |    7 -------
 include/asm-m32r/uaccess.h      |   25 -------------------------
 include/asm-m68k/uaccess.h      |    6 ------
 include/asm-m68knommu/uaccess.h |    6 ------
 include/asm-mips/uaccess.h      |   23 -----------------------
 include/asm-parisc/uaccess.h    |    4 ----
 include/asm-ppc/uaccess.h       |    7 -------
 include/asm-ppc64/uaccess.h     |    7 -------
 include/asm-s390/uaccess.h      |    7 -------
 include/asm-sh/uaccess.h        |    6 ------
 include/asm-sh64/uaccess.h      |    6 ------
 include/asm-sparc/uaccess.h     |    6 ------
 include/asm-sparc64/uaccess.h   |    6 ------
 include/asm-v850/uaccess.h      |    6 ------
 include/asm-x86_64/uaccess.h    |    7 -------
 23 files changed, 197 deletions(-)

diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/arch/um/include/um_uaccess.h linux-2.6.13/arch/um/include/um_uaccess.h
--- linux-2.6.13-orig/arch/um/include/um_uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/arch/um/include/um_uaccess.h	2005-08-29 03:38:14.000000000 +0200
@@ -20,13 +20,6 @@
 #define access_ok(type, addr, size) \
 	CHOOSE_MODE_PROC(access_ok_tt, access_ok_skas, type, addr, size)
 
-/* this function will go away soon - use access_ok() instead */
-static inline int __deprecated verify_area(int type, const void __user *addr, unsigned long size)
-{
-	return (CHOOSE_MODE_PROC(verify_area_tt, verify_area_skas, type, addr,
-				size));
-}
-
 static inline int copy_from_user(void *to, const void __user *from, int n)
 {
 	return(CHOOSE_MODE_PROC(copy_from_user_tt, copy_from_user_skas, to,
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-alpha/uaccess.h linux-2.6.13/include/asm-alpha/uaccess.h
--- linux-2.6.13-orig/include/asm-alpha/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-alpha/uaccess.h	2005-08-29 03:42:33.000000000 +0200
@@ -48,12 +48,6 @@
 	__access_ok(((unsigned long)(addr)),(size),get_fs());	\
 })
 
-/* this function will go away soon - use access_ok() instead */
-extern inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
-{
-	return access_ok(type,addr,size) ? 0 : -EFAULT;
-}
-
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-arm/uaccess.h linux-2.6.13/include/asm-arm/uaccess.h
--- linux-2.6.13-orig/include/asm-arm/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-arm/uaccess.h	2005-08-29 03:42:43.000000000 +0200
@@ -77,12 +77,6 @@ static inline void set_fs (mm_segment_t 
 
 #define access_ok(type,addr,size)	(__range_ok(addr,size) == 0)
 
-/* this function will go away soon - use access_ok() instead */
-static inline int __deprecated verify_area(int type, const void __user *addr, unsigned long size)
-{
-	return access_ok(type, addr, size) ? 0 : -EFAULT;
-}
-
 /*
  * Single-value transfer routines.  They automatically use the right
  * size if we just have the right pointer type.  Note that the functions
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-arm26/uaccess.h linux-2.6.13/include/asm-arm26/uaccess.h
--- linux-2.6.13-orig/include/asm-arm26/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-arm26/uaccess.h	2005-08-29 03:42:53.000000000 +0200
@@ -40,12 +40,6 @@ extern int fixup_exception(struct pt_reg
 
 #define access_ok(type,addr,size)	(__range_ok(addr,size) == 0)
 
-/* this function will go away soon - use access_ok() instead */
-static inline int __deprecated verify_area(int type, const void * addr, unsigned long size)
-{
-	return access_ok(type, addr, size) ? 0 : -EFAULT;
-}
-
 /*
  * Single-value transfer routines.  They automatically use the right
  * size if we just have the right pointer type.  Note that the functions
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-cris/uaccess.h linux-2.6.13/include/asm-cris/uaccess.h
--- linux-2.6.13-orig/include/asm-cris/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-cris/uaccess.h	2005-08-29 03:43:04.000000000 +0200
@@ -91,13 +91,6 @@
 #define __access_ok(addr,size) (__kernel_ok || __user_ok((addr),(size)))
 #define access_ok(type,addr,size) __access_ok((unsigned long)(addr),(size))
 
-/* this function will go away soon - use access_ok() instead */
-extern inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
-{
-	return access_ok(type,addr,size) ? 0 : -EFAULT;
-}
-
-
 #include <asm/arch/uaccess.h>
 
 /*
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-frv/uaccess.h linux-2.6.13/include/asm-frv/uaccess.h
--- linux-2.6.13-orig/include/asm-frv/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-frv/uaccess.h	2005-08-29 03:43:13.000000000 +0200
@@ -67,12 +67,6 @@ static inline int ___range_ok(unsigned l
 #define access_ok(type,addr,size) (__range_ok((addr), (size)) == 0)
 #define __access_ok(addr,size) (__range_ok((addr), (size)) == 0)
 
-/* this function will go away soon - use access_ok() / __range_ok() instead */
-static inline int __deprecated verify_area(int type, const void * addr, unsigned long size)
-{
-	return __range_ok(addr, size);
-}
-
 /*
  * The exception table consists of pairs of addresses: the first is the
  * address of an instruction that is allowed to fault, and the second is
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-h8300/uaccess.h linux-2.6.13/include/asm-h8300/uaccess.h
--- linux-2.6.13-orig/include/asm-h8300/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-h8300/uaccess.h	2005-08-29 03:43:20.000000000 +0200
@@ -24,12 +24,6 @@ static inline int __access_ok(unsigned l
 	return(RANGE_CHECK_OK(addr, size, 0L, (unsigned long)&_ramend));
 }
 
-/* this function will go away soon - use access_ok() instead */
-static inline int __deprecated verify_area(int type, const void *addr, unsigned long size)
-{
-	return access_ok(type,addr,size)?0:-EFAULT;
-}
-
 /*
  * The exception table consists of pairs of addresses: the first is the
  * address of an instruction that is allowed to fault, and the second is
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-i386/uaccess.h linux-2.6.13/include/asm-i386/uaccess.h
--- linux-2.6.13-orig/include/asm-i386/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-i386/uaccess.h	2005-08-29 03:43:36.000000000 +0200
@@ -83,30 +83,6 @@ extern struct movsl_mask {
  */
 #define access_ok(type,addr,size) (likely(__range_ok(addr,size) == 0))
 
-/**
- * verify_area: - Obsolete/deprecated and will go away soon,
- * use access_ok() instead.
- * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE
- * @addr: User space pointer to start of block to check
- * @size: Size of block to check
- *
- * Context: User context only.  This function may sleep.
- *
- * This function has been replaced by access_ok().
- *
- * Checks if a pointer to a block of memory in user space is valid.
- *
- * Returns zero if the memory block may be valid, -EFAULT
- * if it is definitely invalid.
- *
- * See access_ok() for more details.
- */
-static inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
-{
-	return access_ok(type,addr,size) ? 0 : -EFAULT;
-}
-
-
 /*
  * The exception table consists of pairs of addresses: the first is the
  * address of an instruction that is allowed to fault, and the second is
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-ia64/uaccess.h linux-2.6.13/include/asm-ia64/uaccess.h
--- linux-2.6.13-orig/include/asm-ia64/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-ia64/uaccess.h	2005-08-29 03:43:47.000000000 +0200
@@ -72,13 +72,6 @@
 })
 #define access_ok(type, addr, size)	__access_ok((addr), (size), get_fs())
 
-/* this function will go away soon - use access_ok() instead */
-static inline int __deprecated
-verify_area (int type, const void __user *addr, unsigned long size)
-{
-	return access_ok(type, addr, size) ? 0 : -EFAULT;
-}
-
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-m32r/uaccess.h linux-2.6.13/include/asm-m32r/uaccess.h
--- linux-2.6.13-orig/include/asm-m32r/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-m32r/uaccess.h	2005-08-29 03:43:58.000000000 +0200
@@ -120,31 +120,6 @@ static inline int access_ok(int type, co
 }
 #endif /* CONFIG_MMU */
 
-/**
- * verify_area: - Obsolete/deprecated and will go away soon,
- * use access_ok() instead.
- * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE
- * @addr: User space pointer to start of block to check
- * @size: Size of block to check
- *
- * Context: User context only.  This function may sleep.
- *
- * This function has been replaced by access_ok().
- *
- * Checks if a pointer to a block of memory in user space is valid.
- *
- * Returns zero if the memory block may be valid, -EFAULT
- * if it is definitely invalid.
- *
- * See access_ok() for more details.
- */
-static inline int __deprecated verify_area(int type, const void __user *addr,
-			      unsigned long size)
-{
-	return access_ok(type, addr, size) ? 0 : -EFAULT;
-}
-
-
 /*
  * The exception table consists of pairs of addresses: the first is the
  * address of an instruction that is allowed to fault, and the second is
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-m68k/uaccess.h linux-2.6.13/include/asm-m68k/uaccess.h
--- linux-2.6.13-orig/include/asm-m68k/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-m68k/uaccess.h	2005-08-29 03:44:08.000000000 +0200
@@ -14,12 +14,6 @@
 /* We let the MMU do all checking */
 #define access_ok(type,addr,size) 1
 
-/* this function will go away soon - use access_ok() instead */
-static inline int __deprecated verify_area(int type, const void *addr, unsigned long size)
-{
-	return access_ok(type,addr,size) ? 0 : -EFAULT;
-}
-
 /*
  * The exception table consists of pairs of addresses: the first is the
  * address of an instruction that is allowed to fault, and the second is
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-m68knommu/uaccess.h linux-2.6.13/include/asm-m68knommu/uaccess.h
--- linux-2.6.13-orig/include/asm-m68knommu/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-m68knommu/uaccess.h	2005-08-29 03:44:16.000000000 +0200
@@ -23,12 +23,6 @@ static inline int _access_ok(unsigned lo
 		(is_in_rom(addr) && is_in_rom(addr+size)));
 }
 
-/* this function will go away soon - use access_ok() instead */
-extern inline int __deprecated verify_area(int type, const void * addr, unsigned long size)
-{
-	return access_ok(type,addr,size)?0:-EFAULT;
-}
-
 /*
  * The exception table consists of pairs of addresses: the first is the
  * address of an instruction that is allowed to fault, and the second is
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-mips/uaccess.h linux-2.6.13/include/asm-mips/uaccess.h
--- linux-2.6.13-orig/include/asm-mips/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-mips/uaccess.h	2005-08-29 03:44:25.000000000 +0200
@@ -112,29 +112,6 @@
 	likely(__access_ok((unsigned long)(addr), (size),__access_mask))
 
 /*
- * verify_area: - Obsolete/deprecated and will go away soon,
- * use access_ok() instead.
- * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE
- * @addr: User space pointer to start of block to check
- * @size: Size of block to check
- *
- * Context: User context only.  This function may sleep.
- *
- * This function has been replaced by access_ok().
- *
- * Checks if a pointer to a block of memory in user space is valid.
- *
- * Returns zero if the memory block may be valid, -EFAULT
- * if it is definitely invalid.
- *
- * See access_ok() for more details.
- */
-static inline int __deprecated verify_area(int type, const void * addr, unsigned long size)
-{
-	return access_ok(type, addr, size) ? 0 : -EFAULT;
-}
-
-/*
  * put_user: - Write a simple value into user space.
  * @x:   Value to copy to user space.
  * @ptr: Destination address, in user space.
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-parisc/uaccess.h linux-2.6.13/include/asm-parisc/uaccess.h
--- linux-2.6.13-orig/include/asm-parisc/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-parisc/uaccess.h	2005-08-29 03:44:40.000000000 +0200
@@ -40,10 +40,6 @@ static inline long access_ok(int type, c
 	return 1;
 }
 
-#define verify_area(type,addr,size) (0)	/* FIXME: all users should go away soon,
-                                         * and use access_ok instead, then this
-                                         * should be removed. */
-
 #define put_user __put_user
 #define get_user __get_user
 
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-ppc/uaccess.h linux-2.6.13/include/asm-ppc/uaccess.h
--- linux-2.6.13-orig/include/asm-ppc/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-ppc/uaccess.h	2005-08-29 03:44:50.000000000 +0200
@@ -37,13 +37,6 @@
 #define access_ok(type, addr, size) \
 	(__chk_user_ptr(addr),__access_ok((unsigned long)(addr),(size)))
 
-/* this function will go away soon - use access_ok() instead */
-extern inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
-{
-	return access_ok(type, addr, size) ? 0 : -EFAULT;
-}
-
-
 /*
  * The exception table consists of pairs of addresses: the first is the
  * address of an instruction that is allowed to fault, and the second is
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-ppc64/uaccess.h linux-2.6.13/include/asm-ppc64/uaccess.h
--- linux-2.6.13-orig/include/asm-ppc64/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-ppc64/uaccess.h	2005-08-29 03:44:59.000000000 +0200
@@ -56,13 +56,6 @@
 #define access_ok(type,addr,size) \
 	__access_ok(((__force unsigned long)(addr)),(size),get_fs())
 
-/* this function will go away soon - use access_ok() instead */
-static inline int __deprecated verify_area(int type, const void __user *addr, unsigned long size)
-{
-	return access_ok(type,addr,size) ? 0 : -EFAULT;
-}
-
-
 /*
  * The exception table consists of pairs of addresses: the first is the
  * address of an instruction that is allowed to fault, and the second is
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-s390/uaccess.h linux-2.6.13/include/asm-s390/uaccess.h
--- linux-2.6.13-orig/include/asm-s390/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-s390/uaccess.h	2005-08-29 03:45:09.000000000 +0200
@@ -65,13 +65,6 @@
 
 #define access_ok(type,addr,size) __access_ok(addr,size)
 
-/* this function will go away soon - use access_ok() instead */
-extern inline int __deprecated verify_area(int type, const void __user *addr,
-						unsigned long size)
-{
-	return access_ok(type, addr, size) ? 0 : -EFAULT;
-}
-
 /*
  * The exception table consists of pairs of addresses: the first is the
  * address of an instruction that is allowed to fault, and the second is
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-sh/uaccess.h linux-2.6.13/include/asm-sh/uaccess.h
--- linux-2.6.13-orig/include/asm-sh/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-sh/uaccess.h	2005-08-29 03:45:17.000000000 +0200
@@ -146,12 +146,6 @@ static inline int access_ok(int type, co
 	return __access_ok(addr, size);
 }
 
-/* this function will go away soon - use access_ok() instead */
-static inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
-{
-	return access_ok(type,addr,size) ? 0 : -EFAULT;
-}
-
 /*
  * Uh, these should become the main single-value transfer routines ...
  * They automatically use the right size if we just have the right
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-sh64/uaccess.h linux-2.6.13/include/asm-sh64/uaccess.h
--- linux-2.6.13-orig/include/asm-sh64/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-sh64/uaccess.h	2005-08-29 03:45:28.000000000 +0200
@@ -60,12 +60,6 @@
 #define access_ok(type,addr,size) (__range_ok(addr,size) == 0)
 #define __access_ok(addr,size) (__range_ok(addr,size) == 0)
 
-/* this function will go away soon - use access_ok() instead */
-extern inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
-{
-	return access_ok(type,addr,size) ? 0 : -EFAULT;
-}
-
 /*
  * Uh, these should become the main single-value transfer routines ...
  * They automatically use the right size if we just have the right
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-sparc/uaccess.h linux-2.6.13/include/asm-sparc/uaccess.h
--- linux-2.6.13-orig/include/asm-sparc/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-sparc/uaccess.h	2005-08-29 03:45:36.000000000 +0200
@@ -47,12 +47,6 @@
 #define access_ok(type, addr, size)					\
 	({ (void)(type); __access_ok((unsigned long)(addr), size); })
 
-/* this function will go away soon - use access_ok() instead */
-static inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
-{
-	return access_ok(type,addr,size) ? 0 : -EFAULT;
-}
-
 /*
  * The exception table consists of pairs of addresses: the first is the
  * address of an instruction that is allowed to fault, and the second is
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-sparc64/uaccess.h linux-2.6.13/include/asm-sparc64/uaccess.h
--- linux-2.6.13-orig/include/asm-sparc64/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-sparc64/uaccess.h	2005-08-29 03:45:52.000000000 +0200
@@ -59,12 +59,6 @@ static inline int access_ok(int type, co
 	return 1;
 }
 
-/* this function will go away soon - use access_ok() instead */
-static inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
-{
-	return 0;
-}
-
 /*
  * The exception table consists of pairs of addresses: the first is the
  * address of an instruction that is allowed to fault, and the second is
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-v850/uaccess.h linux-2.6.13/include/asm-v850/uaccess.h
--- linux-2.6.13-orig/include/asm-v850/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-v850/uaccess.h	2005-08-29 03:45:58.000000000 +0200
@@ -27,12 +27,6 @@ extern inline int access_ok (int type, c
 	return val >= (0x80 + NUM_CPU_IRQS*16) && val < 0xFFFFF000;
 }
 
-/* this function will go away soon - use access_ok() instead */
-extern inline int __deprecated verify_area (int type, const void *addr, unsigned long size)
-{
-	return access_ok (type, addr, size) ? 0 : -EFAULT;
-}
-
 /*
  * The exception table consists of pairs of addresses: the first is the
  * address of an instruction that is allowed to fault, and the second is
diff -upr -X ./linux-2.6.13/Documentation/dontdiff linux-2.6.13-orig/include/asm-x86_64/uaccess.h linux-2.6.13/include/asm-x86_64/uaccess.h
--- linux-2.6.13-orig/include/asm-x86_64/uaccess.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13/include/asm-x86_64/uaccess.h	2005-08-29 03:46:07.000000000 +0200
@@ -49,13 +49,6 @@
 
 #define access_ok(type, addr, size) (__range_not_ok(addr,size) == 0)
 
-/* this function will go away soon - use access_ok() instead */
-extern inline int __deprecated verify_area(int type, const void __user * addr, unsigned long size)
-{
-	return access_ok(type,addr,size) ? 0 : -EFAULT;
-}
-
-
 /*
  * The exception table consists of pairs of addresses: the first is the
  * address of an instruction that is allowed to fault, and the second is



