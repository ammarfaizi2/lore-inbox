Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132193AbQLNGx1>; Thu, 14 Dec 2000 01:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132598AbQLNGxR>; Thu, 14 Dec 2000 01:53:17 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:41222 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S132193AbQLNGxE>;
	Thu, 14 Dec 2000 01:53:04 -0500
Date: Thu, 14 Dec 2000 00:23:04 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, korbit-cvs@lists.sourceforge.net
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.GSO.4.21.0012140018120.6300-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0012140007540.25306-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > NO.  You want leagacy program to "just get" rounded ints, and new programs
> > to get the "full precision" of the floating point #'s.

> What rounded ints? Rounded to zero? To nearest integer? To plus or minus
> infinity? Does program have something to say here?

The exact same thing that older mouse drivers did.  In this particular
case, it doesn't matter anyways, because it's a simple example.  If you
REALLY care about rounding those coordinates a certain way, it's trivial
to add an extra component to the interface.

> ...
> My mouse example
> ...

> Oh, great. So we don't have to care about formatting changes. We just
> have to care about the data changes. IOW, we are shielded from the
> results of changes that should never happen in the first place. And the
> benefit being...?

What the hell are you talking about?  Did you even read my example? I was
giving an example of extending an API, adding new functionality to it.

> Notice that we could equally well add /dev/floatymouse and everything that
> worked with old API would keep working. The only programs that would need
> to know about floats would be ones that would... need to know about floats
> since they want to work with them.

Wonderful solution.  This is exactly what you would _have_ to do.  Are you
aware of why devfs came into existence?  It is because there are already
so damn many device nodes in /dev.  Lets keep adding more.  

Why is it (for example) that on my machine (mandrake 7 install, no devfs),
I automatically get inodes for ISDN & PPP!?!  Well, because ISDN has a
slightly different interface, and you're talking to a different driver
that is not transparently hidden to the user.  Why can't I just open
/dev/net0 and get the first network device?  Because we have so many
inconsistent, poorly design, inextensible interfaces laying around, thats
why.

> Notice also that I can say ls /dev/*mouse* and get some idea of the files
> there. I can't do that for your interfaces.

And you know what?  I can't do ls /dev/*net* and get all the network
devices either.  Actually, one of the very cool things about CORBA is that
you can BROWSE/LIST/SEARCH all objects currently instantiated.  Being
able to browse all in kernel objects would be very cool.

> The point being: if your program spends efforts on marshalling it would
> better _do_ something with the obtained data. And then we are back to
> the square 1.

Uh huh, go ahead and read the example I sent to you.

> Returning to your example, I could not tee(1) the stream into file for
> later analysis. Not unless I write a special-case program for intercepting
> that stuff. I don't see why it is a good thing.

On the contrary, it would be pretty easy to do something like that with
CORBA.  No you wouldn't be able to use tee, but why would you want to tee
a binary data file?  The only reason that tee works in this situation is
because it's agnostic to the format of the data coming off the
line... your analysis program would have to have special purpose code to
parse the file.  EVERY consumer of "mouse data" would have to parse the
file.  That seems pretty silly to me.

> I also don't see where the need in new system calls (or ioctls, same shit)
> comes from. Notice that your way is much closer to new system call than
> read()/write() of the right stuff.

A new syscall was one example.  It would be very simple to implement this
by making _yet_another_ device node in /dev and issue reads and writes to
it.  That's more of a syntactic issue than a symantic one.

> As for the proc/meminfo... What would you do to a userland programmer who
> had defined a structure like that? Let's see: way too large, ugly as hell,
> many fields are almost guaranteed to become meaningless at later point...
> It was not designed, it got accreted. And that's very mild description -
> judging by results it might as well be s/ac/ex/.

There is no provision in CORBA that prevents the creation of ugly
interfaces.  There is no provision in C that prevents them either, as
witnessed by this example.  At least with CORBA, I can extend the
interface to actually return meaningful results while still maintaining
backwards compatibility with programs that don't actually look at that
field (as is done now by sticking the 0 in there).

The trick is having enough foresight to design robust interfaces.  I'm not
saying that I'm an expert at that, and obviously nobody can be.  What I
_am_ saying is that CORBA/kORBit gives you flexibility in how you do
interfaces, and it lets you "future proof" them (obviously only within
reason).  Adding a new device node everytime an API gets changed is like
defining a different API for every hard disk that exists.  Seems kinda
silly.

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
