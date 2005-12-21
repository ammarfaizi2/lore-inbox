Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVLUT4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVLUT4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbVLUT4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:56:43 -0500
Received: from tarjoilu.luukku.com ([194.215.205.232]:7851 "EHLO
	tarjoilu.luukku.com") by vger.kernel.org with ESMTP id S964800AbVLUT4n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:56:43 -0500
Date: Wed, 21 Dec 2005 21:55:27 +0200
From: mikukkon@iki.fi
To: shemminger@osdl.org
Cc: bridge@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] BRIDGE: Fix faulty check in br_stp_recalculate_bridge_id()
Message-ID: <20051221195527.GA24213@localhost.localdomain>
Reply-To: mikukkon@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did a compile with extra gcc warnings, and found a bug in
net/bridge/br_stp_if.c function br_stp_recalculate_bridge_id():
compare_ether_addr() returns 0 if match, positive if not, so
checking it for negative is wrong. 

Signed-of-by: Mika Kukkonen <mikukkon@iki.fi>

---

 net/bridge/br_stp_if.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index ac09b6a..08c52c2 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -158,7 +158,7 @@ void br_stp_recalculate_bridge_id(struct
 
 	list_for_each_entry(p, &br->port_list, list) {
 		if (addr == br_mac_zero ||
-		    compare_ether_addr(p->dev->dev_addr, addr) < 0)
+		    compare_ether_addr(p->dev->dev_addr, addr))
 			addr = p->dev->dev_addr;
 
 	}

