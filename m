Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbUC2M0z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUC2M0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:26:33 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:53433 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262843AbUC2MQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:16:20 -0500
Date: Mon, 29 Mar 2004 04:15:37 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] mask ADT: ia64 changes from Matthew's nodemask_t Patch 6/7
 [15/22]
Message-Id: <20040329041537.2c9e6951.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_15_of_22 - Matthew Dobson's [PATCH]_nodemask_t_ia64_changes_[6_7]
	Changes to ia64 specific code.  Untested.
	Code review & testing requested.

diffstat Patch_15_of_22:
 arch/ia64/kernel/acpi.c                  |   15 +++++----
 arch/ia64/kernel/smpboot.c               |    2 -
 arch/ia64/mm/discontig.c                 |   48 ++++++++++++++++---------------
 arch/ia64/mm/hugetlbpage.c               |    9 ++---
 arch/ia64/mm/numa.c                      |    6 +--
 arch/ia64/sn/fakeprom/fpmem.c            |    8 ++---
 arch/ia64/sn/io/machvec/pci_bus_cvlink.c |    3 -
 arch/ia64/sn/io/sn2/klconflib.c          |    4 +-
 arch/ia64/sn/io/sn2/klgraph.c            |    4 +-
 arch/ia64/sn/io/sn2/ml_SN_init.c         |    2 -
 arch/ia64/sn/io/sn2/ml_SN_intr.c         |    4 +-
 arch/ia64/sn/io/sn2/ml_iograph.c         |    2 -
 arch/ia64/sn/io/sn2/module.c             |    4 +-
 arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c    |    4 +-
 arch/ia64/sn/io/sn2/shub.c               |   18 +++++++----
 arch/ia64/sn/kernel/setup.c              |   12 +++----
 arch/ia64/sn/kernel/sn2/prominfo_proc.c  |   16 +++++-----
 arch/ia64/sn/kernel/sn2/sn2_smp.c        |    2 -
 include/asm-ia64/numa.h                  |    2 -
 include/asm-ia64/sn/sn2/sn_private.h     |    4 +-
 20 files changed, 88 insertions(+), 81 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1721  -> 1.1722 
#	arch/ia64/sn/io/sn2/ml_iograph.c	1.20    -> 1.21   
#	arch/ia64/sn/io/sn2/ml_SN_init.c	1.11    -> 1.12   
#	arch/ia64/sn/io/sn2/klconflib.c	1.14    -> 1.15   
#	arch/ia64/sn/io/sn2/module.c	1.10    -> 1.11   
#	include/asm-ia64/sn/sn2/sn_private.h	1.13    -> 1.14   
#	arch/ia64/sn/kernel/sn2/prominfo_proc.c	1.3     -> 1.4    
#	arch/ia64/kernel/smpboot.c	1.47    -> 1.48   
#	arch/ia64/sn/kernel/setup.c	1.33    -> 1.34   
#	 arch/ia64/mm/numa.c	1.7     -> 1.8    
#	include/asm-ia64/numa.h	1.15    -> 1.16   
#	arch/ia64/sn/fakeprom/fpmem.c	1.8     -> 1.9    
#	arch/ia64/kernel/acpi.c	1.63    -> 1.64   
#	arch/ia64/mm/hugetlbpage.c	1.18    -> 1.19   
#	arch/ia64/sn/io/sn2/shub.c	1.13    -> 1.14   
#	arch/ia64/sn/io/sn2/klgraph.c	1.12    -> 1.13   
#	arch/ia64/sn/io/sn2/ml_SN_intr.c	1.10    -> 1.11   
#	arch/ia64/sn/io/machvec/pci_bus_cvlink.c	1.36    -> 1.37   
#	arch/ia64/mm/discontig.c	1.12    -> 1.13   
#	arch/ia64/sn/kernel/sn2/sn2_smp.c	1.10    -> 1.11   
#	arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c	1.29    -> 1.30   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/28	pj@sgi.com	1.1722
# Matthew Dobson's [PATCH]_nodemask_t_ia64_changes_[6_7] of 18 Mar 2004:
#   Changes to ia64 specific code.  Untested.
#   Code review & testing requested.
# --------------------------------------------
#
diff -Nru a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
--- a/arch/ia64/kernel/acpi.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/kernel/acpi.c	Mon Mar 29 01:03:56 2004
@@ -450,14 +450,15 @@
 	}
 
 	/* calculate total number of nodes in system from PXM bitmap */
