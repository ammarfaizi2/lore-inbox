Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUDHUjo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbUDHUcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 16:32:35 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:63973 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262438AbUDHTuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:50:37 -0400
Date: Thu, 8 Apr 2004 12:50:01 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Patch 15/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408125001.7938aa3e.pj@sgi.com>
In-Reply-To: <20040408115050.2c67311a.pj@sgi.com>
References: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P15.cpumask_sched_refine- Cpumask code clarification in kernel/sched.c
        Clarify and slightly optimize set_cpus_allowed() cpumask check

Index: 2.6.5.bitmap/kernel/sched.c
===================================================================
--- 2.6.5.bitmap.orig/kernel/sched.c	2004-04-08 09:39:29.000000000 -0700
+++ 2.6.5.bitmap/kernel/sched.c	2004-04-08 09:40:08.000000000 -0700
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
