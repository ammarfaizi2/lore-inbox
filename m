Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTJRGeu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 02:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbTJRGeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 02:34:50 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:41344
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261351AbTJRGet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 02:34:49 -0400
Date: Sat, 18 Oct 2003 02:34:25 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: [PATCH][2.6] fix compilation w/o CONFIG_XFRM
Message-ID: <Pine.LNX.4.53.0310180226360.2831@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.6.0-test8/net/ipv6/sit.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test8/net/ipv6/sit.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 sit.c
--- linux-2.6.0-test8/net/ipv6/sit.c	18 Oct 2003 01:37:19 -0000	1.1.1.1
+++ linux-2.6.0-test8/net/ipv6/sit.c	18 Oct 2003 04:13:21 -0000
@@ -377,8 +377,10 @@ static int ipip6_rcv(struct sk_buff *skb
 
 	read_lock(&ipip6_lock);
 	if ((tunnel = ipip6_tunnel_lookup(iph->saddr, iph->daddr)) != NULL) {
+#ifdef CONFIG_XFRM
 		secpath_put(skb->sp);
 		skb->sp = NULL;
+#endif
 		skb->mac.raw = skb->nh.raw;
 		skb->nh.raw = skb->data;
 		memset(&(IPCB(skb)->opt), 0, sizeof(struct ip_options));
