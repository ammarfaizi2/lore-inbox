Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271693AbRICNQ3>; Mon, 3 Sep 2001 09:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271692AbRICNQU>; Mon, 3 Sep 2001 09:16:20 -0400
Received: from leeor.math.technion.ac.il ([132.68.115.2]:26537 "EHLO
	leeor.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S271693AbRICNQK>; Mon, 3 Sep 2001 09:16:10 -0400
Date: Mon, 3 Sep 2001 16:16:21 +0300
From: "Nadav Har'El" <nyh@math.technion.ac.il>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Transparent proxy support in 2.4 - revisited
Message-ID: <20010903161621.A14859@leeor.math.technion.ac.il>
In-Reply-To: <20010607170825.A18760@leeor.math.technion.ac.il> <20010608014443.A28407@saw.sw.com.sg> <20010903131240.A9791@leeor.math.technion.ac.il> <20010903144442.A32332@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010903144442.A32332@castle.nmd.msu.ru>; from saw@saw.sw.com.sg on Mon, Sep 03, 2001 at 02:44:42PM +0400
Hebrew-Date: 15 Elul 5761
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001, Andrey Savochkin wrote about "Re: Transparent proxy support in 2.4 - revisited":
> > Unfortunately, that's not enough. When the return SYN-ACK packet carrying a
> > non-local destination address is received (in practice, the transparent
> > proxy machine is acting as a default gateway to the other machine), this
> > packet is either ignored or forwarded out (depending on ip_forward), but is
> > never accepted as a local packet and transfered to the appropriate socket
> > as it should.
> 
> Right.
> In 2.2 kernel you also needed to configure which incoming packets you want to
> handle locally.

If I remember correctly, no such configuration was needed if the
CONFIG_IP_TRANSPARENT_PROXY compilation flag was enabled. As I understand from
a cursory examination of the 2.2 source, Whenever packets were received and
were not meant for the local address, a check would be made if they meant for
one of the transparent-proxied connections (i.e., connections whose local
endpoint isn't local).

This is the kind of thing I need in Linux 2.4 too.
I'm still puzzled by the fact that this support simply disappeared between
2.2 and 2.4, and nobody seems to know why (or people who know why don't
reply).

> If you want to handle locally all packets destined to a specific IP address,
> just add local route.
> If you want some complex matching rules, check iptables, there was something
> about "redirects" there.

Remember that the reverse proxy machine, the one faking connections with an
adjacent server (as if they are coming from the actual clients) also serves
as the the gateway for that server and needs to forward packets for it.
So I can't redirect *all* packets to local sockets, yet I also can't pick
specific IP addresses to redirect (unless I write some sort of hack to
modify the iptables tables dynamically as new non-local bind()s happen).
Not to mention that the standard redirect, which also rewrites the destination
address on the packet (if I remember correctly), isn't quite what I need when
I already have a socket bound to a non-local address.


> You seemed to start to solve your problems from the wrong end.
> First of all, decide how to handle incoming packets.
> Then consider outgoing.

You're right. But I started at the easier end :)



-- 
Nadav Har'El                        |        Monday, Sep  3 2001, 15 Elul 5761
nyh@math.technion.ac.il             |-----------------------------------------
Phone: +972-53-245868, ICQ 13349191 |I'm a peripheral visionary: I see into
http://nadav.harel.org.il           |the future, but mostly off to the sides.
