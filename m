Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWEQWP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWEQWP7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWEQWMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:12:40 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:56451 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751259AbWEQWM0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:26 -0400
Message-Id: <20060517221403.630773000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:10 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Karsten Keil <kkeil@suse.de>, Michael Chan <mchan@broadcom.com>,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/22] [PATCH] TG3: ethtool always report port is TP.
Content-Disposition: inline; filename=tg3-ethtool-always-report-port-is-tp.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Even with fiber cards ethtool reports that the connected port is TP,
the patch fix this.

Signed-off-by: Karsten Keil <kkeil@suse.de>
Acked-by: Michael Chan <mchan@broadcom.com>
Signed-off-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/net/tg3.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- linux-2.6.16.16.orig/drivers/net/tg3.c
+++ linux-2.6.16.16/drivers/net/tg3.c
@@ -7368,21 +7368,23 @@ static int tg3_get_settings(struct net_d
 		cmd->supported |= (SUPPORTED_1000baseT_Half |
 				   SUPPORTED_1000baseT_Full);
 
-	if (!(tp->tg3_flags2 & TG3_FLG2_ANY_SERDES))
+	if (!(tp->tg3_flags2 & TG3_FLG2_ANY_SERDES)) {
 		cmd->supported |= (SUPPORTED_100baseT_Half |
 				  SUPPORTED_100baseT_Full |
 				  SUPPORTED_10baseT_Half |
 				  SUPPORTED_10baseT_Full |
 				  SUPPORTED_MII);
-	else
+		cmd->port = PORT_TP;
+	} else {
 		cmd->supported |= SUPPORTED_FIBRE;
+		cmd->port = PORT_FIBRE;
+	}
   
 	cmd->advertising = tp->link_config.advertising;
 	if (netif_running(dev)) {
 		cmd->speed = tp->link_config.active_speed;
 		cmd->duplex = tp->link_config.active_duplex;
 	}
-	cmd->port = 0;
 	cmd->phy_address = PHY_ADDR;
 	cmd->transceiver = 0;
 	cmd->autoneg = tp->link_config.autoneg;

--
