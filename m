Return-Path: <linux-kernel-owner+w=401wt.eu-S965000AbWLOBjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWLOBjw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWLOBgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:36:00 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46202 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964994AbWLOBfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:35:38 -0500
Message-Id: <20061215013724.639400000@sous-sol.org>
References: <20061215013337.823935000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 17:33:52 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Andy Gospodarek <andy@greyhouse.net>,
       fubar@us.ibm.com, ctindel@users.sourceforge.net,
       Jeff Garzik <jeff@garzik.org>, Stephen Hemminger <shemminger@osdl.org>
Subject: [patch 15/24] bonding: incorrect bonding state reported via ioctl
Content-Disposition: inline; filename=bonding-incorrect-bonding-state-reported-via-ioctl.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Andy Gospodarek <andy@greyhouse.net>

This is a small fix-up to finish out the work done by Jay Vosburgh to
add carrier-state support for bonding devices.  The output in
/proc/net/bonding/bondX was correct, but when collecting the same info
via an iotcl it could still be incorrect.

Signed-off-by: Andy Gospodarek <andy@greyhouse.net>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/net/bonding/bond_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.5.orig/drivers/net/bonding/bond_main.c
+++ linux-2.6.18.5/drivers/net/bonding/bond_main.c
@@ -3547,7 +3547,7 @@ static int bond_do_ioctl(struct net_devi
 			mii->val_out = 0;
 			read_lock_bh(&bond->lock);
 			read_lock(&bond->curr_slave_lock);
-			if (bond->curr_active_slave) {
+			if (netif_carrier_ok(bond->dev)) {
 				mii->val_out = BMSR_LSTATUS;
 			}
 			read_unlock(&bond->curr_slave_lock);

--
