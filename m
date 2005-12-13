Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbVLMI3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVLMI3l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVLMI3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:29:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:28292 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932566AbVLMIZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:25:10 -0500
Date: Tue, 13 Dec 2005 00:23:30 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       razzor@kopf-tisch.de, davem@davemloft.net
Subject: [patch 20/26] [BRIDGE]: recompute features when adding a new device
Message-ID: <20051213082330.GT5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Olaf Rempel <razzor@kopf-tisch.de>

We must recompute bridge features everytime the list of underlying
devices changes, or we might end up with features that are not supported
by all devices (eg. NETIF_F_TSO)
This patch adds the missing recompute when adding a device to the bridge.

Signed-off-by: Olaf Rempel <razzor@kopf-tisch.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/bridge/br_if.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.14.3.orig/net/bridge/br_if.c
+++ linux-2.6.14.3/net/bridge/br_if.c
@@ -366,6 +366,7 @@ int br_add_if(struct net_bridge *br, str
 
 		spin_lock_bh(&br->lock);
 		br_stp_recalculate_bridge_id(br);
+		br_features_recompute(br);
 		if ((br->dev->flags & IFF_UP) 
 		    && (dev->flags & IFF_UP) && netif_carrier_ok(dev))
 			br_stp_enable_port(p);

--
