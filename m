Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267608AbTAQRNf>; Fri, 17 Jan 2003 12:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbTAQRNf>; Fri, 17 Jan 2003 12:13:35 -0500
Received: from franka.aracnet.com ([216.99.193.44]:21962 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267608AbTAQRNb>; Fri, 17 Jan 2003 12:13:31 -0500
Date: Fri, 17 Jan 2003 09:21:49 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Ingo Molnar <mingo@elte.hu>
cc: Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] sched-2.5.59-A2
Message-ID: <286110000.1042824100@titus>
In-Reply-To: <200301171535.21226.efocht@ess.nec.de>
References: <Pine.LNX.4.44.0301170921430.3723-100000@localhost.localdomain> <200301171535.21226.efocht@ess.nec.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I like the cleanup of the topology.h. 

Any chance we could keep that broken out as a seperate patch?
Topo cleanups below:

diff -urpN -X /home/fletch/.diff.exclude virgin/drivers/base/cpu.c ingo-A/drivers/base/cpu.c
--- virgin/drivers/base/cpu.c	Sun Dec  1 09:59:47 2002
+++ ingo-A/drivers/base/cpu.c	Fri Jan 17 09:19:23 2003
@@ -6,8 +6,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
-
-#include <asm/topology.h>
+#include <linux/topology.h>
 
 
 static int cpu_add_device(struct device * dev)
diff -urpN -X /home/fletch/.diff.exclude virgin/drivers/base/memblk.c ingo-A/drivers/base/memblk.c
--- virgin/drivers/base/memblk.c	Mon Dec 16 21:50:42 2002
+++ ingo-A/drivers/base/memblk.c	Fri Jan 17 09:19:23 2003
@@ -7,8 +7,7 @@
 #include <linux/init.h>
 #include <linux/memblk.h>
 #include <linux/node.h>
-
-#include <asm/topology.h>
+#include <linux/topology.h>
 
 
 static int memblk_add_device(struct device * dev)
diff -urpN -X /home/fletch/.diff.exclude virgin/drivers/base/node.c ingo-A/drivers/base/node.c
--- virgin/drivers/base/node.c	Fri Jan 17 09:18:26 2003
+++ ingo-A/drivers/base/node.c	Fri Jan 17 09:19:23 2003
@@ -7,8 +7,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/node.h>
-
-#include <asm/topology.h>
+#include <linux/topology.h>
 
 
 static int node_add_device(struct device * dev)
diff -urpN -X /home/fletch/.diff.exclude virgin/include/asm-generic/topology.h ingo-A/include/asm-generic/topology.h
--- virgin/include/asm-generic/topology.h	Fri Jan 17 09:18:31 2003
+++ ingo-A/include/asm-generic/topology.h	Fri Jan 17 09:19:23 2003
@@ -1,56 +0,0 @@
-/*
- * linux/include/asm-generic/topology.h
- *
- * Written by: Matthew Dobson, IBM Corporation
- *
- * Copyright (C) 2002, IBM Corp.
- *
- * All rights reserved.          
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Send feedback to <colpatch@us.ibm.com>
- */
-#ifndef _ASM_GENERIC_TOPOLOGY_H
-#define _ASM_GENERIC_TOPOLOGY_H
-
-/* Other architectures wishing to use this simple topology API should fill
-   in the below functions as appropriate in their own <asm/topology.h> file. */
-#ifndef __cpu_to_node
-#define __cpu_to_node(cpu)		(0)
-#endif
-#ifndef __memblk_to_node
-#define __memblk_to_node(memblk)	(0)
-#endif
-#ifndef __parent_node
-#define __parent_node(node)		(0)
-#endif
-#ifndef __node_to_first_cpu
-#define __node_to_first_cpu(node)	(0)
-#endif
-#ifndef __node_to_cpu_mask
-#define __node_to_cpu_mask(node)	(cpu_online_map)
-#endif
-#ifndef __node_to_memblk
-#define __node_to_memblk(node)		(0)
-#endif
-
-/* Cross-node load balancing interval. */
-#ifndef NODE_BALANCE_RATE
-#define NODE_BALANCE_RATE 10
-#endif
-
-#endif /* _ASM_GENERIC_TOPOLOGY_H */
diff -urpN -X /home/fletch/.diff.exclude virgin/include/asm-i386/cpu.h ingo-A/include/asm-i386/cpu.h
--- virgin/include/asm-i386/cpu.h	Sun Nov 17 20:29:50 2002
+++ ingo-A/include/asm-i386/cpu.h	Fri Jan 17 09:19:23 2003
@@ -3,8 +3,8 @@
 
 #include <linux/device.h>
 #include <linux/cpu.h>
