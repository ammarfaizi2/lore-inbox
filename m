Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWJRIOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWJRIOw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 04:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWJRIOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 04:14:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27801 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932096AbWJRIOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 04:14:50 -0400
From: Paul Jackson <pj@sgi.com>
To: Dinakar Guniguntala <dino@in.ibm.com>
Cc: Simon.Derr@bull.net, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Date: Wed, 18 Oct 2006 01:14:41 -0700
Message-Id: <20061018081441.18477.43390.sendpatchset@sam.engr.sgi.com>
Subject: [PATCH] Cpuset: remove useless sched domain line
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Remove a useless line from the sched domain setup code in cpusets.

When I removed the 'is_removed()' flag test from the sched domain
setup code in cpusets, as part of my July 23, 2006 patch:

    Cpuset: fix ABBA deadlock with cpu hotplug lock

I failed to notice that this opened the door to a little bit of code
simplification.  A line of code that had to cover for the possibility
that a cpuset marked cpu_exclusive was marked for removal could
be eliminated.  In the code section visible in this patch, it is
now the case that cur->cpus_allowed is always a subset of pspan,
so it is always a no-op to cpus_or() cur->cpus_allowed into pspan.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |    1 -
 1 files changed, 1 deletion(-)

--- 2.6.19-rc1-mm1.orig/kernel/cpuset.c	2006-10-13 21:31:16.000000000 -0700
+++ 2.6.19-rc1-mm1/kernel/cpuset.c	2006-10-13 21:32:20.000000000 -0700
@@ -783,7 +783,6 @@ static void update_cpu_domains(struct cp
 			cpus_andnot(pspan, pspan, c->cpus_allowed);
 	}
 	if (!is_cpu_exclusive(cur)) {
-		cpus_or(pspan, pspan, cur->cpus_allowed);
 		if (cpus_equal(pspan, cur->cpus_allowed))
 			return;
 		cspan = CPU_MASK_NONE;

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
