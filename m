Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbUKPRSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUKPRSK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 12:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUKPRSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 12:18:10 -0500
Received: from hera.cwi.nl ([192.16.191.8]:43190 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262049AbUKPRRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 12:17:13 -0500
Date: Tue, 16 Nov 2004 18:17:08 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200411161717.iAGHH8A26623@apps.cwi.nl>
To: akpm@osdl.org, linux-net@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] police fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -uprN -X /linux/dontdiff a/net/sched/police.c b/net/sched/police.c
--- a/net/sched/police.c	2004-11-15 20:02:25.000000000 +0100
+++ b/net/sched/police.c	2004-11-16 18:14:25.000000000 +0100
@@ -576,6 +576,7 @@ int tcf_police_dump_stats(struct sk_buff
 	
 	if (gnet_stats_start_copy_compat(skb, TCA_STATS2, TCA_STATS,
 			TCA_XSTATS, p->stats_lock, &d) < 0)
+		goto errout;
 	
 	if (gnet_stats_copy_basic(&d, &p->bstats) < 0 ||
 #ifdef CONFIG_NET_ESTIMATOR
