Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWEAXLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWEAXLv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 19:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWEAXLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 19:11:51 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:47770 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S932309AbWEAXLu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 19:11:50 -0400
Date: Tue, 2 May 2006 01:10:07 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: David Vrabel <dvrabel@cantab.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net
Subject: [PATCH 1/3] ipg: removal of unreachable code
Message-ID: <20060501231007.GB7419@electric-eye.fr.zoreil.com>
References: <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com> <20060428113755.GA7419@fargo> <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI> <1146306567.1642.3.camel@localhost> <20060429122119.GA22160@fargo> <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost> <44554ADE.8030200@cantab.net> <4455F1D8.5030102@cantab.net> <1146506939.23931.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146506939.23931.2.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

map/unmap is done in ipg_{probe/remove}

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

---

 drivers/net/ipg.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

2b14ddef0c29f43c07ffd33c3d1d9e652db3a571
diff --git a/drivers/net/ipg.c b/drivers/net/ipg.c
index 5d4d023..42396ca 100644
--- a/drivers/net/ipg.c
+++ b/drivers/net/ipg.c
@@ -1790,24 +1790,6 @@ static int ipg_nic_stop(struct net_devic
 	/* Release interrupt line. */
 	free_irq(dev->irq, dev);
 	return 0;
-
-#ifdef USE_IO_OPS
-
-	/* Release I/O range reserved for IPG registers. */
-	release_region(dev->base_addr, IPG_IO_REG_RANGE);
-
-#else				/* Not using I/O space. */
-
-	/* Unmap memory used for IPG registers. */
-
-	/* The following line produces strange results unless
-	 * unregister_netdev precedes it.
-	 */
-	iounmap(sp->ioaddr);
-
-#endif
-
-	return 0;
 }
 
 static int ipg_nic_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
-- 
1.3.1

