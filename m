Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWCTJzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWCTJzL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 04:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWCTJzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 04:55:11 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49844
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750992AbWCTJzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 04:55:10 -0500
Date: Mon, 20 Mar 2006 01:55:00 -0800 (PST)
Message-Id: <20060320.015500.72136710.davem@davemloft.net>
To: mst@mellanox.co.il
Cc: rick.jones2@hp.com, netdev@vger.kernel.org, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: TSO and IPoIB performance degradation
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060320090629.GA11352@mellanox.co.il>
References: <4410C671.2050300@hp.com>
	<20060309.232301.77550306.davem@davemloft.net>
	<20060320090629.GA11352@mellanox.co.il>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Date: Mon, 20 Mar 2006 11:06:29 +0200

> Is it the case then that this requirement is less essential on
> networks such as IP over InfiniBand, which are very low latency
> and essencially lossless (with explicit congestion contifications
> in hardware)?

You can never assume any attribute of the network whatsoever.
Even if initially the outgoing device is IPoIB, something in
the middle, like a traffic classification or netfilter rule,
could rewrite the packet and make it go somewhere else.

This even applies to loopback packets, because packets can
get rewritten and redirected even once they are passed in
via netif_receive_skb().

> And as Matt Leininger's research appears to show, stretch ACKs
> are good for performance in case of IP over InfiniBand.
>
> Given all this, would it make sense to add a per-netdevice (or per-neighbour)
> flag to re-enable the trick for these net devices (as was done before
> 314324121f9b94b2ca657a494cf2b9cb0e4a28cc)?
> IP over InfiniBand driver would then simply set this flag.

See above, this is not feasible.

The path an SKB can take is opaque and unknown until the very last
moment it is actually given to the device transmit function.

People need to get the "special case this topology" ideas out of their
heads. :-)

