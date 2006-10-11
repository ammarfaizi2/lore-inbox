Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161394AbWJKVeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161394AbWJKVeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161390AbWJKVeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:34:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55761 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161513AbWJKVdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:33:44 -0400
Date: Wed, 11 Oct 2006 14:29:57 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Steven Whitehouse <steve@chygwyn.com>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
Message-ID: <20061011142957.5bd42784@freekitty>
In-Reply-To: <20061011212339.GH15468@mellanox.co.il>
References: <20061011135720.303f166b@freekitty>
	<20061011212339.GH15468@mellanox.co.il>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O
> > 
> > You might want to try ignoring the check in dev.c and testing
> > to see if there is a performance gain.  It wouldn't be hard to test
> > a modified version and validate the performance change.
> 
> Yes. With my patch, there is a huge performance gain by increasing MTU to 64K.
> And it seems the only way to do this is by S/G.
> 
> > You could even do what I suggested and use skb_checksum_help()
> > to do inplace checksumming, as a performance test.
> 
> I can. But as network algorithmics says (chapter 5)
> "Since such bus reads are expensive, the CPU might as well piggyback
> the checksum computation with the copy process".
> 
> It speaks about onboard the adapter buffers, but memory bus reads are also much slower
> than CPU nowdays.  So I think even if this works well in benchmark in real life
> single copy should better.
> 

The other alternative might be to make copy/checksum code smarter about using
fragments rather than allocating a large buffer. It should avoid second order
allocations (effective size > PAGESIZE).

-- 
Stephen Hemminger <shemminger@osdl.org>
