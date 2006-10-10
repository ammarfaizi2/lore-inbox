Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbWJJVG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbWJJVG5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWJJVG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:06:57 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:55190 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030390AbWJJVGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:06:55 -0400
Date: Tue, 10 Oct 2006 16:06:53 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 10/21]: powerpc/cell spidernet  fix error interrupt print
Message-ID: <20061010210653.GG4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The print message associated with the descriptor chain end interrupt
prints a bogs value. Fix that.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 12:52:42.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 12:58:08.000000000 -0500
@@ -1356,7 +1356,7 @@ spider_net_handle_error_irq(struct spide
 		if (netif_msg_intr(card))
 			pr_err("got descriptor chain end interrupt, "
 			       "restarting DMAC %c.\n",
-			       'D'+i-SPIDER_NET_GDDDCEINT);
+			       'D'-(i-SPIDER_NET_GDDDCEINT)/3);
 		spider_net_refill_rx_chain(card);
 		spider_net_enable_rxdmac(card);
 		show_error = 0;
