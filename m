Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S159968AbQHMAEP>; Sat, 12 Aug 2000 20:04:15 -0400
Received: by vger.rutgers.edu id <S160012AbQHMAEJ>; Sat, 12 Aug 2000 20:04:09 -0400
Received: from [216.101.162.242] ([216.101.162.242]:32802 "EHLO pizda.ninka.net") by vger.rutgers.edu with ESMTP id <S157635AbQHMAD5>; Sat, 12 Aug 2000 20:03:57 -0400
Date: Sat, 12 Aug 2000 17:19:44 -0700
Message-Id: <200008130019.RAA04614@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.rutgers.edu
In-reply-to: <200008121801.TAA11768@flint.arm.linux.org.uk> (message from Russell King on Sat, 12 Aug 2000 19:01:53 +0100 (BST))
Subject: Re: PageSkip
References: <200008121801.TAA11768@flint.arm.linux.org.uk>
Sender: owner-linux-kernel@vger.rutgers.edu

   From: Russell King <rmk@arm.linux.org.uk>
   Date: 	Sat, 12 Aug 2000 19:01:53 +0100 (BST)

   I've just done a grep for PageSkip on all .c and .h files in the current
   (2.4.0-test6) kernel, and have come up with:

 ...

   Since this macro is only used in two architecture-specific places, is there
   any reason to keep it in the header files?

   On ARM, I'm planning on moving it out of pgtable.h and into mm/init.c.

It should die just about everywhere, there should be no use for it
anymore for any port.

it only existed to handle generic parts of the kernel which wished to
walk the mem_map[] array by hand, there is no such code any more
thanks to various cleanups by Kanoj and others.  Ergo PageSkip and
PG_skip can both be just eradicated along with any code referencing
it.  Unless, you are using it for some strange purpose inside your
ports, and I bet even those cases can be easily removed.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
