Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWJWHAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWJWHAS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWJWHAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:00:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:1138 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751628AbWJWHAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:00:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=oSioR5r73FeuoX9gtmpaIstvasJSsdb6yfjHm/hn3hAceeVk+KBBudsGvKTYvm+B1Oraao8FtMWivKln0QnP7eWKQJvzJ50+LFlHA/4/bpkaldZjPGYKjdHuPZc12iQyCg3h2PcaTmFIpcpc4i1MOw3SWc/vK3+F//dnhKFZqSc=
Date: Sun, 22 Oct 2006 23:59:58 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH 2.6.19-rc2] [REVISED] net/ipv4/multipath_wrandom.c: check
 kmalloc() return value.
Message-Id: <20061022235958.b31d7529.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function wrandom_set_nhinfo(), in file net/ipv4/multipath_wrandom.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/net/ipv4/multipath_wrandom.c b/net/ipv4/multipath_wrandom.c
index 92b0482..bcdb1f1 100644
--- a/net/ipv4/multipath_wrandom.c
+++ b/net/ipv4/multipath_wrandom.c
@@ -242,6 +242,9 @@ static void wrandom_set_nhinfo(__be32 ne
 		target_route = (struct multipath_route *)
 			kmalloc(size_rt, GFP_ATOMIC);
 
+		if (!target_route)
+			goto error;
+
 		target_route->gw = nh->nh_gw;
 		target_route->oif = nh->nh_oif;
 		memset(&target_route->rcu, 0, sizeof(struct rcu_head));
@@ -263,6 +266,9 @@ static void wrandom_set_nhinfo(__be32 ne
 		target_dest = (struct multipath_dest*)
 			kmalloc(size_dst, GFP_ATOMIC);
 
+		if (!target_dest)
+			goto error;
+
 		target_dest->nh_info = nh;
 		target_dest->network = network;
 		target_dest->netmask = netmask;
@@ -275,6 +281,7 @@ static void wrandom_set_nhinfo(__be32 ne
 	 * we are finished
 	 */
 
+ error:
 	spin_unlock_bh(&state[state_idx].lock);
 }
 
