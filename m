Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbSLJXV2>; Tue, 10 Dec 2002 18:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265647AbSLJXV1>; Tue, 10 Dec 2002 18:21:27 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:44555 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S265543AbSLJXVY>;
	Tue, 10 Dec 2002 18:21:24 -0500
Date: Wed, 11 Dec 2002 00:29:01 +0100
From: Willy TARREAU <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Roberto Nibali <ratz@drugphish.ch>, willy@w.ods.org,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: hidden interface (ARP) 2.4.20 / network performance
Message-ID: <20021210232901.GB172@pcw.home.local>
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil> <1039124530.18881.0.camel@rth.ninka.net> <20021205140349.A5998@ns1.theoesters.com> <3DEFD845.1000600@drugphish.ch> <20021205154822.A6762@ns1.theoesters.com> <3DF5C492.1070103@drugphish.ch> <20021210140912.7a9092b6.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021210140912.7a9092b6.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 02:09:12PM +0100, Stephan von Krawczynski wrote:
 
> Well, what I am trying to say is this: my experience is that under load with
> small sized packets even standard routing/packet forwarding becomes lossy.

This is more often dependant on hardware itself (NICs, chipsets). When your NIC
doesn't support scatter/gather, mitigated interrupts and other wonderful features,
and it receives 148600 pkts/second, it generates as many interrupts. Many chipsets
completely die under such a load. I can tell you that I wasn't proud of hanging my
Dual Athlon 1800+ with its 64/66 PCI slots and so from a single Celeron 800 on
100 Mbps copper !

> If I put NAT and other nice netfilter features on top of such a situation things
> get a lot worse (obviously) - no comparison to building the "application" (e.g.
> cluster) with routing and hidden-patch (mainly because of its pure simplicity I
> guess).

don't even need that to kill a system. Only a cheap NIC, a responding MAC address
and that's all. Of course routing make it worse and NAT even more. And BTW, when I
get 10 to 12 kHits/s with Tux on a 100 Mbps network, you'll notice that it only
happens on empty files. This is about 1 kB per hit, from a wire point of vue.
Count the ACKs, the data (tcp headers), and global overhead, and you're not far
from wire-speed on very small packets.

> Don't get me wrong: I am pretty content with the hidden-patch and my setup
> without NAT. But I wanted to point to the direction of possible further routing
> performance improvement in 2.4.X tree. Is it correct that I can expect higher
> data-rates (concerning small packets) if using higher HZ ?

don't know. perhaps forwarding packets between input and output involves queues
that are processed alternatively at HZ rate, but that seems strange to me.

> Someone selling E3 cards told me he cannot manage loads like these (small
> packet stuff) with a stock kernel, and that you _at least_ have to increase HZ
> to get acceptable throughput results.

E3 is only 45 Mbps (or I'm mistaken) ? Tweaking such parameters for such medium
rates doesn't seem the most appropriate to me. Perhaps his driver has some problems.

Cheers,
Willy

