Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131222AbQKYVi1>; Sat, 25 Nov 2000 16:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131529AbQKYViV>; Sat, 25 Nov 2000 16:38:21 -0500
Received: from maild.telia.com ([194.22.190.3]:17929 "EHLO maild.telia.com")
        by vger.kernel.org with ESMTP id <S131222AbQKYViF>;
        Sat, 25 Nov 2000 16:38:05 -0500
From: Roger Larsson <roger.larsson@norran.net>
Date: Sat, 25 Nov 2000 22:05:06 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nigel Gamble <nigel@nrg.org>
To: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>,
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <00112516072500.01122@dox> <00112520034902.01122@dox> <20001125192214.R2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20001125192214.R2272@parcelfarce.linux.theplanet.co.uk>
Subject: Re: *_trylock return on success?
MIME-Version: 1.0
Message-Id: <00112522050600.01096@dox>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 November 2000 20:22, Philipp Rumpf wrote:
> On Sat, Nov 25, 2000 at 08:03:49PM +0100, Roger Larsson wrote:
> > > _trylock functions return 0 for success.
> >
> > Not   spin_trylock
>
> Argh, I missed the (recent ?) change to make x86 spinlocks use 1 to mean
> unlocked.  You're correct, and obviously this should be fixed.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

If this are to change in 2.4 I would suggest
to renaming it to mutex_lock (as in Nigels preemptive kernel patch)

Why?

A) the name spin_lock describes how the function is implemented and not
    the intended purpose.
B) with a preemptive kernel we will have more than four intended purposes:
    1) SMP - spin_lock, prevent two processors to run currently
    2) UP    - not used, code can only be executed by one thread.
    3) PREEMTIVE - lock a region for preemption to avoid concurrent execution.
    4) debug - addition of debug checks.

With Nigels patch most are changed, with some additional stuff...

My suggestion, change the name to mutex_lock and negate let mutex_trylock
follow the example of other _trylocks (returning 0 for success).

Ok?

If it is ok, I can prepare a patch (earliest monday)

/RogerL
-- 
Home page:
  http://www.norran.net/nra02596/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
