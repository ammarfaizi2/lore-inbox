Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbUC2Nhj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbUC2Ngu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:36:50 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:48570 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262877AbUC2MRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:17:06 -0500
Date: Mon, 29 Mar 2004 04:16:24 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] mask ADT:  clarify kernel/sched.c set_cpus_allowed cpumask
  [21/22]
Message-Id: <20040329041624.6a8c49c0.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_21_of_22 - Cpumask code clarification in kernel/sched.c
	Clarify and slightly optimize set_cpus_allowed() cpumask check

diffstat Patch_21_of_22:
 sched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1727  -> 1.1728 
#	      kernel/sched.c	1.248   -> 1.249  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/29	pj@sgi.com	1.1728
# Clarify and slightly optimize set_cpus_allowed() cpumask check.
# --------------------------------------------
#
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
