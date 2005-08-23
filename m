Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVHWVrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVHWVrg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVHWVrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:47:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16566 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932437AbVHWVoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:44:39 -0400
To: torvalds@osdl.org
Subject: [PATCH] (35/43) emac netpoll fix
Cc: linux-kernel@vger.kernel.org, mporter@kernel.crashing.org
Message-Id: <E1E7gcQ-0007EQ-Au@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:47:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

netpoll is void(struct net_device *), not int(struct net_device *)

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-vidc/drivers/net/ibm_emac/ibm_emac_core.c RC13-rc6-git13-emac-netpoll/drivers/net/ibm_emac/ibm_emac_core.c
--- RC13-rc6-git13-vidc/drivers/net/ibm_emac/ibm_emac_core.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-emac-netpoll/drivers/net/ibm_emac/ibm_emac_core.c	2005-08-21 13:17:16.000000000 -0400
@@ -1712,11 +1712,10 @@
 };
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-static int emac_netpoll(struct net_device *ndev)
+static void emac_netpoll(struct net_device *ndev)
 {
 	emac_rxeob_dev((void *)ndev, 0);
 	emac_txeob_dev((void *)ndev, 0);
-	return 0;
 }
 #endif
 
