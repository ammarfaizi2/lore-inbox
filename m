Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264976AbRGSSSQ>; Thu, 19 Jul 2001 14:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbRGSSSG>; Thu, 19 Jul 2001 14:18:06 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:9234 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S264663AbRGSSR5>;
	Thu, 19 Jul 2001 14:17:57 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107191817.WAA32355@ms2.inr.ac.ru>
Subject: Re: [PATCH] PPPOE can kfree SKB twice (was Re: kernel panic problem. (smp, iptables?))
To: mostrows@speakeasy.net
Date: Thu, 19 Jul 2001 22:17:52 +0400 (MSK DST)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com
In-Reply-To: <sb666cohk89.fsf@slug.watson.ibm.com> from "Michal Ostrowski" at Jul 19, 1 02:00:54 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> However, could we not have dev_queue_xmit behave as such (not free
> frame on failure)?  

If you need to hold original skb, you may hold its refcnt.

However, this feature inevitably results in big troubles: dev_queue_xmit()
is allowed to change skb and you cannot assume anything about this.
So that resuing skb dev_queue_xmit() is fatal bug not depending on anything.


> The reason why I'm proposing this is that ppp_generic.c assumes that
> the skb is still available after a transmission failure via pppoe.  To
> support the semantics of dev_queue_xmit and ppp_generic we would have
> to always copy skb's inside pppoe_xmit.  Then, if dev_queue_xmit fails
> the original is deleted.

You need not copy it. I said "clone".

Nobody is allowed to touch _data_ part of skb, so that you need not
to copy data.

Alexey
