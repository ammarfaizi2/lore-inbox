Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267601AbSKQVXc>; Sun, 17 Nov 2002 16:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267602AbSKQVXc>; Sun, 17 Nov 2002 16:23:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27218 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267601AbSKQVXb>; Sun, 17 Nov 2002 16:23:31 -0500
To: Brad Hards <bhards@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
References: <1037490849.24843.11.camel@irongate.swansea.linux.org.uk>
	<20021116193008.C25741@work.bitmover.com>
	<m11y5k3ruw.fsf@frodo.biederman.org>
	<200211180725.27450.bhards@bigpond.net.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Nov 2002 14:30:00 -0700
In-Reply-To: <200211180725.27450.bhards@bigpond.net.au>
Message-ID: <m1smxz3mw7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Hards <bhards@bigpond.net.au> writes:

> On Mon, 18 Nov 2002 06:42, Eric W. Biederman wrote:
> > As long as the network console/debug interface includes basic a basic
> > check to verify that the packets it accepts are from the local network.
> This is pretty hard to do in some configurations. You essentially have to do 
> this at the router, not at destination.

I agree that you cannot do a perfect job.  The goal is to get something
that is good enough so that it can be enabled and not give an automatic root
exploit if someone accidentally leaves it on at the wrong time.
 
> > And it's outgoing packets have a ttl of one.  I don't have a problem.
> Recent IETF work on link-local has used TTL=255 outgoing, and it has to be 255 
> at the receive end too. That is a reasonable way to ensure that is is 
> link-local, since even the most brain-dead routers will at least decrement 
> TTL.

Nice. And then on the transmit end I would still use a TTL=1 so that
routers will refuse to route the packets.  A bit asymmetric but I only
care about security in one direction.  

But in what kind of configurations is checking the ip against the
current netmask insufficient?  Checking for a TTL of 255 will
trivially make the check stronger.

Having a network console for various debugging tasks could be very
useful.  The question is how to implement it simply and reliably.

Eric
