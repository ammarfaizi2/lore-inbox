Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265628AbTFNHBM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 03:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265630AbTFNHBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 03:01:12 -0400
Received: from [66.212.224.118] ([66.212.224.118]:15887 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265628AbTFNHBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 03:01:11 -0400
Date: Sat, 14 Jun 2003 03:03:44 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH][2.5] Add cachep->name to kmem_cache_destroy debug printk
Message-ID: <Pine.LNX.4.50.0306140303080.31716-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kmem_cache_destroy: Can't free all objects cbc7af30 (dcookie_cache)

        I've been getting a number of these, perhaps it might be
worthwhile adding the name too.

Index: linux-2.5/mm/slab.c
===================================================================
RCS file: /home/cvs/linux-2.5/mm/slab.c,v
retrieving revision 1.88
diff -u -p -B -r1.88 slab.c
--- linux-2.5/mm/slab.c	11 Jun 2003 07:09:28 -0000	1.88
+++ linux-2.5/mm/slab.c	14 Jun 2003 05:35:25 -0000
@@ -1319,8 +1319,8 @@ int kmem_cache_destroy (kmem_cache_t * c
 	up(&cache_chain_sem);
 
 	if (__cache_shrink(cachep)) {
-		printk(KERN_ERR "kmem_cache_destroy: Can't free all objects %p\n",
-		       cachep);
+		printk(KERN_ERR "kmem_cache_destroy: Can't free all objects %p (%s)\n",
+		       cachep, cachep->name);
 		down(&cache_chain_sem);
 		list_add(&cachep->next,&cache_chain);
 		up(&cache_chain_sem);
