Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267605AbSKQVpg>; Sun, 17 Nov 2002 16:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267607AbSKQVpg>; Sun, 17 Nov 2002 16:45:36 -0500
Received: from mta05ps.bigpond.com ([144.135.25.137]:13046 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S267605AbSKQVpf>; Sun, 17 Nov 2002 16:45:35 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: lan based kgdb
Date: Mon, 18 Nov 2002 08:42:19 +1100
User-Agent: KMail/1.4.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1037490849.24843.11.camel@irongate.swansea.linux.org.uk> <200211180725.27450.bhards@bigpond.net.au> <m1smxz3mw7.fsf@frodo.biederman.org>
In-Reply-To: <m1smxz3mw7.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200211180842.19313.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 18 Nov 2002 08:30, Eric W. Biederman wrote:
> Brad Hards <bhards@bigpond.net.au> writes:
> > On Mon, 18 Nov 2002 06:42, Eric W. Biederman wrote:
> > > As long as the network console/debug interface includes basic a basic
> > > check to verify that the packets it accepts are from the local network.
> >
> > This is pretty hard to do in some configurations. You essentially have to
> > do this at the router, not at destination.
>
> I agree that you cannot do a perfect job.  The goal is to get something
> that is good enough so that it can be enabled and not give an automatic
> root exploit if someone accidentally leaves it on at the wrong time.
if you put it on the network, the best you can do is restrict the problem to 
being link-local. If you exclude wireless, then the problem is basically then 
a matter of physical security, which isn't much different to having a console 
running on the box itself.

> > > And it's outgoing packets have a ttl of one.  I don't have a problem.
> >
> > Recent IETF work on link-local has used TTL=255 outgoing, and it has to
> > be 255 at the receive end too. That is a reasonable way to ensure that is
> > is link-local, since even the most brain-dead routers will at least
> > decrement TTL.
>
> Nice. And then on the transmit end I would still use a TTL=1 so that
> routers will refuse to route the packets.  A bit asymmetric but I only
> care about security in one direction.
I was completely confused when I first read this. 
I take it that you mean:
On machine under test (the target in the debug context) you make TTL=1 on 
outgoing packets, and drop incoming packets that don't have TTL=255
On machine being used to view console (the host in the debug context) you make 
TTL=255 on outgoing packets.

That doesn't ensure that the machine you are monitoring (or debugging) is 
really the machine you think it is, but it might solve enough of the problem.

> But in what kind of configurations is checking the ip against the
> current netmask insufficient?  Checking for a TTL of 255 will
> trivially make the check stronger.
It prevents source field spoofing. I don't know how much defence you get from 
this on fielded routers, but faking the source field in a UDP packet doesn't 
seem too hard.
TTL=255 ensures that the machine you are talking to is _really_ on the same 
link. Any other number is subject to an attacker knowing how many hops it is, 
and setting TTL appropriately.

Brad
- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE92A07W6pHgIdAuOMRAhmBAJ9O//ObT/e2pq6lrbiKUDhkNNJslwCdHYEN
mXWWIAkZW7SDUSRhY7AvN0s=
=EA7y
-----END PGP SIGNATURE-----

