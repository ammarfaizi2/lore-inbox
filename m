Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbUDAV50 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbUDAVXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:23:48 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:57653 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263203AbUDAVOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:14:17 -0500
Date: Thu, 1 Apr 2004 13:13:12 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [Patch 23/23] mask v2 - Cpumask tweak in kernel/sched.c
Message-Id: <20040401131312.00ccb9a6.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_23_of_23 - Cpumask code clarification in kernel/sched.c
	Clarify and slightly optimize set_cpus_allowed() cpumask check


Diffstat Patch_23_of_23:
 sched.c                        |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Mon Mar 29 01:04:08 2004
+++ b/kernel/sched.c	Mon Mar 29 01:04:08 2004
@@ -2708,7 +2708,7 @@
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
