Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWF0Msz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWF0Msz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWF0Msy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:48:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:20557 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932247AbWF0Msw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:48:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=W+hDyb6ZIGbW+xInHUQRiyQNr4UA6+BuQokVCjOSGIPzVhP9dvOsWm+EXAlleUXWITdZozE86d34b+4Omohn4def2e3D9ZPLVcNrPEMxCTdyEooi2L/MIVAoZ8eiWPytEx8DL9D1CZ2lnJvgVhdMp75xgHEBXpzs6vwD3S77hX8=
Message-ID: <44A12A43.3050501@innova-card.com>
Date: Tue, 27 Jun 2006 14:53:23 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Franck <vagabon.xyz@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Mel Gorman <mel@skynet.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] bootmem: remove useless __init in header file
References: <449FDD02.2090307@innova-card.com> <1151344691.10877.44.camel@localhost.localdomain>
In-Reply-To: <1151344691.10877.44.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__init in headers is pretty useless because the compiler doesn't check it,
and they get out of sync relatively frequently.  So if you see an __init
in a header file, it's quite unreliable and you need to check the
definition anyway.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 include/linux/bootmem.h |   52 ++++++++++++++++++++++++-----------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index da2d107..1dee668 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -41,23 +41,23 @@ typedef struct bootmem_data {
 	struct list_head list;
 } bootmem_data_t;
 
-extern unsigned long __init bootmem_bootmap_pages (unsigned long);
-extern unsigned long __init init_bootmem (unsigned long addr, unsigned long memend);
-extern void __init free_bootmem (unsigned long addr, unsigned long size);
-extern void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal);
-extern void * __init __alloc_bootmem_nopanic (unsigned long size, unsigned long align, unsigned long goal);
-extern void * __init __alloc_bootmem_low(unsigned long size,
+extern unsigned long bootmem_bootmap_pages (unsigned long);
+extern unsigned long init_bootmem (unsigned long addr, unsigned long memend);
+extern void free_bootmem (unsigned long addr, unsigned long size);
+extern void * __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal);
+extern void * __alloc_bootmem_nopanic (unsigned long size, unsigned long align, unsigned long goal);
+extern void * __alloc_bootmem_low(unsigned long size,
 					 unsigned long align,
 					 unsigned long goal);
-extern void * __init __alloc_bootmem_low_node(pg_data_t *pgdat,
+extern void * __alloc_bootmem_low_node(pg_data_t *pgdat,
 					      unsigned long size,
 					      unsigned long align,
 					      unsigned long goal);
-extern void * __init __alloc_bootmem_core(struct bootmem_data *bdata,
+extern void * __alloc_bootmem_core(struct bootmem_data *bdata,
 		unsigned long size, unsigned long align, unsigned long goal,
 		unsigned long limit);
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
-extern void __init reserve_bootmem (unsigned long addr, unsigned long size);
+extern void reserve_bootmem (unsigned long addr, unsigned long size);
 #define alloc_bootmem(x) \
 	__alloc_bootmem((x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low(x) \
@@ -67,12 +67,12 @@ #define alloc_bootmem_pages(x) \
 #define alloc_bootmem_low_pages(x) \
 	__alloc_bootmem_low((x), PAGE_SIZE, 0)
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
-extern unsigned long __init free_all_bootmem (void);
-extern void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
-extern unsigned long __init init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn);
-extern void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size);
-extern void __init free_bootmem_node (pg_data_t *pgdat, unsigned long addr, unsigned long size);
-extern unsigned long __init free_all_bootmem_node (pg_data_t *pgdat);
+extern unsigned long free_all_bootmem (void);
+extern void * __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
+extern unsigned long init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn);
+extern void reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size);
+extern void free_bootmem_node (pg_data_t *pgdat, unsigned long addr, unsigned long size);
+extern unsigned long free_all_bootmem_node (pg_data_t *pgdat);
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 #define alloc_bootmem_node(pgdat, x) \
 	__alloc_bootmem_node((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
@@ -91,17 +91,17 @@ static inline void *alloc_remap(int nid,
 }
 #endif
 
-extern unsigned long __initdata nr_kernel_pages;
-extern unsigned long __initdata nr_all_pages;
+extern unsigned long nr_kernel_pages;
+extern unsigned long nr_all_pages;
 
-extern void *__init alloc_large_system_hash(const char *tablename,
-					    unsigned long bucketsize,
-					    unsigned long numentries,
-					    int scale,
-					    int flags,
-					    unsigned int *_hash_shift,
-					    unsigned int *_hash_mask,
-					    unsigned long limit);
+extern void * alloc_large_system_hash(const char *tablename,
+				      unsigned long bucketsize,
+				      unsigned long numentries,
+				      int scale,
+				      int flags,
+				      unsigned int *_hash_shift,
+				      unsigned int *_hash_mask,
+				      unsigned long limit);
 
 #define HASH_HIGHMEM	0x00000001	/* Consider highmem? */
 #define HASH_EARLY	0x00000002	/* Allocating during early boot? */
@@ -114,7 +114,7 @@ #define HASHDIST_DEFAULT 1
 #else
 #define HASHDIST_DEFAULT 0
 #endif
-extern int __initdata hashdist;		/* Distribute hashes across NUMA nodes? */
+extern int hashdist;		/* Distribute hashes across NUMA nodes? */
 
 
 #endif /* _LINUX_BOOTMEM_H */
-- 
1.4.0.g64e8

