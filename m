Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWHDFfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWHDFfj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWHDFfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:35:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:50079 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030262AbWHDFfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:35:38 -0400
Subject: [PATCH 1 of 4] cpumask: add highest_possible_node_id
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1154669719.21040.2351.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 04 Aug 2006 15:35:19 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask: add highest_possible_node_id(), analogous to
highest_possible_processor_id().

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 include/linux/nodemask.h |    2 ++
 lib/cpumask.c            |   16 ++++++++++++++++
 2 files changed, 18 insertions(+)

Index: linus-git/include/linux/nodemask.h
===================================================================
--- linus-git.orig/include/linux/nodemask.h	2006-07-05 15:55:26.000000000 +1000
+++ linus-git/include/linux/nodemask.h	2006-08-01 15:40:50.953022638 +1000
@@ -352,6 +352,7 @@ extern nodemask_t node_possible_map;
 #define node_possible(node)	node_isset((node), node_possible_map)
 #define first_online_node	first_node(node_online_map)
 #define next_online_node(nid)	next_node((nid), node_online_map)
+int highest_possible_node_id(void);
 #else
 #define num_online_nodes()	1
 #define num_possible_nodes()	1
@@ -359,6 +360,7 @@ extern nodemask_t node_possible_map;
 #define node_possible(node)	((node) == 0)
 #define first_online_node	0
 #define next_online_node(nid)	(MAX_NUMNODES)
+#define highest_possible_node_id()	0
 #endif
 
 #define any_online_node(mask)			\
Index: linus-git/lib/cpumask.c
===================================================================
--- linus-git.orig/lib/cpumask.c	2006-07-05 15:55:39.000000000 +1000
+++ linus-git/lib/cpumask.c	2006-08-01 15:42:42.742593668 +1000
@@ -43,3 +43,19 @@ int __any_online_cpu(const cpumask_t *ma
 	return cpu;
 }
 EXPORT_SYMBOL(__any_online_cpu);
+
+#if MAX_NUMNODES > 1
+/*
+ * Find the highest possible node id.
+ */
+int highest_possible_node_id(void)
+{
+	unsigned int node;
+	unsigned int highest = 0;
+
+	for_each_cpu_mask(node, node_possible_map)
+		highest = node;
+	return highest;
+}
+EXPORT_SYMBOL(highest_possible_node_id);
+#endif

-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


