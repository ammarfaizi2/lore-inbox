Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWIKHoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWIKHoM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 03:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWIKHoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 03:44:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:17568 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751173AbWIKHoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 03:44:10 -0400
From: Balbir Singh <balbir@in.ibm.com>
To: akpm@osdl.org
Cc: Balbir Singh <balbir@in.ibm.com>, Jamal Hadi <hadi@cyberus.ca>,
       Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
       Shailabh Nagar <nagar@watson.ibm.com>, linux-kernel@vger.kernel.org
Date: Mon, 11 Sep 2006 13:10:32 +0530
Message-Id: <20060911074032.26844.3566.sendpatchset@localhost.localdomain>
In-Reply-To: <20060911074021.26844.70576.sendpatchset@localhost.localdomain>
References: <20060911074021.26844.70576.sendpatchset@localhost.localdomain>
Subject: [RFC][PATCH -mm] Fix taskstats size calculation (use the new genetlink utility functions)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The addition of the CSA patch pushed the size of struct taskstats to 256
bytes. This exposed a problem with prepare_reply(), we were not allocating
space for the netlink and genetlink header. It worked earlier because
alloc_skb() would align the skb to SMP_CACHE_BYTES, which added some additonal
bytes.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 kernel/taskstats.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN kernel/taskstats.c~taskstats-fix-msg-size kernel/taskstats.c
--- linux-2.6.18-rc6/kernel/taskstats.c~taskstats-fix-msg-size	2006-09-11 11:42:40.000000000 +0530
+++ linux-2.6.18-rc6-balbir/kernel/taskstats.c	2006-09-11 11:42:55.000000000 +0530
@@ -77,7 +77,7 @@ static int prepare_reply(struct genl_inf
 	/*
 	 * If new attributes are added, please revisit this allocation
 	 */
-	skb = nlmsg_new(size, GFP_KERNEL);
+	skb = nlmsg_new(genlmsg_total_size(size), GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
