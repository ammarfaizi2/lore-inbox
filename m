Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422640AbWJKVnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422640AbWJKVnU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422641AbWJKVnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:43:19 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:7555 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1422640AbWJKVnS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:43:18 -0400
Date: Wed, 11 Oct 2006 23:42:37 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Steven Whitehouse <steve@chygwyn.com>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
Message-ID: <20061011214237.GK15468@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061011142957.5bd42784@freekitty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011142957.5bd42784@freekitty>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Stephen Hemminger <shemminger@osdl.org>:
> Subject: Re: Dropping NETIF_F_SG since no checksum feature.
> 
> O
> > > 
> > > You might want to try ignoring the check in dev.c and testing
> > > to see if there is a performance gain.  It wouldn't be hard to test
> > > a modified version and validate the performance change.
> > 
> > Yes. With my patch, there is a huge performance gain by increasing MTU to 64K.
> > And it seems the only way to do this is by S/G.
> > 
> > > You could even do what I suggested and use skb_checksum_help()
> > > to do inplace checksumming, as a performance test.
> > 
> > I can. But as network algorithmics says (chapter 5)
> > "Since such bus reads are expensive, the CPU might as well piggyback
> > the checksum computation with the copy process".
> > 
> > It speaks about onboard the adapter buffers, but memory bus reads are also much slower
> > than CPU nowdays.  So I think even if this works well in benchmark in real life
> > single copy should better.
> > 
> 
> The other alternative might be to make copy/checksum code smarter about using
> fragments rather than allocating a large buffer. It should avoid second order
> allocations (effective size > PAGESIZE).
 
In my testing, it seems quite smart already - once I declare F_SG and clear F_...CSUM
I start getting properly checksummed packets with lots of s/g fragments.
But I'm not catching the drift - an alternative to what this would be?

-- 
MST
