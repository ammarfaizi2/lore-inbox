Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154518-28471>; Mon, 7 Sep 1998 09:15:29 -0400
Received: from styx.cs.kuleuven.ac.be ([134.58.40.3]:35323 "EHLO styx.cs.kuleuven.ac.be" ident: "TIMEDOUT2") by vger.rutgers.edu with ESMTP id <154761-28471>; Mon, 7 Sep 1998 08:21:17 -0400
Date: Mon, 7 Sep 1998 16:47:23 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: "David S. Miller" <davem@dm.cobaltmicro.com>, Ulrik De Bie <winmute@kotnet.org>
cc: Linux kernel <linux-kernel@vger.rutgers.edu>, Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: IPv4 kernel messages
In-Reply-To: <199809070016.RAA09205@dm.cobaltmicro.com>
Message-ID: <Pine.LNX.4.03.9809071639480.30228-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Sun, 6 Sep 1998, David S. Miller wrote:
>    Date: 	Mon, 7 Sep 1998 01:12:16 +0200 (CEST)
>    From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
> 
>    They're still there:
> 
>    | Socket destroy delayed (r=0 w=160)
>    | TCPv4 bad checksum from 10.0.24.8:0071 to 10.0.24.4:040c, len=20/20/40
> 
>    Are these just warnings to be disabled in 2.2, or is there something wrong?
> 
>    10.0.24.4 runs Linux/m68k 2.1.119. 10.0.24.8 is a PPC running vger-19980903.
> I see them only rarely on my main workstation which talks a lot to the
> rest of the world.  On my internal Linux-2.1.x machines I never see
> it.
> 
> I would check out the csum routines on m68k and PPC to make sure they
> are sane in all cases.
> 
> Here is the lifesaver development utility I have been using for a long
> time to verify all major changes made to Sparc and MIPS checksumming
> routines.  It won't work for you as-is, but you can figure out what it
> is supposed to do and link the PPC and M68k csum routines into it to
> perform verifications.  Note there is an ugly piece of MIPS inline asm
> in here which you'll need to remove too as the last thing I used this
> for was the Cobalt kernels :-)  Note it also performs performance
> metrics on your code too, so it's useful for speed tuning as well as
> verification.

Thanks! The PPC checksumming code passed the test, but the m68k code seems to
be broken. I got:

    verify_ip_fast_csum: buffer 0 gets bogus csum abe7!

Ulrik De Bie wrote:
> I think the following information is interesting here. I have the same with
> Linux/i486 running recent-vger and PPC running recent-vger.
> 
> So both intel and m68k are wrong, or ppc is wrong. Which would give a big
> hint to the latter.

Since PPC passed the test, this would indicate that ia32 is incorrect, too.

But if I understand it correctly, the test isn't exhaustive, right?

Greetings,

						Geert

P.S. I put the code I used (i.e. Dave's with adaptations for ppc and m68k) on
     my webpage: http://www.cs.kuleuven.ac.be/~geert/bin/cksum_helper.c
--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
