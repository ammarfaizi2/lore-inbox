Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVHLCVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVHLCVs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 22:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbVHLCUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 22:20:16 -0400
Received: from waste.org ([216.27.176.166]:168 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964789AbVHLCTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 22:19:49 -0400
Date: Thu, 11 Aug 2005 21:19:10 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.com>, "David S. Miller" <davem@davemloft.net>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: ak@suse.de, Jeff Moyer <jmoyer@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, john.ronciak@intel.com,
       rostedt@goodmis.org
In-Reply-To: <1.502409567@selenic.com>
Message-Id: <2.502409567@selenic.com>
Subject: [PATCH 1/8] netpoll: rx_flags bugfix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize npinfo->rx_flags.  The way it stands now, this will have random
garbage, and so will incur a locking penalty even when an rx_hook isn't
registered and we are not active in the netpoll polling code.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Matt Mackall <mpm@selenic.com>

--- linux-2.6.12/net/core/netpoll.c.orig	2005-07-01 14:02:56.039174635 -0400
+++ linux-2.6.12/net/core/netpoll.c	2005-07-01 14:03:16.688739508 -0400
@@ -639,6 +639,7 @@ int netpoll_setup(struct netpoll *np)
 		if (!npinfo)
 			goto release;
 
+		npinfo->rx_flags = 0;
 		npinfo->rx_np = NULL;
 		npinfo->poll_lock = SPIN_LOCK_UNLOCKED;
 		npinfo->poll_owner = -1;
