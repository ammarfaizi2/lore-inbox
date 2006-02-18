Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWBRQEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWBRQEb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWBRQEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:04:30 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:30224 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751461AbWBRQE3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:04:29 -0500
Date: Sat, 18 Feb 2006 17:04:48 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick McHardy <kaber@trash.net>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: Linux 2.6.16-rc4
Message-Id: <20060218170448.5e05f0a7.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, all,

Fix the following warning introduced by commit
ee68cea2c26b7a8222f9020f54d22c6067011e8b when !CONFIG_XFRM:

net/ipv4/netfilter/ip_nat_standalone.c: In function `ip_nat_out':
net/ipv4/netfilter/ip_nat_standalone.c:229: warning: unused variable `ctinfo'
net/ipv4/netfilter/ip_nat_standalone.c:228: warning: unused variable `ct'

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Patrick McHardy <kaber@trash.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
---
 net/ipv4/netfilter/ip_nat_standalone.c |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2.6.16-rc4.orig/net/ipv4/netfilter/ip_nat_standalone.c	2006-02-18 16:47:22.000000000 +0100
+++ linux-2.6.16-rc4/net/ipv4/netfilter/ip_nat_standalone.c	2006-02-18 16:47:40.000000000 +0100
@@ -225,8 +225,10 @@
 	   const struct net_device *out,
 	   int (*okfn)(struct sk_buff *))
 {
+#ifdef CONFIG_XFRM
 	struct ip_conntrack *ct;
 	enum ip_conntrack_info ctinfo;
+#endif
 	unsigned int ret;
 
 	/* root is playing with raw sockets. */

-- 
Jean Delvare
