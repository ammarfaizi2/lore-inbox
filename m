Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154203AbPHSRrD>; Thu, 19 Aug 1999 13:47:03 -0400
Received: by vger.rutgers.edu id <S154236AbPHSRqt>; Thu, 19 Aug 1999 13:46:49 -0400
Received: from neon-best.transmeta.com ([206.184.214.10]:16492 "EHLO neon.transmeta.com") by vger.rutgers.edu with ESMTP id <S154180AbPHSRpP>; Thu, 19 Aug 1999 13:45:15 -0400
Date: Thu, 19 Aug 1999 10:45:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jes Sorensen <Jes.Sorensen@cern.ch>
cc: x-linux-kernel@vger.rutgers.edu
Subject: Re: irq.h changes in 2.3.14
In-Reply-To: <199908190914.LAA15538@lxp03.cern.ch>
Message-ID: <Pine.LNX.4.10.9908191034350.2091-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Thu, 19 Aug 1999, Jes Sorensen wrote:
> 
> I noticed the moving of arch/i386/kernel/irq.h to include/linux/irq.h in
> the 2.3.14 final patch.
> 
> I really don't think it is a good idea to move this very i386 specific
> definitions in there since the interrupt subsystems on other
> architectures are very different from that of the i386.

The thing is, that the irq handling is _too_ different on different
architectures. A lot of the problems, especially the SMP issues, are
simply completely architecture-independent. 

>					 Ie. on the m68k
> we do not use the same types or irq descriptors, the IRQ line statuses
> make no sense etc. and I am sure it is the same for some of the other
> non x86 architectures.

It is. And I _know_ that just about every architecture except for the x86
has bugs when it comes to SMP handling. Some, like the 68k, do not need to
care. 

> I see that it expects asm/hw_irq.h to be the architecture dependant
> stuff, but even the things that made it into include/linux/irq.h are way
> to architecture specific.

There's absolutely nothing architecture-specific in <linux/irq.h>.

It may be _different_ than existing architectures, but I'll try to make
sure that future ports use the same correct irq handling, and I'll see if
I can port some of the existing stuff (notably alpha) to use the new
generic handling. It's actually very flexible - it pretty much has to be
in order to handle the different kinds of interrupt controllers that exist
on PC-like machines.

No architecture will be _forced_ to use the new stuff, so don't worry. But
I'll just warn you that you're likely to get the SMP stuff wrong if you
don't use it ;)

			Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
