Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129730AbQJaKGs>; Tue, 31 Oct 2000 05:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129797AbQJaKGj>; Tue, 31 Oct 2000 05:06:39 -0500
Received: from atapco.demon.co.uk ([194.222.134.57]:5649 "EHLO
	gate.atapco.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129730AbQJaKGX>; Tue, 31 Oct 2000 05:06:23 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200010310937.JAA07048@brick.arm.linux.org.uk>
Subject: Re: test10-pre7
To: kaos@ocs.com.au (Keith Owens)
Date: Tue, 31 Oct 2000 09:37:09 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <12109.972949137@ocs3.ocs-net> from "Keith Owens" at Oct 31, 2000 10:38:57 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> kbuild 2.5 splits link order into three categories.  Those that must
> come first, in the order they are specified - LINK_FIRST.  Those that
> must come last, in the order they are specified - LINK_LAST.

Keith, this sounds like a K-ludge.

Take the instance where we need to link a.o first, z.o second, f.o third
and p.o fourth.  How does LINK_FIRST / LINK_LAST guarantee this?

LINK_FIRST = a.o z.o
LINK_LAST = f.o p.o

But then what guarantees that 'a.o' will be linked before 'z.o'?

A first/last implementation can *not* specify precisely a link order without
guaranteeing that the order of the LINK_FIRST *and* the LINK_LAST objects
is preserved, which incidentally is the same requirement for the obj-y
implementation.

I don't see what this LINK_FIRST / LINK_LAST gains us other than more
complexity for zero gain.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | |   http://www.arm.linux.org.uk/~rmk/aboutme.html    /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
