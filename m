Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132381AbQLNEgw>; Wed, 13 Dec 2000 23:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132380AbQLNEgm>; Wed, 13 Dec 2000 23:36:42 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:16039 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130340AbQLNEg3>;
	Wed, 13 Dec 2000 23:36:29 -0500
Date: Wed, 13 Dec 2000 23:05:57 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Lattner <sabre@nondot.org>
cc: linux-kernel@vger.kernel.org, korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012132133190.24718-100000@www.nondot.org>
Message-ID: <Pine.GSO.4.21.0012132249200.6300-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Chris Lattner wrote:

> > plan-9.bell-labs.com/sys/man/

Arrgh. s/plan-9/plan9/. My apologies.

> Err... yeah, so you're effectively mapping UNIX/POSIX across 9P.  That's
> not very creative, and you could do the same thing with CORBA.  I ask
> again, "How much development infrastructure is there for 9P?".  If you say
> "just use unix", then what is the point of 9P at all?  (on linux).  Linux
> already has most of posix (and some would claim all of the "good
> stuff" in posix.).

IDGI. What 9P gives is an RPC mechanism that uses normal (as in "named streams
of characters") representation on the client side and very light-weight
library on the server side. It looks like you are trying to do a mechanism
that would export arbitrary _internal_ kernel APIs. I really don't see
what you would want it for.

Notice that exporting a kernel API is possible right now and you don't
need _any_ RPC for that. Check procfs/devfs/shmfs/etc. RPC comes into
the game when you want to export the piece of namespace to other box
or when userland server wants to export its stuff into namespace.

IOW, you don't export internal interfaces via RPC, you publish them
as a filesystem and then use RPC if you want to access it from another
box. Where it looks like filesystem, again.

_Another_ issue is with the stuff like plumber when you want to talk
with userland program via filesystem, but you seem to be talking about
something that looks like the first kind of situation...


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
