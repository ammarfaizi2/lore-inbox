Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751598AbWDAS40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbWDAS40 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 13:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWDAS40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 13:56:26 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:27313 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751595AbWDAS4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 13:56:25 -0500
Date: Sun, 2 Apr 2006 00:26:23 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Cc: suresh.b.siddha@intel.com, Dinakar Guniguntala <dino@in.ibm.com>,
       pj@sgi.com, hawkes@sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.16-mm2 3/4] sched_domain: Use kmalloc_node
Message-ID: <20060401185623.GB25971@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sched group structures used to represent various nodes need to be
allocated from respective nodes (as suggested here also:

	http://uwsg.ucs.indiana.edu/hypermail/linux/kernel/0603.3/0051.html)

Patch below (against 2.6.16-mm2) has been boot tested on a
non-NUMA/4-way SMP machine.


Signed-off-by: Srivatsa Vaddagiri <vatsa@in.ibm.com>

diff -puN kernel/sched.c~sd_usekmalloc_node kernel/sched.c
--- linux-2.6.16-mm2/kernel/sched.c~sd_usekmalloc_node	2006-04-01 23:39:37.000000000 +0530
+++ linux-2.6.16-mm2-root/kernel/sched.c	2006-04-01 23:40:17.000000000 +0530
@@ -6263,7 +6263,7 @@ static int build_sched_domains(const cpu
 		domainspan = sched_domain_node_span(i);
 		cpus_and(domainspan, domainspan, *cpu_map);
 
-		sg = kmalloc(sizeof(struct sched_group), GFP_KERNEL);
+		sg = kmalloc_node(sizeof(struct sched_group), GFP_KERNEL, i);
 		if (!sg) {
 			printk(KERN_WARNING
 			"Can not alloc domain group for node %d\n", i);
@@ -6296,7 +6296,8 @@ static int build_sched_domains(const cpu
 			if (cpus_empty(tmp))
 				continue;
 
-			sg = kmalloc(sizeof(struct sched_group), GFP_KERNEL);
+			sg = kmalloc_node(sizeof(struct sched_group),
+					  GFP_KERNEL, i);
 			if (!sg) {
 				printk(KERN_WARNING
 				"Can not alloc domain group for node %d\n", j);

_

 
-- 
Regards,
vatsa
