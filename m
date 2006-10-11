Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161364AbWJKUxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161364AbWJKUxB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161363AbWJKUxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:53:00 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:64898 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1161364AbWJKUw7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:52:59 -0400
Date: Wed, 11 Oct 2006 22:52:14 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Steven Whitehouse <steve@chygwyn.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, David Miller <davem@davemloft.net>,
       shemminger@osdl.org
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
Message-ID: <20061011205214.GC15468@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061011090926.GA15393@fogou.chygwyn.com> <20061011150103.GF4888@mellanox.co.il> <20061011201138.GA21657@fogou.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011201138.GA21657@fogou.chygwyn.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Steven Whitehouse <steve@chygwyn.com>:
> Subject: Re: Dropping NETIF_F_SG since no checksum feature.
> 
> Hi,
> 
> On Wed, Oct 11, 2006 at 05:01:03PM +0200, Michael S. Tsirkin wrote:
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
> >
> 
> In so far as I'm able to ack it, then yes, but with the following
> caveats: that you also need to look at the tcp code's checks for
> NETIF_F_SG (aside from the interface to tcp_sendpage which I think
> we've agreed is ok) and ensure that this patch will not change their
> behaviour, and here I'm thinking of the test in net/ipv4/tcp.c:select_size()
> in particular - there may be others but thats the only one I can think
> of off the top of my head. I think this is what davem was getting at
> with his comment about copy & sum for smaller packets.

Will do - thanks for the tips.

> Also all subject to approval by davem and shemminger of course :-)

Goes without saying :)

> My general feeling is that devices should advertise the features that
> they actually have and that the protocols should make the decision
> as to which ones to use or not depending on the combinations available
> (which I think is pretty much your argument).
> 
> Steve.

-- 
MST
