Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbQLNRkq>; Thu, 14 Dec 2000 12:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129784AbQLNRkg>; Thu, 14 Dec 2000 12:40:36 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:60422 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S129604AbQLNRkU>;
	Thu, 14 Dec 2000 12:40:20 -0500
Date: Thu, 14 Dec 2000 11:10:24 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Xavier Ordoquy <xordoquy@aurora-linux.com>
Cc: orbit-list@gnome.org, linux-kernel@vger.kernel.org
Subject: Re: ORBit speed measure
Message-ID: <Pine.LNX.4.21.0012141100590.26708-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> There is a large perception of CORBA being slow, but for the most part
>> it is unjustified.  

> Well, I've measured using function calls through ORBit is 300 times
> slower than using dynamic loading.
> ...
> Which gives me the dl is about 333 times faster than ORBit.

You leave so many details out, and you sortof miss the point with my
statement.  The idea is that CORBA doesn't specify a transport to use _at
all_ except when doing inter-orb communication (which you basically have
to use IIOP to be compatible).  This is why, for example, if you
ior-decode ORBit IORs that they contain two parts: an IIOP portion, and a
Unix domain socket portion.  Basically ORBit is optimizing the
intramachine case, because it is very common for purposes that ORBit is
mainly used: GNOME.

You didn't specify, but I assume that you were using the Unix sockets
transport for your benchmark.  I am also assuming that the two things
communicating were in different processes.  If you wanted to make a more
fair test case, you would have to use some form of IPC mechanism to
communicate between two distinct processes.  Comparing a function call to
an RPC mechanism will never look good.  :)

There are many other optimizations that one can make the transport faster
that ORBit doesn't implement.  For example, you could mmap (shared) data
buffers between the two processes communicating (of course, you still need
to wake processes up, which is why it hasn't been done yet), or you could
use pipes (if you can control forkness) or any number of things.  If you
are communicating with a server in the same process as your client
(because it was dynamically loaded) you can even do a direct function
call.

When I said that "for the most part it is unjustified" to think that CORBA
is slow, what I meant is that CORBA isn't slow: implementations are.  Just
look at the difference between ORBit and all those other orbs out
there... orders of magnitude speed differences, with little or no
functionality differences.

What CORBA gives you is the power to have optimizations for important
special cases (in kORBit's case, one of those would be User->kernel),
WITHOUT sacrificing the big picture or the ability to be interoperable...

I am not claiming that kORBit is where it needs to be right now.  :)

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
