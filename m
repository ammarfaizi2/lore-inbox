Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030180AbVKRR0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbVKRR0D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVKRR0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:26:02 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:20431 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932332AbVKRR0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:26:00 -0500
Subject: [PATCH 1/5] slab: rename obj_reallen to obj_size
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, colpatch@us.ibm.com,
       manfred@colorfullife.com
Content-Type: text/plain
Message-Id: <iq5uu1.87bo1s.3tcvszwr6pjjr4ngr04pw358p.beaver@cs.helsinki.fi>
Date: Fri, 18 Nov 2005 19:20:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch renames the obj_reallen() function to obj_size() which makes the
code more readable.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 slab.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -508,7 +508,7 @@ static int obj_dbghead(kmem_cache_t *cac
 	return cachep->dbghead;
 }
 
-static int obj_reallen(kmem_cache_t *cachep)
+static int obj_size(kmem_cache_t *cachep)
 {
 	return cachep->reallen;
 }
@@ -536,7 +536,12 @@ static void **dbg_userword(kmem_cache_t 
 #else
 
 #define obj_dbghead(x)			0
-#define obj_reallen(cachep)		(cachep->objsize)
+
+static int obj_size(kmem_cache_t *cachep)
+{
+	return cachep->objsize;
+}
+
 #define dbg_redzone1(cachep, objp)	({BUG(); (unsigned long *)NULL;})
 #define dbg_redzone2(cachep, objp)	({BUG(); (unsigned long *)NULL;})
 #define dbg_userword(cachep, objp)	({BUG(); (void **)NULL;})
@@ -1259,7 +1264,7 @@ static void kmem_rcu_free(struct rcu_hea
 static void store_stackinfo(kmem_cache_t *cachep, unsigned long *addr,
 				unsigned long caller)
 {
-	int size = obj_reallen(cachep);
+	int size = obj_size(cachep);
 
 	addr = (unsigned long *)&((char*)addr)[obj_dbghead(cachep)];
 
@@ -1291,7 +1296,7 @@ static void store_stackinfo(kmem_cache_t
 
 static void poison_obj(kmem_cache_t *cachep, void *addr, unsigned char val)
 {
-	int size = obj_reallen(cachep);
+	int size = obj_size(cachep);
 	addr = &((char*)addr)[obj_dbghead(cachep)];
 
 	memset(addr, val, size);
@@ -1330,7 +1335,7 @@ static void print_objinfo(kmem_cache_t *
 		printk("\n");
 	}
 	realobj = (char*)objp+obj_dbghead(cachep);
-	size = obj_reallen(cachep);
+	size = obj_size(cachep);
 	for (i=0; i<size && lines;i+=16, lines--) {
 		int limit;
 		limit = 16;
@@ -1347,7 +1352,7 @@ static void check_poison_obj(kmem_cache_
 	int lines = 0;
 
 	realobj = (char*)objp+obj_dbghead(cachep);
-	size = obj_reallen(cachep);
+	size = obj_size(cachep);
 
 	for (i=0;i<size;i++) {
 		char exp = POISON_FREE;
@@ -3069,7 +3074,7 @@ EXPORT_SYMBOL(free_percpu);
 
 unsigned int kmem_cache_size(kmem_cache_t *cachep)
 {
-	return obj_reallen(cachep);
+	return obj_size(cachep);
 }
 EXPORT_SYMBOL(kmem_cache_size);
 
@@ -3607,7 +3612,7 @@ unsigned int ksize(const void *objp)
 	if (unlikely(objp == NULL))
 		return 0;
 
-	return obj_reallen(page_get_cache(virt_to_page(objp)));
+	return obj_size(page_get_cache(virt_to_page(objp)));
 }
 
 
