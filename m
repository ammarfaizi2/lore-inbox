Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWACSmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWACSmN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 13:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWACSmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 13:42:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1996 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932478AbWACSmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 13:42:12 -0500
Date: Tue, 3 Jan 2006 10:41:57 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: mikukkon@iki.fi, bridge@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] BRIDGE: Fix faulty check in br_stp_recalculate_bridge_id()
Message-ID: <20060103104157.1512f5fa@dxpl.pdx.osdl.net>
In-Reply-To: <20051221.195107.113618698.davem@davemloft.net>
References: <20051221195527.GA24213@localhost.localdomain>
	<20051221132527.1ef12bcf@dxpl.pdx.osdl.net>
	<20051221.195107.113618698.davem@davemloft.net>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the conversions from memcmp to compare_ether_addr is incorrect.
We need to do relative comparison to determine min MAC address to
use in bridge id. 

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- linux-2.6.15.orig/net/bridge/br_stp_if.c
+++ linux-2.6.15/net/bridge/br_stp_if.c
@@ -158,7 +158,7 @@ void br_stp_recalculate_bridge_id(struct
 
 	list_for_each_entry(p, &br->port_list, list) {
 		if (addr == br_mac_zero ||
-		    compare_ether_addr(p->dev->dev_addr, addr) < 0)
+		    memcmp(p->dev->dev_addr, addr, ETH_ALEN) < 0)
 			addr = p->dev->dev_addr;
 
 	}
