Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263314AbTECN7K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 09:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTECN7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 09:59:10 -0400
Received: from [203.145.184.221] ([203.145.184.221]:274 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263314AbTECN7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 09:59:09 -0400
Subject: [PATCH 2.{4,5}.x] mod_timer fix for sch_cbq.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: davej@codemonkey.org.uk
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 May 2003 19:46:19 +0530
Message-Id: <1051971380.2018.128.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sch_cbq.c: trivial {del,add}_timer to mod_timer conversions.

vinay

--- linux-2.5.68/net/sched/sch_cbq.c	2003-03-25 10:08:36.000000000 +0530
+++ linux-2.5.68-nvk/net/sched/sch_cbq.c	2003-05-03 19:29:08.000000000 +0530
@@ -1056,11 +1056,9 @@
 		sch->stats.overlimits++;
 		if (q->wd_expires && !netif_queue_stopped(sch->dev)) {
 			long delay = PSCHED_US2JIFFIE(q->wd_expires);
-			del_timer(&q->wd_timer);
 			if (delay <= 0)
 				delay = 1;
-			q->wd_timer.expires = jiffies + delay;
-			add_timer(&q->wd_timer);
+			mod_timer(&q->wd_timer, jiffies + delay);
 			sch->flags |= TCQ_F_THROTTLED;
 		}
 	}

