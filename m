Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbTDCRxS 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261539AbTDCRxS 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:53:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:50839 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id S261525AbTDCRxH 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 12:53:07 -0500
Date: Thu, 3 Apr 2003 13:07:05 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: my linux does not accept redirects
In-Reply-To: <Pine.LNX.4.51.0304021727440.2739@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.53.0304031247330.5887@chaos>
References: <Pine.LNX.4.51.0304021657090.2465@dns.toxicfilms.tv>
 <Pine.LNX.4.53.0304021019210.30327@chaos> <Pine.LNX.4.51.0304021727440.2739@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003, Maciej Soltysiak wrote:

> > >
> > > What could be wrong?
> > >
> >
> > How would it learn? If everybody is going to set their default
> > route to your box A, and box A routes internally, then box A needs its
> > default route to go to the internet-box B.
> >From my investigation i have found that my box stores routes based on
> icmp redirects (as seen with netstat -C) and it does learn the routes
> but not for all routes. Please look at this printout:
>

No it doesn't! If your box "finds" routes then it has `routed` or
`gated` installed and running. Otherwise it uses static routes and
has no way of "learning" anything you didn't tell it.

> <snip>
> dns.toxicfilms. trek13.sv.av.co nihil.ae.poznan       0      0        4 eth1
> dns.toxicfilms. nms.cyf-kr.edu. alnair.ae.pozna       0      0        6 eth1
> <snip>
>
> dns.toxicfilms.tv is my box
>
> nihil.ae.poznan.pl is the router that routes to my other public nets
> alnair.ae.poznan.pl is the Internet Gateway.
>
> Why did not my box learn to send packets to trek13.sv.av.com via alnair ?
>

Because networking doesn't work that way. Packets are routed directly
to hosts if the host address fits inside the netmask. If the host
address is outside that network, packets are routed to the default
address which should be a host or other gatweay that connects with
the outside world.

If you have multiple isolated subnets, they work the same way.
However, the host that gets the default-route packets needs to
further route these packets both internally and externally.

> it's 2.4.20-xfs, no other patches.
> I am running a similar box on the same net with 2.5.66-mm2 and i do not
> see this effect, thus i presume, it's not a configuration error.
>

Then find out what's different. Probably the netmask on one is
different than on the other. It's the netmask that defines the
"width" of a network. Any address that fits inside that netmask
goes directly to a host on that network. Anything that falls
outside goes out the default route.

> Having one default route via Router A (nihil) should cause only one
> redirect per one connections. But i get flooded for every packet.
>

It will have NO, none, not any, redirects --ever. Redirects are an
attempt by a host to work around a severe problem. Communications
(datagram) packets are never redirected, only ICMP or ARP packets.
The ARP protocol finds the physical address, the IEEE station address
of a particular host and talks to it using that address. If the
IP address is behind a router, then the router answers the ARP request
with its physical address. Therefore, the host communicating with
an IP address behind a router ends up talking to the router.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

