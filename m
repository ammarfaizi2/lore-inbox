Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267463AbUGWBDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267463AbUGWBDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 21:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUGWBDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 21:03:07 -0400
Received: from cfcafwp.SGI.COM ([192.48.179.6]:55341 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267168AbUGWBDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 21:03:02 -0400
Date: Thu, 22 Jul 2004 20:02:57 -0500
From: Jack Steiner <steiner@sgi.com>
To: mingo@elte.hu
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] - Initialize sched domain table
Message-ID: <20040723010257.GA27350@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a trivial patch that is required to boot the latest 2.6.7 tree 
on the SGI 512p system.

	Initial the busy_factor in the sched_domain_init table.
	Otherwise, booting hangs doing excessive load balance
	operations.

	Signed-off-by: Jack Steiner <steiner@sgi.com>



Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -3922,6 +3922,7 @@ void __init sched_init(void)
 	sched_domain_init.groups = &sched_group_init;
 	sched_domain_init.last_balance = jiffies;
 	sched_domain_init.balance_interval = INT_MAX; /* Don't balance */
+	sched_domain_init.busy_factor = 1;
 
 	memset(&sched_group_init, 0, sizeof(struct sched_group));
 	sched_group_init.cpumask = CPU_MASK_ALL;
-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


