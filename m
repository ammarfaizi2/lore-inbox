Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTECPCk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 11:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263332AbTECPCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 11:02:40 -0400
Received: from [203.145.184.221] ([203.145.184.221]:24082 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263330AbTECPCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 11:02:39 -0400
Subject: [PATCH 2.{4,5}.x] mod_timer fix for sch_htb.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: davej@codemonkey.org.uk
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 May 2003 20:49:52 +0530
Message-Id: <1051975192.1243.197.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sch_htb.c: trivial {del,add}_timer to mod_timer conversion.

--- linux-2.5.68/net/sched/sch_htb.c	2003-04-21 10:14:44.000000000 +0530
+++ linux-2.5.68-nvk/net/sched/sch_htb.c	2003-05-03 14:41:36.000000000 +0530
@@ -975,9 +975,7 @@
 			printk(KERN_INFO "HTB delay %ld > 5sec\n", delay);
 		delay = 5*HZ;
 	}
-	del_timer(&q->timer);
-	q->timer.expires = jiffies + delay;
-	add_timer(&q->timer);
+	mod_timer(&q->timer, jiffies + delay);
 	sch->flags |= TCQ_F_THROTTLED;
 	sch->stats.overlimits++;
 	HTB_DBG(3,1,"htb_deq t_delay=%ld\n",delay);



