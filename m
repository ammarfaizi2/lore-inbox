Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154170AbPHSJOK>; Thu, 19 Aug 1999 05:14:10 -0400
Received: by vger.rutgers.edu id <S154021AbPHSJN7>; Thu, 19 Aug 1999 05:13:59 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:3405 "EHLO smtp1.cern.ch") by vger.rutgers.edu with ESMTP id <S154004AbPHSJNv>; Thu, 19 Aug 1999 05:13:51 -0400
Date: Thu, 19 Aug 1999 11:14:10 +0200
Message-Id: <199908190914.LAA15538@lxp03.cern.ch>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
To: torvalds@transmeta.com
CC: x-linux-kernel@vger.rutgers.edu
Subject: irq.h changes in 2.3.14
Sender: owner-linux-kernel@vger.rutgers.edu

Hi

I noticed the moving of arch/i386/kernel/irq.h to include/linux/irq.h in
the 2.3.14 final patch.

I really don't think it is a good idea to move this very i386 specific
definitions in there since the interrupt subsystems on other
architectures are very different from that of the i386. Ie. on the m68k
we do not use the same types or irq descriptors, the IRQ line statuses
make no sense etc. and I am sure it is the same for some of the other
non x86 architectures.

I see that it expects asm/hw_irq.h to be the architecture dependant
stuff, but even the things that made it into include/linux/irq.h are way
to architecture specific.

Putting this include file in include/linux/irq.h with a generic name
like that means someone is going to use it in the generic kernel code at
some point. Having the common kernel code relying on such x86 specific
features is going to be a pain for us to handle at that point.

The only things I can see being architecture independant is the
irq_{enter,exit}() stuff and even then I am not sure the SMP versions
are portable enough for non x86 machines (being able to do test_bit() on
a spin lock is fairly implementation specific).

I really think those bits should be moved out of the generic header
files to avoid problems.

Jes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
