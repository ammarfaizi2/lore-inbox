Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132640AbQLHUO0>; Fri, 8 Dec 2000 15:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132603AbQLHUOR>; Fri, 8 Dec 2000 15:14:17 -0500
Received: from frogger.telerama.com ([205.201.1.48]:33807 "EHLO
	frogger.telerama.com") by vger.kernel.org with ESMTP
	id <S132640AbQLHUOB>; Fri, 8 Dec 2000 15:14:01 -0500
Date: Fri, 8 Dec 2000 14:43:30 -0500 (EST)
From: Peter Berger <peterb@telerama.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Pthreads, linux, gdb, oh my! (fwd)
In-Reply-To: <E144RAj-0004BT-00@the-village.bc.nu>
Message-ID: <Pine.BSI.4.02.10012081344430.26743-100000@frogger.telerama.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000, Alan Cox wrote:
> > I have seen two failure modes:  on my machine (linux 2.2.5-22, glibc
> > 2.1.1), when run under gdb 5.0, the created pthreads stick around as
> glibc 2.1.1 definitely has problems with several bits of pthreads. You
> want 2.1.3 or higher I believe.

So you're saying that you got this to work?  Because I certainly couldn't
get it working with a higher version either.  I would really love a
positive ack from someone -- anyone -- that can get this working on any
version of linux, with any version of glibc.  Likewise, if there is
someone running a 'current' glibc who can verify for me that this fails, I
think that would be a useful datapoint.

> Its unlikely to be remotely kernel related
I'm not confident that we have enough data to make that assertion yet,
although I'm certainly willing to believe it!  Fortunately there are ways
of testing this (I suggest one below).
 
> tg->created may be out of date
  ... 
> You can create it, count it, then up tg->created out of order

Well, you're right, but this is picking lint.  Making this change (see
http://peterb.telerama.com/thread-test.c for the corrected version)
certainly doesn't make the problem go away (nor would I expect it to).

I apologize for my ignorance -- I frankly don't know the intricicies of
linux kernel development; all I know is I wrote what might be the simplest
of all possible concurrency tests and it is failing.  If someone could
point me to a version or combination of linux and glibc where it doesn't
fail, I'd be happy.

Glibc 2.2 (allegedly) works on both linux and the Hurd.  Are there any
readers of linux-kernel that are running hurd installations?  Could you
run my test program under gdb and see if it evinces the same behavior?
Assuming we see the same broken behavior on my linux box with glibc-2.2
(I'm compiling it now..), as on the Hurd box, we can presume it is a glibc
problem.  If it works on the Hurd but not on linux with the same glibc, we
can presume it is a linux problem. I'd do the Hurd test myself, but I
haven't yet played with Hurd enough (read: at all) to be confident that I
was setting up the test correctly.

Likewise if the problem magically goes away on my linux box once I use
glibc-2.2, I'll be sure to report back.

-Peter

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
