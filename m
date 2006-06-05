Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751232AbWFERVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWFERVg (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 13:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWFERVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 13:21:36 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:419 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1751232AbWFERVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 13:21:35 -0400
X-IronPort-AV: i="4.05,211,1146466800"; 
   d="scan'208"; a="288971588:sNHT30738088"
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [git pull] please pull infiniband.git
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 05 Jun 2006 10:21:33 -0700
Message-ID: <adaejy3plgi.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Jun 2006 17:21:34.0585 (UTC) FILETIME=[7E9D6690:01C688C4]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This has a one-line bug fix:

Eli Cohen:
      IPoIB: Fix AH leak at interface down

 drivers/infiniband/ulp/ipoib/ipoib_ib.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index a54da42..8406839 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -275,6 +275,7 @@ static void ipoib_ib_handle_wc(struct ne
 		spin_lock_irqsave(&priv->tx_lock, flags);
 		++priv->tx_tail;
 		if (netif_queue_stopped(dev) &&
+		    test_bit(IPOIB_FLAG_ADMIN_UP, &priv->flags) &&
 		    priv->tx_head - priv->tx_tail <= ipoib_sendq_size >> 1)
 			netif_wake_queue(dev);
 		spin_unlock_irqrestore(&priv->tx_lock, flags);
