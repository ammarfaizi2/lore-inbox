Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbUKNB1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbUKNB1w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 20:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbUKNB1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 20:27:52 -0500
Received: from hera.cwi.nl ([192.16.191.8]:38111 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261228AbUKNB1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 20:27:50 -0500
Date: Sun, 14 Nov 2004 02:27:46 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __init in mm/slab.c
Message-ID: <20041114012744.GA10116@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below removes an __initdata
(for initarray_generic that is referenced in non-init code).

diff -uprN -X /linux/dontdiff a/include/linux/slab.h b/include/linux/slab.h
--- a/include/linux/slab.h	2004-10-30 21:44:07.000000000 +0200
+++ b/include/linux/slab.h	2004-11-13 22:40:51.000000000 +0100
@@ -13,6 +13,7 @@ typedef struct kmem_cache_s kmem_cache_t
 
 #include	<linux/config.h>	/* kmalloc_sizes.h needs CONFIG_ options */
 #include	<linux/gfp.h>
+#include	<linux/init.h>
 #include	<linux/types.h>
 #include	<asm/page.h>		/* kmalloc_sizes.h needs PAGE_SIZE */
 #include	<asm/cache.h>		/* kmalloc_sizes.h needs L1_CACHE_BYTES */
@@ -53,7 +54,7 @@ typedef struct kmem_cache_s kmem_cache_t
 #define	SLAB_CTOR_VERIFY	0x004UL		/* tell constructor it's a verify call */
 
 /* prototypes */
-extern void kmem_cache_init(void);
+extern void __init kmem_cache_init(void);
 
 extern kmem_cache_t *kmem_cache_create(const char *, size_t, size_t, unsigned long,
 				       void (*)(void *, kmem_cache_t *, unsigned long),
diff -uprN -X /linux/dontdiff a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c	2004-10-30 21:44:09.000000000 +0200
+++ b/mm/slab.c	2004-11-13 22:40:51.000000000 +0100
@@ -506,7 +506,7 @@ static struct cache_names __initdata cac
 
 static struct arraycache_init initarray_cache __initdata =
 	{ { 0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
-static struct arraycache_init initarray_generic __initdata =
+static struct arraycache_init initarray_generic =
 	{ { 0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
 
 /* internal cache of cache description objs */
