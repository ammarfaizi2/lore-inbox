Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVCRR5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVCRR5l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 12:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVCRR5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 12:57:41 -0500
Received: from dd3624.kasserver.com ([81.209.188.85]:28378 "EHLO
	dd3624.kasserver.com") by vger.kernel.org with ESMTP
	id S261919AbVCRR5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 12:57:39 -0500
From: Sven Henkel <shenkel@gmail.com>
Message-ID: <16955.5772.749812.983639@gargle.gargle.HOWL>
Date: Fri, 18 Mar 2005 18:57:32 +0100
To: mpm@selenic.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Align udp-packet in netpoll_send_udp
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
X-Spam-Flag: NO
X-Spam-score: -1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

The udp-packet constructed in netpoll_send_udp should be aligned
to avoid alignment-traps on some platforms. The patch applies to
vanilla 2.6.11.2.

Ciao,
Sven


Signed-off-by: Sven Henkel <shenkel@gmail.com>

--- linux-2.6.11.2/net/core/netpoll.c	2005-03-09 09:12:58.000000000 +0100
+++ mylinux-2.6.11.2/net/core/netpoll.c	2005-03-18 15:56:30.330061256 +0100
@@ -233,7 +233,7 @@ void netpoll_send_udp(struct netpoll *np
 
 	udp_len = len + sizeof(*udph);
 	ip_len = eth_len = udp_len + sizeof(*iph);
-	total_len = eth_len + ETH_HLEN;
+	total_len = eth_len + ETH_HLEN + NET_IP_ALIGN;
 
 	skb = find_skb(np, total_len, total_len - len);
 	if (!skb)

