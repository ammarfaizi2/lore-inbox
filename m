Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287048AbSALPMA>; Sat, 12 Jan 2002 10:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287051AbSALPLv>; Sat, 12 Jan 2002 10:11:51 -0500
Received: from lilly.ping.de ([62.72.90.2]:1029 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S287048AbSALPLj>;
	Sat, 12 Jan 2002 10:11:39 -0500
Date: 12 Jan 2002 16:07:14 +0100
Message-ID: <20020112160714.A10847@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: "Robert Love" <rml@tech9.net>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        nigel@nrg.org, "Rob Landley" <landley@trommello.org>,
        "Andrew Morton" <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20020112121315.B1482@inspiron.school.suse.de>; from andrea@suse.de on Sat, Jan 12, 2002 at 12:13:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 12:13:15PM +0100, Andrea Arcangeli wrote:
> On Fri, Jan 11, 2002 at 03:33:22PM -0500, Robert Love wrote:
> > On Fri, 2002-01-11 at 07:37, Alan Cox wrote:
> > 
> > > Its more than a spinlock cleanup at that point. To do anything useful you have
> > > to tackle both priority inversion and some kind of at least semi-formal 
> > > validation of the code itself. At the point it comes down to validating the
> > > code I'd much rather validate rtlinux than the entire kernel
> > 
> > The preemptible kernel plus the spinlock cleanup could really take us
> > far.  Having locked at a lot of the long-held locks in the kernel, I am
> > confident at least reasonable progress could be made.
> > 
> > Beyond that, yah, we need a better locking construct.  Priority
> > inversion could be solved with a priority-inheriting mutex, which we can
> > tackle if and when we want to go that route.  Not now.
> > 
> > I want to lay the groundwork for a better kernel.  The preempt-kernel
> > patch gives real-world improvements, it provides a smoother user desktop
> > experience -- just look at the positive feedback.  Most importantly,
> > however, it provides a framework for superior response with our standard
> 
> I don't know how to tell you, positive feedback compared to mainline
> kernel is totally irrelevant, mainline has broken read/write/sendfile
> syscalls that can hang the machine etc... That was fixed ages ago in
> many ways, current way is very lightweight, if you can get positive
> feedback compared to -aa _that_ will matter.

Hello Andrea,

I did my usual compile testings (untar kernel archive, apply patches,
make -j<value> ...

Here are some results (Wall time + Percent cpu) for each of the consecutive five runs:

        13-pre5aa1      18-pre2aa2      18-pre3         18-pre3s        18-pre3sp
j100:   6:59.79  78%    7:07.62  76%        *           6:39.55  81%    6:24.79  83%
j100:   7:03.39  77%    8:10.04  66%        *           8:07.13  66%    6:21.23  83%
j100:   6:40.40  81%    7:43.15  70%        *           6:37.46  81%    6:03.68  87%
j100:   7:45.12  70%    7:11.59  75%        *           7:14.46  74%    6:06.98  87%
j100:   6:56.71  79%    7:36.12  71%        *           6:26.59  83%    6:11.30  86%

j75:    6:22.33  85%    6:42.50  81%    6:48.83  80%    6:01.61  89%    5:42.66  93%
j75:    6:41.47  81%    7:19.79  74%    6:49.43  79%    5:59.82  89%    6:00.83  88%
j75:    6:10.32  88%    6:44.98  80%    7:01.01  77%    6:02.99  88%    5:48.00  91%
j75:    6:28.55  84%    6:44.21  80%    9:33.78  57%    6:19.83  85%    5:49.07  91%
j75:    6:17.15  86%    6:46.58  80%    7:24.52  73%    6:23.50  84%    5:58.06  88%

* build incomplete (OOM killer killed several cc1 ... )

So far 2.4.13-pre5aa1 had been the king of the block in compile times.
But this has changed. Now the (by far) fastest kernel is 2.4.18-pre
+ Ingos scheduler patch (s) + preemptive patch (p). I did not test
preemptive patch alone so far since I don't know if the one I have
applies cleanly against -pre3 without Ingos patch. I used the
following patches:

s: sched-O1-2.4.17-H6.patch
p: preempt-kernel-rml-2.4.18-pre3-ingo-1.patch

I hope this info is useful to someone.

Kind regards,

   Jogi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
