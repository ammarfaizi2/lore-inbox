Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVCCGIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVCCGIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVCCFem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:34:42 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:54897 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261194AbVCCFbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:31:43 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][7/11] IB/ipoib: use list_for_each_entry_safe when required
In-Reply-To: <2005322131.6N8qBqgz1WuD4wnL@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 2 Mar 2005 21:31:22 -0800
Message-Id: <2005322131.K2SnvQsocHnkTwPm@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 05:31:22.0835 (UTC) FILETIME=[3C6D1A30:01C51FB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shirley Ma <xma@us.ibm.com>

Change uses of list_for_each_entry() where the loop variable is freed
inside the loop to list_for_each_entry_safe().

Signed-off-by: Shirley Ma <xma@us.ibm.com>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	2005-03-02 20:26:02.832873236 -0800
+++ linux-export/drivers/infiniband/ulp/ipoib/ipoib_multicast.c	2005-03-02 20:26:12.799709771 -0800
@@ -790,7 +790,7 @@
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	list_for_each_entry(mcast, &remove_list, list) {
+	list_for_each_entry_safe(mcast, tmcast, &remove_list, list) {
 		ipoib_mcast_leave(dev, mcast);
 		ipoib_mcast_free(mcast);
 	}
@@ -902,7 +902,7 @@
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	/* We have to cancel outside of the spinlock */
-	list_for_each_entry(mcast, &remove_list, list) {
+	list_for_each_entry_safe(mcast, tmcast, &remove_list, list) {
 		ipoib_mcast_leave(mcast->dev, mcast);
 		ipoib_mcast_free(mcast);
 	}

