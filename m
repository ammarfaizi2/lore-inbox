Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279035AbRKIBf1>; Thu, 8 Nov 2001 20:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279013AbRKIBfR>; Thu, 8 Nov 2001 20:35:17 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:36335
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279003AbRKIBfE>; Thu, 8 Nov 2001 20:35:04 -0500
Date: Thu, 8 Nov 2001 17:34:58 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
Message-ID: <20011108173458.C14468@mikef-linux.matchmail.com>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011108170740.B14468@mikef-linux.matchmail.com> <Pine.LNX.4.40.0111081718570.1501-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0111081718570.1501-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 05:29:25PM -0800, Davide Libenzi wrote:
> On Thu, 8 Nov 2001, Mike Fedyk wrote:
> 
> > [cc trimed]
> >
> > On Thu, Nov 08, 2001 at 04:37:46PM -0800, Davide Libenzi wrote:
> > > On Thu, 8 Nov 2001, Mike Fedyk wrote:
> > >
> > > > Ingo's patch in effect lowers the number of jiffies taken per second in the
> > > > scheduler (by making each task use several jiffies).
> > > >
> > > > Davide's patch can take the default scheduler (even Ingo's enhanced
> > > > scheduler) and make it per processor, with his extra layer of scheduling
> > > > between individual processors.
> > >
> > > Don't mix things :)
> > > We're talking only about the CpuHistory token of the scheduler proposed here:
> > >
> > > http://www.xmailserver.org/linux-patches/mss.html
> > >
> > > This is a bigger ( and not yet complete ) change on the SMP scheduler
> > > behavior, while it keeps the scheduler that runs on each CPU the same.
> > > I'm currently working on different balancing methods to keep the proposed
> > > scheduler fair well balanced without spinning tasks "too much"(tm).
> > >
> > I've given your patch a try, and so far it looks promising.
> >
> > Running one niced copy of cpuhog on a 2x366 mhz celeron box did pretty well.
> > Instead of switching several times in one second, it only switched a few
> > times per minute.
> >
> > I was also able to merge it with just about everything else I was testing
> > (ext3, freeswan, elevator updates, -ac) except for the preempt patch.  Well, I
> > was able to manually merge it, but the cpu afinity broke.  (it wouldn't use
> > the second processor for anything except for interrupt processing...)
> >
> > I haven't tried any of the other scheduler patches though.  MQ, looks
> > interesting... :)
> >
> > All in all, I think xsched will have much more impact on performance.
> > Simply because it tackles the problem of CPU affinity...
> >
> > Even comparing Ingo's patch to your CPU History patch isn't fair, because
> > they attack different problems.  Yours of CPU affinity, Ingo's of time spent
> > on individual tasks within a single processor.

Looking at that again, it could've been "Ingo's of intra-CPU time slice
length"... ;)

> xsched is not complete yet, it's a draft ( working draft :) ) that i'm

A pretty good draft, I'd say!

> using to study a more heavy CPU tasks isolation on SMP systems.
> I think that this is the way to go for a more scalable SMP scheduler.
> I'm currently sampling the proposed scheduler with LatSched that gives a
> very good picture of 1) process migration 2) _real_ scheduler latency
> cycles cost.

:)

> The MQ scheduler has the same roots of the proposed one but has a longest
> fast path due the try to make global scheduling decisions at every
> schedule.

Ahh, so that's why it hasn't been adopted...

> I'm in contact ( close contact coz we're both in Beaverton :) ) with IBM
> guys to have the two scheduler tested on bigger machines if the proposed
> scheduler will give some fruit.
>

>From what I've seen, it probably will...

I hope something like this will go into 2.5...

What do other unixes do in this case?  Are there any commercial Unixes that
have loose affinity like linux currently does?  What about NT?
