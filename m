Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSLJOlW>; Tue, 10 Dec 2002 09:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbSLJOlW>; Tue, 10 Dec 2002 09:41:22 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:14097 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261855AbSLJOlU>; Tue, 10 Dec 2002 09:41:20 -0500
Date: Tue, 10 Dec 2002 09:47:31 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Roberto Nibali <ratz@drugphish.ch>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: hidden interface (ARP) 2.4.20
In-Reply-To: <3DF5C4B5.3030205@drugphish.ch>
Message-ID: <Pine.LNX.3.96.1021210093408.12210B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2002, Roberto Nibali wrote:

> Maybe I should first note that I am not against the hidden patch at all, 
> I just accepted that it won't go in. I use it on an almost daily basis.
> 
> > In spite of vast resistance from some developers, it is highly desirable
> > on some systems to force a packet with a given source IP out an interface
> > which has that IP assigned. With this capability it is possible to make a
> 
> Yes, source address selection based on different rules and routing 
> tables. What does it have to do with the hidden patch?

  I see it as an alternative solution to the problem the hidden patch is
addressing. Perhaps a more general one, although the method of causing
such routing might not be source routing in the "ip" sense.

> > usual proxy_arp fix doesn't really address these cases. If I have multiple
> > default routes, the router on which the packet arrived is likely to be on
> > the route with the fewest hops, randomly using another route doesn't help.
> 
> ??? Depends how you use those multiple default routes. If you do nexthop 
> routing you do sort of RR balancing on preferred routes. If you do 
> source address selection routing based on rules you have fixed default 
> routes which will not match because of the fewest hops but because of 
> the rule. I am a bit confused as to what you're trying to tell me.

I have in mid multiple ISPs for redundancy, perhaps a pair of OC12s or
similar. Sites would be reachable from either, but fewer hops to one or
the other. When the client connects, it avoids asymmetric routing to reply
on the same router.

> > Source routing takes too much overhead for lots of connections, and as I
> 
> Either we have a different view of source routing or I have to ask you 
> why you think there is too much overhead with source routing.

More rules, more overhead, having to set up a rule per IP (which can be
dynamic) takes overhead.

> > recall is limited to 256 rules. I'm not sure the hidden interface patch
> > really does this, although I just looked quickly.
> 
> The hidden patch doesn't do source routing and the limit of available 
> source routes is 254 but not because of the rules (you can have 2**16 
> rule entries) but because of the amount of routing tables which is 256 
> [0..255] minus local table minus main table which equals to 254 tables.

I actually meant that the patch didn't do this in another way, but you
have noted that the number of routing tables is limited. That may or may
not be a limitation depending on complexity. In any case a single
use-configured-interface patch avoids having tables.

> > Patches like the hidden interface will continue as long as there are
> > useful things people want to do with Linux and can't. It's one of many in
> 
> Yes, that's the nice thing about patches, isn't it :).
> 
> > the networking area. I don't expect them to be adopted in the main kernel,
> > but as long as they're easier than making multiple configs, particularly
> > at runtime, they will be around.
> 
> Yes, definitely. And I think noone has said anything against that.

I thought this thread had a "please don't post patches like that we don't
want it in the kernel" early on in the thread, but I've expired the
message and lack time to dig archives.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

