Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263332AbTECPFS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 11:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbTECPFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 11:05:18 -0400
Received: from [203.145.184.221] ([203.145.184.221]:24850 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263332AbTECPFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 11:05:17 -0400
Subject: [PATCH 2.{4,5}.x] mod_timer fxi for sch_csz.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 May 2003 20:52:34 +0530
Message-Id: <1051975354.2018.201.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sch_csz.c: trivial {del,add}_timer to mod_timer conversion.

--- linux-2.5.68/net/sched/sch_csz.c	2003-04-21 10:14:44.000000000 +0530
+++ linux-2.5.68-nvk/net/sched/sch_csz.c	2003-05-03 14:40:11.000000000 +0530
@@ -708,11 +708,9 @@
 	 */
 	if (q->wd_expires) {
 		unsigned long delay = PSCHED_US2JIFFIE(q->wd_expires);
-		del_timer(&q->wd_timer);
 		if (delay == 0)
 			delay = 1;
-		q->wd_timer.expires = jiffies + delay;
-		add_timer(&q->wd_timer);
+		mod_timer(&q->wd_timer, jiffies + delay);
 		sch->stats.overlimits++;
 	}
 #endif



