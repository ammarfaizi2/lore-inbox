Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135413AbRDRWGT>; Wed, 18 Apr 2001 18:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135403AbRDRWF7>; Wed, 18 Apr 2001 18:05:59 -0400
Received: from netsonic.fi ([194.29.192.20]:62472 "EHLO nalle.netsonic.fi")
	by vger.kernel.org with ESMTP id <S135399AbRDRWD2>;
	Wed, 18 Apr 2001 18:03:28 -0400
Date: Thu, 19 Apr 2001 01:02:49 +0300 (EEST)
From: Sampsa Ranta <sampsa@netsonic.fi>
To: Julian Anastasov <ja@ssi.bg>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ARP responses broken!
In-Reply-To: <Pine.LNX.4.30.0104180023130.7698-100000@u.domain.uli>
Message-ID: <Pine.LNX.4.33.0104190039460.27239-100000@nalle.netsonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2001, Julian Anastasov wrote:

>
> 	Hello,
>
> Sampsa Ranta wrote:
>
> > 23:38:25.278848 > arp who-has 194.29.192.38 tell 194.29.192.10 (0:50:da:82:ae:9f)
> > 23:38:25.278988 < arp reply 194.29.192.38 is-at 0:1:2:dc:d2:64 (0:50:da:82:ae:9f)
> > 23:38:25.279009 < arp reply 194.29.192.38 is-at 0:1:2:dc:d2:6c (0:50:da:82:ae:9f)
> >
> > The second one is the valid one, but both interfaces seem to answer to the
> > broadcasted packet with their own ARP addresses.
>
> 	arp_filter is not broken, it is simply not for your setup.
> It depends what you want to achieve by defining two IP addresses in
> different interfaces. Considering the fact you have two addresses
> in one subnet you need the incoming traffic to come from the two
> interfaces. In this case you need "hidden". For the outgoing traffic:
> it is controlled only from the routing.
>
> 	While in your setup arp_filter and rp_filter will ARP answer
> from one card only, for the both addresses, hidden will answer from the
> both cards, "correctly" in your eyes. Use arp_filter for different
> nets only, i.e. when the ARP probes come from different nets in your
> routing universe. hidden does not depend on nets/subnets. But may
> be there are exceptions I'm missing and the other guys can correct me.

Yes, I wan't that other routers only see the MAC address of the interface
I assigned the IP address for if someone asks it by ARP. I also control
outgoing traffic with routing. But how am I supposed to do this in 2.4
enviroment?

I also would want outgoing traffic to work from either of the interfaces,
not depending from which the incoming traffic did come, so outgoing ARP
requests would have the MAC address and IP address of the interface they
were asked from. For filtering IP traffic, the iptables is good enough so
I can filter just as I want, I don't need filtering to happen by routing
table at the moment.

Yeah, and I am aware that routing protocols won't make this very much
easier but OSPF for example communicates only via one interface per subnet
at a time so I can use the other for my static configuration. Zebra
also wants the packets to come from the interface it expects them to, and
that is the one it is assigned.

This is what my patch was supposed to deal with, but there was something
missing from it, right?

As far as I consider routing, the routers only determinate next-hop,
routing thinks the next-hop is IP. But actually the IP number given to
routing is nothing more than a key that is passed to ARP layer to
determinate the layer 2 address. And when I don't want to make stupid
subnets when I actually can work under one network, I would like to be
able to "mark" interface by giving it IP and when I point something to
that specific IP from other host, I would like to have the traffic to be
go via that interface. If I wanted it to go via two interfaces, I would
need to deal with load balancing issues on both ends, randomly taken
interface from ARP layer is nothing I call load balancing, and the
interface could even be the same to all.

Yeah, I could do this by defining ARP addresses by hand but I would rather
not do that because there are two many routers involved.

Btw. Kernel sets up two routes to the subnet, which one is selected and
     should the other one be deleted?

Thanks,
   Sampsa Ranta
   sampsa@netsonic.fi

