Return-Path: <linux-kernel-owner+willy=40w.ods.org-S773514AbUKBFXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S773514AbUKBFXW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 00:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S376804AbUKAW3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:29:01 -0500
Received: from mail47.e.nsc.no ([193.213.115.47]:61359 "EHLO mail47.e.nsc.no")
	by vger.kernel.org with ESMTP id S293402AbUKAT5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:57:30 -0500
Subject: [Patch]2.6.8 htmldocs target fails with id already defined.
	<asm/uaccess.h>
From: Enrique Perez-Terron <enrio@online.no>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1099339046.2774.14.camel@arabia.home.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 01 Nov 2004 20:57:28 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The DocBook markup in source comments is misplaced in
include/asm-i386/uaccess.h, with the description of macro
strlen-user() just above the definition of
direct_strncpy_from_user(). 

This leads the "make htmldocs" commands to generate the following
error messages:

jade:/var/linux/Documentation/DocBook/kernel-api.sgml:6698:27:E: ID "API-DIRECT-STRNCPY-FROM-USER" already defined
jade:/var/linux/Documentation/DocBook/kernel-api.sgml:6556:27: ID "API-DIRECT-STRNCPY-FROM-USER" first defined here

where the "first defined here" instance produces a documentation that
gives the description of strlen_user() under the header of
direct_strncpy_from_user().  The second instance is the correct one.

Regards,
Enrique Perez-Terron

--- include/asm-i386/uaccess.h~	2004-08-16 14:58:44.000000000 +0200
+++ include/asm-i386/uaccess.h	2004-11-01 10:21:05.000000000 +0100
@@ -549,21 +549,6 @@
 long strncpy_from_user(char *dst, const char __user *src, long count);
 long __strncpy_from_user(char *dst, const char __user *src, long count);
 
-/**
- * strlen_user: - Get the size of a string in user space.
- * @str: The string to measure.
- *
- * Context: User context only.  This function may sleep.
- *
- * Get the size of a NUL-terminated string in user space.
- *
- * Returns the size of the string INCLUDING the terminating NUL.
- * On exception, returns 0.
- *
- * If there is a limit on the length of a valid string, you may wish to
- * consider using strnlen_user() instead.
- */
-
 long direct_strncpy_from_user(char *dst, const char *src, long count);
 long __direct_strncpy_from_user(char *dst, const char *src, long count);
 #define direct_strlen_user(str) direct_strnlen_user(str, ~0UL >> 1)
@@ -604,6 +589,21 @@
 #define get_user(val,ptr) indirect_get_user(val,ptr)
 #define __put_user(val,ptr) __indirect_put_user(val,ptr)
 #define put_user(val,ptr) indirect_put_user(val,ptr)
+/**
+ * strlen_user: - Get the size of a string in user space.
+ * @str: The string to measure.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Get the size of a NUL-terminated string in user space.
+ *
+ * Returns the size of the string INCLUDING the terminating NUL.
+ * On exception, returns 0.
+ *
+ * If there is a limit on the length of a valid string, you may wish to
+ * consider using strnlen_user() instead.
+ */
+
 #define strlen_user(str) indirect_strlen_user(str)
 #define strnlen_user(src,count) indirect_strnlen_user(src,count)
 #define strncpy_from_user(dst,src,count) \


