Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276665AbRJGUCD>; Sun, 7 Oct 2001 16:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276659AbRJGUBx>; Sun, 7 Oct 2001 16:01:53 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23288 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S276653AbRJGUBi>; Sun, 7 Oct 2001 16:01:38 -0400
Message-ID: <3BC0B2E0.C6421F8F@mvista.com>
Date: Sun, 07 Oct 2001 12:54:08 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Mike Kravetz <kravetz@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Context switch times
In-Reply-To: <E15pFor-0004sC-00@fenrus.demon.nl> <200110042139.f94Ld5r09675@vindaloo.ras.ucalgary.ca> <20011004.145239.62666846.davem@redhat.com> <20011004175526.C18528@redhat.com> <9piokt$8v9$1@penguin.transmeta.com> <20011004164102.E1245@w-mikek2.des.beaverton.ibm.com> <20011005024526.E724@athlon.random> <20011004213507.B1032@w-mikek2.sequent.com> <20011007195928.D726@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Thu, Oct 04, 2001 at 09:35:07PM -0700, Mike Kravetz wrote:
> > [..] the pipe routines only call
> > the non-synchronous form of wake_up. [..]
> 
> Ok I see, I overlooked that when we don't need to block we wakeup-async.
> 
> So first of all it would be interesting to change the token passed
> thorugh the pipe so that it always fills in the PAGE_SIZE pipe buffer so
> that the task goes to sleep before reading from the next pipe in the
> ring.
> 
> And if we want to optimize the current benchmark (with the small token that
> triggers the async-wakeup and it always goes to sleep in read() rather
> than write()) we'd need to invalidate a basic point of the scheduler
> that have nothing to do with IPI reschedule, the point to invalidate is
> that if the current task (the one that is running wake_up()) has a small
> avg_slice we'd better not reschedule the wakenup task on a new idle cpu
> but we'd better wait the current task to go away instead. 

A couple of questions: 

1.) Do you want to qualify that the wake_up is not from an interrupt?

2.) Having done this AND the task doesn't block THIS time, do we wait
for the slice to end or is some other "dead man" timer needed?

George


Unless I'm
> missing something this should fix lmbench in its current implementation.
> 
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
