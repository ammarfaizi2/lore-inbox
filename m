Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263691AbTCUTPQ>; Fri, 21 Mar 2003 14:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263735AbTCUTOe>; Fri, 21 Mar 2003 14:14:34 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41092
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263793AbTCUTMx>; Fri, 21 Mar 2003 14:12:53 -0500
Date: Fri, 21 Mar 2003 20:28:09 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212028.h2LKS9lk026347@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: document useraccess lib functions too
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/lib/usercopy.c linux-2.5.65-ac2/arch/i386/lib/usercopy.c
--- linux-2.5.65/arch/i386/lib/usercopy.c	2003-02-10 18:37:55.000000000 +0000
+++ linux-2.5.65-ac2/arch/i386/lib/usercopy.c	2003-03-06 23:12:31.000000000 +0000
@@ -50,6 +50,26 @@
 		: "memory");						   \
 } while (0)
 
+/**
+ * __strncpy_from_user: - Copy a NUL terminated string from userspace, with less checking.
+ * @dst:   Destination address, in kernel space.  This buffer must be at
+ *         least @count bytes long.
+ * @src:   Source address, in user space.
+ * @count: Maximum number of bytes to copy, including the trailing NUL.
+ * 
+ * Copies a NUL-terminated string from userspace to kernel space.
+ * Caller must check the specified block with access_ok() before calling
+ * this function.
+ *
+ * On success, returns the length of the string (not including the trailing
+ * NUL).
+ *
+ * If access to userspace fails, returns -EFAULT (some data may have been
+ * copied).
+ *
+ * If @count is smaller than the length of the string, copies @count bytes
+ * and returns @count.
+ */
 long
 __strncpy_from_user(char *dst, const char *src, long count)
 {
@@ -58,6 +78,24 @@
 	return res;
 }
 
+/**
+ * strncpy_from_user: - Copy a NUL terminated string from userspace.
+ * @dst:   Destination address, in kernel space.  This buffer must be at
+ *         least @count bytes long.
+ * @src:   Source address, in user space.
+ * @count: Maximum number of bytes to copy, including the trailing NUL.
+ * 
+ * Copies a NUL-terminated string from userspace to kernel space.
+ *
+ * On success, returns the length of the string (not including the trailing
+ * NUL).
+ *
+ * If access to userspace fails, returns -EFAULT (some data may have been
+ * copied).
+ *
+ * If @count is smaller than the length of the string, copies @count bytes
+ * and returns @count.
+ */
 long
 strncpy_from_user(char *dst, const char *src, long count)
 {
@@ -93,6 +131,16 @@
 		: "r"(size & 3), "0"(size / 4), "1"(addr), "a"(0));	\
 } while (0)
 
+/**
+ * clear_user: - Zero a block of memory in user space.
+ * @to:   Destination address, in user space.
+ * @n:    Number of bytes to zero.
+ *
+ * Zero a block of memory in user space.
+ *
+ * Returns number of bytes that could not be cleared.
+ * On success, this will be zero.
+ */
 unsigned long
 clear_user(void *to, unsigned long n)
 {
@@ -101,6 +149,17 @@
 	return n;
 }
 
+/**
+ * __clear_user: - Zero a block of memory in user space, with less checking.
+ * @to:   Destination address, in user space.
+ * @n:    Number of bytes to zero.
+ *
+ * Zero a block of memory in user space.  Caller must check
+ * the specified block with access_ok() before calling this function.
+ *
+ * Returns number of bytes that could not be cleared.
+ * On success, this will be zero.
+ */
 unsigned long
 __clear_user(void *to, unsigned long n)
 {
@@ -108,12 +167,17 @@
 	return n;
 }
 
-/*
- * Return the size of a string (including the ending 0)
+/**
+ * strlen_user: - Get the size of a string in user space.
+ * @s: The string to measure.
+ * @n: The maximum valid length
  *
- * Return 0 on exception, a value greater than N if too long
+ * Get the size of a NUL-terminated string in user space.
+ *
+ * Returns the size of the string INCLUDING the terminating NUL.
+ * On exception, returns 0.
+ * If the string is too long, returns a value greater than @n.
  */
-
 long strnlen_user(const char *s, long n)
 {
 	unsigned long mask = -__addr_ok(s);
