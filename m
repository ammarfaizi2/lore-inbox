Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTFIU3n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTFIU3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:29:43 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:462 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261872AbTFIU3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:29:42 -0400
Date: Mon, 09 Jun 2003 13:32:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix scheduler bug not passing idle
Message-ID: <72650000.1055190728@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rebalance_tick is not properly passing the idle argument through to 
load_balance in one case. The fix is trivial. Pointed out by John Hawkes.

diff -purN -X /home/mbligh/.diff.exclude mm5/kernel/sched.c mm5-idle/kernel/sched.c
--- mm5/kernel/sched.c	2003-06-09 13:28:47.000000000 -0700
+++ mm5-idle/kernel/sched.c	2003-06-09 13:31:20.000000000 -0700
@@ -1107,7 +1107,7 @@ static void rebalance_tick(runqueue_t *t
 #endif
 		if (!(j % IDLE_REBALANCE_TICK)) {
 			spin_lock(&this_rq->lock);
-			load_balance(this_rq, 0, cpu_to_node_mask(this_cpu));
+			load_balance(this_rq, idle, cpu_to_node_mask(this_cpu));
 			spin_unlock(&this_rq->lock);
 		}
 		return;


