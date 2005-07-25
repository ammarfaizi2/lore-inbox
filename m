Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVGYX4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVGYX4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 19:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVGYX4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 19:56:43 -0400
Received: from postel.suug.ch ([195.134.158.23]:20104 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S261482AbVGYX4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 19:56:05 -0400
Date: Tue, 26 Jul 2005 01:56:26 +0200
From: Thomas Graf <tgraf@suug.ch>
To: Patrick McHardy <kaber@trash.net>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Andrew Morton <akpm@osdl.org>,
       Harald Welte <laforge@netfilter.org>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: Netlink connector
Message-ID: <20050725235626.GX10481@postel.suug.ch>
References: <20050723125427.GA11177@rama> <20050723091455.GA12015@2ka.mipt.ru> <20050724.191756.105797967.davem@davemloft.net> <Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com> <20050725070603.GA28023@2ka.mipt.ru> <42E4F800.1010908@trash.net> <20050725192853.GA30567@2ka.mipt.ru> <42E579BC.8000701@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E579BC.8000701@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Patrick McHardy <42E579BC.8000701@trash.net> 2005-07-26 01:46
> Netlink users don't have to care about shared or cloned skbs. I don't
> think its a big issue to use alloc_skb and then the usual netlink
> macros. Thomas added a number of macros that simplfiy use a lot.

Once I've finished the generic netlink attribute macros the
usage will be even simpler. I wrote down all the things I want
to do today in a park and I intend to write the code once I'm
back from my vacation.

> But my main objection is that it sends everything to userspace even
> if noone is listening. This can't be used for things that generate
> lots of events, and also will get problematic is the number of users
> increases.

My patches will include a new function netlink_nr_subscribers()
taking the socket and a mask of groups. I posted something
simliar during an earlier connector discussion already.

> You still have to take care of mixed 64/32 bit environments, u64 fields
> for example are differently alligned.

My solution to this (in the same patchset) is that we never
derference u64s but instead copy them.

> Then fix it so we can use more families and groups. I started some work
> on this, but I'm not sure if I have time to complete it.

Great, this is one of the remaining issues I haven't solved yet.
If you want me to take over just hand over your unfinished work
and I'll integrate it into my patchset.

I'm sorry to not being able to provide any code yet, it's
one of the first things I'll do once I'm back.
