Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262230AbSJARCP>; Tue, 1 Oct 2002 13:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262216AbSJARB1>; Tue, 1 Oct 2002 13:01:27 -0400
Received: from dsl-213-023-043-077.arcor-ip.net ([213.23.43.77]:16028 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262152AbSJAQ6E>;
	Tue, 1 Oct 2002 12:58:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: qsbench, interesting results
Date: Tue, 1 Oct 2002 19:03:40 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@digeo.com>,
       Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0210011348060.653-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.44L.0210011348060.653-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wQQv-0005vB-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 18:52, Rik van Riel wrote:
> On Tue, 1 Oct 2002, Daniel Phillips wrote:
> > On Monday 30 September 2002 07:57, Andrew Morton wrote:
> > > I'll take a look at some preferential throttling later on.  But
> > > I must say that I'm not hugely worried about performance regression
> > > under wild swapstorms.  The correct fix is to go buy some more
> > > RAM, and the kernel should not be trying to cater for underprovisioned
> > > machines if that affects the usual case.
> >
> > The operative phrase here is "if that affects the usual case".
> > Actually, the quicksort bench is not that bad a model of a usual case,
> > i.e., a working set 50% bigger than RAM.
> 
> Having the working set of one process larger than RAM is
> a highly unusual case ...

No it's not, it's very similar to having several processes active whose
working sets add up to more than RAM.

> > The page replacement algorithm ought to do something sane with it,
> 
> ... page replacement ought to give this process less RAM
> because it isn't going to get enough to run anyway. No need
> to have a process like qsbench make other processes run
> slow, too.

It should run the process as efficiently as possible, given that there
isn't any competition.

> > and swap performance ought to be decent in general, since desktop users
> > typically have less than 1/2 GB.  With media apps, bloated desktops and
> > all, it doesn't go as far as it used to.
> 
> The difference there is that desktops don't have a working
> set larger than RAM. They've got a few (dozen?) of processes,
> each of which has a working set that easily fits in ram and
> a bunch of pages, or whole processes, which aren't currently
> in use.

Try loading a high res photo in gimp and running any kind of interesting
script-fu on it.  If it doesn't thrash, boot with half the memory and
repeat.

> In this situation the VM _can_ keep the whole working set in
> RAM, simply by evicting the stuff that's not in the working
> set.

We're not talking about that case.  Oh, by the way, since when did
it become ok to ignore corner cases?  I thought corner cases were what
users have been flaming us about for the last 2 or 3 years.

> > My impression is that page replacement just hasn't gotten a lot of
> > attention recently, and there is nothing wrong with that.  It's tuning,
> > not a feature.
> 
> As you write above, it's a pretty damn important feature,
> though.  One thing I'm experimenting with now for 2.4 rmap
> is to ignore the referenced bit and page age if a page is
> only in use by processes which haven't run recently, this
> should help the desktop (and university) workloads by
> swapping out memory from tasks which don't need it anyway
> at the moment.
> 
> There may be other modifications needed, too...

No doubt, and for the first time, we've got a solid base to build on.

-- 
Daniel
