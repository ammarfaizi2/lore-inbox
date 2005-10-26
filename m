Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbVJZQq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVJZQq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 12:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbVJZQq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 12:46:58 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:25269 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964812AbVJZQq5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 12:46:57 -0400
Date: Wed, 26 Oct 2005 10:46:53 -0600
From: Santiago Leon <santil@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Santiago Leon <santil@us.ibm.com>, Jeff Garzik <jgarzik@pobox.com>
Message-Id: <20051026164539.21820.57374.sendpatchset@localhost.localdomain>
In-Reply-To: <20051026164532.21820.72673.sendpatchset@localhost.localdomain>
References: <20051026164532.21820.72673.sendpatchset@localhost.localdomain>
Subject: [PATCH 1/5] ibmveth fix bonding
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates dev->trans_start and dev->last_rx so that the ibmveth
driver can be used with the ARP monitor in the bonding driver. 

Signed-off-by: Santiago Leon <santil@us.ibm.com>
---

 drivers/net/ibmveth.c |    2 ++
 1 files changed, 2 insertions(+)

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
