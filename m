Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265719AbUF2LfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265719AbUF2LfS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 07:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265727AbUF2Lex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 07:34:53 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:10184 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265729AbUF2LXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 07:23:53 -0400
Date: Tue, 29 Jun 2004 04:22:13 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Jack Steiner <steiner@sgi.com>,
       Jesse Barnes <jbarnes@sgi.com>, Paul Jackson <pj@sgi.com>,
       Dan Higgins <djh@sgi.com>, Matthew Dobson <colpatch@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Sylvain <sylvain.jeaugey@bull.net>,
       Simon <Simon.Derr@bull.net>
Message-Id: <20040629112213.24730.26304.69746@sam.engr.sgi.com>
In-Reply-To: <20040629112140.24730.18796.34300@sam.engr.sgi.com>
References: <20040629112140.24730.18796.34300@sam.engr.sgi.com>
Subject: [patch 4/8] cpusets v3 - nodemask patch (draft of Matthew Dobson's patch)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides a nodemask_t type, similar to cpumask_t,
except it contains MAX_NUMNODES bits, instead of NR_CPUS.

The node_online_map is made to be of this nodemask_t type,
and some minor changes in users of node_online_map are
required.

This is a draft of a nodemask_t patch that I anticipate
Matthew Dobson of IBM will be submitting.

Index: 2.6.7-mm4/arch/i386/kernel/numaq.c
===================================================================
--- 2.6.7-mm4.orig/arch/i386/kernel/numaq.c	2004-06-28 19:34:33.000000000 -0700
+++ 2.6.7-mm4/arch/i386/kernel/numaq.c	2004-06-28 20:14:26.000000000 -0700
@@ -28,6 +28,7 @@
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
 #include <linux/module.h>
+#include <linux/nodemask.h>
 #include <asm/numaq.h>
 
 /* These are needed before the pgdat's are created */
Index: 2.6.7-mm4/arch/i386/kernel/srat.c
===================================================================
--- 2.6.7-mm4.orig/arch/i386/kernel/srat.c	2004-06-28 19:34:33.000000000 -0700
+++ 2.6.7-mm4/arch/i386/kernel/srat.c	2004-06-28 20:14:37.000000000 -0700
@@ -28,6 +28,7 @@
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
 #include <linux/acpi.h>
+#include <linux/nodemask.h>
 #include <asm/srat.h>
 
 /*
Index: 2.6.7-mm4/arch/i386/mm/discontig.c
===================================================================
--- 2.6.7-mm4.orig/arch/i386/mm/discontig.c	2004-06-28 19:40:38.000000000 -0700
+++ 2.6.7-mm4/arch/i386/mm/discontig.c	2004-06-28 20:14:47.000000000 -0700
@@ -28,6 +28,7 @@
 #include <linux/mmzone.h>
 #include <linux/highmem.h>
 #include <linux/initrd.h>
+#include <linux/nodemask.h>
 #include <asm/e820.h>
 #include <asm/setup.h>
 #include <asm/mmzone.h>
Index: 2.6.7-mm4/arch/ia64/kernel/acpi.c
===================================================================
--- 2.6.7-mm4.orig/arch/ia64/kernel/acpi.c	2004-06-28 20:00:54.000000000 -0700
+++ 2.6.7-mm4/arch/ia64/kernel/acpi.c	2004-06-28 20:00:57.000000000 -0700
@@ -43,6 +43,7 @@
 #include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/mmzone.h>
+#include <linux/nodemask.h>
 #include <asm/io.h>
 #include <asm/iosapic.h>
 #include <asm/machvec.h>
Index: 2.6.7-mm4/arch/ia64/mm/discontig.c
===================================================================
--- 2.6.7-mm4.orig/arch/ia64/mm/discontig.c	2004-06-28 20:00:54.000000000 -0700
+++ 2.6.7-mm4/arch/ia64/mm/discontig.c	2004-06-28 20:00:57.000000000 -0700
@@ -16,6 +16,7 @@
 #include <linux/bootmem.h>
 #include <linux/acpi.h>
 #include <linux/efi.h>
+#include <linux/nodemask.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/meminit.h>
Index: 2.6.7-mm4/arch/ppc64/mm/numa.c
===================================================================
--- 2.6.7-mm4.orig/arch/ppc64/mm/numa.c	2004-06-28 19:40:19.000000000 -0700
+++ 2.6.7-mm4/arch/ppc64/mm/numa.c	2004-06-28 20:14:56.000000000 -0700
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/module.h>
+#include <linux/nodemask.h>
 #include <asm/lmb.h>
 #include <asm/machdep.h>
 #include <asm/abs_addr.h>
Index: 2.6.7-mm4/arch/x86_64/mm/numa.c
===================================================================
--- 2.6.7-mm4.orig/arch/x86_64/mm/numa.c	2004-06-28 19:40:19.000000000 -0700
+++ 2.6.7-mm4/arch/x86_64/mm/numa.c	2004-06-28 20:15:06.000000000 -0700
@@ -10,6 +10,7 @@
 #include <linux/mmzone.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
+#include <linux/nodemask.h>
 #include <asm/e820.h>
 #include <asm/proto.h>
 #include <asm/dma.h>
Index: 2.6.7-mm4/include/asm-i386/node.h
===================================================================
--- 2.6.7-mm4.orig/include/asm-i386/node.h	2004-06-28 20:00:54.000000000 -0700
+++ 2.6.7-mm4/include/asm-i386/node.h	2004-06-28 20:00:57.000000000 -0700
@@ -5,6 +5,7 @@
 #include <linux/mmzone.h>
 #include <linux/node.h>
 #include <linux/topology.h>
+#include <linux/nodemask.h>
 
 struct i386_node {
 	struct node node;
Index: 2.6.7-mm4/include/linux/mmzone.h
===================================================================
--- 2.6.7-mm4.orig/include/linux/mmzone.h	2004-06-28 20:00:54.000000000 -0700
+++ 2.6.7-mm4/include/linux/mmzone.h	2004-06-28 20:00:57.000000000 -0700
@@ -411,35 +411,6 @@
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
Index: 2.6.7-mm4/include/linux/nodemask.h
===================================================================
--- 2.6.7-mm4.orig/include/linux/nodemask.h	2003-03-14 05:07:09.000000000 -0800
+++ 2.6.7-mm4/include/linux/nodemask.h	2004-06-28 20:13:13.000000000 -0700
@@ -0,0 +1,336 @@
+#ifndef __LINUX_NODEMASK_H
+#define __LINUX_NODEMASK_H
+
+/*
+ * Nodemasks provide a bitmap suitable for representing the
+ * set of Node's in a system, one bit position per Node number.
+ *
+ * See detailed comments in the file linux/bitmap.h describing the
+ * data type on which these nodemasks are based.
+ *
+ * For details of nodemask_scnprintf() and nodemask_parse(),
+ * see bitmap_scnprintf() and bitmap_parse() in lib/bitmap.c.
+ *
+ * The available nodemask operations are:
+ *
+ * void node_set(node, mask)		turn on bit 'node' in mask
+ * void node_clear(node, mask)		turn off bit 'node' in mask
+ * void nodes_setall(mask)		set all bits
+ * void nodes_clear(mask)		clear all bits
+ * int node_isset(node, mask)		true iff bit 'node' set in mask
+ * int node_test_and_set(node, mask)	test and set bit 'node' in mask
+ *
+ * void nodes_and(dst, src1, src2)	dst = src1 & src2  [intersection]
+ * void nodes_or(dst, src1, src2)	dst = src1 | src2  [union]
+ * void nodes_xor(dst, src1, src2)	dst = src1 ^ src2
+ * void nodes_andnot(dst, src1, src2)	dst = src1 & ~src2
+ * void nodes_complement(dst, src)	dst = ~src
+ *
+ * int nodes_equal(mask1, mask2)	Does mask1 == mask2?
+ * int nodes_intersects(mask1, mask2)	Do mask1 and mask2 intersect?
+ * int nodes_subset(mask1, mask2)	Is mask1 a subset of mask2?
+ * int nodes_empty(mask)		Is mask empty (no bits sets)?
+ * int nodes_full(mask)			Is mask full (all bits sets)?
+ * int nodes_weight(mask)		Hamming weigh - number of set bits
+ *
+ * void nodes_shift_right(dst, src, n)	Shift right
+ * void nodes_shift_left(dst, src, n)	Shift left
+ *
+ * int first_node(mask)			Number lowest set bit, or MAX_NUMNODES
+ * int next_node(node, mask)		Next node past 'node', or MAX_NUMNODES
+ *
+ * nodemask_t nodemask_of_node(node)	Return nodemask with bit 'node' set
+ * NODE_MASK_ALL			Initializer - all bits set
+ * NODE_MASK_NONE			Initializer - no bits set
+ * unsigned long *nodes_addr(mask)	Array of unsigned long's in mask
+ *
+ * int nodemask_scnprintf(buf, len, mask) Format nodemask for printing
+ * int nodemask_parse(ubuf, ulen, mask)	Parse ascii string as nodemask
+ *
+ * for_each_node_mask(node, mask)	for-loop node over mask
+ *
+ * int num_online_nodes()		Number of online Nodes
+ * int num_possible_nodes()		Number of all possible Nodes
+ * int num_present_nodes()		Number of present Nodes
+ *
+ * int node_online(node)		Is some node online?
+ * int node_possible(node)		Is some node possible?
+ * int node_present(node)		Is some node present (can schedule)?
+ *
+ * int any_online_node(mask)		First online node in mask
+ *
+ * for_each_node(node)			for-loop node over node_possible_map
+ * for_each_online_node(node)		for-loop node over node_online_map
+ * for_each_present_node(node)		for-loop node over node_present_map
+ *
+ * int any_online_node(mask)		First online node in mask
+ * node_set_online(node)		set bit 'node' in node_online_map
+ * node_set_offline(node)		clear bit 'node' in node_online_map
+ *
+ *
+ * Subtlety:
+ * 1) The 'type-checked' form of node_isset() causes gcc (3.3.2, anyway)
+ *    to generate slightly worse code.  Note for example the additional
+ *    40 lines of assembly code compiling the "for each possible node"
+ *    loops buried in the disk_stat_read() macros calls when compiling
+ *    drivers/block/genhd.c (arch i386, CONFIG_SMP=y).  So use a simple
+ *    one-line #define for node_isset(), instead of wrapping an inline
+ *    inside a macro, the way we do the other calls.
+ */
+
+#include <linux/threads.h>
+#include <linux/bitmap.h>
+#include <asm/bug.h>
+
+typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
+extern nodemask_t _unused_nodemask_arg_;
+
+#define node_set(node, dst) __node_set((node), &(dst))
+static inline void __node_set(int node, volatile nodemask_t *dstp)
+{
+	set_bit(node, dstp->bits);
+}
+
+#define node_clear(node, dst) __node_clear((node), &(dst))
+static inline void __node_clear(int node, volatile nodemask_t *dstp)
+{
+	clear_bit(node, dstp->bits);
+}
+
+#define nodes_setall(dst) __nodes_setall(&(dst), MAX_NUMNODES)
+static inline void __nodes_setall(nodemask_t *dstp, int nbits)
+{
+	bitmap_fill(dstp->bits, nbits);
+}
+
+#define nodes_clear(dst) __nodes_clear(&(dst), MAX_NUMNODES)
+static inline void __nodes_clear(nodemask_t *dstp, int nbits)
+{
+	bitmap_zero(dstp->bits, nbits);
+}
+
+/* No static inline type checking - see Subtlety (1) above. */
+#define node_isset(node, nodemask) test_bit((node), (nodemask).bits)
+
+#define node_test_and_set(node, nodemask) \
+			__node_test_and_set((node), &(nodemask))
+static inline int __node_test_and_set(int node, nodemask_t *addr)
+{
+	return test_and_set_bit(node, addr->bits);
+}
+
+#define nodes_and(dst, src1, src2) \
+			__nodes_and(&(dst), &(src1), &(src2), MAX_NUMNODES)
+static inline void __nodes_and(nodemask_t *dstp, const nodemask_t *src1p,
+					const nodemask_t *src2p, int nbits)
+{
+	bitmap_and(dstp->bits, src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_or(dst, src1, src2) \
+			__nodes_or(&(dst), &(src1), &(src2), MAX_NUMNODES)
+static inline void __nodes_or(nodemask_t *dstp, const nodemask_t *src1p,
+					const nodemask_t *src2p, int nbits)
+{
+	bitmap_or(dstp->bits, src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_xor(dst, src1, src2) \
+			__nodes_xor(&(dst), &(src1), &(src2), MAX_NUMNODES)
+static inline void __nodes_xor(nodemask_t *dstp, const nodemask_t *src1p,
+					const nodemask_t *src2p, int nbits)
+{
+	bitmap_xor(dstp->bits, src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_andnot(dst, src1, src2) \
+			__nodes_andnot(&(dst), &(src1), &(src2), MAX_NUMNODES)
+static inline void __nodes_andnot(nodemask_t *dstp, const nodemask_t *src1p,
+					const nodemask_t *src2p, int nbits)
+{
+	bitmap_andnot(dstp->bits, src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_complement(dst, src) \
+			__nodes_complement(&(dst), &(src), MAX_NUMNODES)
+static inline void __nodes_complement(nodemask_t *dstp,
+					const nodemask_t *srcp, int nbits)
+{
+	bitmap_complement(dstp->bits, srcp->bits, nbits);
+}
+
+#define nodes_equal(src1, src2) \
+			__nodes_equal(&(src1), &(src2), MAX_NUMNODES)
+static inline int __nodes_equal(const nodemask_t *src1p,
+					const nodemask_t *src2p, int nbits)
+{
+	return bitmap_equal(src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_intersects(src1, src2) \
+			__nodes_intersects(&(src1), &(src2), MAX_NUMNODES)
+static inline int __nodes_intersects(const nodemask_t *src1p,
+					const nodemask_t *src2p, int nbits)
+{
+	return bitmap_intersects(src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_subset(src1, src2) \
+			__nodes_subset(&(src1), &(src2), MAX_NUMNODES)
+static inline int __nodes_subset(const nodemask_t *src1p,
+					const nodemask_t *src2p, int nbits)
+{
+	return bitmap_subset(src1p->bits, src2p->bits, nbits);
+}
+
+#define nodes_empty(src) __nodes_empty(&(src), MAX_NUMNODES)
+static inline int __nodes_empty(const nodemask_t *srcp, int nbits)
+{
+	return bitmap_empty(srcp->bits, nbits);
+}
+
+#define nodes_full(nodemask) __nodes_full(&(nodemask), MAX_NUMNODES)
+static inline int __nodes_full(const nodemask_t *srcp, int nbits)
+{
+	return bitmap_full(srcp->bits, nbits);
+}
+
+#define nodes_weight(nodemask) __nodes_weight(&(nodemask), MAX_NUMNODES)
+static inline int __nodes_weight(const nodemask_t *srcp, int nbits)
+{
+	return bitmap_weight(srcp->bits, nbits);
+}
+
+#define nodes_shift_right(dst, src, n) \
+			__nodes_shift_right(&(dst), &(src), (n), MAX_NUMNODES)
+static inline void __nodes_shift_right(nodemask_t *dstp,
+					const nodemask_t *srcp, int n, int nbits)
+{
+	bitmap_shift_right(dstp->bits, srcp->bits, n, nbits);
+}
+
+#define nodes_shift_left(dst, src, n) \
+			__nodes_shift_left(&(dst), &(src), (n), MAX_NUMNODES)
+static inline void __nodes_shift_left(nodemask_t *dstp,
+					const nodemask_t *srcp, int n, int nbits)
+{
+	bitmap_shift_left(dstp->bits, srcp->bits, n, nbits);
+}
+
+#define first_node(src) __first_node(&(src), MAX_NUMNODES)
+static inline int __first_node(const nodemask_t *srcp, int nbits)
+{
+	return find_first_bit(srcp->bits, nbits);
+}
+
+#define next_node(n, src) __next_node((n), &(src), MAX_NUMNODES)
+static inline int __next_node(int n, const nodemask_t *srcp, int nbits)
+{
+	return find_next_bit(srcp->bits, nbits, n+1);
+}
+
+#define nodemask_of_node(node)						\
+({									\
+	typeof(_unused_nodemask_arg_) m;				\
+	if (sizeof(m) == sizeof(unsigned long)) {			\
+		m.bits[0] = 1UL<<(node);				\
+	} else {							\
+		nodes_clear(m);						\
+		node_set((node), m);					\
+	}								\
+	m;								\
+})
+
+#define NODE_MASK_LAST_WORD BITMAP_LAST_WORD_MASK(MAX_NUMNODES)
+
+#if MAX_NUMNODES <= BITS_PER_LONG
+
+#define NODE_MASK_ALL							\
+((nodemask_t) { {							\
+	[BITS_TO_LONGS(MAX_NUMNODES)-1] = NODE_MASK_LAST_WORD		\
+} })
+
+#else
+
+#define NODE_MASK_ALL							\
+((nodemask_t) { {							\
+	[0 ... BITS_TO_LONGS(MAX_NUMNODES)-2] = ~0UL,			\
+	[BITS_TO_LONGS(MAX_NUMNODES)-1] = NODE_MASK_LAST_WORD		\
+} })
+
+#endif
+
+#define NODE_MASK_NONE							\
+((nodemask_t) { {							\
+	[0 ... BITS_TO_LONGS(MAX_NUMNODES)-1] =  0UL			\
+} })
+
+#define nodes_addr(src) ((src).bits)
+
+#define nodemask_scnprintf(buf, len, src) \
+			__nodemask_scnprintf((buf), (len), &(src), MAX_NUMNODES)
+static inline int __nodemask_scnprintf(char *buf, int len,
+					const nodemask_t *srcp, int nbits)
+{
+	return bitmap_scnprintf(buf, len, srcp->bits, nbits);
+}
+
+#define nodemask_parse(ubuf, ulen, src) \
+			__nodemask_parse((ubuf), (ulen), &(src), MAX_NUMNODES)
+static inline int __nodemask_parse(const char __user *buf, int len,
+					nodemask_t *dstp, int nbits)
+{
+	return bitmap_parse(buf, len, dstp->bits, nbits);
+}
+
+#if MAX_NUMNODES > 1
+#define for_each_node_mask(node, mask)			\
+	for ((node) = first_node(mask);			\
+		(node) < MAX_NUMNODES;			\
+		(node) = next_node((node), (mask)))
+#else /* MAX_NUMNODES == 1 */
+#define for_each_node_mask(node, mask) for ((node) = 0; (node) < 1; (node)++)
+#endif /* MAX_NUMNODES */
+
+/*
+ * The following particular system nodemasks and operations
+ * on them manage all possible, online and present nodes.
+ */
+
+extern nodemask_t node_online_map;
+extern nodemask_t node_possible_map;
+extern nodemask_t node_present_map;
+
+#if MAX_NUMNODES > 1
+#define num_online_nodes()	nodes_weight(node_online_map)
+#define num_possible_nodes()	nodes_weight(node_possible_map)
+#define num_present_nodes()	nodes_weight(node_present_map)
+#define node_online(node)	node_isset((node), node_online_map)
+#define node_possible(node)	node_isset((node), node_possible_map)
+#define node_present(node)	node_isset((node), node_present_map)
+#else
+#define num_online_nodes()	1
+#define num_possible_nodes()	1
+#define num_present_nodes()	1
+#define node_online(node)	((node) == 0)
+#define node_possible(node)	((node) == 0)
+#define node_present(node)	((node) == 0)
+#endif
+
+#define any_online_node(mask)			\
+({						\
+	int node;				\
+	for_each_node_mask(node, (mask))	\
+		if (node_online(node))		\
+			break;			\
+	node;					\
+})
+
+#define node_set_online(node)	   set_bit((node), node_online_map.bits)
+#define node_set_offline(node)	   clear_bit((node), node_online_map.bits)
+
+#define for_each_node(node)	   for_each_node_mask((node), node_possible_map)
+#define for_each_online_node(node) for_each_node_mask((node), node_online_map)
+#define for_each_present_node(node) for_each_node_mask((node), node_present_map)
+
+#endif /* __LINUX_NODEMASK_H */
Index: 2.6.7-mm4/mm/mempolicy.c
===================================================================
--- 2.6.7-mm4.orig/mm/mempolicy.c	2004-06-28 20:00:54.000000000 -0700
+++ 2.6.7-mm4/mm/mempolicy.c	2004-06-28 20:13:13.000000000 -0700
@@ -66,6 +66,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/nodemask.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -95,7 +96,7 @@
 {
 	DECLARE_BITMAP(online2, MAX_NUMNODES);
 
-	bitmap_copy(online2, node_online_map, MAX_NUMNODES);
+	bitmap_copy(online2, nodes_addr(node_online_map), MAX_NUMNODES);
 	if (bitmap_empty(online2, MAX_NUMNODES))
 		set_bit(0, online2);
 	if (!bitmap_subset(nodes, online2, MAX_NUMNODES))
@@ -422,7 +423,7 @@
 	case MPOL_PREFERRED:
 		/* or use current node instead of online map? */
 		if (p->v.preferred_node < 0)
-			bitmap_copy(nodes, node_online_map, MAX_NUMNODES);
+			bitmap_copy(nodes, nodes_addr(node_online_map), MAX_NUMNODES);
 		else
 			__set_bit(p->v.preferred_node, nodes);
 		break;
@@ -628,7 +629,7 @@
 	struct zonelist *zl;
 	struct page *page;
 
-	BUG_ON(!test_bit(nid, node_online_map));
+	BUG_ON(!test_bit(nid, nodes_addr(node_online_map)));
 	zl = NODE_DATA(nid)->node_zonelists + (gfp & GFP_ZONEMASK);
 	page = __alloc_pages(gfp, order, zl);
 	if (page && page_zone(page) == zl->zones[0]) {
@@ -1017,7 +1018,8 @@
 	/* Set interleaving policy for system init. This way not all
 	   the data structures allocated at system boot end up in node zero. */
 
-	if (sys_set_mempolicy(MPOL_INTERLEAVE, node_online_map, MAX_NUMNODES) < 0)
+	if (sys_set_mempolicy(MPOL_INTERLEAVE, nodes_addr(node_online_map),
+							MAX_NUMNODES) < 0)
 		printk("numa_policy_init: interleaving failed\n");
 }
 
Index: 2.6.7-mm4/mm/page_alloc.c
===================================================================
--- 2.6.7-mm4.orig/mm/page_alloc.c	2004-06-28 20:00:54.000000000 -0700
+++ 2.6.7-mm4/mm/page_alloc.c	2004-06-28 20:00:57.000000000 -0700
@@ -31,10 +31,12 @@
 #include <linux/topology.h>
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
+#include <linux/nodemask.h>
 
 #include <asm/tlbflush.h>
 
-DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
+nodemask_t node_online_map = NODE_MASK_NONE;
+nodemask_t node_possible_map = NODE_MASK_ALL;
 struct pglist_data *pgdat_list;
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
