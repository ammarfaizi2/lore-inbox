Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129856AbRB0WlX>; Tue, 27 Feb 2001 17:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbRB0WlE>; Tue, 27 Feb 2001 17:41:04 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:6379 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129856AbRB0Wk4>; Tue, 27 Feb 2001 17:40:56 -0500
Message-ID: <3A9C2CE3.ABA1A6A6@uow.edu.au>
Date: Tue, 27 Feb 2001 22:40:35 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: timing out on a semaphore
In-Reply-To: <20010225224039.W13721@redhat.com> <3A9990EF.8D4ECF49@uow.edu.au> <20010227143942.C13721@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> On Sun, Feb 25, 2001 at 11:10:39PM +0000, Andrew Morton wrote:
> 
> > I think there might be a bogon in __down_interruptible's
> > handling of the semaphore state in this case.  I remember
> > spotting something a few months back but I can't immediately
> > remember what it was :(
> >
> > I'd suggest you slot a
> >
> >       sema_init(&port->physport->ieee1284.irq, 1);
> >
> > into parport_wait_event() prior to adding the timer.  If that
> > fixes it I'll go back through my patchpile, see if I can
> > resurrect that grey cell.
> 
> I haven't been able to confirm that it works around it (can't repeat
> the problem here), but what would you say if I said it did? ;-)

One of two things:

1: Your code is leaving the semaphore in a down'ed state
   somehow.

2: The semaphore code is leaving the semaphore in a funny
   state.

hmm.  I see from your other email that the sema_init() has 
made the problem go away.  Could you please review the code,
see if there's an imbalance somewhere?

What is parport_ieee1284_write_compat() trying to do with
the semaphore?  It will leave the semaphore in a downed
state.  Intentional?  Is this code actually being used
by the person who is having the problem?  Could this
loop be replaced by a simple sema_init()?

(As you can tell, I'm desparately avoiding having
to understand the semaphore code again :))

-
