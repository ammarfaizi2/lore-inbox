Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTECT3X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 15:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTECT3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 15:29:22 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:9221 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263407AbTECT3U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 15:29:20 -0400
Date: Sat, 3 May 2003 20:39:08 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DECNET in latest BK
Message-ID: <20030503203908.A5915@electric-eye.fr.zoreil.com>
References: <20030503175913.GA13595@work.bitmover.com> <1051987091.14504.9.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1051987091.14504.9.camel@rth.ninka.net>; from davem@redhat.com on Sat, May 03, 2003 at 11:38:11AM -0700
X-Organisation: Hungry patch-scripts (c) users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@redhat.com> :
[...]
> Turn off CONFIG_DECNET_ROUTE_FWMARK, aparently even the maintainer
> doesn't even enable this option :-)

Does the attached patch make sense ?

 net/decnet/dn_route.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN net/decnet/dn_route.c~decnet-compile-fix net/decnet/dn_route.c
--- linux-2.5.68-1.1118.1.6-to-1.1192/net/decnet/dn_route.c~decnet-compile-fix	Fri May  2 23:19:48 2003
+++ linux-2.5.68-1.1118.1.6-to-1.1192-fr/net/decnet/dn_route.c	Fri May  2 23:19:48 2003
@@ -1055,7 +1055,7 @@ make_route:
 	rt->fl.oif        = oldflp->oif;
 	rt->fl.iif        = 0;
 #ifdef CONFIG_DECNET_ROUTE_FWMARK
-	rt->fl.fld_fwmark = flp->fld_fwmark;
+	rt->fl.fld_fwmark = oldflp->fld_fwmark;
 #endif
 
 	rt->rt_saddr      = fl.fld_src;
@@ -1180,7 +1180,7 @@ static int dn_route_input_slow(struct sk
 				       .saddr = cb->src,
 				       .scope = RT_SCOPE_UNIVERSE,
 #ifdef CONFIG_DECNET_ROUTE_FWMARK
-				       .fwmark = skb->fwmark
+				       .fwmark = skb->nfmark
 #endif
 				    } },
 			    .iif = skb->dev->ifindex };

