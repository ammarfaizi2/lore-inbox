Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130340AbQLNEpD>; Wed, 13 Dec 2000 23:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131132AbQLNEox>; Wed, 13 Dec 2000 23:44:53 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:26630 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S130340AbQLNEog>;
	Wed, 13 Dec 2000 23:44:36 -0500
Date: Wed, 13 Dec 2000 22:14:38 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.GSO.4.21.0012132249200.6300-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0012132208430.24782-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > plan-9.bell-labs.com/sys/man/
> Arrgh. s/plan-9/plan9/. My apologies.

Cool, thanks, will read.  :)

> IDGI. What 9P gives is an RPC mechanism that uses normal (as in "named streams
> of characters") representation on the client side and very light-weight
> library on the server side. It looks like you are trying to do a mechanism
> that would export arbitrary _internal_ kernel APIs. I really don't see
> what you would want it for.

Which is exactly why it doesn't work well for many applications.  The
problem is this: how do you get from a byte stream to a structured data
stream?  There are many answers:

1. Keep your data structures so simple, that it's obvious.  Not a good
choice.  :)
2. Defined interfaces to the bytestream for every interface that you
define.
3. Define a standard for inflating/deflating "things" into
bytestreams.  Oh wait, that's what corba does.  :)

The point of the matter is that CORBA gives you a nice, clean, well
supported method of not having to write marshalling/demarshalling code
every time you want to use an interface.  Not only that, it lets you
define "fast paths" for special cases (ie, with user level corba, if you
are communicating between two objects in the same processes, you can do
direct calls and do no marshalling).  These fast paths do not interfere
with the generality of the system at all.

The 9P way of doing things is not fundementally new, they just applied the
idea that "everything is a file" more broadly.  What annoys me is that it
is not immediately obvious how to "demarshall" the data that comes out of
/dev/mouse for example.  Combine that with the problem that /dev/mouse
might change format in the future (okay stupid example, but you get the
idea) to use floating point coordinates, and things certainly get hairy.

Why reinvent the wheel countless times?

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
