Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131163AbQJ1RUT>; Sat, 28 Oct 2000 13:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131155AbQJ1RUJ>; Sat, 28 Oct 2000 13:20:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31112 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131152AbQJ1RT6>;
	Sat, 28 Oct 2000 13:19:58 -0400
Date: Sat, 28 Oct 2000 10:05:49 -0700
Message-Id: <200010281705.KAA05833@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: andrewm@uow.edu.au
CC: sclark46@gte.net, linux-kernel@vger.kernel.org
In-Reply-To: <39FAFC63.EDD4A767@uow.edu.au> (message from Andrew Morton on
	Sun, 29 Oct 2000 03:18:43 +1100)
Subject: Re: RTNL assert
In-Reply-To: <39FA4968.62588272@gte.net> <39FAAFF2.200E1860@uow.edu.au> <39FADF38.9CA09B1A@gte.net> <39FAFC63.EDD4A767@uow.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is even one more Andrew :-)  Here is the full patch:

--- ./net/ipv4/ip_gre.c.~1~	Thu Aug 24 18:48:54 2000
+++ ./net/ipv4/ip_gre.c	Sat Oct 28 09:59:43 2000
@@ -1266,7 +1266,9 @@
 #ifdef MODULE
 	register_netdev(&ipgre_fb_tunnel_dev);
 #else
+	rtnl_lock();
 	register_netdevice(&ipgre_fb_tunnel_dev);
+	rtnl_unlock();
 #endif
 
 	inet_add_protocol(&ipgre_protocol);
--- ./net/ipv4/ipip.c.~1~	Thu Aug 24 19:15:47 2000
+++ ./net/ipv4/ipip.c	Sat Oct 28 10:00:04 2000
@@ -894,7 +894,9 @@
 #ifdef MODULE
 	register_netdev(&ipip_fb_tunnel_dev);
 #else
+	rtnl_lock();
 	register_netdevice(&ipip_fb_tunnel_dev);
+	rtnl_unlock();
 #endif
 
 	inet_add_protocol(&ipip_protocol);
--- ./net/ipv6/sit.c.~1~	Mon Oct  9 21:36:50 2000
+++ ./net/ipv6/sit.c	Sat Oct 28 10:00:50 2000
@@ -829,7 +829,9 @@
 #ifdef MODULE
 	register_netdev(&ipip6_fb_tunnel_dev);
 #else
+	rtnl_lock();
 	register_netdevice(&ipip6_fb_tunnel_dev);
+	rtnl_unlock();
 #endif
 	inet_add_protocol(&sit_protocol);
 	return 0;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
