Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269379AbUIIJbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269379AbUIIJbt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 05:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269388AbUIIJbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 05:31:49 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:28838 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S269379AbUIIJbs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 05:31:48 -0400
From: Duncan Sands <baldrick@free.fr>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] netpoll endian fixes
Date: Thu, 9 Sep 2004 11:31:46 +0200
User-Agent: KMail/1.6.2
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <200409080124.43530.baldrick@free.fr> <200409081201.28261.baldrick@free.fr> <20040908225334.GN31237@waste.org>
In-Reply-To: <20040908225334.GN31237@waste.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409091131.46574.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, could you send an updated patch with a Signed-off-by, please?

Here you are:

Correct wrong ip header in netpoll_send_udp.

Signed-off-by: Duncan Sands <baldrick@free.fr>

--- linux-2.5/net/core/netpoll.c.orig	2004-09-09 11:20:43.000000000 +0200
+++ linux-2.5/net/core/netpoll.c	2004-09-09 11:20:58.000000000 +0200
@@ -242,9 +242,9 @@
 	iph = (struct iphdr *)skb_push(skb, sizeof(*iph));
 
 	/* iph->version = 4; iph->ihl = 5; */
-	put_unaligned(0x54, (unsigned char *)iph);
+	put_unaligned(0x45, (unsigned char *)iph);
 	iph->tos      = 0;
-	put_unaligned(htonl(ip_len), &(iph->tot_len));
+	put_unaligned(htons(ip_len), &(iph->tot_len));
 	iph->id       = 0;
 	iph->frag_off = 0;
 	iph->ttl      = 64;
