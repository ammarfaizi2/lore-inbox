Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVCPENH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVCPENH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 23:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVCPENH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 23:13:07 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:37130
	"EHLO graphe.net") by vger.kernel.org with ESMTP id S262506AbVCPEM7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 23:12:59 -0500
Date: Tue, 15 Mar 2005 20:12:55 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cacheline alignment for cpu maps
Message-ID: <Pine.LNX.4.58.0503152012210.5134@server.graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add cacheline alignment to some critical SMP management maps.
These are in particular important for NUMA systems to avoid false
sharing.

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Shai Fultheim <Shai@Scalex86.org>

Index: linux-2.6.11/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.11.orig/arch/i386/kernel/smpboot.c	2005-03-14 10:32:53.349590752 -0800
+++ linux-2.6.11/arch/i386/kernel/smpboot.c	2005-03-14 10:33:48.592192600 -0800
@@ -64,7 +64,7 @@ int phys_proc_id[NR_CPUS]; /* Package ID
 EXPORT_SYMBOL(phys_proc_id);

 /* bitmap of online cpus */
-cpumask_t cpu_online_map;
+cpumask_t cpu_online_map __cacheline_aligned;

 cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
@@ -472,10 +472,10 @@ extern struct {
 #ifdef CONFIG_NUMA

 /* which logical CPUs are on which nodes */
-cpumask_t node_2_cpu_mask[MAX_NUMNODES] =
+cpumask_t node_2_cpu_mask[MAX_NUMNODES] __cacheline_aligned =
 				{ [0 ... MAX_NUMNODES-1] = CPU_MASK_NONE };
 /* which node each logical CPU is on */
-int cpu_2_node[NR_CPUS] = { [0 ... NR_CPUS-1] = 0 };
+int cpu_2_node[NR_CPUS] __cacheline_aligned = { [0 ... NR_CPUS-1] = 0 };
 EXPORT_SYMBOL(cpu_2_node);

 /* set up a mapping between cpu and node. */
@@ -503,7 +503,8 @@ static inline void unmap_cpu_to_node(int

 #endif /* CONFIG_NUMA */

-u8 cpu_2_logical_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
+u8 cpu_2_logical_apicid[NR_CPUS] __cacheline_aligned =
+			{ [0 ... NR_CPUS-1] = BAD_APICID };

 static void map_cpu_to_logical_apicid(void)
 {
