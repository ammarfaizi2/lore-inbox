Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267943AbRG0RR3>; Fri, 27 Jul 2001 13:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268885AbRG0RRK>; Fri, 27 Jul 2001 13:17:10 -0400
Received: from ntt-connection.daiwausa.com ([210.175.188.3]:56621 "EHLO
	ead42.ead.dsa.com") by vger.kernel.org with ESMTP
	id <S267943AbRG0RQv>; Fri, 27 Jul 2001 13:16:51 -0400
Date: Fri, 27 Jul 2001 13:16:46 -0400
From: "Bill Rugolsky Jr." <rugolsky@ead.dsa.com>
To: Lawrence Greenfield <leg+@andrew.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010727131646.A16145@ead45>
In-Reply-To: <20010726174844.W17244@emma1.emma.line.org> <E15PnTJ-0003z0-00@the-village.bc.nu> <9jpftj$356$1@penguin.transmeta.com> <20010726095452.L27780@work.bitmover.com>, <20010726095452.L27780@work.bitmover.com> <996167751.209473.2263.nullmailer@bozar.algorithm.com.au> <3B60EDD3.2CE54732@zip.com.au> <200107271624.f6RGOu8U010566@acap-dev.nas.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200107271624.f6RGOu8U010566@acap-dev.nas.cmu.edu>; from leg+@andrew.cmu.edu on Fri, Jul 27, 2001 at 12:24:56PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 12:24:56PM -0400, Lawrence Greenfield wrote:
> I love it when I see things like:  "No, Linus is right and the MTA
> guys are just wrong."
> 
> This sort of attitude is just ridiculous.  Unix had a defined set of
> semantics.  This might have been stupid semantics, but it had them.
> Then journalling filesystems, softupdates, and Linux async updates
> came along and destroyed those semantics, preventing those of us who
> want to write reliable applications using the filesystem from doing
> so.  At least Oracle doesn't change the definition of COMMIT.

First off, would you care to quote chapter and verse of these
"defined semantics" ?   Do you mean the BSD source?

Traditional FFS/UFS achieves "safety" at a terrible cost to
performance.  I can barely stand the wait to untar XFree86 on Solaris8
on a PII-333, even with UFS logging -- I'd rather use my Pentium 166
laptop running Linux!  ext2 solved this performance issue many years
ago by recognizing that the FFS metadata scheme was not really safe
either; instead the intelligence was put into e2fsck, and where
necessary, the applications.  (Do I hear faint echoes of the
"lint" v. "cc" design criterion ... ?)

The infrastructure is now in place to solve these problems in ext3,
without imposing a least-common-denominator approach that degrades
overall system performance.  In these instances "Linus is right" when
he notes that (1) the proposed immediate solution does not really solve
the problem, and (2) once in there, developers will rely on its precise
semantics, making them difficult to get right later on, and providing
no incentive to do so.  In many such instances "undefined" behavior is
the best intermediate solution.

As one can see from the "gkernel-commit" traffic, Andrew Morton has
not only taken away useful information from this thread, he's already
halfway to a solution, in just a day, because  Matthias Andree took
the time to describe the functional requirements instead of just
whining that "it's not like BSD."
 
> Thus why all reasonably paranoid MTAs and other mail programs say "use
> chattr +S on ext2"---we need ordered metadata writes.

And that's precisely the type of thing we want -- unused features should
not impact the rest of the system.
 
Regards,

   Bill Rugolsky

