Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284657AbRLJX25>; Mon, 10 Dec 2001 18:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbRLJX2s>; Mon, 10 Dec 2001 18:28:48 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:65289 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284657AbRLJX2b>; Mon, 10 Dec 2001 18:28:31 -0500
Date: Mon, 10 Dec 2001 15:30:29 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Scheduler queue implementation ...
In-Reply-To: <20011210150342.C1124@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.40.0112101508190.1645-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001, Mike Kravetz wrote:

> On Sun, Dec 09, 2001 at 05:38:42PM -0800, Davide Libenzi wrote:
> > Coming at the pipe example, let's take Larry's lat_ctx ( lmbench ).
> > This is bouncing data through pipes using I/O bound tasks, and running
> > vmstat together with a lat_ctx 32 32 ... ( long list ), you'll see the run
> > queue length barley reach 3 ( with 32 bouncing tasks ).
> > It barely reaches 5 with 64 bouncing tasks.
>
> This may show my ignorance, but ... Why would one expect much
> more than 2 runnable tasks as a result of a running lat_ctx?
> This benchmark simply passes a token around a ring of tasks.
> One task awakens the next, then goes to sleep.  The only time
> you have more than one runnable task is during the times when
> the token is passed between tasks.  In these transition times
> I would rarely expect more than 2 tasks on the runqueue no
> matter how many bouncing tasks you have.
>
> We created a benchmark similar to lat_ctx that would allow you
> to control how many runnable tasks there are in the system.
> Look for 'Reflex' benchmark at:
> http://lse.sourceforge.net/scheduling/
> You can think of this as a controlled way of running multiple
> copies of lat_ctx in parallel.

Mike, this is not to criticize lat_ctx ( i'll do it later :) ) but is
started from an example that Alan made about processes bouncing data through pipes.
Talking about lat_ctx, it's a benchmark that you've to use 1) not to plot
latencies by having runqueue lengths on the x axis 2) only on UP systems (
take a look at the process distribution on SMP ).
I usually prefer to have a real measure of the scheduler latency and
having a real runqueue length to put on the x axis.
I cannot have this with lat_ctx because :

1) you'll never have a given rq len
2) numbers are bogus

If you've to show how the latency varies with the runqueue length you've
to have a benchmark that during the test shows that length.
That's why i prefer to use a cycle counter + the cpuhog program.
In that way i do not need to switch like a crazy ( and you're actually
going to measure warm cache performances ) to get the measure.
I can simply sample my system while it's switching "naturally" with my
system switch-load plus the cpuhog load on the runqueue.
So lat_ctx is basically a 1) simple 2) warm cache 3) UP 4) not rqlen
dependent, benchmark.




- Davide




