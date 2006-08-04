Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWHDFgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWHDFgM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWHDFgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:36:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53151 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030266AbWHDFgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:36:09 -0400
Subject: PATCH 2 of 4] cpumask: export cpu_online_map and cpu_possible_map
	consistently
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1154669759.21040.2353.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 04 Aug 2006 15:35:59 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask: ensure that the cpu_online_map and cpu_possible_map bitmasks,
and hence all the macros in <linux/cpumask.h> that require them, are
available to modules for all supported combinations of architecture
and CONFIG_SMP.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 arch/arm/kernel/smp.c           |    2 ++
 arch/cris/arch-v32/kernel/smp.c |    1 +
 arch/sh/kernel/smp.c            |    1 +
 kernel/sched.c                  |    3 +++
 4 files changed, 7 insertions(+)

Index: linux-2.6.18-rc2/kernel/sched.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/sched.c	2006-08-01 17:53:25.000000000 +1000
+++ linux-2.6.18-rc2/kernel/sched.c	2006-08-02 23:01:20.535457863 +1000
@@ -4348,7 +4348,10 @@ EXPORT_SYMBOL(cpu_present_map);
 
 #ifndef CONFIG_SMP
 cpumask_t cpu_online_map __read_mostly = CPU_MASK_ALL;
+EXPORT_SYMBOL_GPL(cpu_online_map);
+
 cpumask_t cpu_possible_map __read_mostly = CPU_MASK_ALL;
+EXPORT_SYMBOL_GPL(cpu_possible_map);
 #endif
 
 long sched_getaffinity(pid_t pid, cpumask_t *mask)
Index: linux-2.6.18-rc2/arch/arm/kernel/smp.c
===================================================================
--- linux-2.6.18-rc2.orig/arch/arm/kernel/smp.c	2006-07-16 07:53:08.000000000 +1000
+++ linux-2.6.18-rc2/arch/arm/kernel/smp.c	2006-08-02 23:16:11.014268293 +1000
@@ -36,7 +36,9 @@
  * The online bitmask indicates that the CPU is up and running.
  */
 cpumask_t cpu_possible_map;
+EXPORT_SYMBOL(cpu_possible_map);
 cpumask_t cpu_online_map;
+EXPORT_SYMBOL(cpu_online_map);
 
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
Index: linux-2.6.18-rc2/arch/cris/arch-v32/kernel/smp.c
===================================================================
--- linux-2.6.18-rc2.orig/arch/cris/arch-v32/kernel/smp.c	2006-07-16 07:53:08.000000000 +1000
+++ linux-2.6.18-rc2/arch/cris/arch-v32/kernel/smp.c	2006-08-02 23:26:25.253636007 +1000
@@ -28,6 +28,7 @@ spinlock_t cris_atomic_locks[] = { [0 ..
 
 /* CPU masks */
 cpumask_t cpu_online_map = CPU_MASK_NONE;
+EXPORT_SYMBOL(cpu_online_map);
 cpumask_t phys_cpu_present_map = CPU_MASK_NONE;
 EXPORT_SYMBOL(phys_cpu_present_map);
 
Index: linux-2.6.18-rc2/arch/sh/kernel/smp.c
===================================================================
--- linux-2.6.18-rc2.orig/arch/sh/kernel/smp.c	2006-07-16 07:53:08.000000000 +1000
+++ linux-2.6.18-rc2/arch/sh/kernel/smp.c	2006-08-02 23:23:34.284064085 +1000
@@ -42,6 +42,7 @@ cpumask_t cpu_possible_map;
 EXPORT_SYMBOL(cpu_possible_map);
 
 cpumask_t cpu_online_map;
+EXPORT_SYMBOL(cpu_online_map);
 static atomic_t cpus_booted = ATOMIC_INIT(0);
 
 /* These are defined by the board-specific code. */

-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


