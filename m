Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271711AbRICNs5>; Mon, 3 Sep 2001 09:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271712AbRICNsr>; Mon, 3 Sep 2001 09:48:47 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:12813 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S271711AbRICNs3>;
	Mon, 3 Sep 2001 09:48:29 -0400
Message-ID: <20010903175544.A1340@castle.nmd.msu.ru>
Date: Mon, 3 Sep 2001 17:55:44 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: "Nadav Har'El" <nyh@math.technion.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Transparent proxy support in 2.4 - revisited
In-Reply-To: <20010607170825.A18760@leeor.math.technion.ac.il> <20010608014443.A28407@saw.sw.com.sg> <20010903131240.A9791@leeor.math.technion.ac.il> <20010903144442.A32332@castle.nmd.msu.ru> <20010903161621.A14859@leeor.math.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010903161621.A14859@leeor.math.technion.ac.il>; from "Nadav Har'El" on Mon, Sep 03, 2001 at 04:16:21PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 03, 2001 at 04:16:21PM +0300, Nadav Har'El wrote:
> On Mon, Sep 03, 2001, Andrey Savochkin wrote about "Re: Transparent proxy support in 2.4 - revisited":
> > In 2.2 kernel you also needed to configure which incoming packets you want to
> > handle locally.
> 
> If I remember correctly, no such configuration was needed if the
> CONFIG_IP_TRANSPARENT_PROXY compilation flag was enabled. As I understand from
> a cursory examination of the 2.2 source, Whenever packets were received and
> were not meant for the local address, a check would be made if they meant for
> one of the transparent-proxied connections (i.e., connections whose local
> endpoint isn't local).

I don't remember for sure, but packet processing layering suggests that you
still needed to do something.  Otherwise the packet will be forwarded on the
routing level and will never reach socket layer.
So, ipchains rule was still necessary.
The really difference of 2.2 was amasingly complex socket lookup procedure
with CONFIG_IP_TRANSPARENT_PROXY turned on.

> This is the kind of thing I need in Linux 2.4 too.
> I'm still puzzled by the fact that this support simply disappeared between
> 2.2 and 2.4, and nobody seems to know why (or people who know why don't
> reply).

It had been broken in 2.2 for months and nobody repaired it => nobody needed
it.  I don't know, whether it works now or not.
The implementation was crooked, difficult to understand and maintain...

> > If you want to handle locally all packets destined to a specific IP address,
> > just add local route.
> > If you want some complex matching rules, check iptables, there was something
> > about "redirects" there.
> 
> Remember that the reverse proxy machine, the one faking connections with an
> adjacent server (as if they are coming from the actual clients) also serves
> as the the gateway for that server and needs to forward packets for it.

How are you going to determine whether the packet is destined to you or two
the real server?
That's the main question.

> So I can't redirect *all* packets to local sockets, yet I also can't pick
> specific IP addresses to redirect (unless I write some sort of hack to
> modify the iptables tables dynamically as new non-local bind()s happen).
> Not to mention that the standard redirect, which also rewrites the destination
> address on the packet (if I remember correctly), isn't quite what I need when

If it's true, the redirecting module is the place to change the policy to what
you need.
If the module always rewrites the destination IP address, and it can't be
turned off, it's certainly a misfeature.
Make it conditional, or just make a quick hack for yourself, or copy the
existing redirect module, fix it and use the new module.

> I already have a socket bound to a non-local address.

Best regards
		Andrey
