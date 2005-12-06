Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbVLFABE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbVLFABE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbVLFABD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:01:03 -0500
Received: from serv01.siteground.net ([70.85.91.68]:8408 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751498AbVLFABB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:01:01 -0500
Date: Mon, 5 Dec 2005 16:00:53 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 2/2] Kill L1_CACHE_SHIFT_MAX
Message-ID: <20051206000053.GB3788@localhost.localdomain>
References: <20051205235926.GA3788@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205235926.GA3788@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to kill L1_CACHE_SHIFT from all arches.
Since L1_CACHE_SHIFT_MAX is not used anymore with the  introduction
of INTERNODE_CACHE, kill L1_CACHE_SHIFT_MAX.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>
Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux-2.6.15-rc4/include/asm-alpha/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-alpha/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-alpha/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -20,6 +20,5 @@
 
 #define L1_CACHE_ALIGN(x)  (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
 #define SMP_CACHE_BYTES    L1_CACHE_BYTES
-#define L1_CACHE_SHIFT_MAX L1_CACHE_SHIFT
 
 #endif
Index: linux-2.6.15-rc4/include/asm-arm/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-arm/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-arm/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -7,9 +7,4 @@
 #define L1_CACHE_SHIFT		5
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
-/*
- * largest L1 which this arch supports
- */
-#define L1_CACHE_SHIFT_MAX	5
-
 #endif
Index: linux-2.6.15-rc4/include/asm-cris/arch-v10/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-cris/arch-v10/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-cris/arch-v10/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -4,6 +4,5 @@
 /* Etrax 100LX have 32-byte cache-lines. */
 #define L1_CACHE_BYTES 32
 #define L1_CACHE_SHIFT 5
-#define L1_CACHE_SHIFT_MAX 5
 
 #endif /* _ASM_ARCH_CACHE_H */
Index: linux-2.6.15-rc4/include/asm-cris/arch-v32/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-cris/arch-v32/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-cris/arch-v32/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -4,6 +4,5 @@
 /* A cache-line is 32 bytes. */
 #define L1_CACHE_BYTES 32
 #define L1_CACHE_SHIFT 5
-#define L1_CACHE_SHIFT_MAX 5
 
 #endif /* _ASM_CRIS_ARCH_CACHE_H */
Index: linux-2.6.15-rc4/include/asm-cris/dma-mapping.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-cris/dma-mapping.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-cris/dma-mapping.h	2005-12-02 16:59:35.000000000 -0800
@@ -153,7 +153,7 @@
 static inline int
 dma_get_cache_alignment(void)
 {
-	return (1 << L1_CACHE_SHIFT_MAX);
+	return (1 << INTERNODE_CACHE_SHIFT);
 }
 
 #define dma_is_consistent(d)	(1)
Index: linux-2.6.15-rc4/include/asm-generic/dma-mapping.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-generic/dma-mapping.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-generic/dma-mapping.h	2005-12-02 16:59:35.000000000 -0800
@@ -274,7 +274,7 @@
 {
 	/* no easy way to get cache size on all processors, so return
 	 * the maximum possible, to be safe */
-	return (1 << L1_CACHE_SHIFT_MAX);
+	return (1 << INTERNODE_CACHE_SHIFT);
 }
 
 static inline void
Index: linux-2.6.15-rc4/include/asm-i386/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-i386/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-i386/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -10,6 +10,4 @@
 #define L1_CACHE_SHIFT	(CONFIG_X86_L1_CACHE_SHIFT)
 #define L1_CACHE_BYTES	(1 << L1_CACHE_SHIFT)
 
-#define L1_CACHE_SHIFT_MAX 7	/* largest L1 which this arch supports */
-
 #endif
Index: linux-2.6.15-rc4/include/asm-ia64/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-ia64/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-ia64/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -12,8 +12,6 @@
 #define L1_CACHE_SHIFT		CONFIG_IA64_L1_CACHE_SHIFT
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
-#define L1_CACHE_SHIFT_MAX 7	/* largest L1 which this arch supports */
-
 #ifdef CONFIG_SMP
 # define SMP_CACHE_SHIFT	L1_CACHE_SHIFT
 # define SMP_CACHE_BYTES	L1_CACHE_BYTES
Index: linux-2.6.15-rc4/include/asm-m32r/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-m32r/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-m32r/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -7,6 +7,4 @@
 #define L1_CACHE_SHIFT		4
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
-#define L1_CACHE_SHIFT_MAX	4
-
 #endif  /* _ASM_M32R_CACHE_H */
Index: linux-2.6.15-rc4/include/asm-m68k/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-m68k/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-m68k/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -8,6 +8,4 @@
 #define        L1_CACHE_SHIFT  4
 #define        L1_CACHE_BYTES  (1<< L1_CACHE_SHIFT)
 
-#define L1_CACHE_SHIFT_MAX 4	/* largest L1 which this arch supports */
-
 #endif
