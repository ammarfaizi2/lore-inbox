Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288658AbSAIRF4>; Wed, 9 Jan 2002 12:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288763AbSAIRFs>; Wed, 9 Jan 2002 12:05:48 -0500
Received: from maila.telia.com ([194.22.194.231]:43976 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S288658AbSAIRFi>;
	Wed, 9 Jan 2002 12:05:38 -0500
Message-Id: <200201091705.g09H5YQ25146@maila.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: arjanv@redhat.com, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Wed, 9 Jan 2002 18:02:53 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <000a01c19917$0b567ec0$0501a8c0@psuedogod> <20020109152717.J1543@inspiron.school.suse.de> <3C3C58E0.EB1333F0@redhat.com>
In-Reply-To: <3C3C58E0.EB1333F0@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday den 9 January 2002 15.51, Arjan van de Ven wrote:
> Andrea Arcangeli wrote:
> > On Wed, Jan 09, 2002 at 09:07:55AM -0500, Ed Sweetman wrote:
> > > Ok so the medicine is worse than the disease.   I take it that you only
> > > want some key points made for rescheduling instead of the full preempt
> > > patch by Robert.   That seems logical enough.   The only issue i see is
> > > that for the
> >
> > My ideal is to have the kernel to be as low worst latency as -preempt,
> > but without being preemptive. that's possible to achieve, I don't think
> > we're that far.
> >
> > mean latency is another matter, but I personally don't mind about mean
> > latency and I much prefer to save cpu cycles instead.
>
> hear hear!
>
> The akpm patch is achieving a MUCH better latency than pure -preempt,
> and only has 40
> or so coded preemption points instead of a few hundred (eg every
> spin_unlock)....

The difference is that the preemptive kernel mostly uses existing 
infrastructure. When SMP scalability gets better due to holding locks
for a shorter time then the preemptive kernel will improve as well!

AND it can be used on a UP computer to "simulate" SMP and that
should help the quality of the total code base...

This is my idea:
* Add the preemptive kernel
* "Remove" reschedule points from main kernel.
   note: that reschedule points that does nothing more than
   test and schedule can be NOOPed since they will never trigger in a
   preemptive kernel...

>
> and if with 40 we can get <= 1ms then everybody will be happy; if you
> want, say, 50 usec
> latency instead you need RTLinux anyway. With 1ms _worst case_ latency
> the "mean" latency
> is obviously also very good.......

Worst case latency... is VERY hard to prove if you rely on schedule points.
Since they are typically added after the fact...
If the code suddenly end up on a road less travelled...

With preemptive kernel your worst latency is the longest held spinlock. 
PERIOD.
(you can of cause be delayed by an even higher priority process)
* Make sure that there are no "infinite" loops inside any spinlock.

"infinite" == over ALL or ALL/x of something since someone, somewere
 will have ALL close to infinite... (infinity/x is still infinity... :-)
   example code is looping through LRU list to find a victim page...
   once it was not infinite due to the small number of pages...

Note: that akpm patches usually hava a - "do not do this list" with known
problem spots (ok, usually in a hard to break spinlocks).

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

