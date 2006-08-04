Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWHDFhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWHDFhM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWHDFhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:37:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:55967 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030264AbWHDFhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:37:10 -0400
Subject: [PATCH 3 of 4] cpumask: export node_to_cpu_mask consistently
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1154669820.21040.2355.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 04 Aug 2006 15:37:00 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask: ensure that node_to_cpumask() is available to modules for
all supported combinations of architecture and CONFIG_NUMA.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 arch/i386/kernel/smpboot.c |    1 +
 arch/ia64/kernel/numa.c    |    1 +
 2 files changed, 2 insertions(+)

Index: linux-2.6.18-rc2/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.18-rc2.orig/arch/i386/kernel/smpboot.c	2006-08-03 13:29:58.956798616 +1000
+++ linux-2.6.18-rc2/arch/i386/kernel/smpboot.c	2006-08-03 13:30:34.716149882 +1000
@@ -609,6 +609,7 @@ extern struct {
 /* which logical CPUs are on which nodes */
 cpumask_t node_2_cpu_mask[MAX_NUMNODES] __read_mostly =
 				{ [0 ... MAX_NUMNODES-1] = CPU_MASK_NONE };
+EXPORT_SYMBOL(node_2_cpu_mask);
 /* which node each logical CPU is on */
 int cpu_2_node[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = 0 };
 EXPORT_SYMBOL(cpu_2_node);
Index: linux-2.6.18-rc2/arch/ia64/kernel/numa.c
===================================================================
--- linux-2.6.18-rc2.orig/arch/ia64/kernel/numa.c	2006-08-03 13:30:03.548201734 +1000
+++ linux-2.6.18-rc2/arch/ia64/kernel/numa.c	2006-08-03 13:31:01.696642365 +1000
@@ -28,6 +28,7 @@ u16 cpu_to_node_map[NR_CPUS] __cacheline
 EXPORT_SYMBOL(cpu_to_node_map);
 
 cpumask_t node_to_cpu_mask[MAX_NUMNODES] __cacheline_aligned;
+EXPORT_SYMBOL_GPL(node_to_cpu_mask);
 
 /**
  * build_cpu_to_node_map - setup cpu to node and node to cpumask arrays

-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


