Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWF3AXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWF3AXL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933160AbWF3ARN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:17:13 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:39847 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S933119AbWF3ARI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:17:08 -0400
Subject: [RFC][Update][Patch 2/16]sector_t type format string
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 29 Jun 2006 17:17:06 -0700
Message-Id: <1151626626.6601.68.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define SECTOR_FMT to print sector_t in proper format

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
Acked-by: Andreas Dilger <adilger@clusterfs.com>


---

 linux-2.6.17-ming/include/asm-h8300/types.h   |    1 +
 linux-2.6.17-ming/include/asm-i386/types.h    |    1 +
 linux-2.6.17-ming/include/asm-mips/types.h    |    5 +++++
 linux-2.6.17-ming/include/asm-powerpc/types.h |    5 +++++
 linux-2.6.17-ming/include/asm-s390/types.h    |    5 +++++
 linux-2.6.17-ming/include/asm-sh/types.h      |    1 +
 linux-2.6.17-ming/include/asm-x86_64/types.h  |    1 +
 linux-2.6.17-ming/include/linux/types.h       |    1 +
 8 files changed, 20 insertions(+)

diff -puN include/asm-h8300/types.h~sector_fmt include/asm-h8300/types.h
--- linux-2.6.17/include/asm-h8300/types.h~sector_fmt	2006-06-28 16:46:28.523183099 -0700
+++ linux-2.6.17-ming/include/asm-h8300/types.h	2006-06-28 16:46:28.552179772 -0700
@@ -57,6 +57,7 @@ typedef u32 dma_addr_t;
 
 #define HAVE_SECTOR_T
 typedef u64 sector_t;
+#define SECTOR_FMT "%llu"
 
 #define HAVE_BLKCNT_T
 typedef u64 blkcnt_t;
diff -puN include/asm-i386/types.h~sector_fmt include/asm-i386/types.h
--- linux-2.6.17/include/asm-i386/types.h~sector_fmt	2006-06-28 16:46:28.526182755 -0700
+++ linux-2.6.17-ming/include/asm-i386/types.h	2006-06-28 16:46:28.553179658 -0700
@@ -59,6 +59,7 @@ typedef u64 dma64_addr_t;
 
 #ifdef CONFIG_LBD
 typedef u64 sector_t;
+#define SECTOR_FMT "%llu"
 #define HAVE_SECTOR_T
 #endif
 
diff -puN include/asm-mips/types.h~sector_fmt include/asm-mips/types.h
--- linux-2.6.17/include/asm-mips/types.h~sector_fmt	2006-06-28 16:46:28.530182296 -0700
+++ linux-2.6.17-ming/include/asm-mips/types.h	2006-06-28 16:46:28.554179543 -0700
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
--- linux-2.6.17/include/asm-powerpc/types.h~sector_fmt	2006-06-28 16:46:28.534181837 -0700
+++ linux-2.6.17-ming/include/asm-powerpc/types.h	2006-06-28 16:46:28.554179543 -0700
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
--- linux-2.6.17/include/asm-s390/types.h~sector_fmt	2006-06-28 16:46:28.537181493 -0700
+++ linux-2.6.17-ming/include/asm-s390/types.h	2006-06-28 16:46:28.555179428 -0700
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
--- linux-2.6.17/include/asm-sh/types.h~sector_fmt	2006-06-28 16:46:28.540181149 -0700
+++ linux-2.6.17-ming/include/asm-sh/types.h	2006-06-28 16:46:28.555179428 -0700
@@ -54,6 +54,7 @@ typedef u32 dma_addr_t;
 
 #ifdef CONFIG_LBD
 typedef u64 sector_t;
+#define SECTOR_FMT "%llu"
 #define HAVE_SECTOR_T
 #endif
 
diff -puN include/asm-x86_64/types.h~sector_fmt include/asm-x86_64/types.h
--- linux-2.6.17/include/asm-x86_64/types.h~sector_fmt	2006-06-28 16:46:28.543180805 -0700
+++ linux-2.6.17-ming/include/asm-x86_64/types.h	2006-06-28 16:46:28.556179313 -0700
@@ -49,6 +49,7 @@ typedef u64 dma64_addr_t;
 typedef u64 dma_addr_t;
 
 typedef u64 sector_t;
+#define SECTOR_FMT "%llu"
 #define HAVE_SECTOR_T
 
 #endif /* __ASSEMBLY__ */
diff -puN include/linux/types.h~sector_fmt include/linux/types.h
--- linux-2.6.17/include/linux/types.h~sector_fmt	2006-06-28 16:46:28.549180116 -0700
+++ linux-2.6.17-ming/include/linux/types.h	2006-06-28 16:46:28.557179199 -0700
@@ -134,6 +134,7 @@ typedef		__s64		int64_t;
  */
 #ifndef HAVE_SECTOR_T
 typedef unsigned long sector_t;
+#define SECTOR_FMT "%lu"
 #endif
 
 #ifndef HAVE_BLKCNT_T

_


