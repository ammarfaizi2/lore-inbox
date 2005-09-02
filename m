Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVIBULa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVIBULa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbVIBULa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:11:30 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:4750 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751131AbVIBUL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:11:27 -0400
Date: Fri, 2 Sep 2005 13:11:14 -0700 (PDT)
From: hawkes@sgi.com
To: Dinakar Guniguntala <dino@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ia64@vger.kernel.org,
       hawkes@sgi.com, Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20050902201114.16681.88184.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 3/3] 2.6.13-mm1: cpuset + build_sched_domains() fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, Dino, and Andrew,

Here is the "cpuset + build_sched_domains() mangles structures" set of
patches against 2.6.13-mm1.

Patch #3:  Re-enable "dynamic sched domains" by backing out the hack
	   introduced last week.

Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/kernel/cpuset.c
===================================================================
--- linux.orig/kernel/cpuset.c	2005-08-28 16:41:01.000000000 -0700
+++ linux/kernel/cpuset.c	2005-09-02 11:18:43.000000000 -0700
@@ -628,13 +628,6 @@
  * lock_cpu_hotplug()/unlock_cpu_hotplug() pair.
  */
 
-/*
- * Hack to avoid 2.6.13 partial node dynamic sched domain bug.
- * Disable letting 'cpu_exclusive' cpusets define dynamic sched
- * domains, until the sched domain can handle partial nodes.
- * Remove this #if hackery when sched domains fixed.
- */
-#if 0
 static void update_cpu_domains(struct cpuset *cur)
 {
 	struct cpuset *c, *par = cur->parent;
@@ -675,11 +668,6 @@
 	partition_sched_domains(&pspan, &cspan);
 	unlock_cpu_hotplug();
 }
-#else
-static void update_cpu_domains(struct cpuset *cur)
-{
-}
-#endif
 
 static int update_cpumask(struct cpuset *cs, char *buf)
 {
