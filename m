Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965438AbWI0Iyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965438AbWI0Iyj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 04:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWI0Iyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 04:54:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:946 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750890AbWI0Iyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 04:54:39 -0400
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg Banks <gnb@melbourne.sgi.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Date: Wed, 27 Sep 2006 01:54:29 -0700
Message-Id: <20060927085429.32218.64893.sendpatchset@sam.engr.sgi.com>
Subject: [PATCH] cpumask add highest_possible_node_id fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in lib/cpumask.c - looks like a cut+paste forgot
to change a cpu macro call to a node macro call.  This
typo caused the following build warnings:

lib/cpumask.c: In function `highest_possible_node_id':
lib/cpumask.c:56: warning: passing arg 1 of `__first_cpu' from incompatible pointer type
lib/cpumask.c:56: warning: passing arg 2 of `__next_cpu' from incompatible pointer type   

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 lib/cpumask.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6.18-rc7-mm1.orig/lib/cpumask.c	2006-09-26 16:25:57.000000000 -0700
+++ 2.6.18-rc7-mm1/lib/cpumask.c	2006-09-27 01:38:17.000000000 -0700
@@ -53,7 +53,7 @@ int highest_possible_node_id(void)
 	unsigned int node;
 	unsigned int highest = 0;
 
-	for_each_cpu_mask(node, node_possible_map)
+	for_each_node_mask(node, node_possible_map)
 		highest = node;
 	return highest;
 }

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
