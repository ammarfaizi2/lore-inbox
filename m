Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287141AbSALQHG>; Sat, 12 Jan 2002 11:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287149AbSALQG5>; Sat, 12 Jan 2002 11:06:57 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:21352 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287141AbSALQGp>; Sat, 12 Jan 2002 11:06:45 -0500
Date: Sat, 12 Jan 2002 17:05:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: jogi@planetzork.ping.de
Cc: Robert Love <rml@tech9.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        nigel@nrg.org, Rob Landley <landley@trommello.org>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020112170528.N1482@inspiron.school.suse.de>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020112160714.A10847@planetzork.spacenet>; from jogi@planetzork.ping.de on Sat, Jan 12, 2002 at 04:07:14PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 04:07:14PM +0100, jogi@planetzork.ping.de wrote:
> On Sat, Jan 12, 2002 at 12:13:15PM +0100, Andrea Arcangeli wrote:
> > On Fri, Jan 11, 2002 at 03:33:22PM -0500, Robert Love wrote:
> > > On Fri, 2002-01-11 at 07:37, Alan Cox wrote:
> > > 
> > > > Its more than a spinlock cleanup at that point. To do anything useful you have
> > > > to tackle both priority inversion and some kind of at least semi-formal 
> > > > validation of the code itself. At the point it comes down to validating the
> > > > code I'd much rather validate rtlinux than the entire kernel
> > > 
> > > The preemptible kernel plus the spinlock cleanup could really take us
> > > far.  Having locked at a lot of the long-held locks in the kernel, I am
> > > confident at least reasonable progress could be made.
> > > 
> > > Beyond that, yah, we need a better locking construct.  Priority
> > > inversion could be solved with a priority-inheriting mutex, which we can
> > > tackle if and when we want to go that route.  Not now.
> > > 
> > > I want to lay the groundwork for a better kernel.  The preempt-kernel
> > > patch gives real-world improvements, it provides a smoother user desktop
> > > experience -- just look at the positive feedback.  Most importantly,
> > > however, it provides a framework for superior response with our standard
> > 
> > I don't know how to tell you, positive feedback compared to mainline
> > kernel is totally irrelevant, mainline has broken read/write/sendfile
> > syscalls that can hang the machine etc... That was fixed ages ago in
> > many ways, current way is very lightweight, if you can get positive
> > feedback compared to -aa _that_ will matter.
> 
> Hello Andrea,
> 
> I did my usual compile testings (untar kernel archive, apply patches,
> make -j<value> ...
> 
> Here are some results (Wall time + Percent cpu) for each of the consecutive five runs:
> 
>         13-pre5aa1      18-pre2aa2      18-pre3         18-pre3s        18-pre3sp
> j100:   6:59.79  78%    7:07.62  76%        *           6:39.55  81%    6:24.79  83%
> j100:   7:03.39  77%    8:10.04  66%        *           8:07.13  66%    6:21.23  83%
> j100:   6:40.40  81%    7:43.15  70%        *           6:37.46  81%    6:03.68  87%
> j100:   7:45.12  70%    7:11.59  75%        *           7:14.46  74%    6:06.98  87%
> j100:   6:56.71  79%    7:36.12  71%        *           6:26.59  83%    6:11.30  86%
> 
> j75:    6:22.33  85%    6:42.50  81%    6:48.83  80%    6:01.61  89%    5:42.66  93%
> j75:    6:41.47  81%    7:19.79  74%    6:49.43  79%    5:59.82  89%    6:00.83  88%
> j75:    6:10.32  88%    6:44.98  80%    7:01.01  77%    6:02.99  88%    5:48.00  91%
> j75:    6:28.55  84%    6:44.21  80%    9:33.78  57%    6:19.83  85%    5:49.07  91%
> j75:    6:17.15  86%    6:46.58  80%    7:24.52  73%    6:23.50  84%    5:58.06  88%
> 
> * build incomplete (OOM killer killed several cc1 ... )
> 
> So far 2.4.13-pre5aa1 had been the king of the block in compile times.
> But this has changed. Now the (by far) fastest kernel is 2.4.18-pre
> + Ingos scheduler patch (s) + preemptive patch (p). I did not test
> preemptive patch alone so far since I don't know if the one I have
> applies cleanly against -pre3 without Ingos patch. I used the
> following patches:
> 
> s: sched-O1-2.4.17-H6.patch
> p: preempt-kernel-rml-2.4.18-pre3-ingo-1.patch
> 
> I hope this info is useful to someone.

the improvement of "sp" compared to "s" is quite visible, not sure how
can a little different time spent in kernel make such a difference on
the final numbers, also given compilation is mostly an userspace task, I
assume you were swapping out or running out of cache at the very least,
right?

btw, I'd be curious if you could repeat the same test with -j1 or -j2?
(actually real world)

Still the other numbers remains interesting for a trashing machine, but
a few percent difference with a trashing box isn't a big difference, vm
changes can infulence those numbers more than any preempt or scheduler
number (of course if my guess that you're swapping out is really right :).
I guess "p" helps because we simply miss some schedule point in some vm
routine. Hints?

Andrea
