Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263006AbVALCSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbVALCSV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 21:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbVALCSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 21:18:20 -0500
Received: from mail.renesas.com ([202.234.163.13]:36235 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S263007AbVALCQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 21:16:38 -0500
Date: Wed, 12 Jan 2005 11:16:24 +0900 (JST)
Message-Id: <20050112.111624.607085791.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-mm3] m32r: build fix
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.16 (Corporate Culture)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

csum_and_copy_from_user-gcc4-warning-fixes.patch breakes m32r's build.
It seems that checksum.h update was also required for m32r.

>From: <pluto@pld-linux.org>
>
>This patch kills tons of gcc4 warnings:
>
>pointer targets in passing argument 2 of 'csum_and_copy_from_user' differ in signedness
>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> 25-akpm/arch/ia64/lib/csum_partial_copy.c      |   11 ++++++-----
> 25-akpm/arch/m32r/lib/csum_partial_copy.c      |    7 +++----
> 25-akpm/arch/m68k/lib/checksum.c               |    6 +++---
> 25-akpm/arch/m68knommu/lib/checksum.c          |    5 +++--
> 25-akpm/arch/parisc/lib/checksum.c             |    4 ++--
> 25-akpm/arch/sh64/lib/c-checksum.c             |    8 ++++----
> 25-akpm/arch/um/include/sysdep-i386/checksum.h |   20 ++++++++++----------
> 25-akpm/arch/um/kernel/checksum.c              |   12 ++++++------
> 25-akpm/arch/v850/lib/checksum.c               |    4 ++--
> 25-akpm/arch/x86_64/lib/csum-wrappers.c        |    6 +++---
> 25-akpm/include/asm-i386/checksum.h            |   12 ++++++------
> 25-akpm/include/asm-mips/checksum.h            |   10 +++++-----
> 25-akpm/include/asm-parisc/checksum.h          |   10 ++++++----
> 25-akpm/include/asm-sh/checksum.h              |   12 ++++++------
> 25-akpm/include/asm-sparc/checksum.h           |    8 ++++----
> 25-akpm/include/asm-sparc64/checksum.h         |   12 +++++++-----
> 25-akpm/include/asm-x86_64/checksum.h          |    8 ++++----
> 25-akpm/include/net/checksum.h                 |    4 ++--
> 18 files changed, 82 insertions(+), 77 deletions(-)

Here is a patch to fix compile errors of 2.6.10-mm3 for m32r.

	* include/asm-m32r/checksum.h: build fix

	* arch/m32r/lib/csum_partial_copy.c:
	- update comment
	- cosmetic changes: change indentation

Compile tested, and boot checked.
Please apply.

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/lib/csum_partial_copy.c |   27 +++++++++++++++------------
 include/asm-m32r/checksum.h       |   10 ++++++----
 2 files changed, 21 insertions(+), 16 deletions(-)


diff -ruNp a/arch/m32r/lib/csum_partial_copy.c b/arch/m32r/lib/csum_partial_copy.c
--- a/arch/m32r/lib/csum_partial_copy.c	2005-01-11 21:08:10.000000000 +0900
+++ b/arch/m32r/lib/csum_partial_copy.c	2005-01-12 10:49:17.000000000 +0900
@@ -3,16 +3,16 @@
  *		operating system.  INET is implemented using the  BSD Socket
  *		interface as the means of communication with the user level.
  *
- *		MIPS specific IP/TCP/UDP checksumming routines
+ *		M32R specific IP/TCP/UDP checksumming routines
+ *		(Some code taken from MIPS architecture)
  *
- * Authors:	Ralf Baechle, <ralf@waldorf-gmbh.de>
- *		Lots of code moved from tcp.c and ip.c; see those files
- *		for more names.
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
- *		This program is free software; you can redistribute it and/or
- *		modify it under the terms of the GNU General Public License
- *		as published by the Free Software Foundation; either version
- *		2 of the License, or (at your option) any later version.
+ * Copyright (C) 1994, 1995  Waldorf Electronics GmbH
+ * Copyright (C) 1998, 1999  Ralf Baechle
+ * Copyright (C) 2001-2005  Hiroyuki Kondo, Hirokazu Takata
  *
  */
 
@@ -27,8 +27,9 @@
 /*
  * Copy while checksumming, otherwise like csum_partial
  */
-unsigned int csum_partial_copy_nocheck (const unsigned char *src, unsigned char *dst,
-                                        int len, unsigned int sum)
+unsigned int
+csum_partial_copy_nocheck (const unsigned char *src, unsigned char *dst,
+                           int len, unsigned int sum)
 {
 	sum = csum_partial(src, len, sum);
 	memcpy(dst, src, len);
@@ -41,8 +42,10 @@ EXPORT_SYMBOL(csum_partial_copy_nocheck)
  * Copy from userspace and compute checksum.  If we catch an exception
  * then zero the rest of the buffer.
  */
-unsigned int csum_partial_copy_from_user (const unsigned char __user *src, unsigned char *dst,
-                                          int len, unsigned int sum, int *err_ptr)
+unsigned int
+csum_partial_copy_from_user (const unsigned char __user *src,
+			     unsigned char *dst,
+			     int len, unsigned int sum, int *err_ptr)
 {
 	int missing;
 
diff -ruNp a/include/asm-m32r/checksum.h b/include/asm-m32r/checksum.h
--- a/include/asm-m32r/checksum.h	2004-12-25 06:33:50.000000000 +0900
+++ b/include/asm-m32r/checksum.h	2005-01-11 20:45:47.000000000 +0900
@@ -31,7 +31,8 @@
  *
  * it's best to have buff aligned on a 32-bit boundary
  */
-asmlinkage unsigned int csum_partial(const unsigned char *buff, int len, unsigned int sum);
+asmlinkage unsigned int csum_partial(const unsigned char *buff,
+				     int len, unsigned int sum);
 
 /*
  * The same as csum_partial, but copies from src while it checksums.
@@ -39,15 +40,16 @@ asmlinkage unsigned int csum_partial(con
  * Here even more important to align src and dst on a 32-bit (or even
  * better 64-bit) boundary
  */
-extern unsigned int csum_partial_copy_nocheck(const char *src, char *dst,
+extern unsigned int csum_partial_copy_nocheck(const unsigned char *src,
+					      unsigned char *dst,
                                               int len, unsigned int sum);
 
 /*
  * This is a new version of the above that records errors it finds in *errp,
  * but continues and zeros thre rest of the buffer.
  */
-extern unsigned int csum_partial_copy_from_user(const char __user *src,
-                                                char *dst,
+extern unsigned int csum_partial_copy_from_user(const unsigned char __user *src,
+                                                unsigned char *dst,
                                                 int len, unsigned int sum,
                                                 int *err_ptr);
 
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
