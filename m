Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWAWQMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWAWQMW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWAWQMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:12:22 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:35463 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751491AbWAWQMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:12:21 -0500
Date: Mon, 23 Jan 2006 13:31:21 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, penberg@cs.helsinki.fi
Subject: [PATCH] slab: Adds two missing kmalloc() checks.
Message-Id: <20060123133121.70f2cbcb.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 2.2.0beta4 (GTK+ 2.8.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Adds two missing kmalloc() checks in kmem_cache_init(). The check is worth
because if kmalloc() fails we'll have a nice message instead of a OOPS (which
will make us look for a bug).

 We're using BUG_ON() so that embedded people can disable it.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 mm/slab.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
index 6f8495e..2fcfd08 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1130,6 +1130,7 @@ void __init kmem_cache_init(void)
 		void *ptr;
 
 		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
+		BUG_ON(!ptr);
 
 		local_irq_disable();
 		BUG_ON(ac_data(&cache_cache) != &initarray_cache.cache);
@@ -1139,6 +1140,7 @@ void __init kmem_cache_init(void)
 		local_irq_enable();
 
 		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
+		BUG_ON(!ptr);
 
 		local_irq_disable();
 		BUG_ON(ac_data(malloc_sizes[INDEX_AC].cs_cachep)


-- 
Luiz Fernando N. Capitulino
