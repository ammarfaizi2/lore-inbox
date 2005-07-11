Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVGKB16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVGKB16 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 21:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVGKBZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 21:25:33 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:24553 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262180AbVGKBYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 21:24:21 -0400
Date: Sun, 10 Jul 2005 18:22:11 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, pj@sgi.com
Subject: [PATCH] kernel/cpuset.c: add kerneldoc, fix typos
Message-Id: <20050710182211.6f741101.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add kerneldoc to kernel/cpuset.c
Fix cpuset typos in init/Kconfig

Paul (someone), please check cpuset_zone_allowed() especially.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 init/Kconfig    |    2 +-
 kernel/cpuset.c |   26 +++++++++++++++++++-------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff -Naurp linux-2613-rc2/init/Kconfig~kdoc_kernel_cpuset linux-2613-rc2/init/Kconfig
--- linux-2613-rc2/init/Kconfig~kdoc_kernel_cpuset	2005-07-09 13:55:03.000000000 -0700
+++ linux-2613-rc2/init/Kconfig	2005-07-10 16:42:42.000000000 -0700
@@ -231,7 +231,7 @@ config CPUSETS
 	bool "Cpuset support"
 	depends on SMP
 	help
-	  This options will let you create and manage CPUSET's which
+	  This option will let you create and manage CPUSETs which
 	  allow dynamically partitioning a system into sets of CPUs and
 	  Memory Nodes and assigning tasks to run only within those sets.
 	  This is primarily useful on large SMP or NUMA systems.
diff -Naurp linux-2613-rc2/kernel/cpuset.c~kdoc_kernel_cpuset linux-2613-rc2/kernel/cpuset.c
--- linux-2613-rc2/kernel/cpuset.c~kdoc_kernel_cpuset	2005-07-09 13:55:03.000000000 -0700
+++ linux-2613-rc2/kernel/cpuset.c	2005-07-10 17:25:16.000000000 -0700
@@ -1440,10 +1440,10 @@ void __init cpuset_init_smp(void)
 
 /**
  * cpuset_fork - attach newly forked task to its parents cpuset.
- * @p: pointer to task_struct of forking parent process.
+ * @tsk: pointer to task_struct of forking parent process.
  *
  * Description: By default, on fork, a task inherits its
- * parents cpuset.  The pointer to the shared cpuset is
+ * parent's cpuset.  The pointer to the shared cpuset is
  * automatically copied in fork.c by dup_task_struct().
  * This cpuset_fork() routine need only increment the usage
  * counter in that cpuset.
@@ -1471,7 +1471,6 @@ void cpuset_fork(struct task_struct *tsk
  * by the cpuset_sem semaphore.  If you don't hold cpuset_sem,
  * then a zero cpuset use count is a license to any other task to
  * nuke the cpuset immediately.
- *
  **/
 
 void cpuset_exit(struct task_struct *tsk)
@@ -1521,7 +1520,9 @@ void cpuset_init_current_mems_allowed(vo
 	current->mems_allowed = NODE_MASK_ALL;
 }
 
-/*
+/**
+ * cpuset_update_current_mems_allowed - update mems parameters to new values
+ *
  * If the current tasks cpusets mems_allowed changed behind our backs,
  * update current->mems_allowed and mems_generation to the new value.
  * Do not call this routine if in_interrupt().
@@ -1540,13 +1541,20 @@ void cpuset_update_current_mems_allowed(
 	}
 }
 
+/**
+ * cpuset_restrict_to_mems_allowed - limit nodes to current mems_allowed
+ * @nodes: pointer to a node bitmap that is and-ed with mems_allowed
+ */
 void cpuset_restrict_to_mems_allowed(unsigned long *nodes)
 {
 	bitmap_and(nodes, nodes, nodes_addr(current->mems_allowed),
 							MAX_NUMNODES);
 }
 
-/*
+/**
+ * cpuset_zonelist_valid_mems_allowed - check zonelist vs. curremt mems_allowed
+ * @zl: the zonelist to be checked
+ *
  * Are any of the nodes on zonelist zl allowed in current->mems_allowed?
  */
 int cpuset_zonelist_valid_mems_allowed(struct zonelist *zl)
@@ -1562,8 +1570,12 @@ int cpuset_zonelist_valid_mems_allowed(s
 	return 0;
 }
 
-/*
- * Is 'current' valid, and is zone z allowed in current->mems_allowed?
+/**
+ * cpuset_zone_allowed - is zone z allowed in current->mems_allowed
+ * @z: zone in question
+ *
+ * Is zone z allowed in current->mems_allowed, or is
+ * the CPU in interrupt context? (zone is always allowed in this case)
  */
 int cpuset_zone_allowed(struct zone *z)
 {


---
