Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbTAVXrR>; Wed, 22 Jan 2003 18:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbTAVXrR>; Wed, 22 Jan 2003 18:47:17 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:34014 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264729AbTAVXrI>;
	Wed, 22 Jan 2003 18:47:08 -0500
Message-ID: <3E2F2DF4.4000507@us.ibm.com>
Date: Wed, 22 Jan 2003 15:49:08 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: [patch][cleanup] Remove __ from topology macros
Content-Type: multipart/mixed;
 boundary="------------040608080904080909020802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040608080904080909020802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

When I originally wrote the patches implementing the in-kernel topology 
macros, they were meant to be called as a second layer of functions, 
sans underbars.  This additional layer was deemed unnecessary and 
summarily dropped.  As such, carrying around (and typing!) all these 
extra underbars is quite pointless.  Here's a patch to nip this in the 
(sorta) bud.  The macros only appear in 16 files so far, most of them 
being the definitions themselves.

[mcd@arrakis push]$ diffstat remove_underbars-2.5.59.patch
  drivers/base/cpu.c             |    2 +-
  drivers/base/memblk.c          |    2 +-
  drivers/base/node.c            |    2 +-
  include/asm-alpha/topology.h   |   10 +++++-----
  include/asm-generic/topology.h |   24 ++++++++++++------------
  include/asm-i386/cpu.h         |    2 +-
  include/asm-i386/memblk.h      |    2 +-
  include/asm-i386/node.h        |    2 +-
  include/asm-i386/topology.h    |   14 +++++++-------
  include/asm-ia64/topology.h    |   18 +++++++++---------
  include/asm-mips64/topology.h  |    2 +-
  include/asm-ppc64/topology.h   |   13 ++++---------
  include/linux/mmzone.h         |    2 +-
  kernel/sched.c                 |   10 +++++-----
  mm/page_alloc.c                |    2 +-
  mm/vmscan.c                    |    2 +-
  16 files changed, 52 insertions(+), 57 deletions(-)

Any objections?

Cheers!

-Matt

--------------040608080904080909020802
Content-Type: text/plain;
 name="remove_underbars-2.5.59.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove_underbars-2.5.59.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/drivers/base/cpu.c linux-2.5.59-underscore_free/drivers/base/cpu.c
