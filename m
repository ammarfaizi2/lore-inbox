Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971129-15443>; Mon, 20 Jul 1998 11:34:47 -0400
Received: from neon-best.transmeta.com ([206.184.214.10]:20632 "EHLO neon.transmeta.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <970909-15443>; Mon, 20 Jul 1998 11:34:35 -0400
Date: Mon, 20 Jul 1998 10:01:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Henderson <rth@cygnus.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>, ganesh.sittampalam@magd.ox.ac.uk, Virtual Memory problem report list <linux-kernel@vger.rutgers.edu>, mingo@valerie.inf.elte.hu, Bill Hawes <whawes@star.net>, Alan Cox <number6@the-village.bc.nu>, "David S. Miller" <davem@dm.cobaltmicro.com>
Subject: Re: Progress! was: Re: Yet more VM writable swap-cached pages
In-Reply-To: <19980720041630.D15377@dot.cygnus.com>
Message-ID: <Pine.LNX.3.96.980720100016.20495A-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Mon, 20 Jul 1998, Richard Henderson wrote:
> On Thu, Jul 09, 1998 at 05:54:21PM -0700, Linus Torvalds wrote:
> > It also explains why so few people saw this - PROT_NONE is not something
> > that is normally used.
> 
> Actually, the glibc ld.so will create PROT_NONE regions if there is
> a hole between a shared library's text and data space.  E.g.
> 
> 20000110000-200001d6000 r-xp 00000000000 08:02 29407      /lib/libc-2.0.7.so
> 200001d6000-200002d0000 ---p 000000c6000 08:02 29407      /lib/libc-2.0.7.so
> 200002d0000-200002e6000 rwxp 000000c0000 08:02 29407      /lib/libc-2.0.7.so

Yes, but you won't have any actualy _pages_ mapped there. 

The only way to get the pages there is to first map it with something else
than prot_none, touch some of the pages, and then do a mprotect() to make
them invisible again. I doubt glibc does that ;) 

		Linus



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
