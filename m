Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161465AbWJKVMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161465AbWJKVMr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161452AbWJKVMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:12:45 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:2179 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1161459AbWJKVMh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:12:37 -0400
Date: Wed, 11 Oct 2006 23:11:53 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: David Miller <davem@davemloft.net>
Cc: steve@chygwyn.com, shemminger@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
Message-ID: <20061011211153.GE15468@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061011.135201.15405152.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011.135201.15405152.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. David Miller <davem@davemloft.net>:
> Subject: Re: Dropping NETIF_F_SG since no checksum feature.
> 
> From: "Michael S. Tsirkin" <mst@mellanox.co.il>
> Date: Wed, 11 Oct 2006 17:01:03 +0200
> 
> > Quoting Steven Whitehouse <steve@chygwyn.com>:
> > > > ssize_t tcp_sendpage(struct socket *sock, struct page *page, int offset,
> > > >                      size_t size, int flags)
> > > > {
> > > >         ssize_t res;
> > > >         struct sock *sk = sock->sk;
> > > > 
> > > >         if (!(sk->sk_route_caps & NETIF_F_SG) ||
> > > >             !(sk->sk_route_caps & NETIF_F_ALL_CSUM))
> > > >                 return sock_no_sendpage(sock, page, offset, size, flags);
> > > > 
> > > > 
> > > > So, it seems that if I set NETIF_F_SG but clear NETIF_F_ALL_CSUM,
> > > > data will be copied over rather than sent directly.
> > > > So why does dev.c have to force set NETIF_F_SG to off then?
> > > >
> > > I agree with that analysis,
> > 
> > So, would you Ack something like the following then?
> 
> I certainly don't.
> 

Dave, sorry, you lost me.
Would a new flag NETIF_F_SW_CSUM be better, to tell network core that device
computes checksums in software, so we should piggyback the checksum
computation with the copy process if possible?

Or is there some other issue?

-- 
MST
