Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286262AbSALNZt>; Sat, 12 Jan 2002 08:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286311AbSALNZj>; Sat, 12 Jan 2002 08:25:39 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:53517 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S286262AbSALNZW>; Sat, 12 Jan 2002 08:25:22 -0500
Message-ID: <3C40392F.C4E1EFF3@linux-m68k.org>
Date: Sat, 12 Jan 2002 14:25:03 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Rob Landley <landley@trommello.org>, Robert Love <rml@tech9.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com> <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there> <20020111220051.A2333@hq.fsmlabs.com> <3C4023A2.8B89C278@linux-m68k.org> <20020112052802.A3734@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

yodaiken@fsmlabs.com wrote:

> > > SCHED_FIFO leads to
> > >                 niced app 1 in K mode gets Sem A
> > >                 SCHED_FIFO app prempts and blocks on  Sem A
> > >                 whoops! app 2 in K more preempts niced app 1
> >
> > Please explain what's different without the preempt patch.
> 
> See that "preempt" in line 2 . Linux does not
> preempt kernel mode processes otherwise. The beauty of the
> non-preemptive kernel is that "in K mode every process makes progress"
> and even the "niced app" will complete its use of SemA and
> release it in one run.

The point of using semaphores is that one can sleep while holding them,
whether this is forced by preemption or voluntary makes no difference.

> If you have a reasonably fair scheduler you
> can make very useful analysis with Linux now of the form
>
>         Under 50 active proceses in the system means that in every
>         2 second interval every process
>         will get at least 10ms of time to run.
> 
> That's a very valuable property and it goes away in a preemptive kernel
> to get you something vague.

How is that changed? AFAIK inserting more schedule points does not
change the behaviour of the scheduler. The niced app will still get its
time.

> So your argument is that I'm advocating Andrew Morton's patch which
> reduces latencies more than the preempt patch because I have a
> financial interest in not reducing latencies? Subtle.

Andrew's patch requires constant audition and Andrew can't audit all
drivers for possible problems. That doesn't mean Andrew's work is
wasted, since it identifies problems, which preempting can't solve, but
it will always be a hunt for the worst cases, where preempting goes for
the general case.

> In any case, motive has no bearing on a technical argument.
> Your motive could be to make the 68K look better by reducing
> performance on other processors for all I know.

I am more than busy to keep it running (together with a few others, who
are left) and more important I make no money of it.

bye, Roman
