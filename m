Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130174AbQJaOQm>; Tue, 31 Oct 2000 09:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130152AbQJaOQc>; Tue, 31 Oct 2000 09:16:32 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:38666 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130079AbQJaOQZ>; Tue, 31 Oct 2000 09:16:25 -0500
Date: Tue, 31 Oct 2000 08:16:08 -0600
To: Keith Owens <kaos@ocs.com.au>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7
Message-ID: <20001031081608.C1041@wire.cadcamlab.org>
In-Reply-To: <200010310937.JAA07048@brick.arm.linux.org.uk> <16544.973000930@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16544.973000930@ocs3.ocs-net>; from kaos@ocs.com.au on Wed, Nov 01, 2000 at 01:02:10AM +1100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [rmk]
> > Take the instance where we need to link a.o first, z.o second, f.o
> > third and p.o fourth.  How does LINK_FIRST / LINK_LAST guarantee
> > this?

It does.  Read the patch.  LINK_FIRST *itself* is not sorted.

> > LINK_FIRST = a.o z.o
> > LINK_LAST = f.o p.o
> >
> > But then what guarantees that 'a.o' will be linked before 'z.o'?

[kaos]
> LINK_FIRST is processed in the order it is specified, so a.o will be
> linked before z.o when both are present.  See the patch.

Indeed, the right solution is

  LINK_FIRST := a.o z.o f.o p.o

which is self-documenting, as Keith has said: by looking at that line,
the intended behavior is obvious.  You should still accompany this with
a comment explaining *why* the ordering is needed, but even if you
don't, you are giving us much more information than the status quo
(which is "this link order works, any other order is quite possibly
sane but who knows for sure").

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
