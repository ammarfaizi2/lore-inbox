Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUDHUD6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbUDHT7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:59:37 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:37095 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262418AbUDHTvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:51:18 -0400
Date: Thu, 8 Apr 2004 12:50:12 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Patch 17/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408125012.4f1ce5ac.pj@sgi.com>
In-Reply-To: <20040408115050.2c67311a.pj@sgi.com>
References: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P17.nodemask_mmzone - the mmzone.h changes from Matthew's Patch [1/7]
        Just the mmzone.h changes taken from this patch: removing
        extistant definition of node_online_map and helper functions,
        added a #include <nodemask.h>.

Index: 2.6.5.bitmap/include/linux/mmzone.h
===================================================================
--- 2.6.5.bitmap.orig/include/linux/mmzone.h	2004-04-08 04:42:34.000000000 -0700
+++ 2.6.5.bitmap/include/linux/mmzone.h	2004-04-08 04:45:58.000000000 -0700
@@ -11,6 +11,7 @@
 #include <linux/cache.h>
 #include <linux/threads.h>
 #include <linux/numa.h>
+#include <linux/nodemask.h>
 #include <asm/atomic.h>
 
 /* Free memory management - zoned buddy allocator.  */
@@ -220,7 +221,6 @@
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
 #define node_spanned_pages(nid)	(NODE_DATA(nid)->node_spanned_pages)
 
-extern int numnodes;
 extern struct pglist_data *pgdat_list;
 
 void get_zone_counts(unsigned long *active, unsigned long *inactive,
@@ -343,35 +343,6 @@
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
