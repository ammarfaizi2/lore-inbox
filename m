Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966065AbWKNW66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966065AbWKNW66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965992AbWKNW66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:58:58 -0500
Received: from mga07.intel.com ([143.182.124.22]:8636 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S966442AbWKNW65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:58:57 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,422,1157353200"; 
   d="scan'208"; a="146249784:sNHT18432246"
Date: Tue, 14 Nov 2006 14:35:42 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: mingo@elte.hu, nickpiggin@yahoo.com.au, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, clameter@sgi.com, kenneth.w.chen@intel.com
Subject: [patch] sched domain: increase the SMT busy rebalance interval
Message-ID: <20061114143542.A30786@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With SMT, if the logical processor is busy, load balance happens for every
8msec(min)-16msec(max). There is no need to do this often, as this is
just for fairness(to maintain uniform runqueue lengths) and default time slice
anyhow is 100msec.

Appended patch increases this interval to 64msec(min)-128msec(max) when the
logical processor is busy.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
---

diff --git a/include/linux/topology.h b/include/linux/topology.h
index da508d1..b93bb6c 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -93,7 +93,7 @@ #define SD_SIBLING_INIT (struct sched_do
 	.groups			= NULL,			\
 	.min_interval		= 1,			\
 	.max_interval		= 2,			\
-	.busy_factor		= 8,			\
+	.busy_factor		= 64,			\
 	.imbalance_pct		= 110,			\
 	.cache_nice_tries	= 0,			\
 	.per_cpu_gain		= 25,			\
