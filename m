Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVDNC0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVDNC0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 22:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVDNC0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 22:26:30 -0400
Received: from fmr24.intel.com ([143.183.121.16]:7332 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261418AbVDNC01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 22:26:27 -0400
Date: Wed, 13 Apr 2005 19:26:17 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: nickpiggin@yahoo.com.au, mingo@elte.hu
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] sched: fix sched domain degenerate
Message-ID: <20050413192616.A28163@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Appended patch makes sched domain degenerate really work.

For example, now NUMA domain really gets removed on a non-NUMA system.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>


--- linux-2.6.12-rc2-mm3/kernel/sched.c	2005-04-13 11:15:00.942609504 -0700
+++ linux-mc/kernel/sched.c	2005-04-13 10:44:37.400829992 -0700
@@ -4777,7 +4777,7 @@ static int __devinit sd_parent_degenerat
 	/* WAKE_BALANCE is a subset of WAKE_AFFINE */
 	if (cflags & SD_WAKE_AFFINE)
 		pflags &= ~SD_WAKE_BALANCE;
-	if ((~sd->flags) & parent->flags)
+	if (~cflags & pflags)
 		return 0;
 
 	return 1;
--- linux-2.6.12-rc2-mm3/include/linux/topology.h	2005-04-11 23:08:30.843108376 -0700
+++ linux-mc/include/linux/topology.h	2005-04-13 11:14:44.591095312 -0700
@@ -97,6 +97,7 @@
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
+				| SD_BALANCE_FORK	\
 				| SD_WAKE_AFFINE	\
 				| SD_WAKE_IDLE		\
 				| SD_SHARE_CPUPOWER,	\
@@ -128,6 +129,7 @@
 	.flags			= SD_LOAD_BALANCE	\
 				| SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
+				| SD_BALANCE_FORK	\
 				| SD_WAKE_AFFINE,	\
 	.last_balance		= jiffies,		\
 	.balance_interval	= 1,			\
