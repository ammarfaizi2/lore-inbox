Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVIWWoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVIWWoa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 18:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbVIWWo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 18:44:29 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:59879 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751331AbVIWWo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 18:44:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DBoTdVI8YHRYH32y0+EN2ecbnyQT2b37Pjr/vNDvF02ZtQg9s0bH4dIcp5fB0npLyZ8Eiz/CucwoidoXrhuEfvSpczDxqRvsxcLPBHJ83j/Mdbu5vgE9JjUwPvxWf1zSaXx3yA9icBUudKmulyJjyxFsWFceIJVCN9IpxvkAfu4=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Whitespace and CodingStyle cleanup for lib/idr.c
Date: Sat, 24 Sep 2005 00:46:32 +0200
User-Agent: KMail/1.8.2
Cc: Jim Houston <jim.houston@ccur.com>, George Anzinger <george@mvista.com>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509240046.32576.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup trailing whitespace, blank lines, CodingStyle issues etc, for lib/idr.c


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
--- 

 lib/idr.c |   35 +++++++++++++++++------------------
 1 files changed, 17 insertions(+), 18 deletions(-)

--- linux-2.6.14-rc2-git3-orig/lib/idr.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-git3/lib/idr.c	2005-09-24 00:41:35.000000000 +0200
@@ -6,20 +6,20 @@
  * Modified by George Anzinger to reuse immediately and to use
  * find bit instructions.  Also removed _irq on spinlocks.
  *
- * Small id to pointer translation service.  
+ * Small id to pointer translation service.
  *
- * It uses a radix tree like structure as a sparse array indexed 
+ * It uses a radix tree like structure as a sparse array indexed
  * by the id to obtain the pointer.  The bitmap makes allocating
- * a new id quick.  
+ * a new id quick.
  *
  * You call it to allocate an id (an int) an associate with that id a
  * pointer or what ever, we treat it as a (void *).  You can pass this
  * id to a user for him to pass back at a later time.  You then pass
  * that id to this code and it returns your pointer.
 
- * You can release ids at any time. When all ids are released, most of 
+ * You can release ids at any time. When all ids are released, most of
  * the memory is returned (we keep IDR_FREE_MAX) in a local pool so we
- * don't need to go to the memory "store" during an id allocate, just 
+ * don't need to go to the memory "store" during an id allocate, just
  * so you don't need to be too concerned about locking and conflicts
  * with the slab allocator.
  */
@@ -77,7 +77,7 @@ int idr_pre_get(struct idr *idp, unsigne
 	while (idp->id_free_cnt < IDR_FREE_MAX) {
 		struct idr_layer *new;
 		new = kmem_cache_alloc(idr_layer_cache, gfp_mask);
-		if(new == NULL)
+		if (new == NULL)
 			return (0);
 		free_layer(idp, new);
 	}
@@ -107,7 +107,7 @@ static int sub_alloc(struct idr *idp, vo
 		if (m == IDR_SIZE) {
 			/* no space available go back to previous layer. */
 			l++;
-			id = (id | ((1 << (IDR_BITS*l))-1)) + 1;
+			id = (id | ((1 << (IDR_BITS * l)) - 1)) + 1;
 			if (!(p = pa[l])) {
 				*starting_id = id;
 				return -2;
@@ -161,7 +161,7 @@ static int idr_get_new_above_int(struct 
 {
 	struct idr_layer *p, *new;
 	int layers, v, id;
-	
+
 	id = starting_id;
 build_up:
 	p = idp->top;
@@ -225,6 +225,7 @@ build_up:
 int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id)
 {
 	int rv;
+
 	rv = idr_get_new_above_int(idp, ptr, starting_id);
 	/*
 	 * This is a cheap hack until the IDR code can be fixed to
@@ -259,6 +260,7 @@ EXPORT_SYMBOL(idr_get_new_above);
 int idr_get_new(struct idr *idp, void *ptr, int *id)
 {
 	int rv;
+
 	rv = idr_get_new_above_int(idp, ptr, 0);
 	/*
 	 * This is a cheap hack until the IDR code can be fixed to
@@ -306,11 +308,10 @@ static void sub_remove(struct idr *idp, 
 			free_layer(idp, **paa);
 			**paa-- = NULL;
 		}
-		if ( ! *paa )
+		if (!*paa)
 			idp->layers = 0;
-	} else {
+	} else
 		idr_remove_warning(id);
-	}
 }
 
 /**
@@ -326,9 +327,8 @@ void idr_remove(struct idr *idp, int id)
 	id &= MAX_ID_MASK;
 
 	sub_remove(idp, (idp->layers - 1) * IDR_BITS, id);
-	if ( idp->top && idp->top->count == 1 && 
-	     (idp->layers > 1) &&
-	     idp->top->ary[0]){  // We can drop a layer
+	if (idp->top && idp->top->count == 1 && (idp->layers > 1) &&
+	    idp->top->ary[0]) {  // We can drop a layer
 
 		p = idp->top->ary[0];
 		idp->top->bitmap = idp->top->count = 0;
@@ -337,7 +337,6 @@ void idr_remove(struct idr *idp, int id)
 		--idp->layers;
 	}
 	while (idp->id_free_cnt >= IDR_FREE_MAX) {
-		
 		p = alloc_layer(idp);
 		kmem_cache_free(idr_layer_cache, p);
 		return;
@@ -378,8 +377,8 @@ void *idr_find(struct idr *idp, int id)
 }
 EXPORT_SYMBOL(idr_find);
 
-static void idr_cache_ctor(void * idr_layer, 
-			   kmem_cache_t *idr_layer_cache, unsigned long flags)
+static void idr_cache_ctor(void * idr_layer, kmem_cache_t *idr_layer_cache,
+		unsigned long flags)
 {
 	memset(idr_layer, 0, sizeof(struct idr_layer));
 }
@@ -387,7 +386,7 @@ static void idr_cache_ctor(void * idr_la
 static  int init_id_cache(void)
 {
 	if (!idr_layer_cache)
-		idr_layer_cache = kmem_cache_create("idr_layer_cache", 
+		idr_layer_cache = kmem_cache_create("idr_layer_cache",
 			sizeof(struct idr_layer), 0, 0, idr_cache_ctor, NULL);
 	return 0;
 }



