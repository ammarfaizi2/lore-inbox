Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270359AbTG2C7U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 22:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270322AbTG2C7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 22:59:20 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52998 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S270228AbTG2C7Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 22:59:16 -0400
Date: Mon, 28 Jul 2003 22:51:00 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "David S. Miller" <davem@redhat.com>
cc: Carlos Velasco <carlosev@newipnet.com>, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
In-Reply-To: <20030727164649.517b2b88.davem@redhat.com>
Message-ID: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003, David S. Miller wrote:

> On Mon, 28 Jul 2003 01:40:47 +0200
> "Carlos Velasco" <carlosev@newipnet.com> wrote:
> 
> > I stepped into the same problems you have reported here.
> 
> No, your problem was completely different.
> 
> > There's a feature to do linux to behave like other OS and systems, called "hidden".
> 
> WRONG!  People please stop this misinformation already.
> 
> Bas's problem can be solved by him giving a "preferred source"
> to each of his IPV4 routes and setting the "arpfilter" sysctl
> variable for his devices to "1".

You say this with total disregard for the fact that in actual practice it
only works for static routes. If you get a new connection it does not by
magic make an entry in the route table to go back out of the NIC with the
matching source IP, doing a "solution" with routing needs a route for
every destination (host or CIDR block).

Doing a "solution" with source routing works if you have a small number of
source IPs. However the number of routes is limited (252??) and again the
convenience factor of having the right information added with the route
addition is "do it by hand or write your own software."

> 
> This particular case has been discussed to death in the past
> and I really recommend people read up there before dragging this
> out further.

It will keep coming back because it's a real problem. I do agree that the
hidden patch is not the desired way to solve the problem, but until there
is a reasonable (not requiring a guru or large manual effort) solution
people will keep bringing it up.

You have stated that this is required by some RFC. I can see that the RFC
*allows* this behaviour, but I think there are a very small number of
people who believe that current 2.6 behaviour is better than doing what
most of the other o/s vandors have done. Feel free to quote the RFC saying
it must be done the way it is and at least some of us will stop mentioning
the problem.

I believe you were the one who said that my "require source IP on NIC"
patch (2.4.16) was non-compliant, but I don't quite see that either. It
didn't prevent accepting a packet on one NIC which matched an address on
another, but it did prevent packets from going out if the source address
was not on the NIC. The incoming seems to be a minor problem, since there
should *be* no incoming packets if arp-filter is on. It didn't have a
/proc interface, either, but that's a nit-pick, it could be added.

I would hope that you would either quote the RFC other vendors are
violating, or stop repeating "the hidden patch is bad" and start saying
"here is another convienient solution." As in one which can be set in a
single place and which will send packets out of a NIC with the matching
source address, similar to the behaviour of other implementations. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

