Return-Path: <linux-kernel-owner+w=401wt.eu-S1755365AbXABQiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365AbXABQiu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755368AbXABQiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:38:50 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:39605 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365AbXABQit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:38:49 -0500
Date: Tue, 2 Jan 2007 18:38:47 +0200 (EET)
From: Pekka J Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [PATCH] slab: add missing debug_check_no_locks_freed for kmem_cache_free
Message-ID: <Pine.LNX.4.64.0701021838230.24781@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

Add a missing debug_check_no_locks_freed() debug check for kmem_cache_free().

Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -3491,6 +3491,8 @@ static inline void __cache_free(struct k
 {
 	struct array_cache *ac = cpu_cache_get(cachep);
 
+	debug_check_no_locks_freed(objp, obj_size(cachep));
+
 	check_irq_off();
 	objp = cache_free_debugcheck(cachep, objp, __builtin_return_address(0));
 
@@ -3757,7 +3759,6 @@ void kfree(const void *objp)
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
 	c = virt_to_cache(objp);
-	debug_check_no_locks_freed(objp, obj_size(c));
 	__cache_free(c, (void *)objp);
 	local_irq_restore(flags);
 }
