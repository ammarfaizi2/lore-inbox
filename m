Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286151AbRLJDFJ>; Sun, 9 Dec 2001 22:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286154AbRLJDE7>; Sun, 9 Dec 2001 22:04:59 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:30735 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286151AbRLJDEl>; Sun, 9 Dec 2001 22:04:41 -0500
Date: Sun, 9 Dec 2001 19:06:35 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Scheduler queue implementation ...
In-Reply-To: <E16DFcV-0000E0-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0112091839590.996-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001, Alan Cox wrote:

> > vmstat together with a lat_ctx 32 32 ... ( long list ), you'll see the run
> > queue length barley reach 3 ( with 32 bouncing tasks ).
> > It barely reaches 5 with 64 bouncing tasks.
>
> Try 250 apache server processes running a mix of mod_perl and static
> content, you'll see quite a reasonable queue size then, and it isnt all
> cpu hogs.

For I/O bound, in this case ( since i use the average run time to weighs
the scheduler latency ), i mean tasks that runs for a very short time
before being rescheduled.
mod_perl is quite heavy from a cpu point of view and the static content,
as soon it becomes to be cached, will result in unblocking IO.
Since very likely even the HTTP response is going to be eaten by the
network layer w/out preemption, you're going to have a cpu path starting
from the HTTP request receiving from the next request fetch, that is very
likely run w/out preemption.


> Interesting question however. I certainly can't disprove your belief that
> the queue will be short enough to be worth using multiqueue for the case
> where its a queue per processor.

My point is, when the scheduler latency is going to have an impact on the
run task ?
When the average run time of the task is low.
But run time low means high dynamic priority ( counter ) that is
accumulated in consecutive recalc loops.
By having a tunable trigger point ( counter ) for task classification
( iobound-rttask or cpubound queue selection ) will make it possible to
have a runtime tuning of its value.




- Davide




