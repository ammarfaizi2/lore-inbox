Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131212AbQKYTgd>; Sat, 25 Nov 2000 14:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131587AbQKYTgX>; Sat, 25 Nov 2000 14:36:23 -0500
Received: from mailc.telia.com ([194.22.190.4]:18633 "EHLO mailc.telia.com")
        by vger.kernel.org with ESMTP id <S131212AbQKYTgJ>;
        Sat, 25 Nov 2000 14:36:09 -0500
From: Roger Larsson <roger.larsson@norran.net>
Date: Sat, 25 Nov 2000 20:03:49 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <00112516072500.01122@dox> <Pine.LNX.4.21.0011251547210.8818-100000@duckman.distro.conectiva> <20001125183036.Q2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20001125183036.Q2272@parcelfarce.linux.theplanet.co.uk>
Subject: Re: *_trylock return on success?
MIME-Version: 1.0
Message-Id: <00112520034902.01122@dox>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 November 2000 19:30, Philipp Rumpf wrote:
> On Sat, Nov 25, 2000 at 03:49:25PM -0200, Rik van Riel wrote:
> > On Sat, 25 Nov 2000, Roger Larsson wrote:
> > > Questions:
> > >   What are _trylocks supposed to return?
> >
> > It depends on the type of _trylock  ;(
> >
> > >   Does spin_trylock and down_trylock behave differently?
> > >   Why isn't the expected return value documented?
> >
> > The whole trylock stuff is, IMHO, a big mess. When you
> > change from one type of trylock to another, you may be
> > forced to invert the logic of your code since the return
> > code from the different locks is different.
> >
> > For bitflags, for example, the trylock returns the state
> > the bit had before the lock (ie. 1 if the thing was already
> > locked).
>
> I assume you're talking about test_and_{set,clear}_bit here.  Their return
> value isn't consistent with the other _trylock functions since they're not
> _trylock functions.
>
> I think the real problem is that people use test_and_set_bit for locks,
> which is almost never[1] a good idea.  The overhead for a semaphore
> shouldn't be too much in most cases, and that way it is obvious what you
> want to do - and, hopefully, even more obvious if you end up with a
> semaphore that can be turned into a spinlock without further changes.
>
> > For spinlocks, it'll probably return something else ;/
>
> _trylock functions return 0 for success.

Not   spin_trylock

Simple example code from
code from include/asm-mips/spinlock.h:65
#define spin_trylock(lock) (!test_and_set_bit(0,(lock)))

/RogerL

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
--
Home page:
  http://www.norran.net/nra02596/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
