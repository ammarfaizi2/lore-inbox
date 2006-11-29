Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758789AbWK2Eom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758789AbWK2Eom (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 23:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758791AbWK2Eom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 23:44:42 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:56463
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1758789AbWK2Eol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 23:44:41 -0500
Date: Tue, 28 Nov 2006 20:44:40 -0800 (PST)
Message-Id: <20061128.204440.39160464.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: kaber@trash.net, khc@pm.waw.pl, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: Broken commit: [NETFILTER]: ipt_REJECT: remove largely
 duplicate route_reverse function
From: David Miller <davem@davemloft.net>
In-Reply-To: <E1GpHDJ-00059y-00@gondolin.me.apana.org.au>
References: <20061128.202535.112619392.davem@davemloft.net>
	<E1GpHDJ-00059y-00@gondolin.me.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 29 Nov 2006 15:38:29 +1100

> David Miller <davem@davemloft.net> wrote:
> > 
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 9264139..95e86ac 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -94,7 +94,9 @@ #endif
> > #endif
> > 
> > #if !defined(CONFIG_NET_IPIP) && \
> > -    !defined(CONFIG_IPV6) && !defined(CONFIG_IPV6_MODULE)
> > +    !defined(CONFIG_NET_IPGRE) && \
> > +    !defined(CONFIG_IPV6_SIT) && \
> > +    !defined(CONFIG_IPV6_TUNNEL)
> > #define MAX_HEADER LL_MAX_HEADER
> > #else
> > #define MAX_HEADER (LL_MAX_HEADER + 48)
> 
> What if ipip/gre are modules?

Good catch, I'll fix that up by adding the missing CONFIG_*_MODULE
cases.

Longer term this is really messy, we should handle this some
other way.
