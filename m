Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278943AbRKIBID>; Thu, 8 Nov 2001 20:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278968AbRKIBHy>; Thu, 8 Nov 2001 20:07:54 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:53757
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278943AbRKIBHq>; Thu, 8 Nov 2001 20:07:46 -0500
Date: Thu, 8 Nov 2001 17:07:40 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
Message-ID: <20011108170740.B14468@mikef-linux.matchmail.com>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011108153749.A14468@mikef-linux.matchmail.com> <Pine.LNX.4.40.0111081632400.1501-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0111081632400.1501-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc trimed]

On Thu, Nov 08, 2001 at 04:37:46PM -0800, Davide Libenzi wrote:
> On Thu, 8 Nov 2001, Mike Fedyk wrote:
> 
> > Ingo's patch in effect lowers the number of jiffies taken per second in the
> > scheduler (by making each task use several jiffies).
> >
> > Davide's patch can take the default scheduler (even Ingo's enhanced
> > scheduler) and make it per processor, with his extra layer of scheduling
> > between individual processors.
> 
> Don't mix things :)
> We're talking only about the CpuHistory token of the scheduler proposed here:
> 
> http://www.xmailserver.org/linux-patches/mss.html
> 
> This is a bigger ( and not yet complete ) change on the SMP scheduler
> behavior, while it keeps the scheduler that runs on each CPU the same.
> I'm currently working on different balancing methods to keep the proposed
> scheduler fair well balanced without spinning tasks "too much"(tm).
> 
I've given your patch a try, and so far it looks promising.

Running one niced copy of cpuhog on a 2x366 mhz celeron box did pretty well.
Instead of switching several times in one second, it only switched a few
times per minute.

I was also able to merge it with just about everything else I was testing
(ext3, freeswan, elevator updates, -ac) except for the preempt patch.  Well, I
was able to manually merge it, but the cpu afinity broke.  (it wouldn't use
the second processor for anything except for interrupt processing...)

I haven't tried any of the other scheduler patches though.  MQ, looks
interesting... :)

All in all, I think xsched will have much more impact on performance.
Simply because it tackles the problem of CPU affinity...

Even comparing Ingo's patch to your CPU History patch isn't fair, because
they attack different problems.  Yours of CPU affinity, Ingo's of time spent
on individual tasks within a single processor.

Mike
