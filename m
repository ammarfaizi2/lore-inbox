Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbUJYQE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUJYQE4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbUJYQBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:01:25 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:42280 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S261975AbUJYPuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:50:09 -0400
Date: Mon, 25 Oct 2004 17:49:56 +0200 (CEST)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sit.c
Message-ID: <Pine.LNX.4.58LT.0410251746160.7107@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (portraits.wsisiz.edu.pl [0.0.0.0]); Mon, 25 Oct 2004 17:50:05 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Patch based on ipip.c and ip6_tunnel.c

diff -Nru linux-2.6.9.org/net/ipv6/sit.c linux-2.6.9/net/ipv6/sit.c
--- linux-2.6.9.org/net/ipv6/sit.c      2004-10-18 23:55:18.000000000 
+0200
+++ linux-2.6.9/net/ipv6/sit.c  2004-10-25 17:42:47.000000000 +0200
@@ -796,7 +796,10 @@

 void __exit sit_cleanup(void)
 {
-       inet_del_protocol(&sit_protocol, IPPROTO_IPV6);
+
+       if (inet_del_protocol(&sit_protocol, IPPROTO_IPV6) <0)
+               printk(KERN_INFO "sit close: can't remove protocol\n");
+
        unregister_netdev(ipip6_fb_tunnel_dev);
 }
