Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbUAPSiX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265525AbUAPSiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:38:23 -0500
Received: from maxipes.logix.cz ([81.0.234.97]:7118 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S261890AbUAPSiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:38:10 -0500
Message-ID: <40082F88.9030705@logix.cz>
Date: Fri, 16 Jan 2004 19:38:00 +0100
From: Michal Ludvig <michal@logix.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030814
X-Accept-Language: cs, cz, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH] SIT tunnels over IPsec
Content-Type: multipart/mixed;
 boundary="------------030007080708000805060003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030007080708000805060003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

The attached patch fixes IPv6-in-IPv4 (SIT) tunnel over IPsec. Without 
it the SIT packets originated from the same host as the IPsec endpoint 
is leave the interface unencrypted and of course the tunnel doesn't 
work. The patch fixes it. Tested.

Please apply.

Thanks,

Michal Ludvig
-- 
* A mouse is a device used to point at the xterm you want to type in.
* Personal homepage - http://www.logix.cz/michal


--------------030007080708000805060003
Content-Type: text/plain;
 name="kernel-sit.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel-sit.diff"

--- linux-2.6.1.orig/net/ipv6/sit.c	2004-01-09 08:00:03.000000000 +0100
+++ linux-2.6.1/net/ipv6/sit.c	2004-01-16 09:51:13.000000000 +0100
@@ -485,7 +485,8 @@ static int ipip6_tunnel_xmit(struct sk_b
 					      { .daddr = dst,
 						.saddr = tiph->saddr,
 						.tos = RT_TOS(tos) } },
-				    .oif = tunnel->parms.link };
+				    .oif = tunnel->parms.link,
+				    .proto = IPPROTO_IPV6 };
 		if (ip_route_output_key(&rt, &fl)) {
 			tunnel->stat.tx_carrier_errors++;
 			goto tx_error_icmp;
@@ -757,7 +758,8 @@ static int ipip6_tunnel_init(struct net_
 					      { .daddr = iph->daddr,
 						.saddr = iph->saddr,
 						.tos = RT_TOS(iph->tos) } },
-				    .oif = tunnel->parms.link };
+				    .oif = tunnel->parms.link,
+				    .proto = IPPROTO_IPV6 };
 		struct rtable *rt;
 		if (!ip_route_output_key(&rt, &fl)) {
 			tdev = rt->u.dst.dev;


--------------030007080708000805060003--

