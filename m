Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbRE0RSj>; Sun, 27 May 2001 13:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262825AbRE0RSU>; Sun, 27 May 2001 13:18:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54153 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262822AbRE0RSL>;
	Sun, 27 May 2001 13:18:11 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15121.13986.987230.445825@pizda.ninka.net>
Date: Sun, 27 May 2001 10:17:22 -0700 (PDT)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] severe softirq handling performance bug, fix, 2.4.5
In-Reply-To: <20010527190700.H676@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0105261920030.3336-200000@localhost.localdomain>
	<20010527190700.H676@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Linus removed from the CC:, he wouldn't read any of this since
  he's in Japan currently :-)]

Andrea Arcangeli writes:
 > On Sat, May 26, 2001 at 07:59:28PM +0200, Ingo Molnar wrote:
 > > the two error cases are:
 > > 
 > >  #1 hard-IRQ interrupts user-space code, activates softirq, and returns to
 > >     user-space code
 > 
 > Before returning to userspace do_IRQ just runs do_softirq by hand from C
 > code.

Ok, someone agrees with me. :-)

 > >  #2 hard-IRQ interrupts the idle task, activates softirq and returns to
 > >     the idle task.
 > 
 > The problem only happens when we return to the idle task and a softirq
 > is been marked active again and we cannot keep running it or we risk to
 > soft deadlock.

I still fail to understand, won't the C code in do_IRQ() handle
this case as well?  What is so special about returning from an
interrupt to the idle task on x86?  And what about that special'ness
makes the code at the end of do_IRQ() magically not run?

In fact, with the do_IRQ() check _and_ the check in schedule() itself,
the only case entry.S has to really deal with is "end of system call"
which it does.

Andrea, I think you are talking about a deeper and different problem.
Specifically, a softirq that makes new softirqs happen, or something
like this.  Right?

Later,
David S. Miller
davem@redhat.com
