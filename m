Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbUC2MUi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbUC2MT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:19:57 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:6584 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262863AbUC2MPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:15:04 -0500
Date: Mon, 29 Mar 2004 04:14:09 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] mask ADT: mmzone.h changes from Matthew's nodemask_t Patch
 1/7 [10/22]
Message-Id: <20040329041409.0f58021a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_10_of_22 - the mmzone.h changes from Matthew's Patch [1/7]
	Just the mmzone.h changes taken from this patch: removing
	extistant definition of node_online_map and helper functions,
	added a #include <nodemask.h>.

diffstat Patch_10_of_22:
 mmzone.h |   31 +------------------------------
 1 files changed, 1 insertion(+), 30 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1715  -> 1.1716 
#	include/linux/mmzone.h	1.52    -> 1.53   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/28	pj@sgi.com	1.1716
# Matthew Dobson's [PATCH]_nodemask_t_definitions_[1_7] of 18 Mar 2004:
#   Just the mmzone.h changes taken from this patch: removing extistant
#   definition of node_online_map and helper functions, including nodemask.h.
# --------------------------------------------
#
diff -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Mon Mar 29 01:03:44 2004
+++ b/include/linux/mmzone.h	Mon Mar 29 01:03:44 2004
@@ -11,6 +11,7 @@
 #include <linux/cache.h>
 #include <linux/threads.h>
 #include <linux/numa.h>
+#include <linux/nodemask.h>
 #include <asm/atomic.h>
 
 /* Free memory management - zoned buddy allocator.  */
@@ -218,7 +219,6 @@
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
 #define node_spanned_pages(nid)	(NODE_DATA(nid)->node_spanned_pages)
 
-extern int numnodes;
 extern struct pglist_data *pgdat_list;
 
 void get_zone_counts(unsigned long *active, unsigned long *inactive,
@@ -336,35 +336,6 @@
 #error ZONES_SHIFT > MAX_ZONES_SHIFT
 #endif
 
-extern DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
-
-#if defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_NUMA)
-
-#define node_online(node)	test_bit(node, node_online_map)
-#define node_set_online(node)	set_bit(node, node_online_map)
-#define node_set_offline(node)	clear_bit(node, node_online_map)
-static inline unsigned int num_online_nodes(void)
-{
-	int i, num = 0;
-
-	for(i = 0; i < MAX_NUMNODES; i++){
-		if (node_online(i))
-			num++;
-	}
-	return num;
-}
-
-#else /* !CONFIG_DISCONTIGMEM && !CONFIG_NUMA */
-
-#define node_online(node) \
-	({ BUG_ON((node) != 0); test_bit(node, node_online_map); })
-#define node_set_online(node) \
-	({ BUG_ON((node) != 0); set_bit(node, node_online_map); })
-#define node_set_offline(node) \
-	({ BUG_ON((node) != 0); clear_bit(node, node_online_map); })
-#define num_online_nodes()	1
-
-#endif /* CONFIG_DISCONTIGMEM || CONFIG_NUMA */
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MMZONE_H */


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
