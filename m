Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267044AbSKLXeL>; Tue, 12 Nov 2002 18:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbSKLXeK>; Tue, 12 Nov 2002 18:34:10 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:157 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267044AbSKLXeJ>;
	Tue, 12 Nov 2002 18:34:09 -0500
Message-ID: <3DD19078.6030608@us.ibm.com>
Date: Tue, 12 Nov 2002 15:36:24 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, Anton Blanchard <anton@samba.org>,
       Peter Rival <frival@zk3.dec.com>
CC: linux-kernel@vger.kernel.org
Subject: [patch] Fix asm-alpha/topology.h & asm-ppc64/topology.h
Content-Type: multipart/mixed;
 boundary="------------070507000206040706000709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070507000206040706000709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,
	This patch fixes 2 files where non-NUMA macros are redefined, rather 
than including the generic non-NUMA ones already defined.

Please apply.

[mcd@arrakis patches]$ diffstat use_generic_topo-2.5.47.patch
  asm-alpha/topology.h |   19 +++++++------------
  asm-ppc64/topology.h |    8 ++------
  2 files changed, 9 insertions(+), 18 deletions(-)

Cheers!

-Matt

--------------070507000206040706000709
Content-Type: text/plain;
 name="use_generic_topo-2.5.47.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="use_generic_topo-2.5.47.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.46-vanilla/include/asm-alpha/topology.h linux-2.5.46-generic_topo_fix/include/asm-alpha/topology.h
--- linux-2.5.46-vanilla/include/asm-alpha/topology.h	Mon Nov  4 14:30:15 2002
+++ linux-2.5.46-generic_topo_fix/include/asm-alpha/topology.h	Mon Nov  4 16:45:42 2002
@@ -1,20 +1,15 @@
 #ifndef _ASM_ALPHA_TOPOLOGY_H
 #define _ASM_ALPHA_TOPOLOGY_H
 
-#ifdef CONFIG_NUMA
-#ifdef CONFIG_ALPHA_WILDFIRE
+#if defined(CONFIG_NUMA) && defined(CONFIG_ALPHA_WILDFIRE)
+
 /* With wildfire assume 4 CPUs per node */
 #define __cpu_to_node(cpu)		((cpu) >> 2)
-#endif /* CONFIG_ALPHA_WILDFIRE */
-#endif /* CONFIG_NUMA */
 
-#if !defined(CONFIG_NUMA) || !defined(CONFIG_ALPHA_WILDFIRE)
-#define __cpu_to_node(cpu)		(0)
-#define __memblk_to_node(memblk)	(0)
-#define __parent_node(nid)		(0)
-#define __node_to_first_cpu(node)	(0)
-#define __node_to_cpu_mask(node)	(cpu_online_map)
-#define __node_to_memblk(node)		(0)
-#endif /* !CONFIG_NUMA || !CONFIG_ALPHA_WILDFIRE */
+#else /* !CONFIG_NUMA || !CONFIG_ALPHA_WILDFIRE */
+
+#include <asm-generic/topology.h>
+
+#endif /* CONFIG_NUMA && CONFIG_ALPHA_WILDFIRE */
 
 #endif /* _ASM_ALPHA_TOPOLOGY_H */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.46-vanilla/include/asm-ppc64/topology.h linux-2.5.46-generic_topo_fix/include/asm-ppc64/topology.h
--- linux-2.5.46-vanilla/include/asm-ppc64/topology.h	Mon Nov  4 14:30:52 2002
+++ linux-2.5.46-generic_topo_fix/include/asm-ppc64/topology.h	Mon Nov  4 16:45:42 2002
@@ -48,12 +48,8 @@
 
 #else /* !CONFIG_NUMA */
 
-#define __cpu_to_node(cpu)		(0)
-#define __memblk_to_node(memblk)	(0)
-#define __parent_node(nid)		(0)
-#define __node_to_first_cpu(node)	(0)
-#define __node_to_cpu_mask(node)	(cpu_online_map)
-#define __node_to_memblk(node)		(0)
+/* If non-NUMA, grab the generic macros */
+#include <asm-generic/topology.h>
 
 #endif /* CONFIG_NUMA */
 

--------------070507000206040706000709--

