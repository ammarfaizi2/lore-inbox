Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269798AbUICVZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269798AbUICVZt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 17:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269801AbUICVZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 17:25:48 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:1239 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269798AbUICVWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 17:22:08 -0400
Subject: [Fwd: Re: SMP Panic caused by [PATCH] sched: consolidate sched
	domains]
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Mv9ROU3xYps5PqJszgCh"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 03 Sep 2004 17:21:03 -0400
Message-Id: <1094246465.1712.12.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Mv9ROU3xYps5PqJszgCh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Could we get this in please?  The current screw up in the scheduling
domain patch means that any architecture that actually hotplugs CPUs
will crash in find_busiest_group() ... and I notice this has just bitten
the z Series people...

James


--=-Mv9ROU3xYps5PqJszgCh
Content-Disposition: inline
Content-Description: Forwarded message - Re: SMP Panic caused by [PATCH]
	sched: consolidate sched domains
Content-Type: message/rfc822

Return-Path: <wli@holomorphy.com>
Received: from hancock.sc.steeleye.com (hancock.sc.steeleye.com
	[172.17.4.1]) by pogo.mtv1.steeleye.com (8.12.8/8.12.8) with ESMTP id
	i7THp1cY023858 for <jejb@pogo.mtv1.steeleye.com>; Sun, 29 Aug 2004 10:51:01
	-0700
Received: from localhost.localdomain (orville.steeleye.com [209.192.50.34])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id i7THp0J05623 for
	<James.Bottomley@steeleye.com>; Sun, 29 Aug 2004 13:51:00 -0400
Received: from holomorphy.com (holomorphy.com [207.189.100.168]) by
	localhost.localdomain (8.12.8/8.12.8) with ESMTP id i7TItexp014152 for
	<James.Bottomley@steeleye.com>; Sun, 29 Aug 2004 14:55:40 -0400
Received: from wli by holomorphy.com with local (Exim 3.36 #1 (Debian)) id
	1C1TpS-0003sw-00; Sun, 29 Aug 2004 10:50:58 -0700
Date: Sun, 29 Aug 2004 10:50:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Matthew Dobson <colpatch@us.ibm.com>, Nick Piggin <nickpiggin@yahoo.com.au>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP Panic caused by [PATCH] sched: consolidate sched domains
Message-ID: <20040829175058.GP5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>, James
	Bottomley <James.Bottomley@SteelEye.com>, Jesse Barnes
	<jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>, Linus Torvalds
	<torvalds@osdl.org>, Matthew Dobson <colpatch@us.ibm.com>, Nick Piggin
	<nickpiggin@yahoo.com.au>, Linux Kernel <linux-kernel@vger.kernel.org>
References: <1093786747.1708.8.camel@mulgrave>
	<200408290948.06473.jbarnes@engr.sgi.com>
	<20040829170328.GK5492@holomorphy.com> <1093799390.10990.19.camel@mulgrave>
	<20040829172250.GM5492@holomorphy.com>
	<20040829172923.GN5492@holomorphy.com>
	<20040829174039.GO5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829174039.GO5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
X-Spam-Status: No, hits=-9.2 required=5.0
	tests=AWL,BAYES_01,EMAIL_ATTRIBUTION,IN_REP_TO,
	PATCH_UNIFIED_DIFF,REFERENCES,REPLY_WITH_QUOTES, USER_AGENT_MUTT
	autolearn=ham version=2.55
X-Spam-Level: 
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)

On Sun, Aug 29, 2004 at 10:40:39AM -0700, William Lee Irwin III wrote:
> Okay, if you prefer the #ifdef:

And for the other half of it:


Index: wait-2.6.9-rc1-mm1/kernel/sched.c
===================================================================
--- wait-2.6.9-rc1-mm1.orig/kernel/sched.c	2004-08-28 11:41:47.000000000 -0700
+++ wait-2.6.9-rc1-mm1/kernel/sched.c	2004-08-29 10:46:52.543081208 -0700
@@ -4224,7 +4224,11 @@
 		sd = &per_cpu(phys_domains, i);
 		group = cpu_to_phys_group(i);
 		*sd = SD_CPU_INIT;
+#ifdef CONFIG_NUMA
 		sd->span = nodemask;
+#else
+		sd->span = cpu_possible_map;
+#endif
 		sd->parent = p;
 		sd->groups = &sched_group_phys[group];
 
@@ -4262,6 +4266,7 @@
 						&cpu_to_isolated_group);
 	}
 
+#ifdef CONFIG_NUMA
 	/* Set up physical groups */
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		cpumask_t nodemask = node_to_cpumask(i);
@@ -4273,6 +4278,10 @@
 		init_sched_build_groups(sched_group_phys, nodemask,
 						&cpu_to_phys_group);
 	}
+#else
+	init_sched_build_groups(sched_group_phys, cpu_possible_map,
+							&cpu_to_phys_group);
+#endif
 
 #ifdef CONFIG_NUMA
 	/* Set up node groups */

--=-Mv9ROU3xYps5PqJszgCh--