+#include <linux/topology.h>
 
-#include <asm/topology.h>
 #include <asm/node.h>
 
 struct i386_cpu {
diff -urpN -X /home/fletch/.diff.exclude virgin/include/asm-i386/memblk.h ingo-A/include/asm-i386/memblk.h
--- virgin/include/asm-i386/memblk.h	Sun Nov 17 20:29:47 2002
+++ ingo-A/include/asm-i386/memblk.h	Fri Jan 17 09:19:25 2003
@@ -4,8 +4,8 @@
 #include <linux/device.h>
 #include <linux/mmzone.h>
 #include <linux/memblk.h>
+#include <linux/topology.h>
 
-#include <asm/topology.h>
 #include <asm/node.h>
 
 struct i386_memblk {
diff -urpN -X /home/fletch/.diff.exclude virgin/include/asm-i386/node.h ingo-A/include/asm-i386/node.h
--- virgin/include/asm-i386/node.h	Sun Nov 17 20:29:29 2002
+++ ingo-A/include/asm-i386/node.h	Fri Jan 17 09:19:24 2003
@@ -4,8 +4,7 @@
 #include <linux/device.h>
 #include <linux/mmzone.h>
 #include <linux/node.h>
-
-#include <asm/topology.h>
+#include <linux/topology.h>
 
 struct i386_node {
 	struct node node;
diff -urpN -X /home/fletch/.diff.exclude virgin/include/asm-i386/topology.h ingo-A/include/asm-i386/topology.h
--- virgin/include/asm-i386/topology.h	Fri Jan 17 09:18:31 2003
+++ ingo-A/include/asm-i386/topology.h	Fri Jan 17 09:19:23 2003
@@ -61,17 +61,6 @@ static inline int __node_to_first_cpu(in
 /* Returns the number of the first MemBlk on Node 'node' */
 #define __node_to_memblk(node) (node)
 
-/* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE 100
-
-#else /* !CONFIG_NUMA */
-/*
- * Other i386 platforms should define their own version of the 
- * above macros here.
- */
-
-#include <asm-generic/topology.h>
-
 #endif /* CONFIG_NUMA */
 
 #endif /* _ASM_I386_TOPOLOGY_H */
diff -urpN -X /home/fletch/.diff.exclude virgin/include/asm-ia64/topology.h ingo-A/include/asm-ia64/topology.h
--- virgin/include/asm-ia64/topology.h	Fri Jan 17 09:18:31 2003
+++ ingo-A/include/asm-ia64/topology.h	Fri Jan 17 09:19:23 2003
@@ -60,7 +60,4 @@
  */
 #define __node_to_memblk(node) (node)
 
-/* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE 10
-
 #endif /* _ASM_IA64_TOPOLOGY_H */
diff -urpN -X /home/fletch/.diff.exclude virgin/include/asm-ppc64/topology.h ingo-A/include/asm-ppc64/topology.h
--- virgin/include/asm-ppc64/topology.h	Fri Jan 17 09:18:31 2003
+++ ingo-A/include/asm-ppc64/topology.h	Fri Jan 17 09:19:23 2003
@@ -46,18 +46,6 @@ static inline unsigned long __node_to_cp
 	return mask;
 }
 
-/* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE 10
-
-#else /* !CONFIG_NUMA */
-
-#define __cpu_to_node(cpu)		(0)
-#define __memblk_to_node(memblk)	(0)
-#define __parent_node(nid)		(0)
-#define __node_to_first_cpu(node)	(0)
-#define __node_to_cpu_mask(node)	(cpu_online_map)
-#define __node_to_memblk(node)		(0)
-
 #endif /* CONFIG_NUMA */
 
 #endif /* _ASM_PPC64_TOPOLOGY_H */
diff -urpN -X /home/fletch/.diff.exclude virgin/include/linux/mmzone.h ingo-A/include/linux/mmzone.h
--- virgin/include/linux/mmzone.h	Fri Jan 17 09:18:31 2003
+++ ingo-A/include/linux/mmzone.h	Fri Jan 17 09:19:23 2003
@@ -255,9 +255,7 @@ static inline struct zone *next_zone(str
 #define MAX_NR_MEMBLKS	1
 #endif /* CONFIG_NUMA */
 
-#include <asm/topology.h>
-/* Returns the number of the current Node. */
-#define numa_node_id()		(__cpu_to_node(smp_processor_id()))
+#include <linux/topology.h>
 
 #ifndef CONFIG_DISCONTIGMEM
 extern struct pglist_data contig_page_data;
diff -urpN -X /home/fletch/.diff.exclude virgin/include/linux/topology.h ingo-A/include/linux/topology.h
--- virgin/include/linux/topology.h	Wed Dec 31 16:00:00 1969
+++ ingo-A/include/linux/topology.h	Fri Jan 17 09:19:23 2003
@@ -0,0 +1,43 @@
+/*
+ * linux/include/linux/topology.h
+ */
+#ifndef _LINUX_TOPOLOGY_H
+#define _LINUX_TOPOLOGY_H
+
+#include <asm/topology.h>
+
+/*
+ * The default (non-NUMA) topology definitions:
+ */
+#ifndef __cpu_to_node
+#define __cpu_to_node(cpu)		(0)
+#endif
+#ifndef __memblk_to_node
+#define __memblk_to_node(memblk)	(0)
+#endif
+#ifndef __parent_node
+#define __parent_node(node)		(0)
+#endif
+#ifndef __node_to_first_cpu
+#define __node_to_first_cpu(node)	(0)
+#endif
+#ifndef __cpu_to_node_mask
+#define __cpu_to_node_mask(cpu)		(cpu_online_map)
+#endif
+#ifndef __node_to_cpu_mask
+#define __node_to_cpu_mask(node)		(cpu_online_map)
+#endif
+#ifndef __node_to_memblk
+#define __node_to_memblk(node)		(0)
+#endif
+
+#ifndef __cpu_to_node_mask
+#define __cpu_to_node_mask(cpu)		__node_to_cpu_mask(__cpu_to_node(cpu))
+#endif
+
+/*
+ * Generic defintions:
+ */
+#define numa_node_id()			(__cpu_to_node(smp_processor_id()))
+
+#endif /* _LINUX_TOPOLOGY_H */
diff -urpN -X /home/fletch/.diff.exclude virgin/mm/page_alloc.c ingo-A/mm/page_alloc.c
--- virgin/mm/page_alloc.c	Fri Jan 17 09:18:32 2003
+++ ingo-A/mm/page_alloc.c	Fri Jan 17 09:19:25 2003
@@ -28,8 +28,7 @@
 #include <linux/blkdev.h>
 #include <linux/slab.h>
 #include <linux/notifier.h>
-
-#include <asm/topology.h>
+#include <linux/topology.h>
 
 DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
 DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
diff -urpN -X /home/fletch/.diff.exclude virgin/mm/vmscan.c ingo-A/mm/vmscan.c
--- virgin/mm/vmscan.c	Mon Dec 23 23:01:58 2002
+++ ingo-A/mm/vmscan.c	Fri Jan 17 09:19:25 2003
@@ -27,10 +27,10 @@
 #include <linux/pagevec.h>
 #include <linux/backing-dev.h>
 #include <linux/rmap-locking.h>
+#include <linux/topology.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-#include <asm/topology.h>
 #include <asm/div64.h>
 
 #include <linux/swapops.h>

