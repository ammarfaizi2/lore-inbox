Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUDVHKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUDVHKm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUDVHKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:10:42 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:31677 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263731AbUDVHKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:10:22 -0400
Date: Thu, 22 Apr 2004 00:07:59 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: [Patch 17 of 17] cpumask v4 - Cpumask code clarification in
 kernel/sched.c
Message-Id: <20040422000759.2919be54.pj@sgi.com>
In-Reply-To: <20040421232247.22ffe1f2.pj@sgi.com>
References: <20040421232247.22ffe1f2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mask17-cpumask-sched-refine - Cpumask code clarification in kernel/sched.c
        Clarify and slightly optimize set_cpus_allowed() cpumask check

Index: 2.6.5.bitmap.v4/kernel/sched.c
===================================================================
--- 2.6.5.bitmap.v4.orig/kernel/sched.c	2004-04-21 16:45:03.000000000 -0700
+++ 2.6.5.bitmap.v4/kernel/sched.c	2004-04-21 16:45:17.000000000 -0700
@@ -2722,7 +2722,7 @@
 	runqueue_t *rq;
 
 	rq = task_rq_lock(p, &flags);
-	if (any_online_cpu(new_mask) == NR_CPUS) {
+	if (!cpus_intersects(new_mask, cpu_online_map)) {
 		ret = -EINVAL;
 		goto out;
 	}


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
