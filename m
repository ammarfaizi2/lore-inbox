Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264259AbRF2EaJ>; Fri, 29 Jun 2001 00:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265530AbRF2EaA>; Fri, 29 Jun 2001 00:30:00 -0400
Received: from mcbain.stg.com ([205.253.115.13]:41934 "EHLO mcbain.stg.com")
	by vger.kernel.org with ESMTP id <S264259AbRF2E3o>;
	Fri, 29 Jun 2001 00:29:44 -0400
Date: Thu, 28 Jun 2001 23:29:38 -0500 (CDT)
From: "Burkhard Daniel" <burk@stg.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Andreas Schuldei <andreas@schuldei.org>, linux-kernel@vger.kernel.org
Subject: Re: artificial latency for a network interface
In-Reply-To: <3B3C0060.FBDB5F87@uow.edu.au>
Message-ID: <Pine.GSO.4.10.10106282327330.7836-100000@mcbain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a similiar problem once, and wrote a module that overwrote the
loopback net device. Since it's loopback, the kernel won't care about
headers.

Yeah, I know: Quick & Dirty.

I made the new loopback put its packets in a queue and then deliver them
after a (adjustable) delay.

If I can still find the source for this, I'll post it here.

Burk.

On Fri, 29 Jun 2001, Andrew Morton wrote:

> Andreas Schuldei wrote:
> > 
> > to simulate a sattelite link, I need to add a latency to a
> > network connection.
> > 
> > What is the easiest and best way to do that?
> > 
> > I wanted to do that using two tun devices.
> > I had hoped to have a routing like this:
> > 
> >  <-> eth0 <-> tun0 <-> userspace, waiting queue <-> tun1 <-> eth1
> 
> yes, that works very well.  A userspace app sits on top of the
> tun/tap device and pulls out packets, delays them and reinjects
> them.
> 
> The problem is routing: when you send the packet back to the
> kernel, it sends it straight back to you.  You need to rewrite
> the headers, which is a pain.
> 
> A simpler approach is to use policy routing - use the source
> and destination devices to override the IP addresses.  Works
> well.  The code is at
> 
> 	http://www.uow.edu.au/~andrewm/packet-delay.tar.gz
> 
> It has its own variable bandwidth management as well
> as variable latency.  It's for simulating narrowband, high
> latency connections.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

