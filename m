Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUE0Mwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUE0Mwb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 08:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUE0Mwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 08:52:31 -0400
Received: from pxy3allmi.all.mi.charter.com ([24.247.15.42]:22419 "EHLO
	proxy3-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S263626AbUE0Mw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 08:52:29 -0400
Message-ID: <40B5E4A9.70406@quark.didntduck.org>
Date: Thu, 27 May 2004 08:52:57 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] use SLAB_PANIC for general caches
Content-Type: multipart/mixed;
 boundary="------------000501000108040907010504"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000501000108040907010504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Initialize the general caches using SLAB_PANIC instead of BUG().

--
				Brian Gerst

--------------000501000108040907010504
Content-Type: text/plain;
 name="gen_cache_panic-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gen_cache_panic-1"

diff -urN linux-2.6.7-rc1-bk/mm/slab.c linux/mm/slab.c
--- linux-2.6.7-rc1-bk/mm/slab.c	2004-05-23 18:41:51.000000000 -0400
+++ linux/mm/slab.c	2004-05-27 08:49:05.444639592 -0400
@@ -754,11 +754,9 @@
 		 * eliminates "false sharing".
 		 * Note for systems short on memory removing the alignment will
 		 * allow tighter packing of the smaller caches. */
-		sizes->cs_cachep = kmem_cache_create(
-			names->name, sizes->cs_size,
-			ARCH_KMALLOC_MINALIGN, 0, NULL, NULL);
-		if (!sizes->cs_cachep)
-			BUG();
+		sizes->cs_cachep = kmem_cache_create(names->name,
+			sizes->cs_size, ARCH_KMALLOC_MINALIGN,
+			SLAB_PANIC, NULL, NULL);
 
 		/* Inc off-slab bufctl limit until the ceiling is hit. */
 		if (!(OFF_SLAB(sizes->cs_cachep))) {
@@ -766,11 +764,9 @@
 			offslab_limit /= sizeof(kmem_bufctl_t);
 		}
 
-		sizes->cs_dmacachep = kmem_cache_create(
-			names->name_dma, sizes->cs_size,
-			ARCH_KMALLOC_MINALIGN, SLAB_CACHE_DMA, NULL, NULL);
-		if (!sizes->cs_dmacachep)
-			BUG();
+		sizes->cs_dmacachep = kmem_cache_create(names->name_dma,
+			sizes->cs_size, ARCH_KMALLOC_MINALIGN,
+			(SLAB_CACHE_DMA | SLAB_PANIC), NULL, NULL);
 
 		sizes++;
 		names++;

--------------000501000108040907010504--
