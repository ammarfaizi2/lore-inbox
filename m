Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267609AbSKQVfk>; Sun, 17 Nov 2002 16:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267607AbSKQVfk>; Sun, 17 Nov 2002 16:35:40 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:55965 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S267609AbSKQVfj>; Sun, 17 Nov 2002 16:35:39 -0500
Date: Sun, 17 Nov 2002 13:32:01 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: ebiederm@xmission.com
cc: Brad Hards <bhards@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
In-Reply-To: <m1smxz3mw7.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44.0211171323360.10200-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a couple quick questions from an end-user

1. will an interface be dedicated to this use, or will it share an
interface with other traffic.

2. if it is dedicated how do you inform the rest of the system that this
card is off limits? (and can you use one port on a quad card, or do you
require a dedicated card?)

3. if we really want to make this limited to the local wire why not use
something other then UDP? either another IP protocol number (more likly to
be blocked by routers) or somethign not IP compatable (so that routers
couldn't forward it if they wanted to). especially if you are talking
about useing a special (aka stripped down, simplified) stack for this
interface instead of the full-blown version

normally I would agree that standards are good, becouse they let you
interoperate with other equipment, but in this case I'm not sure that's
really what we want. All communications is not IP :-)

as someone managing 60 or so remote boxes, this sounds really nice, if it
can be made to work securely.

David Lang


On 17 Nov 2002 ebiederm@xmission.com wrote:

> Date: 17 Nov 2002 14:30:00 -0700
> From: ebiederm@xmission.com
> To: Brad Hards <bhards@bigpond.net.au>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: lan based kgdb
>
> Brad Hards <bhards@bigpond.net.au> writes:
>
> > On Mon, 18 Nov 2002 06:42, Eric W. Biederman wrote:
> > > As long as the network console/debug interface includes basic a basic
> > > check to verify that the packets it accepts are from the local network.
> > This is pretty hard to do in some configurations. You essentially have to do
> > this at the router, not at destination.
>
> I agree that you cannot do a perfect job.  The goal is to get something
> that is good enough so that it can be enabled and not give an automatic root
> exploit if someone accidentally leaves it on at the wrong time.
>
> > > And it's outgoing packets have a ttl of one.  I don't have a problem.
> > Recent IETF work on link-local has used TTL=255 outgoing, and it has to be 255
> > at the receive end too. That is a reasonable way to ensure that is is
> > link-local, since even the most brain-dead routers will at least decrement
> > TTL.
>
> Nice. And then on the transmit end I would still use a TTL=1 so that
> routers will refuse to route the packets.  A bit asymmetric but I only
> care about security in one direction.
>
> But in what kind of configurations is checking the ip against the
> current netmask insufficient?  Checking for a TTL of 255 will
> trivially make the check stronger.
>
> Having a network console for various debugging tasks could be very
> useful.  The question is how to implement it simply and reliably.
>
> Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