-	numnodes = 0;		/* init total nodes in system */
+	nodes_clear(node_online_map);	/* init total nodes in system */
 
 	memset(pxm_to_nid_map, -1, sizeof(pxm_to_nid_map));
 	memset(nid_to_pxm_map, -1, sizeof(nid_to_pxm_map));
 	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
 		if (pxm_bit_test(i)) {
-			pxm_to_nid_map[i] = numnodes;
-			nid_to_pxm_map[numnodes++] = i;
+			pxm_to_nid_map[i] = num_online_nodes();
+			nid_to_pxm_map[num_online_nodes()] = i;
+			node_set_online(num_online_nodes());
 		}
 	}
 
@@ -466,7 +467,7 @@
 		node_memblk[i].nid = pxm_to_nid_map[node_memblk[i].nid];
 
 	/* assign memory bank numbers for each chunk on each node */
-	for (i = 0; i < numnodes; i++) {
+	for_each_online_node(i) {
 		int bank;
 
 		bank = 0;
@@ -479,7 +480,7 @@
 	for (i = 0; i < srat_num_cpus; i++)
 		node_cpuid[i].nid = pxm_to_nid_map[node_cpuid[i].nid];
 
-	printk(KERN_INFO "Number of logical nodes in system = %d\n", numnodes);
+	printk(KERN_INFO "Number of logical nodes in system = %d\n", num_online_nodes());
 	printk(KERN_INFO "Number of memory chunks in system = %d\n", num_node_memblks);
 
 	if (!slit_table) return;
@@ -499,8 +500,8 @@
 
 #ifdef SLIT_DEBUG
 	printk("ACPI 2.0 SLIT locality table:\n");
-	for (i = 0; i < numnodes; i++) {
-		for (j = 0; j < numnodes; j++)
+	for_each_online_node(i) {
+		for_each_online_node(j)
 			printk("%03d ", node_distance(i,j));
 		printk("\n");
 	}
diff -Nru a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
--- a/arch/ia64/kernel/smpboot.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/kernel/smpboot.c	Mon Mar 29 01:03:56 2004
@@ -474,7 +474,7 @@
 {
 	int cpu, i, node;
 
-	for(node=0; node<MAX_NUMNODES; node++)
+	for_each_node(node)
 		cpus_clear(node_to_cpu_mask[node]);
 	for(cpu = 0; cpu < NR_CPUS; ++cpu) {
 		/*
diff -Nru a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
--- a/arch/ia64/mm/discontig.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/mm/discontig.c	Mon Mar 29 01:03:56 2004
@@ -68,7 +68,7 @@
 	/*
 	 * All nids with memory.
 	 */
-	if (nnode == numnodes)
+	if (nnode == num_online_nodes())
 		return;
 
 	/*
@@ -77,10 +77,11 @@
 	 * For reassigned CPU nodes a nid can't be arrived at
 	 * until after this loop because the target nid's new
 	 * identity might not have been established yet. So
-	 * new nid values are fabricated above numnodes and
+	 * new nid values are fabricated above num_online_nodes() and
 	 * mapped back later to their true value.
 	 */
-	for (nid = 0, i = 0; i < numnodes; i++)  {
+	nid = 0;
+	for_each_online_node(i) {
 		if (test_bit(i, (void *) nodes_with_mem)) {
 			/*
 			 * Save original nid value for numa_slit
@@ -100,12 +101,12 @@
 			cpunid = nid;
 			nid++;
 		} else
-			cpunid = numnodes;
+			cpunid = num_online_nodes();
 
 		for (cpu = 0; cpu < NR_CPUS; cpu++)
 			if (node_cpuid[cpu].nid == i) {
 				/* For nodes not being reassigned just fix the cpu's nid. */
-				if (cpunid < numnodes) {
+				if (cpunid < num_online_nodes()) {
 					node_cpuid[cpu].nid = cpunid;
 					continue;
 				}
@@ -113,15 +114,17 @@
 				/*
 				 * For nodes being reassigned, find best node by
 				 * numa_slit information and then make a temporary
-				 * nid value based on current nid and numnodes.
+				 * nid value based on current nid and num_online_nodes().
 				 */
-				for (slit = 0xff, k = numnodes + numnodes, j = 0; j < numnodes; j++)
+				slit = 0xff;
+				k = 2 * num_online_nodes();
+				for_each_online_node(j)
 					if (i == j)
 						continue;
 					else if (test_bit(j, (void *) nodes_with_mem)) {
-						cslit = numa_slit[i * numnodes + j];
+						cslit = numa_slit[i * num_online_nodes() + j];
 						if (cslit < slit) {
-							k = numnodes + j;
+							k = num_online_nodes() + j;
 							slit = cslit;
 						}
 					}
@@ -134,11 +137,11 @@
 	 * Fixup temporary nid values for CPU-only nodes.
 	 */
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
-		if (node_cpuid[cpu].nid == (numnodes + numnodes))
+		if (node_cpuid[cpu].nid == (2 * num_online_nodes()))
 			node_cpuid[cpu].nid = nnode - 1;
 		else
 			for (i = 0; i < nnode; i++)
-				if (node_flip[i] == (node_cpuid[cpu].nid - numnodes)) {
+				if (node_flip[i] == (node_cpuid[cpu].nid - num_online_nodes())) {
 					node_cpuid[cpu].nid = i;
 					break;
 				}
@@ -150,11 +153,12 @@
 	for (i = 0; i < nnode; i++)
 		for (j = 0; j < nnode; j++)
 			numa_slit_fix[i * nnode + j] =
-				numa_slit[node_flip[i] * numnodes + node_flip[j]];
+				numa_slit[node_flip[i] * num_online_nodes() + node_flip[j]];
 
 	memcpy(numa_slit, numa_slit_fix, sizeof (numa_slit));
 
-	numnodes = nnode;
+	for(i = 0; i < nnode; i++)
+		node_set_online(i);
 
 	return;
 }
@@ -353,7 +357,7 @@
 	struct bootmem_data *bdp;
 	int node;
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		pg_data_t *pdp = mem_data[node].pgdat;
 
 		bdp = pdp->bdata;
@@ -384,11 +388,11 @@
 	int cpu, node;
 	pg_data_t *pgdat_list[NR_NODES];
 
-	for (node = 0; node < numnodes; node++)
+	for_each_online_node(node)
 		pgdat_list[node] = mem_data[node].pgdat;
 
 	/* Copy the pg_data_t list to each node and init the node field */
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		memcpy(mem_data[node].node_data->pg_data_ptrs, pgdat_list,
 		       sizeof(pgdat_list));
 	}
@@ -412,15 +416,15 @@
 
 	reserve_memory();
 
-	if (numnodes == 0) {
+	if (num_online_nodes() == 0) {
 		printk(KERN_ERR "node info missing!\n");
-		numnodes = 1;
+		node_set_online(0);
 	}
 
 	min_low_pfn = -1;
 	max_low_pfn = 0;
 
-	if (numnodes > 1)
+	if (num_online_nodes() > 1)
 		reassign_cpu_only_nodes();
 
 	/* These actually end up getting called by call_pernode_memory() */
@@ -431,7 +435,7 @@
 	 * Initialize the boot memory maps in reverse order since that's
 	 * what the bootmem allocator expects
 	 */
-	for (node = numnodes - 1; node >= 0; node--) {
+	for (node = num_online_nodes() - 1; node >= 0; node--) {
 		unsigned long pernode, pernodesize, map;
 		struct bootmem_data *bdp;
 
@@ -610,12 +614,12 @@
 	efi_memmap_walk(find_largest_hole, &max_gap);
 
 	/* so min() will work in count_node_pages */
-	for (node = 0; node < numnodes; node++)
+	for_each_online_node(node)
 		mem_data[node].min_pfn = ~0UL;
 
 	efi_memmap_walk(filter_rsvd_memory, count_node_pages);
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		memset(zones_size, 0, sizeof(zones_size));
 		memset(zholes_size, 0, sizeof(zholes_size));
 
diff -Nru a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
--- a/arch/ia64/mm/hugetlbpage.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/mm/hugetlbpage.c	Mon Mar 29 01:03:56 2004
@@ -42,12 +42,11 @@
 	struct page *page = NULL;
 
 	if (list_empty(&hugepage_freelists[nid])) {
-		for (nid = 0; nid < MAX_NUMNODES; ++nid)
+		for_each_node(nid)
 			if (!list_empty(&hugepage_freelists[nid]))
 				break;
 	}
-	if (nid >= 0 && nid < MAX_NUMNODES &&
-	    !list_empty(&hugepage_freelists[nid])) {
+	if (node_possible(nid) && !list_empty(&hugepage_freelists[nid])) {
 		page = list_entry(hugepage_freelists[nid].next, struct page, list);
 		list_del(&page->list);
 	}
@@ -59,7 +58,7 @@
 	static int nid = 0;
 	struct page *page;
 	page = alloc_pages_node(nid, GFP_HIGHUSER, HUGETLB_PAGE_ORDER);
-	nid = (nid + 1) % numnodes;
+	nid = (nid + 1) % num_online_nodes();
 	return page;
 }
 
@@ -557,7 +556,7 @@
 	int i;
 	struct page *page;
 
-	for (i = 0; i < MAX_NUMNODES; ++i)
+	for_each_node(i)
 		INIT_LIST_HEAD(&hugepage_freelists[i]);
 
 	for (i = 0; i < htlbpage_max; ++i) {
diff -Nru a/arch/ia64/mm/numa.c b/arch/ia64/mm/numa.c
--- a/arch/ia64/mm/numa.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/mm/numa.c	Mon Mar 29 01:03:56 2004
@@ -54,12 +54,12 @@
 {
 	int i, err = 0;
 
-	sysfs_nodes = kmalloc(sizeof(struct node) * numnodes, GFP_KERNEL);
+	sysfs_nodes = kmalloc(sizeof(struct node) * num_online_nodes(), GFP_KERNEL);
 	if (!sysfs_nodes) {
 		err = -ENOMEM;
 		goto out;
 	}
-	memset(sysfs_nodes, 0, sizeof(struct node) * numnodes);
+	memset(sysfs_nodes, 0, sizeof(struct node) * num_online_nodes());
 
 	sysfs_cpus = kmalloc(sizeof(struct cpu) * NR_CPUS, GFP_KERNEL);
 	if (!sysfs_cpus) {
@@ -69,7 +69,7 @@
 	}
 	memset(sysfs_cpus, 0, sizeof(struct cpu) * NR_CPUS);
 
-	for (i = 0; i < numnodes; i++)
+	for_each_online_node(i)
 		if ((err = register_node(&sysfs_nodes[i], i, 0)))
 			goto out;
 
diff -Nru a/arch/ia64/sn/fakeprom/fpmem.c b/arch/ia64/sn/fakeprom/fpmem.c
--- a/arch/ia64/sn/fakeprom/fpmem.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/sn/fakeprom/fpmem.c	Mon Mar 29 01:03:56 2004
@@ -26,7 +26,7 @@
  *
  *		32 bit		32 bit
  *
- * 		numnodes	numcpus
+ * 		num_nodes	numcpus
  *
  *		16 bit   16 bit		   32 bit
  *		nasid0	cpuconf		membankdesc0
@@ -59,7 +59,7 @@
 #endif
 
 /*
- * For SN, this may not take an arg and gets the numnodes from 
+ * For SN, this may not take an arg and gets the num_nodes from 
  * the prom variable or by traversing klcfg or promcfg
  */
 int
@@ -144,7 +144,7 @@
 int
 build_efi_memmap(void *md, int mdsize)
 {
-	int		numnodes = GetNumNodes() ;
+	int		num_nodes = GetNumNodes() ;
 	int		cnode,bank ;
 	int		nasid ;
 	node_memmap_t	membank_info ;
@@ -153,7 +153,7 @@
 	long		paddr, hole, numbytes;
 
 
-	for (cnode=0;cnode<numnodes;cnode++) {
+	for (cnode=0; cnode<num_nodes; cnode++) {
 		nasid = GetNasid(cnode) ;
 		membank_info = GetMemBankInfo(cnode) ;
 		for (bank=0;bank<MD_BANKS_PER_NODE;bank++) {
diff -Nru a/arch/ia64/sn/io/machvec/pci_bus_cvlink.c b/arch/ia64/sn/io/machvec/pci_bus_cvlink.c
--- a/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	Mon Mar 29 01:03:56 2004
@@ -791,7 +791,6 @@
 	struct list_head *ln;
 	struct pci_bus *pci_bus = NULL;
 	struct pci_dev *pci_dev = NULL;
-	extern int numnodes;
 	int cnode, ret;
 #ifdef CONFIG_PROC_FS
 	extern void register_sn_procfs(void);
@@ -814,7 +813,7 @@
 
 	sgi_master_io_infr_init();
 
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		extern void intr_init_vecblk(cnodeid_t);
 		intr_init_vecblk(cnode);
 	}
diff -Nru a/arch/ia64/sn/io/sn2/klconflib.c b/arch/ia64/sn/io/sn2/klconflib.c
--- a/arch/ia64/sn/io/sn2/klconflib.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/sn/io/sn2/klconflib.c	Mon Mar 29 01:03:56 2004
@@ -62,7 +62,7 @@
 		    (start->brd_nasid == nasid))
 			return start;
 
-		if (numionodes == numnodes)
+		if (numionodes == num_online_nodes())
 			start = KLCF_NEXT_ANY(start);
 		else
 			start = KLCF_NEXT(start);
@@ -95,7 +95,7 @@
 		    (start->brd_nasid == nasid))
 			return start;
 
-		if (numionodes == numnodes)
+		if (numionodes == num_online_nodes())
 			start = KLCF_NEXT_ANY(start);
 		else
 			start = KLCF_NEXT(start);
diff -Nru a/arch/ia64/sn/io/sn2/klgraph.c b/arch/ia64/sn/io/sn2/klgraph.c
--- a/arch/ia64/sn/io/sn2/klgraph.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/sn/io/sn2/klgraph.c	Mon Mar 29 01:03:56 2004
@@ -279,7 +279,7 @@
 	char path_buffer[100];
 	int rv;
 
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		nasid = COMPACT_TO_NASID_NODEID(cnode);
 		brd = find_lboard_class_any((lboard_t *)KL_CONFIG_INFO(nasid),
 				KLTYPE_ROUTER);
@@ -413,7 +413,7 @@
 	cnodeid_t cnode;
 	lboard_t *brd;
 
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		nasid = COMPACT_TO_NASID_NODEID(cnode);
 		brd = find_lboard_class_any((lboard_t *)KL_CONFIG_INFO(nasid),
 				KLTYPE_ROUTER);
diff -Nru a/arch/ia64/sn/io/sn2/ml_SN_init.c b/arch/ia64/sn/io/sn2/ml_SN_init.c
--- a/arch/ia64/sn/io/sn2/ml_SN_init.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/sn/io/sn2/ml_SN_init.c	Mon Mar 29 01:03:56 2004
@@ -38,7 +38,7 @@
 	/* Allocate per-node platform-dependent data */
 	
 	nasid = COMPACT_TO_NASID_NODEID(node);
-	if (node >= numnodes) /* Headless/memless IO nodes */
+	if (node >= num_online_nodes()) /* Headless/memless IO nodes */
 		hubinfo = (hubinfo_t)alloc_bootmem_node(NODE_DATA(0), sizeof(struct hubinfo_s));
 	else
 		hubinfo = (hubinfo_t)alloc_bootmem_node(NODE_DATA(node), sizeof(struct hubinfo_s));
diff -Nru a/arch/ia64/sn/io/sn2/ml_SN_intr.c b/arch/ia64/sn/io/sn2/ml_SN_intr.c
--- a/arch/ia64/sn/io/sn2/ml_SN_intr.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/sn/io/sn2/ml_SN_intr.c	Mon Mar 29 01:03:56 2004
@@ -256,12 +256,12 @@
 	cnodeid_t candidate_node;
 	cpuid_t cpuid;
 
-	if (last_node >= numnodes)
+	if (last_node >= num_online_nodes())
 		last_node = 0;
 
 	for (candidate_node = last_node + 1; candidate_node != last_node;
 			candidate_node++) {
-		if (candidate_node == numnodes)
+		if (candidate_node == num_online_nodes())
 			candidate_node = 0;
 		cpuid = intr_cpu_choose_from_node(candidate_node);
 		if (cpuid != CPU_NONE)
diff -Nru a/arch/ia64/sn/io/sn2/ml_iograph.c b/arch/ia64/sn/io/sn2/ml_iograph.c
--- a/arch/ia64/sn/io/sn2/ml_iograph.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/sn/io/sn2/ml_iograph.c	Mon Mar 29 01:03:56 2004
@@ -680,7 +680,7 @@
 		DBG("init_all_devices: Done io_init_node() for cnode %d\n", cnodeid);
 	}
 
-	for (cnodeid = 0; cnodeid < numnodes; cnodeid++) {
+	for_each_online_node(cnodeid) {
 		/*
 	 	 * Update information generated by IO init.
 		 */
diff -Nru a/arch/ia64/sn/io/sn2/module.c b/arch/ia64/sn/io/sn2/module.c
--- a/arch/ia64/sn/io/sn2/module.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/sn/io/sn2/module.c	Mon Mar 29 01:03:56 2004
@@ -195,7 +195,7 @@
      * First pass just scan for compute node boards KLTYPE_SNIA.
      * We do not support memoryless compute nodes.
      */
-    for (node = 0; node < numnodes; node++) {
+    for_each_online_node(node) {
 	nasid = COMPACT_TO_NASID_NODEID(node);
 	board = find_lboard_nasid((lboard_t *) KL_CONFIG_INFO(nasid), nasid, KLTYPE_SNIA);
 	ASSERT(board);
@@ -210,7 +210,7 @@
     /*
      * Second scan, look for headless/memless board hosted by compute nodes.
      */
-    for (node = numnodes; node < numionodes; node++) {
+    for (node = num_online_nodes(); node < numionodes; node++) {
 	nasid_t		nasid;
 	char		serial_number[16];
 
diff -Nru a/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c b/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c
--- a/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c	Mon Mar 29 01:03:56 2004
@@ -2639,7 +2639,7 @@
 		if (brd->brd_flags & LOCAL_MASTER_IO6) {
 			return 1;
 		}
-                if (numionodes == numnodes)
+                if (numionodes == num_online_nodes())
                         brd = KLCF_NEXT_ANY(brd);
                 else
                         brd = KLCF_NEXT(brd);
@@ -2652,7 +2652,7 @@
 		if (brd->brd_flags & LOCAL_MASTER_IO6) {
 			return 1;
 		}
-                if (numionodes == numnodes)
+                if (numionodes == num_online_nodes())
                         brd = KLCF_NEXT_ANY(brd);
                 else
                         brd = KLCF_NEXT(brd);
diff -Nru a/arch/ia64/sn/io/sn2/shub.c b/arch/ia64/sn/io/sn2/shub.c
--- a/arch/ia64/sn/io/sn2/shub.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/sn/io/sn2/shub.c	Mon Mar 29 01:03:56 2004
@@ -165,7 +165,7 @@
 	int		nasid;
 
         cnode = (cnodeid_t)file->f_dentry->d_fsdata;
-        if (cnode < 0 || cnode >= numnodes)
+        if (cnode < 0 || cnode >= num_online_nodes())
                 return -ENODEV;
 
         switch (cmd) {
@@ -239,8 +239,8 @@
 	uint64_t	    llp_csr_reg;
 
 	spin_lock(&sn_linkstats_lock);
-	memset(sn_linkstats, 0, numnodes * sizeof(struct s_linkstats));
-	for (cnode=0; cnode < numnodes; cnode++) {
+	memset(sn_linkstats, 0, num_online_nodes() * sizeof(struct s_linkstats));
+	for_each_online_node(cnode) {
 	    shub_mmr_write(cnode, SH_NI0_LLP_ERR, 0L);
 	    shub_mmr_write(cnode, SH_NI1_LLP_ERR, 0L);
 	    shub_mmr_write_iospace(cnode, IIO_LLP_LOG, 0L);
@@ -286,7 +286,8 @@
 		spin_lock(&sn_linkstats_lock);
 
 		overflows = 0;
-		for (lsp=sn_linkstats, cnode=0; cnode < numnodes; cnode++, lsp++) {
+		lsp = sn_linkstats;
+		for_each_online_node(cnode) {
 			reg[0] = shub_mmr_read(cnode, SH_NI0_LLP_ERR);
 			reg[1] = shub_mmr_read(cnode, SH_NI1_LLP_ERR);
 			if (lsp->hs_ii_up) {
@@ -349,6 +350,7 @@
 			    iio_wstat &= 0xffffffffff00ffff; /* bits 23:16 */
 			    shub_mmr_write_iospace(cnode, IIO_WSTAT, iio_wstat);
 			}
+			lsp++;
 		}
 
 		sn_linkstats_samples++;
@@ -401,7 +403,8 @@
 	n += sprintf(page+n, "%-37s %8s %8s %8s %8s\n",
 		"# Numalink", "sn errs", "cb errs", "cb/min", "retries");
 
-	for (lsp=sn_linkstats, cnode=0; cnode < numnodes; cnode++, lsp++) {
+	lsp = sn_linkstats;
+	for_each_online_node(cnode) {
 		npda = NODEPDA(cnode);
 
 		/* two NL links on each SHub */
@@ -411,7 +414,7 @@
 			retrysum += lsp->hs_ni_retry_errors[nlport];
 
 			/* avoid buffer overrun (should be using seq_read API) */
-			if (numnodes > 64)
+			if (num_online_nodes() > 64)
 				continue;
 
 			n += sprintf(page + n, "/%s/link/%d  %8lu %8lu %8s %8lu\n",
@@ -432,6 +435,7 @@
 		    cbsum_ii += lsp->hs_ii_cb_errors;
 		    retrysum_ii += lsp->hs_ii_retry_errors;
 		}
+		lsp++;
 	}
 
 	n += sprintf(page + n, "%-37s %8lu %8lu %8s %8lu\n",
@@ -454,7 +458,7 @@
 		return -ENODEV;
 
 	spin_lock_init(&sn_linkstats_lock);
-	sn_linkstats = kmalloc(numnodes * sizeof(struct s_linkstats), GFP_KERNEL);
+	sn_linkstats = kmalloc(num_online_nodes() * sizeof(struct s_linkstats), GFP_KERNEL);
 	sn_linkstats_reset(60000UL); /* default 60 second update interval */
 	kernel_thread(linkstatd_thread, NULL, CLONE_KERNEL);
 
diff -Nru a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
--- a/arch/ia64/sn/kernel/setup.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/sn/kernel/setup.c	Mon Mar 29 01:03:56 2004
@@ -224,7 +224,7 @@
 {
 	int	cnode;
 
-	for (cnode=0; cnode< numnodes; cnode++)
+	for_each_online_node(cnode)
 		if (is_shub_1_1(cnodeid_to_nasid(cnode)))
 			shub_1_1_found = 1;
 }
@@ -372,16 +372,16 @@
 		panic("overflow of cpu_data page");
 
 	memset(pda->cnodeid_to_nasid_table, -1, sizeof(pda->cnodeid_to_nasid_table));
-	for (cnode=0; cnode<numnodes; cnode++)
+	for_each_online_node(cnode)
 		pda->cnodeid_to_nasid_table[cnode] = pxm_to_nasid(nid_to_pxm_map[cnode]);
 
-	numionodes = numnodes;
+	numionodes = num_online_nodes();
 	scan_for_ionodes();
 
         /*
          * Allocate & initalize the nodepda for each node.
          */
-        for (cnode=0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		nodepdaindr[cnode] = alloc_bootmem_node(NODE_DATA(cnode), sizeof(nodepda_t));
 		memset(nodepdaindr[cnode], 0, sizeof(nodepda_t));
         }
@@ -398,7 +398,7 @@
 	 * The following routine actually sets up the hubinfo struct
 	 * in nodepda.
 	 */
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		init_platform_nodepda(nodepdaindr[cnode], cnode);
 		bte_init_node (nodepdaindr[cnode], cnode);
 	}
@@ -486,7 +486,7 @@
 
 	if (nodepda->node_first_cpu == cpuid) {
 		int	buddy_nasid;
-		buddy_nasid = cnodeid_to_nasid(numa_node_id() == numnodes-1 ? 0 : numa_node_id()+ 1);
+		buddy_nasid = cnodeid_to_nasid(numa_node_id() == num_online_nodes()-1 ? 0 : numa_node_id()+ 1);
 		pda->pio_shub_war_cam_addr = (volatile unsigned long*)GLOBAL_MMR_ADDR(nasid, SH_PI_CAM_CONTROL);
 	}
 
diff -Nru a/arch/ia64/sn/kernel/sn2/prominfo_proc.c b/arch/ia64/sn/kernel/sn2/prominfo_proc.c
--- a/arch/ia64/sn/kernel/sn2/prominfo_proc.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/sn/kernel/sn2/prominfo_proc.c	Mon Mar 29 01:03:56 2004
@@ -320,16 +320,15 @@
 	TRACE();
 
 	DPRINTK("running on cpu %d\n", smp_processor_id());
-	DPRINTK("numnodes %d\n", numnodes);
+	DPRINTK("num_online_nodes() %d\n", num_online_nodes());
 
-	proc_entries = kmalloc(numnodes * sizeof(struct proc_dir_entry *),
+	proc_entries = kmalloc(num_online_nodes() * sizeof(struct proc_dir_entry *),
 			       GFP_KERNEL);
 
 	sgi_prominfo_entry = proc_mkdir("sgi_prominfo", NULL);
 
-	for (cnodeid = 0, entp = proc_entries;
-	     cnodeid < numnodes;
-	     cnodeid++, entp++) {
+	entp = proc_entries;
+	for_each_online_node(cnodeid) {
 		sprintf(name, "node%d", cnodeid);
 		*entp = proc_mkdir(name, sgi_prominfo_entry);
 		nasid = cnodeid_to_nasid(cnodeid);
@@ -339,6 +338,7 @@
 		create_proc_read_entry(
 			"version", 0, *entp, read_version_entry,
 			lookup_fit(nasid));
+		entp++;
 	}
 
 	return 0;
@@ -353,13 +353,13 @@
 
 	TRACE();
 
-	for (cnodeid = 0, entp = proc_entries;
-	     cnodeid < numnodes;
-	     cnodeid++, entp++) {
+	entp = proc_entries;
+	for_each_online_node(cnodeid) {
 		remove_proc_entry("fit", *entp);
 		remove_proc_entry("version", *entp);
 		sprintf(name, "node%d", cnodeid);
 		remove_proc_entry(name, sgi_prominfo_entry);
+		entp++;
 	}
 	remove_proc_entry("sgi_prominfo", NULL);
 	kfree(proc_entries);
diff -Nru a/arch/ia64/sn/kernel/sn2/sn2_smp.c b/arch/ia64/sn/kernel/sn2/sn2_smp.c
--- a/arch/ia64/sn/kernel/sn2/sn2_smp.c	Mon Mar 29 01:03:56 2004
+++ b/arch/ia64/sn/kernel/sn2/sn2_smp.c	Mon Mar 29 01:03:56 2004
@@ -183,7 +183,7 @@
 
 	mycnode = numa_node_id();
 
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		if (is_headless_node(cnode) || cnode == mycnode)
 			continue;
 		nasid = cnodeid_to_nasid(cnode);
diff -Nru a/include/asm-ia64/numa.h b/include/asm-ia64/numa.h
--- a/include/asm-ia64/numa.h	Mon Mar 29 01:03:56 2004
+++ b/include/asm-ia64/numa.h	Mon Mar 29 01:03:56 2004
@@ -59,7 +59,7 @@
  */
 
 extern u8 numa_slit[MAX_NUMNODES * MAX_NUMNODES];
-#define node_distance(from,to) (numa_slit[from * numnodes + to])
+#define node_distance(from,to) (numa_slit[from * num_online_nodes() + to])
 
 extern int paddr_to_nid(unsigned long paddr);
 
diff -Nru a/include/asm-ia64/sn/sn2/sn_private.h b/include/asm-ia64/sn/sn2/sn_private.h
--- a/include/asm-ia64/sn/sn2/sn_private.h	Mon Mar 29 01:03:56 2004
+++ b/include/asm-ia64/sn/sn2/sn_private.h	Mon Mar 29 01:03:56 2004
@@ -87,9 +87,9 @@
 void install_klidbg_functions(void);
 
 /* klnuma.c */
-extern void replicate_kernel_text(int numnodes);
+extern void replicate_kernel_text(void);  /* TODO: is this used??? */
 extern unsigned long get_freemem_start(cnodeid_t cnode);
-extern void setup_replication_mask(int maxnodes);
+extern void setup_replication_mask(void); /* TODO: is this used??? */
 
 /* init.c */
 extern cnodeid_t get_compact_nodeid(void);	/* get compact node id */


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
