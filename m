Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130379AbQLNFLh>; Thu, 14 Dec 2000 00:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130685AbQLNFL1>; Thu, 14 Dec 2000 00:11:27 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:28166 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S130379AbQLNFLU>;
	Thu, 14 Dec 2000 00:11:20 -0500
Date: Wed, 13 Dec 2000 22:41:22 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: CORBA vs 9P
In-Reply-To: <Pine.GSO.4.21.0012132308440.6300-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0012132235000.24937-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Okay, so there are _stubs_ for these platforms.  How many languages are
> > there bindings for?
> Grr... Let's define the terms, OK? What is available: kernel code that
> represents the client side of RPC as a filesystem. Userland clients do
> not know (or care) about the mechanisms involved.

But they DO CARE about the format of the data.

> 	And files with structure are things of dreadful past. BTDT.
> You really need to... work with an OS that would have and enforce
> "structured files" <spit> to appreciate the beauty of ASCII streams.

Ahhh, so ASCII streams are a wonderful thing.  Are you an XML fan?  :)

> 	However, that's a different story. What I _really_ don't understand
> is the need to export anything structured from kernel to userland.

Okay, how about a few examples.  How about /proc/meminfo?  How about the
"stat" structure?  How about /proc/stat?  You seem to be indicating that
ASCII files are fine for general exportation of kernel information.  The
/proc filesystem begs to differ.  One specific example is the
/proc/meminfo file.  Why is it that one field is 0 now?  Ouch we can't
change the format of the file because we'll break some program.  Crap, you
want to add a field, well, tough luck.

The struct stat example is one _trivial_ example of "the need to export
anything structured from kernel to userland".

> 	IOW, I would really like to see a description of use of your
> mechanism. If it's something along the lines of "let's take a network
> card driver, implement it in userland and preserve the current API" -
> see the comment about layering violations. You've taken an internal
> API and exposed it to userland in all gory details. See also your own
> comment about internal APIs being not convenient for such operations.

I'm not trying to dictate interfaces.  I'm not trying to tell people what
to use this stuff for.  I'm arguing that it's useful and that you can do
very interesting things with it.

> If it's something else - I wonder what kind of objects you are talking
> about and why opaque stuff (== file descriptors) would not be sufficient.

Opaque stuff is fine.  I have no problem with file descriptors.  They
effectively solve the exact same class of problems that CORBA does, except
that they add significant _API BLOAT_ because every little "method" that
implements them gets a syscall.  Oh yeah, they you get ioctl
too.  Funness.  :)

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
