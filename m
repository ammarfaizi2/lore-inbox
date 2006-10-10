Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWJJVWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWJJVWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWJJVWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:22:35 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:57498 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030398AbWJJVWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:22:34 -0400
Date: Tue, 10 Oct 2006 16:22:29 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 20/21]: powerpc/cell spidernet release all descrs
Message-ID: <20061010212229.GQ4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bugfix: rx descriptor release function fails to visit
the last entry while walking receive descriptor ring.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 13:37:40.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 13:40:56.000000000 -0500
@@ -358,7 +358,7 @@ spider_net_free_rx_chain_contents(struct
 	struct spider_net_descr *descr;
 
 	descr = card->rx_chain.head;
-	while (descr->next != card->rx_chain.head) {
+	do {
 		if (descr->skb) {
 			dev_kfree_skb(descr->skb);
 			pci_unmap_single(card->pdev, descr->buf_addr,
@@ -366,7 +366,7 @@ spider_net_free_rx_chain_contents(struct
 					 PCI_DMA_BIDIRECTIONAL);
 		}
 		descr = descr->next;
-	}
+	} while (descr != card->rx_chain.head);
 }
 
 /**
