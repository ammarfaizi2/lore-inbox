Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbQLNSDh>; Thu, 14 Dec 2000 13:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQLNSD1>; Thu, 14 Dec 2000 13:03:27 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:63750 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S130010AbQLNSDS>;
	Thu, 14 Dec 2000 13:03:18 -0500
Date: Thu, 14 Dec 2000 11:33:33 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <E146VE3-00043s-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0012141124530.26708-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > There is a large perception of CORBA being slow, but for the most part it
> > is unjustified.  I believe that the act of _designing_ a completely new

> CORBA is slow compared to some of the other solutions. The question I was 
> trying to ask is whether you should put something smaller and faster into the
> kernel space and leave CORBA in userland. 

What I'm trying to show is that CORBA itself is not slow.  CORBA can be
thought of as an IDEA, and the current implementations are
suboptimal.  For example, no CORBA implementation has been tweaked to run
well in-kernel.  Because of this, people will say that CORBA sucks and is
slow, but that's not true.

I will agree that IIOP (the standardized corba communication mechanism) is
much slower and more complex than we would want for a generalized
user->kernel communication mechanism.  The nice thing about CORBA is that
you can design your own transport to optimize things.  Thus 99% of the
time you could use a heavily optimized, very simple transport that doesn't
do much.  This is what you are asking for, and it make perfect
sense.  What CORBA buys you is the ability to use this streamlined
interface without giving up full generality...

> It's complex, it has security 
> implications surely it belongs talking something simple and fast to the kernel.

First off, there are a lot of complex systems in the kernel.  :)
Second, there are not security implications above and beyond any normal
kernel hacking.  The reason that kORBit has security implications right
now is that there _IS NO SECURITY_.  Imagine implementing sys_read with
no checks of what uid is running, and you get the idea.  

Actually security in CORBA can be done BETTER in kernel space than in user
space, but I digress...

> If you look at microkernels they talk a much simpler faster rpc protocol. 

Yes but for the most part they lose all of the advantages of CORBA as
well.  For example, every microkernel that I'm aware of can only talk to
remote servers/clients that are running the same microkernel on the remote
machine.  There are no provisions for byte swapping if the endianness is
incorrect or for having structured bytestreams (so that you can tell
things about the raw bytes coming over the line without understanding them
all).

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
