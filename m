Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266338AbUGOW3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266338AbUGOW3c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 18:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266435AbUGOW3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 18:29:32 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:5960 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266338AbUGOW3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 18:29:30 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, John Hawkes <hawkes@sgi.com>
Subject: [PATCH] reduce inter-node balancing frequency
Date: Thu, 15 Jul 2004 18:29:20 -0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AVw9AQcMmsuzIHm"
Message-Id: <200407151829.20069.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_AVw9AQcMmsuzIHm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Nick, we've had this patch floating around for awhile now and I'm wondering 
what you think.  It's needed to boot systems with lots (e.g. 256) nodes, but 
could probably be done another way.  Do you think we should create a 
scheduler domain for every 64 nodes or something?  Any other NUMA folks have 
thoughts about these values?

Thanks,
Jesse

--Boundary-00=_AVw9AQcMmsuzIHm
Content-Type: text/x-diff;
  charset="us-ascii";
  name="scheduler-numa-tweak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="scheduler-numa-tweak.patch"

===== include/linux/sched.h 1.227 vs edited =====
--- 1.227/include/linux/sched.h	2004-07-01 22:23:48 -07:00
+++ edited/include/linux/sched.h	2004-07-15 14:53:50 -07:00
@@ -651,9 +651,9 @@
 	.span			= CPU_MASK_NONE,	\
 	.parent			= NULL,			\
 	.groups			= NULL,			\
-	.min_interval		= 8,			\
-	.max_interval		= 32,			\
-	.busy_factor		= 32,			\
+	.min_interval		= 80,			\
+	.max_interval		= 320,			\
+	.busy_factor		= 320,			\
 	.imbalance_pct		= 125,			\
 	.cache_hot_time		= (10*1000000),		\
 	.cache_nice_tries	= 1,			\
@@ -662,7 +662,7 @@
 				| SD_BALANCE_CLONE	\
 				| SD_WAKE_BALANCE,	\
 	.last_balance		= jiffies,		\
-	.balance_interval	= 1,			\
+	.balance_interval	= 10,			\
 	.nr_balance_failed	= 0,			\
 }
 #endif

--Boundary-00=_AVw9AQcMmsuzIHm--
