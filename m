Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWAFPRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWAFPRs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWAFPRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:17:17 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:6810 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751509AbWAFPQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:16:56 -0500
Date: Fri, 6 Jan 2006 13:12:46 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm <akpm@osdl.org>
Cc: penberg@cs.helsinki.fi, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] slab: Adds missing kmalloc() checks.
Message-Id: <20060106131246.0b9fde8c.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Adds two missing kmalloc() checks in kmem_cache_init(). Note that if the
allocation fails, there is nothing to do, so we panic(); and the __LINE__
is used because is good to know which allocation has failed.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 mm/slab.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
index e5ec26e..3f23ad2 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1115,6 +1115,8 @@ void __init kmem_cache_init(void)
 		void * ptr;
 
 		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
+		if (!ptr)
+			panic("%s at %d: Could not allocate memory.\n", __FUNCTION__, __LINE__);
 
 		local_irq_disable();
 		BUG_ON(ac_data(&cache_cache) != &initarray_cache.cache);
@@ -1124,6 +1126,8 @@ void __init kmem_cache_init(void)
 		local_irq_enable();
 
 		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
+		if (!ptr)
+			panic("%s at %d: Could not allocate memory.\n", __FUNCTION__, __LINE__);
 
 		local_irq_disable();
 		BUG_ON(ac_data(malloc_sizes[INDEX_AC].cs_cachep)


-- 
Luiz Fernando N. Capitulino
