Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWIWMQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWIWMQc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 08:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWIWMQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 08:16:32 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:48006 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1750819AbWIWMQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 08:16:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAN/BFEWLcAIN
X-IronPort-AV: i="4.09,207,1157320800"; 
   d="scan'208"; a="3399254:sNHT50727800"
Date: Sat, 23 Sep 2006 14:16:29 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: Patrick McHardy <kaber@trash.net>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 02/03] net/bridge: add support for EtherIP devices
Message-ID: <20060923121629.GC32284@zlug.org>
References: <20060923120704.GA32284@zlug.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <20060923120704.GA32284@zlug.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch changes the device check in the bridge code to allow EtherIP
devices to be added.

Signed-off-by: Joerg Roedel <joro-lkml@zlug.org>

--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch_etherip_bridge

diff -uprN -X linux-2.6.18-vanilla/Documentation/dontdiff linux-2.6.18-vanilla/net/bridge/br_if.c linux-2.6.18/net/bridge/br_if.c
--- linux-2.6.18-vanilla/net/bridge/br_if.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18/net/bridge/br_if.c	2006-09-20 23:03:26.000000000 +0200
@@ -407,7 +407,8 @@ int br_add_if(struct net_bridge *br, str
 	struct net_bridge_port *p;
 	int err = 0;
 
-	if (dev->flags & IFF_LOOPBACK || dev->type != ARPHRD_ETHER)
+	if (dev->flags & IFF_LOOPBACK ||
+	    dev->type != ARPHRD_ETHER && dev->type != ARPHRD_ETHERIP)
 		return -EINVAL;
 
 	if (dev->hard_start_xmit == br_dev_xmit)

--w7PDEPdKQumQfZlR--
