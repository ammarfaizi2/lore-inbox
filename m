Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUH2Rky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUH2Rky (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbUH2Rky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:40:54 -0400
Received: from holomorphy.com ([207.189.100.168]:57518 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265093AbUH2Rkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:40:52 -0400
Date: Sun, 29 Aug 2004 10:40:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP Panic caused by [PATCH] sched: consolidate sched domains
Message-ID: <20040829174039.GO5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Matthew Dobson <colpatch@us.ibm.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1093786747.1708.8.camel@mulgrave> <200408290948.06473.jbarnes@engr.sgi.com> <20040829170328.GK5492@holomorphy.com> <1093799390.10990.19.camel@mulgrave> <20040829172250.GM5492@holomorphy.com> <20040829172923.GN5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829172923.GN5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 10:29:23AM -0700, William Lee Irwin III wrote:
> Okay, how about:

Okay, if you prefer the #ifdef:


Index: wait-2.6.9-rc1-mm1/kernel/sched.c
===================================================================
--- wait-2.6.9-rc1-mm1.orig/kernel/sched.c	2004-08-28 11:41:47.000000000 -0700
+++ wait-2.6.9-rc1-mm1/kernel/sched.c	2004-08-29 10:37:04.210521352 -0700
@@ -4262,6 +4262,7 @@
 						&cpu_to_isolated_group);
 	}
 
+#ifdef CONFIG_NUMA
 	/* Set up physical groups */
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		cpumask_t nodemask = node_to_cpumask(i);
@@ -4273,6 +4274,10 @@
 		init_sched_build_groups(sched_group_phys, nodemask,
 						&cpu_to_phys_group);
 	}
+#else
+	init_sched_build_groups(sched_group_phys, cpu_possible_map,
+							&cpu_to_phys_group);
+#endif
 
 #ifdef CONFIG_NUMA
 	/* Set up node groups */
