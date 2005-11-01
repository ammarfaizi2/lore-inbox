Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVKATPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVKATPM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVKATPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:15:12 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:23208 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751154AbVKATPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:15:11 -0500
Date: Tue, 1 Nov 2005 14:15:09 -0500
From: Santiago Leon <santil@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Santiago Leon <santil@us.ibm.com>, netdev <netdev@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Message-Id: <20051101175617.25145.73324.sendpatchset@ltcml8p7.rchland.ibm.com>
Subject: [PATCH] ibmveth fix panic in initial replenish cycle
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a panic in the current tree caused by a race condition between the initial replenish cycle and the rx processing of the first packets trying to replenish the buffers.

Signed-off-by: Santiago Leon <santil@us.ibm.com>

diff --git a/drivers/net/ibmveth.c b/drivers/net/ibmveth.c
--- a/drivers/net/ibmveth.c
+++ b/drivers/net/ibmveth.c
@@ -535,7 +535,7 @@ static int ibmveth_open(struct net_devic
 	}
 
 	ibmveth_debug_printk("initial replenish cycle\n");
-	ibmveth_replenish_task(adapter);
+	ibmveth_interrupt(netdev->irq, netdev, NULL);
 
 	netif_start_queue(netdev);
 
