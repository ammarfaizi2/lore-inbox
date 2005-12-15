Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbVLOHhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbVLOHhn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 02:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbVLOHhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 02:37:43 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:25491 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965163AbVLOHhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 02:37:42 -0500
Date: Wed, 14 Dec 2005 23:37:37 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@w-sridhar.beaverton.ibm.com
To: "David S. Miller" <davem@davemloft.net>
cc: mpm@selenic.com, sri@us.ibm.com, ak@suse.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
In-Reply-To: <20051214.203023.129054759.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0512142318410.7197@w-sridhar.beaverton.ibm.com>
References: <20051214092228.GC18862@brahms.suse.de>
 <1134582945.8698.17.camel@w-sridhar2.beaverton.ibm.com> <20051215033937.GC11856@waste.org>
 <20051214.203023.129054759.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2005, David S. Miller wrote:

> From: Matt Mackall <mpm@selenic.com>
> Date: Wed, 14 Dec 2005 19:39:37 -0800
>
> > I think we need a global receive pool and per-socket send pools.
>
> Mind telling everyone how you plan to make use of the global receive
> pool when the allocation happens in the device driver and we have no
> idea which socket the packet is destined for?  What should be done for
> non-local packets being routed?  The device drivers allocate packets
> for the entire system, long before we know who the eventually received
> packets are for.  It is fully anonymous memory, and it's easy to
> design cases where the whole pool can be eaten up by non-local
> forwarded packets.
>
> I truly dislike these patches being discussed because they are a
> complete hack, and admittedly don't even solve the problem fully.  I
> don't have any concrete better ideas but that doesn't mean this stuff
> should go into the tree.
>
> I think GFP_ATOMIC memory pools are more powerful than they are given
> credit for.  There is nothing preventing the implementation of dynamic
> GFP_ATOMIC watermarks, and having "critical" socket behavior "kick in"
> in response to hitting those water marks.

Does this mean that you are OK with having a mechanism to mark the
sockets as critical and dropping the non critical packets under
emergency, but you do not like having a separate critical page pool.

Instead, you seem to be suggesting in_emergency to be set dynamically
when we are about to run out of ATOMIC memory. Is this right?

Thanks
Sridhar
