Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbSLEACO>; Wed, 4 Dec 2002 19:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbSLEACN>; Wed, 4 Dec 2002 19:02:13 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:59797 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267277AbSLEACI>;
	Wed, 4 Dec 2002 19:02:08 -0500
Message-ID: <3DEE97BC.2000703@us.ibm.com>
Date: Wed, 04 Dec 2002 16:03:08 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, Martin Bligh <mjbligh@us.ibm.com>,
       Peter Rival <frival@zk3.dec.com>, Anton Blanchard <anton@samba.org>
CC: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: [patch][trivial] include <asm-generic/topology.h>
Content-Type: multipart/mixed;
 boundary="------------020103020806080304090505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020103020806080304090505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,
	For a small bit of sanity and a savings of 9 lines of code, we should 
be including the generic topology macros in the alpha & ppc64 topology 
files, rather than just redefining them.  It is much easier to keep all 
the generic topology macros in sync this way, too.

Cheers!

-Matt

[mcd@arrakis patches]$ diffstat use_generic_topo-2.5.50.patch
  asm-alpha/topology.h |   19 +++++++------------
  asm-ppc64/topology.h |    8 ++------
  2 files changed, 9 insertions(+), 18 deletions(-)


--------------020103020806080304090505
Content-Type: text/plain;
 name="use_generic_topo-2.5.50.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="use_generic_topo-2.5.50.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.50-vanilla/include/asm-alpha/topology.h linux-2.5.50-use_generic/include/asm-alpha/topology.h
--- linux-2.5.50-vanilla/include/asm-alpha/topology.h	Wed Nov 27 14:35:53 2002
+++ linux-2.5.50-use_generic/include/asm-alpha/topology.h	Wed Dec  4 15:57:38 2002
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
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.50-vanilla/include/asm-ppc64/topology.h linux-2.5.50-use_generic/include/asm-ppc64/topology.h
--- linux-2.5.50-vanilla/include/asm-ppc64/topology.h	Wed Nov 27 14:36:22 2002
+++ linux-2.5.50-use_generic/include/asm-ppc64/topology.h	Wed Dec  4 15:57:38 2002
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
 

--------------020103020806080304090505--

