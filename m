Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbUCMKYE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 05:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUCMKYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 05:24:04 -0500
Received: from dp.samba.org ([66.70.73.150]:38108 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263078AbUCMKYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 05:24:01 -0500
Date: Sat, 13 Mar 2004 21:23:04 +1100
From: Anton Blanchard <anton@samba.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix NUMA compile with large cpumasks
Message-ID: <20040313102303.GC27964@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The recent NUMA changes fail to compile with large cpumasks, we need
to use a temporary to get around the type checking.

Anton

---

 gr26_work-anton/mm/page_alloc.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN mm/page_alloc.c~numacompile mm/page_alloc.c
--- gr26_work/mm/page_alloc.c~numacompile	2004-03-13 02:27:10.474086886 -0600
+++ gr26_work-anton/mm/page_alloc.c	2004-03-13 02:28:15.514771414 -0600
@@ -1155,6 +1155,8 @@ static int __init find_next_best_node(in
 	int best_node = -1;
 
 	for (i = 0; i < numnodes; i++) {
+		cpumask_t tmp;
+
 		/* Start from local node */
 		n = (node+i)%numnodes;
 
@@ -1166,7 +1168,8 @@ static int __init find_next_best_node(in
 		val = node_distance(node, n);
 
 		/* Give preference to headless and unused nodes */
-		if (!cpus_empty(node_to_cpumask(n)))
+		tmp = node_to_cpumask(n);
+		if (!cpus_empty(tmp))
 			val += PENALTY_FOR_NODE_WITH_CPUS;
 
 		/* Slight preference for less loaded node */

_
