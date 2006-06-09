Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbWFIBWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWFIBWd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 21:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWFIBWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 21:22:32 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:54412 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965082AbWFIBWL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 21:22:11 -0400
Subject: [RFC 5/13] extents and 48bit ext3: sector_t type format string
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 08 Jun 2006 18:22:09 -0700
Message-Id: <1149816130.4066.67.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Define SECTOR_FMT to print sector_t in proper format

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
Acked-by: Andreas Dilger <adilger@clusterfs.com>


---

 linux-2.6.16-ming/include/asm-h8300/types.h   |    1 +
 linux-2.6.16-ming/include/asm-i386/types.h    |    1 +
 linux-2.6.16-ming/include/asm-mips/types.h    |    5 +++++
 linux-2.6.16-ming/include/asm-powerpc/types.h |    5 +++++
 linux-2.6.16-ming/include/asm-s390/types.h    |    5 +++++
 linux-2.6.16-ming/include/asm-sh/types.h      |    1 +
 linux-2.6.16-ming/include/asm-x86_64/types.h  |    1 +
 linux-2.6.16-ming/include/linux/types.h       |    1 +
 8 files changed, 20 insertions(+)

diff -puN include/asm-h8300/types.h~sector_fmt include/asm-h8300/types.h
--- linux-2.6.16/include/asm-h8300/types.h~sector_fmt	2006-06-07 15:43:40.000000000 -0700
+++ linux-2.6.16-ming/include/asm-h8300/types.h	2006-06-07 15:43:40.000000000 -0700
@@ -57,6 +57,7 @@ typedef u32 dma_addr_t;
 
 #define HAVE_SECTOR_T
 typedef u64 sector_t;
+#define SECTOR_FMT "%llu"
 
 #define HAVE_BLKCNT_T
 typedef u64 blkcnt_t;
diff -puN include/asm-i386/types.h~sector_fmt include/asm-i386/types.h
--- linux-2.6.16/include/asm-i386/types.h~sector_fmt	2006-06-07 15:43:40.000000000 -0700
+++ linux-2.6.16-ming/include/asm-i386/types.h	2006-06-07 15:43:40.000000000 -0700
@@ -60,6 +60,7 @@ typedef u64 dma64_addr_t;
 
 #ifdef CONFIG_LBD
 typedef u64 sector_t;
+#define SECTOR_FMT "%llu"
 #define HAVE_SECTOR_T
 #endif
 
diff -puN include/asm-mips/types.h~sector_fmt include/asm-mips/types.h
--- linux-2.6.16/include/asm-mips/types.h~sector_fmt	2006-06-07 15:43:40.000000000 -0700
+++ linux-2.6.16-ming/include/asm-mips/types.h	2006-06-07 15:43:40.000000000 -0700
@@ -96,6 +96,11 @@ typedef unsigned long phys_t;
 
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
--- linux-2.6.16/include/asm-powerpc/types.h~sector_fmt	2006-06-07 15:43:40.000000000 -0700
+++ linux-2.6.16-ming/include/asm-powerpc/types.h	2006-06-07 15:43:40.000000000 -0700
@@ -100,6 +100,11 @@ typedef struct {
 
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
--- linux-2.6.16/include/asm-s390/types.h~sector_fmt	2006-06-07 15:43:40.000000000 -0700
+++ linux-2.6.16-ming/include/asm-s390/types.h	2006-06-07 15:43:40.000000000 -0700
@@ -90,6 +90,11 @@ typedef union {
 
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
--- linux-2.6.16/include/asm-sh/types.h~sector_fmt	2006-06-07 15:43:40.000000000 -0700
+++ linux-2.6.16-ming/include/asm-sh/types.h	2006-06-07 15:43:40.000000000 -0700
@@ -55,6 +55,7 @@ typedef u32 dma_addr_t;
 
 #ifdef CONFIG_LBD
 typedef u64 sector_t;
+#define SECTOR_FMT "%llu"
 #define HAVE_SECTOR_T
 #endif
 
diff -puN include/asm-x86_64/types.h~sector_fmt include/asm-x86_64/types.h
--- linux-2.6.16/include/asm-x86_64/types.h~sector_fmt	2006-06-07 15:43:40.000000000 -0700
+++ linux-2.6.16-ming/include/asm-x86_64/types.h	2006-06-07 15:43:40.000000000 -0700
@@ -49,6 +49,7 @@ typedef u64 dma64_addr_t;
 typedef u64 dma_addr_t;
 
 typedef u64 sector_t;
+#define SECTOR_FMT "%llu"
 #define HAVE_SECTOR_T
 
 #endif /* __ASSEMBLY__ */
diff -puN include/linux/types.h~sector_fmt include/linux/types.h
--- linux-2.6.16/include/linux/types.h~sector_fmt	2006-06-07 15:43:40.000000000 -0700
+++ linux-2.6.16-ming/include/linux/types.h	2006-06-07 15:43:40.000000000 -0700
@@ -135,6 +135,7 @@ typedef		__s64		int64_t;
  */
 #ifndef HAVE_SECTOR_T
 typedef unsigned long sector_t;
+#define SECTOR_FMT "%lu"
 #endif
 
 #ifndef HAVE_BLKCNT_T

_


