Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbVHLCU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbVHLCU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 22:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVHLCUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 22:20:22 -0400
Received: from waste.org ([216.27.176.166]:64423 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964781AbVHLCTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 22:19:48 -0400
Date: Thu, 11 Aug 2005 21:19:10 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.com>, "David S. Miller" <davem@davemloft.net>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: ak@suse.de, Jeff Moyer <jmoyer@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, john.ronciak@intel.com,
       rostedt@goodmis.org
In-Reply-To: <3.502409567@selenic.com>
Message-Id: <4.502409567@selenic.com>
Subject: [PATCH 3/8] netpoll: e1000 netpoll tweak
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suggested by Steven Rostedt, matches his patch included in e100.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: l/drivers/net/e1000/e1000_main.c
===================================================================
--- l.orig/drivers/net/e1000/e1000_main.c	2005-08-06 17:36:32.000000000 -0500
+++ l/drivers/net/e1000/e1000_main.c	2005-08-06 17:55:01.000000000 -0500
@@ -3789,6 +3789,7 @@ e1000_netpoll(struct net_device *netdev)
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	disable_irq(adapter->pdev->irq);
 	e1000_intr(adapter->pdev->irq, netdev, NULL);
+	e1000_clean_tx_irq(adapter);
 	enable_irq(adapter->pdev->irq);
 }
 #endif
