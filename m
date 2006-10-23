Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbWJWGVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWJWGVF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbWJWGVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:21:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:18817 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751591AbWJWGVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:21:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=maxRfvGpEjAHRV4xf5iE35Ar9xSDCELaDeM5P8xxSTLaoaCyeZRAAhEXZwVXCyMqTB+z0s09h/9VMsDz/E3tjc2DQvy/BVrDPnLVUVccSX6lBRT69YbxcYdG2xkveXPMYmndX+JmcsvAF0LOvLF+FtzppAbfJ6DTy30mezLQgho=
Date: Sun, 22 Oct 2006 23:20:52 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc2] net/ipv4/multipath_wrandom.c: check kmalloc()
 return value.
Message-Id: <20061022232052.16b1bcf3.amit2030@gmail.com>
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
index 92b0482..45bfd20 100644
--- a/net/ipv4/multipath_wrandom.c
+++ b/net/ipv4/multipath_wrandom.c
@@ -242,6 +242,11 @@ static void wrandom_set_nhinfo(__be32 ne
 		target_route = (struct multipath_route *)
 			kmalloc(size_rt, GFP_ATOMIC);
 
+		if (!target_route) {
+			spin_unlock_bh(&state[state_idx].lock);
+			return;
+		}
+
 		target_route->gw = nh->nh_gw;
 		target_route->oif = nh->nh_oif;
 		memset(&target_route->rcu, 0, sizeof(struct rcu_head));
@@ -263,6 +268,11 @@ static void wrandom_set_nhinfo(__be32 ne
 		target_dest = (struct multipath_dest*)
 			kmalloc(size_dst, GFP_ATOMIC);
 
+		if (!target_dest) {
+			spin_unlock_bh(&state[state_idx].lock);
+			return;
+		}
+
 		target_dest->nh_info = nh;
 		target_dest->network = network;
 		target_dest->netmask = netmask;
