Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVICQW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVICQW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 12:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVICQW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 12:22:56 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:24206 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751082AbVICQWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 12:22:55 -0400
Date: Sat, 3 Sep 2005 09:22:46 -0700 (PDT)
From: hawkes@sgi.com
To: Dinakar Guniguntala <dino@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ia64@vger.kernel.org,
       hawkes@sgi.com, Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20050903162246.22567.3948.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH 3/3] 2.6.13: cpuset + build_sched_domains() fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix part 3:
Undo the #ifdef disabling hack that was put into 2.6.13 to disable
dynamic sched domains.

Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/kernel/cpuset.c
===================================================================
--- linux.orig/kernel/cpuset.c	2005-08-28 16:41:01.000000000 -0700
+++ linux/kernel/cpuset.c	2005-09-02 08:45:24.000000000 -0700
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
