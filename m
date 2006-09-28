Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWI1RYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWI1RYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWI1RYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:24:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:21186 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751310AbWI1RYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:24:15 -0400
Date: Thu, 28 Sep 2006 12:24:07 -0500
From: Dean Nelson <dcn@sgi.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, holt@sgi.com, swise@opengridcomputing.com,
       jes@trained-monkey.org, avolkov@varma-el.com, dcn@sgi.com
Subject: [PATCH] make genpool allocator adhere to kernel-doc standards
Message-ID: <20060928172407.GA13807@sgi.com>
References: <20060927153545.28235.76214.stgit@dell3.ogc.int> <20060927085123.99749d2c.rdunlap@xenotime.net> <1159372405.10663.13.camel@stevo-desktop> <20060927085608.7f753439.rdunlap@xenotime.net> <20060927195929.GB3283@sgi.com> <20060927132728.d01ee9fb.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927132728.d01ee9fb.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The exported kernel interfaces of genpool allocator need to adhere to
the requirements of kernel-doc.

Signed-off-by: Dean Nelson <dcn@sgi.com>

---

On Wed, Sep 27, 2006 at 01:27:28PM -0700, Randy Dunlap wrote:
> On Wed, 27 Sep 2006 14:59:29 -0500 Dean Nelson wrote:
> > 
> > Sorry Randy, this was my mistake. I didn't know about kernel-doc.
> > I'll put together a patch tommorrow, if that would be alright?
> > I don't have the time today.
> 
> Sure, no problem.  Thanks for doing that.
> I'll review it when you post it.

Thanks for reviewing this. If you do not have any issues with
this patch, would you mind sending it on to Linus?

This patch is dependent on another patch to be applied first, the
patch with a subject line of: '[PATCH] add gen_pool_destroy()'.
(Its most recent version.)

Thanks,
Dean


 genalloc.c |   39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)


Index: linux-2.6/lib/genalloc.c
===================================================================
--- linux-2.6.orig/lib/genalloc.c	2006-09-28 10:54:41.330794389 -0500
+++ linux-2.6/lib/genalloc.c	2006-09-28 11:02:54.327472348 -0500
@@ -14,11 +14,13 @@
 #include <linux/genalloc.h>
 
 
-/*
- * Create a new special memory pool.
- *
+/**
+ * gen_pool_create - create a new special memory pool
  * @min_alloc_order: log base 2 of number of bytes each bitmap bit represents
  * @nid: node id of the node the pool structure should be allocated on, or -1
+ *
+ * Create a new special memory pool that can be used to manage special purpose
+ * memory not managed by the regular kmalloc/kfree interface.
  */
 struct gen_pool *gen_pool_create(int min_alloc_order, int nid)
 {
@@ -35,14 +37,15 @@
 EXPORT_SYMBOL(gen_pool_create);
 
 
-/*
- * Add a new chunk of memory to the specified pool.
- *
+/**
+ * gen_pool_add - add a new chunk of special memory to the pool
  * @pool: pool to add new memory chunk to
  * @addr: starting address of memory chunk to add to pool
  * @size: size in bytes of the memory chunk to add to pool
  * @nid: node id of the node the chunk structure and bitmap should be
  *       allocated on, or -1
+ *
+ * Add a new chunk of special memory to the specified pool.
  */
 int gen_pool_add(struct gen_pool *pool, unsigned long addr, size_t size,
 		 int nid)
@@ -70,10 +73,12 @@
 EXPORT_SYMBOL(gen_pool_add);
 
 
-/*
- * Destroy a memory pool. Verifies that there are no outstanding allocations.
- *
+/**
+ * gen_pool_destroy - destroy a special memory pool
  * @pool: pool to destroy
+ *
+ * Destroy the specified special memory pool. Verifies that there are no
+ * outstanding allocations.
  */
 void gen_pool_destroy(struct gen_pool *pool)
 {
@@ -100,12 +105,13 @@
 EXPORT_SYMBOL(gen_pool_destroy);
 
 
-/*
- * Allocate the requested number of bytes from the specified pool.
- * Uses a first-fit algorithm.
- *
+/**
+ * gen_pool_alloc - allocate special memory from the pool
  * @pool: pool to allocate from
  * @size: number of bytes to allocate from the pool
+ *
+ * Allocate the requested number of bytes from the specified pool.
+ * Uses a first-fit algorithm.
  */
 unsigned long gen_pool_alloc(struct gen_pool *pool, size_t size)
 {
@@ -158,12 +164,13 @@
 EXPORT_SYMBOL(gen_pool_alloc);
 
 
-/*
- * Free the specified memory back to the specified pool.
- *
+/**
+ * gen_pool_free - free allocated special memory back to the pool
  * @pool: pool to free to
  * @addr: starting address of memory to free back to pool
  * @size: size in bytes of memory to free
+ *
+ * Free previously allocated special memory back to the specified pool.
  */
 void gen_pool_free(struct gen_pool *pool, unsigned long addr, size_t size)
 {
