Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266407AbTAFKIW>; Mon, 6 Jan 2003 05:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266417AbTAFKIW>; Mon, 6 Jan 2003 05:08:22 -0500
Received: from alfie.demon.co.uk ([158.152.44.128]:24582 "EHLO
	bagpuss.pyrites.org.uk") by vger.kernel.org with ESMTP
	id <S266407AbTAFKIV>; Mon, 6 Jan 2003 05:08:21 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Newsgroups: list.linux-kernel
Subject: Re: dummy ethernet driver
Date: 6 Jan 2003 10:16:54 -0000
Organization: Alfie's Internet Node
Message-ID: <avbl2m$ros$1@alfie.demon.co.uk>
References: <Pine.LNX.4.44.0301060553260.24333-200000@skynet>
X-Newsreader: NN version 6.5.0 CURRENT #120
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

airlied@linux.ie (Dave Airlie) writes:
> device but rather a useless one :-), so I patched the dummy so it had an
> address (hardcoded) is broadcast and loops back packets to itself...
> 
> the patch is attached.. is there any reason why the dummy device doesn't
> want to do this stuff? I'm just submitting the patch as a request for
> comments on why this isn't done anyway in the dummy?

[Some background on the dummy driver -- I don't know if there is another
way to configure devices for your purpose, or if your patch is the only
way, I'll leave that for others to answer]

With the way the dummy driver was used, it wasn't necessary to handle
packets.

I wanted my dial-up static IP address to be valid even when the ppp device
was not connected, so I wrote the dummy interface.  If the destination
IP of a packet matches the IP of a local interface, then the packet is
routed over the loopback interface.

So, for this use the dummy interface doesn't need to handle packets, it
just needs to hold an IP address.  In the case that someone configures
the routing tables so that packets are sent via the dummy device, it
just black-holes the packets.

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
