Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUJFBJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUJFBJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUJFBJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:09:32 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:38623 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266582AbUJFBJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:09:17 -0400
Subject: [PATCH] scheduler: remove NODE_BALANCE_RATE definitions
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097024938.4065.65.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 05 Oct 2004 18:08:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NODE_BALANCE_RATE is defined all over the place, but used nowhere. 
Let's remove it.

[mcd@arrakis source]$ diffstat ~/linux/patches/remove-NODE_BALANCE_RATE.patch
 asm-alpha/topology.h          |    3 ---
 asm-generic/topology.h        |    5 -----
 asm-i386/topology.h           |    3 ---
 asm-ia64/topology.h           |    3 ---
 asm-m32r/topology.h           |    5 -----
 asm-mips/mach-ip27/topology.h |    3 ---
 asm-ppc64/topology.h          |    3 ---
 asm-x86_64/topology.h         |    2 --
 8 files changed, 27 deletions(-)

-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc3-mm2/include/asm-alpha/topology.h linux-2.6.9-rc3-mm2-NODE_BALANCE_RATE/include/asm-alpha/topology.h
--- linux-2.6.9-rc3-mm2/include/asm-alpha/topology.h	2004-08-13 22:36:32.000000000 -0700
+++ linux-2.6.9-rc3-mm2-NODE_BALANCE_RATE/include/asm-alpha/topology.h	2004-10-05 18:03:01.000000000 -0700
@@ -39,9 +39,6 @@ static inline cpumask_t node_to_cpumask(
 	return node_cpu_mask;
 }
 
-/* Cross-node load balancing interval. */
-# define NODE_BALANCE_RATE 10
-
 #define pcibus_to_cpumask(bus)	(cpu_online_map)
 
 #else /* CONFIG_NUMA */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc3-mm2/include/asm-generic/topology.h linux-2.6.9-rc3-mm2-NODE_BALANCE_RATE/include/asm-generic/topology.h
--- linux-2.6.9-rc3-mm2/include/asm-generic/topology.h	2004-08-13 22:36:16.000000000 -0700
+++ linux-2.6.9-rc3-mm2-NODE_BALANCE_RATE/include/asm-generic/topology.h	2004-10-05 18:01:16.000000000 -0700
@@ -45,9 +45,4 @@
 #define pcibus_to_cpumask(bus)	(cpu_online_map)
 #endif
 
-/* Cross-node load balancing interval. */
-#ifndef NODE_BALANCE_RATE
-#define NODE_BALANCE_RATE 10
-#endif
-
 #endif /* _ASM_GENERIC_TOPOLOGY_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc3-mm2/include/asm-i386/topology.h linux-2.6.9-rc3-mm2-NODE_BALANCE_RATE/include/asm-i386/topology.h
--- linux-2.6.9-rc3-mm2/include/asm-i386/topology.h	2004-10-04 14:38:56.000000000 -0700
+++ linux-2.6.9-rc3-mm2-NODE_BALANCE_RATE/include/asm-i386/topology.h	2004-10-05 18:01:27.000000000 -0700
@@ -69,9 +69,6 @@ static inline cpumask_t pcibus_to_cpumas
 /* Node-to-Node distance */
 #define node_distance(from, to) ((from) != (to))
 
-/* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE 100
-
 /* sched_domains SD_NODE_INIT for NUMAQ machines */
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc3-mm2/include/asm-ia64/topology.h linux-2.6.9-rc3-mm2-NODE_BALANCE_RATE/include/asm-ia64/topology.h
--- linux-2.6.9-rc3-mm2/include/asm-ia64/topology.h	2004-10-04 14:38:56.000000000 -0700
+++ linux-2.6.9-rc3-mm2-NODE_BALANCE_RATE/include/asm-ia64/topology.h	2004-10-05 18:01:39.000000000 -0700
@@ -40,9 +40,6 @@
  */
 #define node_to_first_cpu(node) (__ffs(node_to_cpumask(node)))
 
-/* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE 10
-
 void build_cpu_to_node_map(void);
 
 /* sched_domains SD_NODE_INIT for IA64 NUMA machines */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc3-mm2/include/asm-m32r/topology.h linux-2.6.9-rc3-mm2-NODE_BALANCE_RATE/include/asm-m32r/topology.h
--- linux-2.6.9-rc3-mm2/include/asm-m32r/topology.h	2004-09-30 11:15:16.000000000 -0700
+++ linux-2.6.9-rc3-mm2-NODE_BALANCE_RATE/include/asm-m32r/topology.h	2004-10-05 18:03:13.000000000 -0700
@@ -45,9 +45,4 @@
 #define pcibus_to_cpumask(bus)	(cpu_online_map)
 #endif
 
-/* Cross-node load balancing interval. */
-#ifndef NODE_BALANCE_RATE
-#define NODE_BALANCE_RATE 10
-#endif
-
 #endif /* _ASM_M32R_TOPOLOGY_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc3-mm2/include/asm-mips/mach-ip27/topology.h linux-2.6.9-rc3-mm2-NODE_BALANCE_RATE/include/asm-mips/mach-ip27/topology.h
--- linux-2.6.9-rc3-mm2/include/asm-mips/mach-ip27/topology.h	2004-08-13 22:38:11.000000000 -0700
+++ linux-2.6.9-rc3-mm2-NODE_BALANCE_RATE/include/asm-mips/mach-ip27/topology.h	2004-10-05 18:02:44.000000000 -0700
@@ -12,7 +12,4 @@
 extern int node_distance(nasid_t nasid_a, nasid_t nasid_b);
 #define node_distance(from, to)	node_distance(from, to)
 
-/* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE	10
-
 #endif /* _ASM_MACH_TOPOLOGY_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc3-mm2/include/asm-ppc64/topology.h linux-2.6.9-rc3-mm2-NODE_BALANCE_RATE/include/asm-ppc64/topology.h
--- linux-2.6.9-rc3-mm2/include/asm-ppc64/topology.h	2004-10-04 14:38:56.000000000 -0700
+++ linux-2.6.9-rc3-mm2-NODE_BALANCE_RATE/include/asm-ppc64/topology.h	2004-10-05 18:02:19.000000000 -0700
@@ -37,9 +37,6 @@ static inline int node_to_first_cpu(int 
 
 #define nr_cpus_node(node)	(nr_cpus_in_node[node])
 
-/* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE 10
-
 /* sched_domains SD_NODE_INIT for PPC64 machines */
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc3-mm2/include/asm-x86_64/topology.h linux-2.6.9-rc3-mm2-NODE_BALANCE_RATE/include/asm-x86_64/topology.h
--- linux-2.6.9-rc3-mm2/include/asm-x86_64/topology.h	2004-10-04 14:38:57.000000000 -0700
+++ linux-2.6.9-rc3-mm2-NODE_BALANCE_RATE/include/asm-x86_64/topology.h	2004-10-05 18:01:52.000000000 -0700
@@ -32,8 +32,6 @@ static inline cpumask_t __pcibus_to_cpum
 /* broken generic file uses #ifndef later on this */
 #define pcibus_to_cpumask(bus) __pcibus_to_cpumask(bus)
 
-#define NODE_BALANCE_RATE 30	/* CHECKME */ 
-
 #ifdef CONFIG_NUMA
 /* sched_domains SD_NODE_INIT for x86_64 machines */
 #define SD_NODE_INIT (struct sched_domain) {		\


