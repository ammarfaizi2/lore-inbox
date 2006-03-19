Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWCSI6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWCSI6V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 03:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWCSI6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 03:58:17 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:16257 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751465AbWCSI6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 03:58:15 -0500
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Date: Sun, 19 Mar 2006 00:58:13 -0800
Message-Id: <20060319085813.18851.69069.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] mm: slab cache interleave rotor fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

The alien cache rotor in mm/slab.c assumes that the first online
node is node 0.  Eventually for some archs, especially with hotplug,
this will no longer be true.

Fix the interleave rotor to handle the general case of node numbering.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 mm/slab.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6.16-rc6-mm2.orig/mm/slab.c	2006-03-18 21:40:42.465283732 -0800
+++ 2.6.16-rc6-mm2/mm/slab.c	2006-03-18 21:53:10.440761398 -0800
@@ -835,7 +835,7 @@ static void init_reap_node(int cpu)
 
 	node = next_node(cpu_to_node(cpu), node_online_map);
 	if (node == MAX_NUMNODES)
-		node = 0;
+		node = first_node(node_online_map);
 
 	__get_cpu_var(reap_node) = node;
 }

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
