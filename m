Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136073AbRD0PGd>; Fri, 27 Apr 2001 11:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136078AbRD0PGY>; Fri, 27 Apr 2001 11:06:24 -0400
Received: from oe23.law11.hotmail.com ([64.4.16.80]:32518 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S136073AbRD0PGK>;
	Fri, 27 Apr 2001 11:06:10 -0400
X-Originating-IP: [12.19.166.64]
From: "Dan Mann" <daniel_b_mann@hotmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0104270848530.425-100000@mikeg.weiden.de>
Subject: Re: #define HZ 1024 -- negative effects?
Date: Fri, 27 Apr 2001 11:06:03 -0400
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Message-ID: <OE23nsnRzHXvXFskwcO00004413@hotmail.com>
X-OriginalArrivalTime: 27 Apr 2001 15:06:03.0061 (UTC) FILETIME=[93718E50:01C0CF2B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When you change the #define HZ setting in param.h, what effect does that
have on the CLOCKS_PER_SEC?  Are you really going to get a different amount
of slice time or is the is there another kernel source file (timex.h) that
just puts you back anyway?


Dan
----- Original Message -----
From: "Mike Galbraith" <mikeg@wen-online.de>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Sent: Friday, April 27, 2001 6:04 AM
Subject: Re: #define HZ 1024 -- negative effects?


> > > I have not tried it, but I would think that setting HZ to 1024
> > > should make a big improvement in responsiveness.
> > >
> > > Currently, the time slice allocated to a standard Linux
> > > process is 5*HZ, or 50ms when HZ is 100.  That means that you
> > > will notice keystrokes being echoed slowly in X when you have
> > > just one or two running processes,
> >
> > Rubbish.  Whenever a higher-priority thread than the current
> > thread becomes runnable the current thread will get preempted,
> > regardless of whether its timeslices is over or not.
>
> (hmm.. noone mentioned this, and it doesn't look like anyone is
> going to volunteer to be my proxy [see ionut's .sig].  oh well)
>
> What about SCHED_YIELD and allocating during vm stress times?
>
> Say you have only two tasks.  One is the gui and is allocating,
> the other is a pure compute task.  The compute task doesn't do
> anything which will cause preemtion except use up it's slice.
> The gui may yield the cpu but the compute job never will.
>
> (The gui won't _become_ runnable if that matters.  It's marked
> as running, has yielded it's remaining slice and went to sleep..
> with it's eyes open;)
>
> Since increasing HZ reduces timeslice, the maximum amount of time
> that you can yield is also decreased.  In the above case, isn't
> it true that changing HZ from 100 to 1000 decreases sleep time
> for the yielder from 50ms to 5ms if the compute task is at the
> start of it's slice when the gui yields?
>
> It seems likely that even if you're running a normal mix of tasks,
> that the gui, big fat oinker that the things tend to be, will yield
> much more often than the slimmer tasks it's competing with for cpu
> because it's likely allocating/yielding much more often.
>
> It follows that increasing HZ must decrease latency for the gui if
> there's any vm stress.. and that's the time that gui responsivness
> complaints usually refer to.  Throughput for yielding tasks should
> also increase with a larger HZ value because the number of yields
> is constant (tied to the number of allocations) but the amount of
> cpu time lost per yield is smaller.
>
> Correct?
>
> (if big fat tasks _don't_ generally allocate more than slim tasks,
> my refering to ionuts .sig was most unfortunate.  i hope it's safe
> to assume that you can't become that obese without eating a lot;)
>
>   -Mike
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
