Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751597AbWDASz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbWDASz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 13:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbWDASz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 13:55:59 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:16570 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750744AbWDASz7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 13:55:59 -0500
Date: Sun, 2 Apr 2006 00:25:51 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Cc: suresh.b.siddha@intel.com, Dinakar Guniguntala <dino@in.ibm.com>,
       pj@sgi.com, hawkes@sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.16-mm2 2/4] sched_domain: Don't use GFP_ATOMIC
Message-ID: <20060401185551.GA25971@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch below (against 2.6.16-mm2) replaces GFP_ATOMIC allocation for 
sched_group_nodes with GFP_KERNEL based allocation.

Signed-off-by: Srivatsa Vaddagiri <vatsa@in.ibm.com


diff -puN kernel/sched.c~sd_dontusegfpatomic kernel/sched.c
--- linux-2.6.16-mm2/kernel/sched.c~sd_dontusegfpatomic	2006-04-01 23:39:01.000000000 +0530
+++ linux-2.6.16-mm2-root/kernel/sched.c	2006-04-01 23:39:14.000000000 +0530
@@ -6121,7 +6121,7 @@ static int build_sched_domains(const cpu
 	 * Allocate the per-node list of sched groups
 	 */
 	sched_group_nodes = kzalloc(sizeof(struct sched_group*)*MAX_NUMNODES,
-					   GFP_ATOMIC);
+					   GFP_KERNEL);
 	if (!sched_group_nodes) {
 		printk(KERN_WARNING "Can not alloc sched group node list\n");
 		return -ENOMEM;

_


-- 
Regards,
vatsa
