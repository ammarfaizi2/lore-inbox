Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbUCCQ5t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 11:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbUCCQ5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 11:57:49 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:17104 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S262511AbUCCQ5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 11:57:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16454.3720.225353.650939@gargle.gargle.HOWL>
Date: Wed, 3 Mar 2004 11:57:44 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, jbarnes@sgi.com
Subject: [patch] 2.6.4-rc1-mm2 page_alloc on NUMA
X-Mailer: VM 7.03 under Emacs 21.2.1
From: Jes Sorensen <jes@trained-monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I need the following to compile page_alloc.c on a NUMA box. I can't say
if it's a perfect patch though as I am seeing other strange things with
.4-rc1-mm2 but this at least got it compiled and booted.

Problem is that a cpumask_t can be an array so just doing
if (cpumask_t) doesn't work.

Cheers,
Jes

--- linux-2.6.4-rc1-mm2/mm/page_alloc.c~	Wed Mar  3 06:47:37 2004
+++ linux-2.6.4-rc1-mm2/mm/page_alloc.c	Wed Mar  3 07:55:29 2004
@@ -1166,7 +1166,7 @@
 		val = node_distance(node, n);
 
 		/* Give preference to headless and unused nodes */
-		if (node_to_cpumask(n))
+		if (!cpus_empty(node_to_cpumask(n)))
 			val += PENALTY_FOR_NODE_WITH_CPUS;
 
 		/* Slight preference for less loaded node */
