Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVJYV2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVJYV2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 17:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVJYV2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 17:28:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:36780 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932394AbVJYV2Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 17:28:16 -0400
Subject: [PATCH] 1/5 ibmveth fix bonding
From: Santiago Leon <santil@us.ibm.com>
To: netdev <netdev@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>
Content-Type: text/plain
Message-Id: <1130275458.10524.425.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 25 Oct 2005 16:27:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates dev->trans_start and dev->last_rx so that the ibmveth
driver can be used with the ARP monitor in the bonding driver. 

Signed-off-by: Santiago Leon <santil@us.ibm.com>
---
 drivers/net/ibmveth.c |    2 ++
 1 files changed, 2 insertions(+)
---
diff -urN a/drivers/net/ibmveth.c b/drivers/net/ibmveth.c
--- a/drivers/net/ibmveth.c	2005-10-11 12:56:24.000000000 -0500
+++ b/drivers/net/ibmveth.c	2005-10-11 13:52:45.000000000 -0500
@@ -725,6 +725,7 @@
 	} else {
 		adapter->stats.tx_packets++;
 		adapter->stats.tx_bytes += skb->len;
+		netdev->trans_start = jiffies;
 	}
 
 	do {
@@ -776,6 +777,7 @@
 				adapter->stats.rx_packets++;
 				adapter->stats.rx_bytes += length;
 				frames_processed++;
+				netdev->last_rx = jiffies;
 			}
 		} else {
 			more_work = 0;

-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center

