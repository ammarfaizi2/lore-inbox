Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVI3BZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVI3BZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 21:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVI3BZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 21:25:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:58561 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932387AbVI3BZp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 21:25:45 -0400
Date: Thu, 29 Sep 2005 18:26:22 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix PREEMPT_RT compile error on NUMA-Q
Message-ID: <20050930012621.GA9734@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes a fatal compile-time error on NUMA-Q, and
probably on any other NUMA machine, involving kmem_cache_alloc_node()'s
"flags" argument.

Signed-off-by: <paulmck@us.ibm.com>
---

 slab.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpNa -X dontdiff linux-2.6.14-rc2-rt7/mm/slab.c linux-2.6.14-rc2-rt7-NUMA/mm/slab.c
--- linux-2.6.14-rc2-rt7/mm/slab.c	2005-09-29 13:57:16.000000000 -0700
+++ linux-2.6.14-rc2-rt7-NUMA/mm/slab.c	2005-09-29 17:40:28.000000000 -0700
@@ -2400,7 +2400,7 @@ out:
  * and can sleep. And it will allocate memory on the given node, which
  * can improve the performance for cpu bound structures.
  */
-void *kmem_cache_alloc_node(kmem_cache_t *cachep, int flags, int nodeid)
+void *kmem_cache_alloc_node(kmem_cache_t *cachep, unsigned int __nocast flags, int nodeid)
 {
 	int loop;
 	void *objp;
