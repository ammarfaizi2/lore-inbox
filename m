Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279024AbRKIBVQ>; Thu, 8 Nov 2001 20:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279013AbRKIBVH>; Thu, 8 Nov 2001 20:21:07 -0500
Received: from [208.129.208.52] ([208.129.208.52]:23556 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S279003AbRKIBVB>;
	Thu, 8 Nov 2001 20:21:01 -0500
Date: Thu, 8 Nov 2001 17:29:25 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
In-Reply-To: <20011108170740.B14468@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.40.0111081718570.1501-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Mike Fedyk wrote:

> [cc trimed]
>
> On Thu, Nov 08, 2001 at 04:37:46PM -0800, Davide Libenzi wrote:
> > On Thu, 8 Nov 2001, Mike Fedyk wrote:
> >
> > > Ingo's patch in effect lowers the number of jiffies taken per second in the
> > > scheduler (by making each task use several jiffies).
> > >
> > > Davide's patch can take the default scheduler (even Ingo's enhanced
> > > scheduler) and make it per processor, with his extra layer of scheduling
> > > between individual processors.
> >
> > Don't mix things :)
> > We're talking only about the CpuHistory token of the scheduler proposed here:
> >
> > http://www.xmailserver.org/linux-patches/mss.html
> >
> > This is a bigger ( and not yet complete ) change on the SMP scheduler
> > behavior, while it keeps the scheduler that runs on each CPU the same.
> > I'm currently working on different balancing methods to keep the proposed
> > scheduler fair well balanced without spinning tasks "too much"(tm).
> >
> I've given your patch a try, and so far it looks promising.
>
> Running one niced copy of cpuhog on a 2x366 mhz celeron box did pretty well.
> Instead of switching several times in one second, it only switched a few
> times per minute.
>
> I was also able to merge it with just about everything else I was testing
> (ext3, freeswan, elevator updates, -ac) except for the preempt patch.  Well, I
> was able to manually merge it, but the cpu afinity broke.  (it wouldn't use
> the second processor for anything except for interrupt processing...)
>
> I haven't tried any of the other scheduler patches though.  MQ, looks
> interesting... :)
>
> All in all, I think xsched will have much more impact on performance.
> Simply because it tackles the problem of CPU affinity...
>
> Even comparing Ingo's patch to your CPU History patch isn't fair, because
> they attack different problems.  Yours of CPU affinity, Ingo's of time spent
> on individual tasks within a single processor.

xsched is not complete yet, it's a draft ( working draft :) ) that i'm
using to study a more heavy CPU tasks isolation on SMP systems.
I think that this is the way to go for a more scalable SMP scheduler.
I'm currently sampling the proposed scheduler with LatSched that gives a
very good picture of 1) process migration 2) _real_ scheduler latency
cycles cost.
The MQ scheduler has the same roots of the proposed one but has a longest
fast path due the try to make global scheduling decisions at every
schedule.
I'm in contact ( close contact coz we're both in Beaverton :) ) with IBM
guys to have the two scheduler tested on bigger machines if the proposed
scheduler will give some fruit.




- Davide


