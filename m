Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318448AbSGaSvj>; Wed, 31 Jul 2002 14:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318455AbSGaSvj>; Wed, 31 Jul 2002 14:51:39 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7182 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318448AbSGaSvj>; Wed, 31 Jul 2002 14:51:39 -0400
Date: Wed, 31 Jul 2002 14:48:43 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: David Shirley <dave@cs.curtin.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Network Routing Problems on Dual NIC Box
In-Reply-To: <5.1.1.6.0.20020731132143.00bc5078@pop.cs.curtin.edu.au>
Message-ID: <Pine.LNX.3.96.1020731142559.10066E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2002, David Shirley wrote:

> I'm not sure this is the right list for this question so bear with me :)
> 
> I have a machine that has 2 NIC's both on different subnet's lets
> say 192.168.2.200 and 192.168.3.200
> 
> We are running a proxy server on this box, and the box is called proxy
> which when you do a lookup points to 192.168.3.200
> 
> the problem is when machines on the 192.168.2.0 subnet try to
> access proxy:80 the session connects but no data is being received on the
> 192.168.2.0 box.
> 
> I think its because proxy accepts on the .3 but then tries to send all the data
> via the .2 interface because its directly connected and the .2 box ignores it
> because its not coming from the .3
> 
> is this true?
> how can i get proxy to send data back via the .3 interface? rather than via .2

The short answer is that Linux works that way because the network folks
want it to and quote an RFC which says that's alowed conforming behaviour. 
It also does proxy arp by default and bunch of other stuff. Your packets
are probably going out the other interface.

The long answer is that you can probably use iproute2 to route packets by
source address to the correct interface. I haven't used 2.2 in a while and
didn't ever try that back when, so I am totally guessing. You might repeat
this question in the cosl.networking for a better answer if iproute2 won't
do this in 2.2.

> btw its 2.2.19 box running redhat 6.2

2.4 is better in many ways, but that implementation decision hasn't
changed. What you probably want is a single rule to choose interface by
source address, but you can get what you need by routing as long as you
have only a few subnets (the tables are 255 entries long IIRC). 

Hope this helps.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