Index: linux-2.6.15-rc4/include/asm-mips/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-mips/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-mips/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -15,7 +15,6 @@
 #define L1_CACHE_SHIFT		CONFIG_MIPS_L1_CACHE_SHIFT
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
-#define L1_CACHE_SHIFT_MAX	6
 #define SMP_CACHE_SHIFT		L1_CACHE_SHIFT
 #define SMP_CACHE_BYTES		L1_CACHE_BYTES
 
Index: linux-2.6.15-rc4/include/asm-parisc/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-parisc/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-parisc/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -28,7 +28,6 @@
 #define L1_CACHE_ALIGN(x)       (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
 
 #define SMP_CACHE_BYTES L1_CACHE_BYTES
-#define L1_CACHE_SHIFT_MAX 5	/* largest L1 which this arch supports */
 
 extern void flush_data_cache_local(void);  /* flushes local data-cache only */
 extern void flush_instruction_cache_local(void); /* flushes local code-cache only */
Index: linux-2.6.15-rc4/include/asm-powerpc/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-powerpc/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-powerpc/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -19,7 +19,6 @@
 #define	L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
 #define	SMP_CACHE_BYTES		L1_CACHE_BYTES
-#define L1_CACHE_SHIFT_MAX	7 /* largest L1 which this arch supports */
 
 #if defined(__powerpc64__) && !defined(__ASSEMBLY__)
 struct ppc64_caches {
Index: linux-2.6.15-rc4/include/asm-s390/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-s390/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-s390/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -13,7 +13,6 @@
 
 #define L1_CACHE_BYTES     256
 #define L1_CACHE_SHIFT     8
-#define L1_CACHE_SHIFT_MAX 8	/* largest L1 which this arch supports */
 
 #define ARCH_KMALLOC_MINALIGN	8
 
Index: linux-2.6.15-rc4/include/asm-sh/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-sh/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-sh/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -22,8 +22,6 @@
 
 #define L1_CACHE_ALIGN(x)	(((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
 
-#define L1_CACHE_SHIFT_MAX 	5	/* largest L1 which this arch supports */
-
 struct cache_info {
 	unsigned int ways;
 	unsigned int sets;
Index: linux-2.6.15-rc4/include/asm-sh64/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-sh64/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-sh64/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -20,8 +20,6 @@
 #define L1_CACHE_ALIGN_MASK	(~(L1_CACHE_BYTES - 1))
 #define L1_CACHE_ALIGN(x)	(((x)+(L1_CACHE_BYTES - 1)) & L1_CACHE_ALIGN_MASK)
 #define L1_CACHE_SIZE_BYTES	(L1_CACHE_BYTES << 10)
-/* Largest L1 which this arch supports */
-#define L1_CACHE_SHIFT_MAX	5
 
 #ifdef MODULE
 #define __cacheline_aligned __attribute__((__aligned__(L1_CACHE_BYTES)))
Index: linux-2.6.15-rc4/include/asm-sparc/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-sparc/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-sparc/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -13,7 +13,6 @@
 #define L1_CACHE_SHIFT 5
 #define L1_CACHE_BYTES 32
 #define L1_CACHE_ALIGN(x) ((((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1)))
-#define L1_CACHE_SHIFT_MAX 5	/* largest L1 which this arch supports */
 
 #define SMP_CACHE_BYTES 32
 
Index: linux-2.6.15-rc4/include/asm-sparc64/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-sparc64/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-sparc64/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -9,7 +9,6 @@
 #define        L1_CACHE_BYTES	32 /* Two 16-byte sub-blocks per line. */
 
 #define        L1_CACHE_ALIGN(x)       (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
-#define		L1_CACHE_SHIFT_MAX 5	/* largest L1 which this arch supports */
 
 #define        SMP_CACHE_BYTES_SHIFT	6
 #define        SMP_CACHE_BYTES		(1 << SMP_CACHE_BYTES_SHIFT) /* L2 cache line size. */
Index: linux-2.6.15-rc4/include/asm-um/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-um/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-um/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -13,9 +13,6 @@
 # define L1_CACHE_SHIFT		5
 #endif
 
-/* XXX: this is valid for x86 and x86_64. */
-#define L1_CACHE_SHIFT_MAX	7	/* largest L1 which this arch supports */
-
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
 #endif
Index: linux-2.6.15-rc4/include/asm-v850/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-v850/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-v850/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -23,6 +23,4 @@
 #define L1_CACHE_SHIFT		4
 #endif
 
-#define L1_CACHE_SHIFT_MAX	L1_CACHE_SHIFT
-
 #endif /* __V850_CACHE_H__ */
Index: linux-2.6.15-rc4/include/asm-x86_64/cache.h
===================================================================
--- linux-2.6.15-rc4.orig/include/asm-x86_64/cache.h	2005-12-02 16:58:05.000000000 -0800
+++ linux-2.6.15-rc4/include/asm-x86_64/cache.h	2005-12-02 16:59:35.000000000 -0800
@@ -9,6 +9,5 @@
 /* L1 cache line size */
 #define L1_CACHE_SHIFT	(CONFIG_X86_L1_CACHE_SHIFT)
 #define L1_CACHE_BYTES	(1 << L1_CACHE_SHIFT)
-#define L1_CACHE_SHIFT_MAX 7	/* largest L1 which this arch supports */
 
 #endif
