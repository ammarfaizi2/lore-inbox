Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971801-15443>; Mon, 20 Jul 1998 05:50:21 -0400
Received: from dot.cygnus.com ([205.180.230.224]:1970 "EHLO dot.cygnus.com" ident: "SOCKWRITE-65") by vger.rutgers.edu with ESMTP id <971797-15443>; Mon, 20 Jul 1998 05:49:59 -0400
Message-ID: <19980720041630.D15377@dot.cygnus.com>
Date: Mon, 20 Jul 1998 04:16:30 -0700
From: Richard Henderson <rth@dot.cygnus.com>
To: Linus Torvalds <torvalds@transmeta.com>, "Stephen C. Tweedie" <sct@redhat.com>
Cc: ganesh.sittampalam@magd.ox.ac.uk, Virtual Memory problem report list <linux-kernel@vger.rutgers.edu>, mingo@valerie.inf.elte.hu, Bill Hawes <whawes@star.net>, Alan Cox <number6@the-village.bc.nu>, "David S. Miller" <davem@dm.cobaltmicro.com>
Subject: Re: Progress! was: Re: Yet more VM writable swap-cached pages
Reply-To: Richard Henderson <rth@cygnus.com>
References: <199807100042.BAA07833@dax.dcs.ed.ac.uk> <Pine.LNX.3.96.980709174951.431E-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1i
In-Reply-To: <Pine.LNX.3.96.980709174951.431E-100000@penguin.transmeta.com>; from Linus Torvalds on Thu, Jul 09, 1998 at 05:54:21PM -0700
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, Jul 09, 1998 at 05:54:21PM -0700, Linus Torvalds wrote:
> It also explains why so few people saw this - PROT_NONE is not something
> that is normally used.

Actually, the glibc ld.so will create PROT_NONE regions if there is
a hole between a shared library's text and data space.  E.g.

20000110000-200001d6000 r-xp 00000000000 08:02 29407      /lib/libc-2.0.7.so
200001d6000-200002d0000 ---p 000000c6000 08:02 29407      /lib/libc-2.0.7.so
200002d0000-200002e6000 rwxp 000000c0000 08:02 29407      /lib/libc-2.0.7.so

    LOAD off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**16
         filesz 0x000c48a8 memsz 0x000c48a8 flags r-x
    LOAD off    0x000c48a8 vaddr 0x001c48a8 paddr 0x001c48a8 align 2**16
         filesz 0x00010540 memsz 0x0001ae90 flags rwx


r~

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
