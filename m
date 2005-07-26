Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVGZA3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVGZA3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 20:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVGZA3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 20:29:52 -0400
Received: from postel.suug.ch ([195.134.158.23]:44168 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S261580AbVGZA3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 20:29:46 -0400
Date: Tue, 26 Jul 2005 02:30:06 +0200
From: Thomas Graf <tgraf@suug.ch>
To: Patrick McHardy <kaber@trash.net>
Cc: Jamal Hadi Salim <hadi@cyberus.ca>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Andrew Morton <akpm@osdl.org>, Harald Welte <laforge@netfilter.org>,
       netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: Netlink connector
Message-ID: <20050726003006.GY10481@postel.suug.ch>
References: <20050723125427.GA11177@rama> <20050723091455.GA12015@2ka.mipt.ru> <20050724.191756.105797967.davem@davemloft.net> <Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com> <20050725070603.GA28023@2ka.mipt.ru> <42E4F800.1010908@trash.net> <20050725192853.GA30567@2ka.mipt.ru> <42E579BC.8000701@trash.net> <20050725235626.GX10481@postel.suug.ch> <42E580CF.4010800@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E580CF.4010800@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Patrick McHardy <42E580CF.4010800@trash.net> 2005-07-26 02:16
> Thomas Graf wrote:
> >* Patrick McHardy <42E579BC.8000701@trash.net> 2005-07-26 01:46
> >
> >>You still have to take care of mixed 64/32 bit environments, u64 fields
> >>for example are differently alligned.
> >
> >My solution to this (in the same patchset) is that we never
> >derference u64s but instead copy them.
> 
> I don't understand. The problem is mainly u64 embedded in structures,
> the structs have different sizes if the u64 is not 8 byte aligned
> and the structure size padded to a multiple of 8.

Like in gnet_stats, yes. I thought you meant usages like *(u64 *)
which we shouldn't do either.

> I started working on it after the OLS party, so no postable code yet :)
> The idea for more groups is basically to remove the fixed groups
> bitmask from struct sockaddr_nl and use setsockopt to add/remove
> multicast subscriptions. If we add the limitation that a packet
> can only be multicasted to a single group we can support an arbitary
> number of groups, otherwise we would still be limited by size of
> skb->cb.

I was thinking of subscription messages over netlink itself for
the advantage that we could use it within the distributed netlink
protocol that has to come up sometime soon. Well, both ways
are ok I guess, the ease of distributive usage is my only argument.

> This limitation shouldn't be a problem, AFAIK nothing is
> multicasting to multiple groups at once right now and the increased
> number of groups will allow a better granularity anyway.

I'm not aware of any and I agree. We don't need n<->n subscriptions,
1<->n is perfectly fine as I see it.

> The main
> problem is keeping it backwards-compatible for current netlink users.
> If this isn't possible we may need to call it netlink2.

I think Jamal has a moral patent on the name netlink2 so be careful ;->
It should be possible to remain compatible, I don't see any
unresolveable issues right now.
