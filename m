Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263397AbTDSOsP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 10:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263399AbTDSOsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 10:48:15 -0400
Received: from franka.aracnet.com ([216.99.193.44]:2945 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263397AbTDSOsO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 10:48:14 -0400
Date: Sat, 19 Apr 2003 08:00:09 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: [PATCH] Turn on NUMA rebalancing
Message-ID: <33860000.1050764409@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd forgotten that I'd set this to only fire every 20s in the past, 
because it would rebalance too agressively. That seems to be fixed now, 
so we should turn it back on.

diff -urpN -X /home/fletch/.diff.exclude virgin/kernel/sched.c node_rebal/kernel/sched.c
--- virgin/kernel/sched.c	Tue Apr  8 14:38:21 2003
+++ node_rebal/kernel/sched.c	Sat Apr 19 07:51:20 2003
@@ -1091,7 +1091,7 @@ out:
 #define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
 #define BUSY_REBALANCE_TICK (HZ/5 ?: 1)
 #define IDLE_NODE_REBALANCE_TICK (IDLE_REBALANCE_TICK * 5)
-#define BUSY_NODE_REBALANCE_TICK (BUSY_REBALANCE_TICK * 100)
+#define BUSY_NODE_REBALANCE_TICK (BUSY_REBALANCE_TICK * 2)
 
 #ifdef CONFIG_NUMA
 static void balance_node(runqueue_t *this_rq, int idle, int this_cpu)

