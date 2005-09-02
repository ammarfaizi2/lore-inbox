Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161116AbVIBXKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbVIBXKq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbVIBXKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:10:46 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:52616 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1161116AbVIBXKo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:10:44 -0400
Date: Sat, 3 Sep 2005 00:54:25 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: netdev@vger.kernel.org
Cc: pascal.chapperon@wanadoo.fr, lars.vahlenberg@mandator.com,
       Alexey Dobriyan <adobriyan@gmail.com>, apatard@mandriva.com,
       jgarzik@pobox.com, akpm@osdl.org
Subject: [patch 2.6.13-git3 1/5] sis190: unmask the link change events
Message-ID: <20050902225425.GB25687@electric-eye.fr.zoreil.com>
References: <20050902225224.GA25687@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050902225224.GA25687@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

link changes reporting does not work when the driver masks its irq event

Signed-off-by: Arnaud Patard <apatard@mandriva.com>
Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN a/drivers/net/sis190.c~sis190-170 b/drivers/net/sis190.c
--- a/drivers/net/sis190.c~sis190-170	2005-09-02 23:27:18.621147267 +0200
+++ b/drivers/net/sis190.c	2005-09-02 23:27:18.643143712 +0200
@@ -360,7 +360,7 @@ MODULE_VERSION(DRV_VERSION);
 MODULE_LICENSE("GPL");
 
 static const u32 sis190_intr_mask =
-	RxQEmpty | RxQInt | TxQ1Int | TxQ0Int | RxHalt | TxHalt;
+	RxQEmpty | RxQInt | TxQ1Int | TxQ0Int | RxHalt | TxHalt | LinkChange;
 
 /*
  * Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
@@ -923,6 +923,7 @@ static void sis190_phy_task(void * data)
 		     BMSR_ANEGCOMPLETE)) {
 		net_link(tp, KERN_WARNING "%s: PHY reset until link up.\n",
 			 dev->name);
+		netif_carrier_off(dev);
 		mdio_write(ioaddr, phy_id, MII_BMCR, val | BMCR_RESET);
 		mod_timer(&tp->timer, jiffies + SIS190_PHY_TIMEOUT);
 	} else {

_
