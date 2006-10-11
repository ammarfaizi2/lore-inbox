Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161347AbWJKUv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161347AbWJKUv7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161348AbWJKUv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:51:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60852
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161339AbWJKUv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:51:57 -0400
Date: Wed, 11 Oct 2006 13:52:01 -0700 (PDT)
Message-Id: <20061011.135201.15405152.davem@davemloft.net>
To: mst@mellanox.co.il
Cc: steve@chygwyn.com, shemminger@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061011150103.GF4888@mellanox.co.il>
References: <20061011090926.GA15393@fogou.chygwyn.com>
	<20061011150103.GF4888@mellanox.co.il>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Date: Wed, 11 Oct 2006 17:01:03 +0200

> Quoting Steven Whitehouse <steve@chygwyn.com>:
> > > ssize_t tcp_sendpage(struct socket *sock, struct page *page, int offset,
> > >                      size_t size, int flags)
> > > {
> > >         ssize_t res;
> > >         struct sock *sk = sock->sk;
> > > 
> > >         if (!(sk->sk_route_caps & NETIF_F_SG) ||
> > >             !(sk->sk_route_caps & NETIF_F_ALL_CSUM))
> > >                 return sock_no_sendpage(sock, page, offset, size, flags);
> > > 
> > > 
> > > So, it seems that if I set NETIF_F_SG but clear NETIF_F_ALL_CSUM,
> > > data will be copied over rather than sent directly.
> > > So why does dev.c have to force set NETIF_F_SG to off then?
> > >
> > I agree with that analysis,
> 
> So, would you Ack something like the following then?

I certainly don't.
