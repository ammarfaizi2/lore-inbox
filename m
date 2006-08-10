Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWHJBUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWHJBUp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWHJBUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:20:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:35465 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751408AbWHJBUl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:20:41 -0400
Subject: [PATCH 2/9] sector_t format string
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 09 Aug 2006 18:20:43 -0700
Message-Id: <1155172843.3161.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Define SECTOR_FMT to print sector_t in proper format

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
Acked-by: Andreas Dilger <adilger@clusterfs.com>


---

 linux-2.6.18-rc4-ming/include/asm-h8300/types.h   |    1 +
 linux-2.6.18-rc4-ming/include/asm-i386/types.h    |    1 +
 linux-2.6.18-rc4-ming/include/asm-mips/types.h    |    5 +++++
 linux-2.6.18-rc4-ming/include/asm-powerpc/types.h |    5 +++++
 linux-2.6.18-rc4-ming/include/asm-s390/types.h    |    5 +++++
 linux-2.6.18-rc4-ming/include/asm-sh/types.h      |    1 +
 linux-2.6.18-rc4-ming/include/asm-x86_64/types.h  |    1 +
 linux-2.6.18-rc4-ming/include/linux/types.h       |    1 +
 8 files changed, 20 insertions(+)

diff -puN include/asm-h8300/types.h~sector_fmt include/asm-h8300/types.h
--- linux-2.6.18-rc4/include/asm-h8300/types.h~sector_fmt	2006-08-09 15:41:47.912256609 -0700
+++ linux-2.6.18-rc4-ming/include/asm-h8300/types.h	2006-08-09 15:41:47.936256803 -0700
@@ -57,6 +57,7 @@ typedef u32 dma_addr_t;
 
 #define HAVE_SECTOR_T
 typedef u64 sector_t;
+#define SECTOR_FMT "%llu"
 
 #define HAVE_BLKCNT_T
 typedef u64 blkcnt_t;
diff -puN include/asm-i386/types.h~sector_fmt include/asm-i386/types.h
--- linux-2.6.18-rc4/include/asm-i386/types.h~sector_fmt	2006-08-09 15:41:47.915256633 -0700
+++ linux-2.6.18-rc4-ming/include/asm-i386/types.h	2006-08-09 15:41:47.937256811 -0700
@@ -59,6 +59,7 @@ typedef u64 dma64_addr_t;
 
 #ifdef CONFIG_LBD
 typedef u64 sector_t;
+#define SECTOR_FMT "%llu"
 #define HAVE_SECTOR_T
 #endif
 
diff -puN include/asm-mips/types.h~sector_fmt include/asm-mips/types.h
--- linux-2.6.18-rc4/include/asm-mips/types.h~sector_fmt	2006-08-09 15:41:47.918256657 -0700
+++ linux-2.6.18-rc4-ming/include/asm-mips/types.h	2006-08-09 15:41:47.938256819 -0700
@@ -95,6 +95,11 @@ typedef unsigned long phys_t;
 
 #ifdef CONFIG_LBD
 typedef u64 sector_t;
+#if (_MIPS_SZLONG == 64)
+#define SECTOR_FMT "%lu"
+#else
+#define SECTOR_FMT "%llu"
+#endif
 #define HAVE_SECTOR_T
 #endif
 
diff -puN include/asm-powerpc/types.h~sector_fmt include/asm-powerpc/types.h
--- linux-2.6.18-rc4/include/asm-powerpc/types.h~sector_fmt	2006-08-09 15:41:47.921256681 -0700
+++ linux-2.6.18-rc4-ming/include/asm-powerpc/types.h	2006-08-09 15:41:47.938256819 -0700
@@ -99,6 +99,11 @@ typedef struct {
 
 #ifdef CONFIG_LBD
 typedef u64 sector_t;
+#ifdef __powerpc64__
+#define SECTOR_FMT "%lu"
+#else
+#define SECTOR_FMT "%llu"
+#endif
 #define HAVE_SECTOR_T
 #endif
 
diff -puN include/asm-s390/types.h~sector_fmt include/asm-s390/types.h
--- linux-2.6.18-rc4/include/asm-s390/types.h~sector_fmt	2006-08-09 15:41:47.924256706 -0700
+++ linux-2.6.18-rc4-ming/include/asm-s390/types.h	2006-08-09 15:41:47.939256827 -0700
@@ -89,6 +89,11 @@ typedef union {
 
 #ifdef CONFIG_LBD
 typedef u64 sector_t;
+#ifndef __s390x__
+#define SECTOR_FMT "%llu"
+#else
+#define SECTOR_FMT "%lu"
+#endif
 #define HAVE_SECTOR_T
 #endif
 
diff -puN include/asm-sh/types.h~sector_fmt include/asm-sh/types.h
--- linux-2.6.18-rc4/include/asm-sh/types.h~sector_fmt	2006-08-09 15:41:47.927256730 -0700
+++ linux-2.6.18-rc4-ming/include/asm-sh/types.h	2006-08-09 15:41:47.939256827 -0700
@@ -54,6 +54,7 @@ typedef u32 dma_addr_t;
 
 #ifdef CONFIG_LBD
 typedef u64 sector_t;
+#define SECTOR_FMT "%llu"
 #define HAVE_SECTOR_T
 #endif
 
diff -puN include/asm-x86_64/types.h~sector_fmt include/asm-x86_64/types.h
--- linux-2.6.18-rc4/include/asm-x86_64/types.h~sector_fmt	2006-08-09 15:41:47.931256762 -0700
+++ linux-2.6.18-rc4-ming/include/asm-x86_64/types.h	2006-08-09 15:41:47.940256835 -0700
@@ -49,6 +49,7 @@ typedef u64 dma64_addr_t;
 typedef u64 dma_addr_t;
 
 typedef u64 sector_t;
+#define SECTOR_FMT "%llu"
 #define HAVE_SECTOR_T
 
 #endif /* __ASSEMBLY__ */
diff -puN include/linux/types.h~sector_fmt include/linux/types.h
--- linux-2.6.18-rc4/include/linux/types.h~sector_fmt	2006-08-09 15:41:47.934256787 -0700
+++ linux-2.6.18-rc4-ming/include/linux/types.h	2006-08-09 15:41:47.940256835 -0700
@@ -134,6 +134,7 @@ typedef		__s64		int64_t;
  */
 #ifndef HAVE_SECTOR_T
 typedef unsigned long sector_t;
+#define SECTOR_FMT "%lu"
 #endif
 
 #ifndef HAVE_BLKCNT_T

_


