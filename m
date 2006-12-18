Return-Path: <linux-kernel-owner+w=401wt.eu-S1754061AbWLROZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbWLROZp (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 09:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbWLROZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 09:25:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48773 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754061AbWLROZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 09:25:44 -0500
Date: Mon, 18 Dec 2006 15:23:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [patch] lockdep: also check for freed locks in kmem_cache_free()
Message-ID: <20061218142338.GA1902@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0018]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] lockdep: also check for freed locks in kmem_cache_free()
From: Ingo Molnar <mingo@elte.hu>

kmem_cache_free() was missing the check for freeing held locks.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 mm/slab.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux/mm/slab.c
===================================================================
--- linux.orig/mm/slab.c
+++ linux/mm/slab.c
@@ -3533,6 +3533,7 @@ void kmem_cache_free(struct kmem_cache *
 	BUG_ON(virt_to_cache(objp) != cachep);
 
 	local_irq_save(flags);
+	debug_check_no_locks_freed(objp, obj_size(cachep));
 	__cache_free(cachep, objp);
 	local_irq_restore(flags);
 }
