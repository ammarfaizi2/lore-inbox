Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031216AbWKUQtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031216AbWKUQtI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 11:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031214AbWKUQtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 11:49:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56006 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1031199AbWKUQtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 11:49:07 -0500
Date: Tue, 21 Nov 2006 11:46:44 -0500
From: Andy Gospodarek <andy@greyhouse.net>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: fubar@us.ibm.com, ctindel@users.sourceforge.net
Subject: [PATCH 2.6.19] bonding: incorrect bonding state reported via ioctl
Message-ID: <20061121164643.GA2539@gospo.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a small fix-up to finish out the work done by Jay Vosburgh to
add carrier-state support for bonding devices.  The output in
/proc/net/bonding/bondX was correct, but when collecting the same info
via an iotcl it could still be incorrect.

Signed-off-by: Andy Gospodarek <andy@greyhouse.net>
---

 bond_main.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3547,7 +3547,7 @@ static int bond_do_ioctl(struct net_devi
 			mii->val_out = 0;
 			read_lock_bh(&bond->lock);
 			read_lock(&bond->curr_slave_lock);
-			if (bond->curr_active_slave) {
+			if (netif_carrier_ok(bond->dev)) {
 				mii->val_out = BMSR_LSTATUS;
 			}
 			read_unlock(&bond->curr_slave_lock);