--- linux-2.5.59-vanilla/drivers/base/cpu.c	Thu Jan 16 18:21:51 2003
+++ linux-2.5.59-underscore_free/drivers/base/cpu.c	Tue Jan 21 11:04:38 2003
@@ -35,7 +35,7 @@
  */
 int __init register_cpu(struct cpu *cpu, int num, struct node *root)
 {
-	cpu->node_id = __cpu_to_node(num);
+	cpu->node_id = cpu_to_node(num);
 	cpu->sysdev.name = "cpu";
 	cpu->sysdev.id = num;
 	if (root)
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/drivers/base/memblk.c linux-2.5.59-underscore_free/drivers/base/memblk.c
--- linux-2.5.59-vanilla/drivers/base/memblk.c	Thu Jan 16 18:22:57 2003
+++ linux-2.5.59-underscore_free/drivers/base/memblk.c	Tue Jan 21 11:04:38 2003
@@ -36,7 +36,7 @@
  */
 int __init register_memblk(struct memblk *memblk, int num, struct node *root)
 {
-	memblk->node_id = __memblk_to_node(num);
+	memblk->node_id = memblk_to_node(num);
 	memblk->sysdev.name = "memblk";
 	memblk->sysdev.id = num;
 	if (root)
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/drivers/base/node.c linux-2.5.59-underscore_free/drivers/base/node.c
--- linux-2.5.59-vanilla/drivers/base/node.c	Thu Jan 16 18:21:40 2003
+++ linux-2.5.59-underscore_free/drivers/base/node.c	Tue Jan 21 11:04:38 2003
@@ -72,7 +72,7 @@
 {
 	int error;
 
-	node->cpumap = __node_to_cpu_mask(num);
+	node->cpumap = node_to_cpumask(num);
 	node->sysroot.id = num;
 	if (parent)
 		node->sysroot.dev.parent = &parent->sysroot.sysdev;
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/include/asm-alpha/topology.h linux-2.5.59-underscore_free/include/asm-alpha/topology.h
--- linux-2.5.59-vanilla/include/asm-alpha/topology.h	Thu Jan 16 18:21:48 2003
+++ linux-2.5.59-underscore_free/include/asm-alpha/topology.h	Tue Jan 21 11:05:38 2003
@@ -6,7 +6,7 @@
 #include <asm/machvec.h>
 
 #ifdef CONFIG_NUMA
-static inline int __cpu_to_node(int cpu)
+static inline int cpu_to_node(int cpu)
 {
 	int node;
 	
@@ -23,13 +23,13 @@
 	return node;
 }
 
-static inline int __node_to_cpu_mask(int node)
+static inline int node_to_cpumask(int node)
 {
 	unsigned long node_cpu_mask = 0;
 	int cpu;
 
 	for(cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (cpu_online(cpu) && (__cpu_to_node(cpu) == node))
+		if (cpu_online(cpu) && (cpu_to_node(cpu) == node))
 			node_cpu_mask |= 1UL << cpu;
 	}
 
@@ -40,8 +40,8 @@
 	return node_cpu_mask;
 }
 
-# define __node_to_memblk(node)		(node)
-# define __memblk_to_node(memblk)	(memblk)
+# define node_to_memblk(node)		(node)
+# define memblk_to_node(memblk)	(memblk)
 
 #else /* CONFIG_NUMA */
 # include <asm-generic/topology.h>
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/include/asm-generic/topology.h linux-2.5.59-underscore_free/include/asm-generic/topology.h
--- linux-2.5.59-vanilla/include/asm-generic/topology.h	Thu Jan 16 18:21:38 2003
+++ linux-2.5.59-underscore_free/include/asm-generic/topology.h	Tue Jan 21 11:04:38 2003
@@ -29,23 +29,23 @@
 
 /* Other architectures wishing to use this simple topology API should fill
    in the below functions as appropriate in their own <asm/topology.h> file. */
-#ifndef __cpu_to_node
-#define __cpu_to_node(cpu)		(0)
+#ifndef cpu_to_node
+#define cpu_to_node(cpu)	(0)
 #endif
-#ifndef __memblk_to_node
-#define __memblk_to_node(memblk)	(0)
+#ifndef memblk_to_node
+#define memblk_to_node(memblk)	(0)
 #endif
-#ifndef __parent_node
-#define __parent_node(node)		(0)
+#ifndef parent_node
+#define parent_node(node)	(0)
 #endif
-#ifndef __node_to_first_cpu
-#define __node_to_first_cpu(node)	(0)
+#ifndef node_to_cpumask
+#define node_to_cpumask(node)	(cpu_online_map)
 #endif
-#ifndef __node_to_cpu_mask
-#define __node_to_cpu_mask(node)	(cpu_online_map)
+#ifndef node_to_first_cpu
+#define node_to_first_cpu(node)	(0)
 #endif
-#ifndef __node_to_memblk
-#define __node_to_memblk(node)		(0)
+#ifndef node_to_memblk
+#define node_to_memblk(node)	(0)
 #endif
 
 /* Cross-node load balancing interval. */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/include/asm-i386/cpu.h linux-2.5.59-underscore_free/include/asm-i386/cpu.h
--- linux-2.5.59-vanilla/include/asm-i386/cpu.h	Thu Jan 16 18:22:23 2003
+++ linux-2.5.59-underscore_free/include/asm-i386/cpu.h	Tue Jan 21 11:04:38 2003
@@ -17,7 +17,7 @@
 	struct node *parent = NULL;
 	
 #ifdef CONFIG_NUMA
-	parent = &node_devices[__cpu_to_node(num)].node;
+	parent = &node_devices[cpu_to_node(num)].node;
 #endif /* CONFIG_NUMA */
 
 	return register_cpu(&cpu_devices[num].cpu, num, parent);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/include/asm-i386/memblk.h linux-2.5.59-underscore_free/include/asm-i386/memblk.h
--- linux-2.5.59-vanilla/include/asm-i386/memblk.h	Thu Jan 16 18:22:16 2003
+++ linux-2.5.59-underscore_free/include/asm-i386/memblk.h	Tue Jan 21 11:04:38 2003
@@ -14,7 +14,7 @@
 extern struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
 
 static inline int arch_register_memblk(int num){
-	int p_node = __memblk_to_node(num);
+	int p_node = memblk_to_node(num);
 
 	return register_memblk(&memblk_devices[num].memblk, num, 
 				&node_devices[p_node].node);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/include/asm-i386/node.h linux-2.5.59-underscore_free/include/asm-i386/node.h
--- linux-2.5.59-vanilla/include/asm-i386/node.h	Thu Jan 16 18:21:48 2003
+++ linux-2.5.59-underscore_free/include/asm-i386/node.h	Tue Jan 21 11:04:38 2003
@@ -13,7 +13,7 @@
 extern struct i386_node node_devices[MAX_NUMNODES];
 
 static inline int arch_register_node(int num){
-	int p_node = __parent_node(num);
+	int p_node = parent_node(num);
 	struct node *parent = NULL;
 
 	if (p_node != num)
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/include/asm-i386/topology.h linux-2.5.59-underscore_free/include/asm-i386/topology.h
--- linux-2.5.59-vanilla/include/asm-i386/topology.h	Thu Jan 16 18:21:41 2003
+++ linux-2.5.59-underscore_free/include/asm-i386/topology.h	Tue Jan 21 11:04:38 2003
@@ -34,32 +34,32 @@
 extern volatile int cpu_2_node[];
 
 /* Returns the number of the node containing CPU 'cpu' */
-static inline int __cpu_to_node(int cpu)
+static inline int cpu_to_node(int cpu)
 { 
 	return cpu_2_node[cpu];
 }
 
 /* Returns the number of the node containing MemBlk 'memblk' */
-#define __memblk_to_node(memblk) (memblk)
+#define memblk_to_node(memblk) (memblk)
 
 /* Returns the number of the node containing Node 'node'.  This architecture is flat, 
    so it is a pretty simple function! */
-#define __parent_node(node) (node)
+#define parent_node(node) (node)
 
 /* Returns a bitmask of CPUs on Node 'node'. */
-static inline unsigned long __node_to_cpu_mask(int node)
+static inline unsigned long node_to_cpumask(int node)
 {
 	return node_2_cpu_mask[node];
 }
 
 /* Returns the number of the first CPU on Node 'node'. */
-static inline int __node_to_first_cpu(int node)
+static inline int node_to_first_cpu(int node)
 { 
-	return __ffs(__node_to_cpu_mask(node));
+	return __ffs(node_to_cpumask(node));
 }
 
 /* Returns the number of the first MemBlk on Node 'node' */
-#define __node_to_memblk(node) (node)
+#define node_to_memblk(node) (node)
 
 /* Cross-node load balancing interval. */
 #define NODE_BALANCE_RATE 100
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/include/asm-ia64/topology.h linux-2.5.59-underscore_free/include/asm-ia64/topology.h
--- linux-2.5.59-vanilla/include/asm-ia64/topology.h	Thu Jan 16 18:21:34 2003
+++ linux-2.5.59-underscore_free/include/asm-ia64/topology.h	Tue Jan 21 11:04:38 2003
@@ -21,25 +21,25 @@
 /*
  * Returns the number of the node containing CPU 'cpu'
  */
-#define __cpu_to_node(cpu) (int)(cpu_to_node_map[cpu])
+#define cpu_to_node(cpu) (int)(cpu_to_node_map[cpu])
 
 /*
  * Returns a bitmask of CPUs on Node 'node'.
  */
-#define __node_to_cpu_mask(node) (node_to_cpu_mask[node])
+#define node_to_cpumask(node) (node_to_cpumask[node])
 
 #else
-#define __cpu_to_node(cpu) (0)
-#define __node_to_cpu_mask(node) (phys_cpu_present_map)
+#define cpu_to_node(cpu) (0)
+#define node_to_cpumask(node) (phys_cpu_present_map)
 #endif
 
 /*
  * Returns the number of the node containing MemBlk 'memblk'
  */
 #ifdef CONFIG_ACPI_NUMA
-#define __memblk_to_node(memblk) (node_memblk[memblk].nid)
+#define memblk_to_node(memblk) (node_memblk[memblk].nid)
 #else
-#define __memblk_to_node(memblk) (memblk)
+#define memblk_to_node(memblk) (memblk)
 #endif
 
 /*
@@ -47,18 +47,18 @@
  * Not implemented here. Multi-level hierarchies detected with
  * the help of node_distance().
  */
-#define __parent_node(nid) (nid)
+#define parent_node(nid) (nid)
 
 /*
  * Returns the number of the first CPU on Node 'node'.
  */
-#define __node_to_first_cpu(node) (__ffs(__node_to_cpu_mask(node)))
+#define node_to_first_cpu(node) (__ffs(node_to_cpumask(node)))
 
 /*
  * Returns the number of the first MemBlk on Node 'node'
  * Should be fixed when IA64 discontigmem goes in.
  */
-#define __node_to_memblk(node) (node)
+#define node_to_memblk(node) (node)
 
 /* Cross-node load balancing interval. */
 #define NODE_BALANCE_RATE 10
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/include/asm-mips64/topology.h linux-2.5.59-underscore_free/include/asm-mips64/topology.h
--- linux-2.5.59-vanilla/include/asm-mips64/topology.h	Thu Jan 16 18:21:34 2003
+++ linux-2.5.59-underscore_free/include/asm-mips64/topology.h	Tue Jan 21 11:04:38 2003
@@ -3,6 +3,6 @@
 
 #include <asm/mmzone.h>
 
-#define __cpu_to_node(cpu)		(cputocnode(cpu))
+#define cpu_to_node(cpu)	(cputocnode(cpu))
 
 #endif /* _ASM_MIPS64_TOPOLOGY_H */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/include/asm-ppc64/topology.h linux-2.5.59-underscore_free/include/asm-ppc64/topology.h
--- linux-2.5.59-vanilla/include/asm-ppc64/topology.h	Thu Jan 16 18:22:51 2003
+++ linux-2.5.59-underscore_free/include/asm-ppc64/topology.h	Tue Jan 21 11:04:38 2003
@@ -5,7 +5,7 @@
 
 #ifdef CONFIG_NUMA
 
-static inline int __cpu_to_node(int cpu)
+static inline int cpu_to_node(int cpu)
 {
 	int node;
 
@@ -19,7 +19,7 @@
 	return node;
 }
 
-static inline int __node_to_first_cpu(int node)
+static inline int node_to_first_cpu(int node)
 {
 	int cpu;
 
@@ -31,7 +31,7 @@
 	return -1;
 }
 
-static inline unsigned long __node_to_cpu_mask(int node)
+static inline unsigned long node_to_cpumask(int node)
 {
 	int cpu;
 	unsigned long mask = 0UL;
@@ -51,12 +51,7 @@
 
 #else /* !CONFIG_NUMA */
 
-#define __cpu_to_node(cpu)		(0)
-#define __memblk_to_node(memblk)	(0)
-#define __parent_node(nid)		(0)
-#define __node_to_first_cpu(node)	(0)
-#define __node_to_cpu_mask(node)	(cpu_online_map)
-#define __node_to_memblk(node)		(0)
+#include <asm-generic/topology.h>
 
 #endif /* CONFIG_NUMA */
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/include/linux/mmzone.h linux-2.5.59-underscore_free/include/linux/mmzone.h
--- linux-2.5.59-vanilla/include/linux/mmzone.h	Thu Jan 16 18:21:34 2003
+++ linux-2.5.59-underscore_free/include/linux/mmzone.h	Tue Jan 21 11:04:38 2003
@@ -257,7 +257,7 @@
 
 #include <asm/topology.h>
 /* Returns the number of the current Node. */
-#define numa_node_id()		(__cpu_to_node(smp_processor_id()))
+#define numa_node_id()		(cpu_to_node(smp_processor_id()))
 
 #ifndef CONFIG_DISCONTIGMEM
 extern struct pglist_data contig_page_data;
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/kernel/sched.c linux-2.5.59-underscore_free/kernel/sched.c
--- linux-2.5.59-vanilla/kernel/sched.c	Thu Jan 16 18:22:29 2003
+++ linux-2.5.59-underscore_free/kernel/sched.c	Tue Jan 21 11:09:52 2003
@@ -213,7 +213,7 @@
 	int i;
 
 	for (i = 0; i < NR_CPUS; i++)
-		cpu_rq(i)->node_nr_running = &node_nr_running[__cpu_to_node(i)];
+		cpu_rq(i)->node_nr_running = &node_nr_running[cpu_to_node(i)];
 }
 
 #else /* !CONFIG_NUMA */
@@ -715,7 +715,7 @@
 	}
 
 	minload = 10000000;
-	cpumask = __node_to_cpu_mask(node);
+	cpumask = node_to_cpumask(node);
 	for (i = 0; i < NR_CPUS; ++i) {
 		if (!(cpumask & (1UL << i)))
 			continue;
@@ -767,7 +767,7 @@
 
 static inline unsigned long cpus_to_balance(int this_cpu, runqueue_t *this_rq)
 {
-	int this_node = __cpu_to_node(this_cpu);
+	int this_node = cpu_to_node(this_cpu);
 	/*
 	 * Avoid rebalancing between nodes too often.
 	 * We rebalance globally once every NODE_BALANCE_RATE load balances.
@@ -776,9 +776,9 @@
 		int node = find_busiest_node(this_node);
 		this_rq->nr_balanced = 0;
 		if (node >= 0)
-			return (__node_to_cpu_mask(node) | (1UL << this_cpu));
+			return (node_to_cpumask(node) | (1UL << this_cpu));
 	}
-	return __node_to_cpu_mask(this_node);
+	return node_to_cpumask(this_node);
 }
 
 #else /* !CONFIG_NUMA */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/mm/page_alloc.c linux-2.5.59-underscore_free/mm/page_alloc.c
--- linux-2.5.59-vanilla/mm/page_alloc.c	Thu Jan 16 18:21:38 2003
+++ linux-2.5.59-underscore_free/mm/page_alloc.c	Tue Jan 21 11:04:38 2003
@@ -1269,7 +1269,7 @@
 	pgdat->node_mem_map = node_mem_map;
 
 	free_area_init_core(pgdat, zones_size, zholes_size);
-	memblk_set_online(__node_to_memblk(nid));
+	memblk_set_online(node_to_memblk(nid));
 
 	calculate_zone_bitmap(pgdat, zones_size);
 }
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/mm/vmscan.c linux-2.5.59-underscore_free/mm/vmscan.c
--- linux-2.5.59-vanilla/mm/vmscan.c	Thu Jan 16 18:21:39 2003
+++ linux-2.5.59-underscore_free/mm/vmscan.c	Tue Jan 21 11:04:38 2003
@@ -929,7 +929,7 @@
 	DEFINE_WAIT(wait);
 
 	daemonize();
-	set_cpus_allowed(tsk, __node_to_cpu_mask(pgdat->node_id));
+	set_cpus_allowed(tsk, node_to_cpumask(pgdat->node_id));
 	sprintf(tsk->comm, "kswapd%d", pgdat->node_id);
 	sigfillset(&tsk->blocked);
 	

--------------040608080904080909020802--

