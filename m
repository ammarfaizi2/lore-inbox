Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154572-14821>; Sat, 1 May 1999 05:15:47 -0400
Received: by vger.rutgers.edu id <154390-14821>; Sat, 1 May 1999 05:13:05 -0400
Received: from [207.104.6.26] ([207.104.6.26]:2331 "EHLO piglet.twiddle.net" ident: "davem") by vger.rutgers.edu with ESMTP id <153993-14821>; Sat, 1 May 1999 05:12:45 -0400
Date: Sat, 1 May 1999 02:59:56 -0700
Message-Id: <199905010959.CAA24677@piglet.twiddle.net>
From: David Miller <davem@twiddle.net>
To: hpa@transmeta.com
CC: linux-kernel@vger.rutgers.edu
In-reply-to: <7gei4f$qsh$1@palladium.transmeta.com> (hpa@transmeta.com)
Subject: Re: 64bit port
References: <E10dUur-0001vY-00@devel2.axiom.internal> <7gei4f$qsh$1@palladium.transmeta.com>
Sender: owner-linux-kernel@vger.rutgers.edu

   From: hpa@transmeta.com (H. Peter Anvin)
   Date: 	1 May 1999 09:39:27 GMT

   I think that was only UltraSPARC I.

Not true.

All currently shipping UltraSparc's have at least one of the two
64-bit lockup bugs.  On the Ultra-I the user can do it no matter where
the text section is mapped, this is why Solaris doesn't offer 64-bit
installation by default on the < 250Mhz Ultra-I's which are the chips
affected by this first bug.

All UltraSparc chips (to my knowledge) are effected by the second hw
bug, which can only be triggered if the user can execute code in the
top of low 2GB of the 64-bit address space (it involves doing a PC
relative call which over/under-flows the program counter across the
64-bit top/bottom addresses, while doing an access into the VA space
hole in the delay slot, or something like this, I don't know the exact
trigger sequence yet).  This is why Solaris-7 does not allow 64-bit
userspace to map anything in these areas in 64-bit mode, which as a
side-effect makes the medium-low code model close to useless.

When Jakub and I get the 64-bit userland bootstrapped, I'll start
running crashme to learn what the exact instruction sequences are so
we have a chance at coding a more suitable workaround than what
Solaris has chosen.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
