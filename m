Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWCQIWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWCQIWX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 03:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWCQIWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 03:22:22 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:58575 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1752567AbWCQIWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 03:22:09 -0500
Date: Fri, 17 Mar 2006 17:21:15 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 005/017]Memory hotplug for new nodes v.4.(generic refresh NODE_DATA())
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060317163118.C641.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This function refresh NODE_DATA() for generic archs.
In this case, NODE_DATA(nid) == node_data[nid].
node_data[] is array of address of pgdat.
So, refresh is quite simple.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 include/linux/memory_hotplug.h |   12 ++++++++++++
 1 files changed, 12 insertions(+)

Index: pgdat8/include/linux/memory_hotplug.h
===================================================================
--- pgdat8.orig/include/linux/memory_hotplug.h	2006-03-17 13:53:23.914730042 +0900
+++ pgdat8/include/linux/memory_hotplug.h	2006-03-17 13:53:27.319026876 +0900
@@ -88,11 +88,14 @@ static inline int arch_nid_probe(u64 sta
  */
 extern pg_data_t * arch_alloc_nodedata(int nid);
 extern void arch_free_nodedata(pg_data_t *pgdat);
+extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
 
 #else /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
 
 #define arch_alloc_nodedata(nid)	generic_alloc_nodedata(nid)
 #define arch_free_nodedata(pgdat)	generic_free_nodedata(pgdat)
+#define arch_refresh_nodedata(nid, pgdat)	\
+				generic_refresh_nodedata(nid, pgdat)
 
 #ifdef CONFIG_NUMA
 /*
@@ -111,6 +114,12 @@ extern void arch_free_nodedata(pg_data_t
  */
 #define generic_free_nodedata(pgdat)	kfree(pgdat)
 
+extern pg_data_t *node_data[];
+static inline void generic_refresh_nodedata(int nid, pg_data_t *pgdat)
+{
+	node_data[nid] = pgdat;
+}
+
 #else /* !CONFIG_NUMA */
 
 /* never called */
@@ -122,6 +131,9 @@ static inline pg_data_t *generic_alloc_n
 static inline void generic_free_nodedata(pg_data_t *pgdat)
 {
 }
+static inline void generic_refresh_nodedata(int nid, pg_data_t *pgdat)
+{
+}
 #endif /* CONFIG_NUMA */
 #endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
 

-- 
Yasunori Goto 


