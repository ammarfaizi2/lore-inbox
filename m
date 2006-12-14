Return-Path: <linux-kernel-owner+w=401wt.eu-S932692AbWLNM1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbWLNM1Y (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 07:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWLNM1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 07:27:24 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:13120 "EHLO
	amsfep14-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932692AbWLNM1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 07:27:24 -0500
Subject: [PATCH] slab: fix kmem_ptr_validate prototype
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Dec 2006 13:26:40 +0100
Message-Id: <1166099200.32332.233.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some fallout of: 2e892f43ccb602e8ffad73396a1000f2040c9e0b

  CC      mm/slab.o
/usr/src/linux-2.6-git/mm/slab.c:3557: error: conflicting types for ‘kmem_ptr_validate’
/usr/src/linux-2.6-git/include/linux/slab.h:58: error: previous declaration of ‘kmem_ptr_validate’ was here


Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 include/linux/slab.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-git/include/linux/slab.h
===================================================================
--- linux-2.6-git.orig/include/linux/slab.h	2006-12-14 11:56:35.000000000 +0100
+++ linux-2.6-git/include/linux/slab.h	2006-12-14 11:56:46.000000000 +0100
@@ -55,7 +55,7 @@ void *kmem_cache_zalloc(struct kmem_cach
 void kmem_cache_free(struct kmem_cache *, void *);
 unsigned int kmem_cache_size(struct kmem_cache *);
 const char *kmem_cache_name(struct kmem_cache *);
-int kmem_ptr_validate(struct kmem_cache *cachep, const void *ptr);
+int fastcall kmem_ptr_validate(struct kmem_cache *cachep, const void *ptr);
 
 #ifdef CONFIG_NUMA
 extern void *kmem_cache_alloc_node(struct kmem_cache *, gfp_t flags, int node);


