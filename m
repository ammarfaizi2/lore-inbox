Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262179AbSJAQrT>; Tue, 1 Oct 2002 12:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262178AbSJAQrS>; Tue, 1 Oct 2002 12:47:18 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:29332 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262175AbSJAQrJ>; Tue, 1 Oct 2002 12:47:09 -0400
Date: Tue, 1 Oct 2002 13:52:25 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@digeo.com>,
       Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: qsbench, interesting results
In-Reply-To: <E17wNeG-0005th-00@starship>
Message-ID: <Pine.LNX.4.44L.0210011348060.653-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Daniel Phillips wrote:
> On Monday 30 September 2002 07:57, Andrew Morton wrote:
> > I'll take a look at some preferential throttling later on.  But
> > I must say that I'm not hugely worried about performance regression
> > under wild swapstorms.  The correct fix is to go buy some more
> > RAM, and the kernel should not be trying to cater for underprovisioned
> > machines if that affects the usual case.
>
> The operative phrase here is "if that affects the usual case".
> Actually, the quicksort bench is not that bad a model of a usual case,
> i.e., a working set 50% bigger than RAM.

Having the working set of one process larger than RAM is
a highly unusual case ...

> The page replacement algorithm ought to do something sane with it,

... page replacement ought to give this process less RAM
because it isn't going to get enough to run anyway. No need
to have a process like qsbench make other processes run
slow, too.


> and swap performance ought to be decent in general, since desktop users
> typically have less than 1/2 GB.  With media apps, bloated desktops and
> all, it doesn't go as far as it used to.

The difference there is that desktops don't have a working
set larger than RAM. They've got a few (dozen?) of processes,
each of which has a working set that easily fits in ram and
a bunch of pages, or whole processes, which aren't currently
in use.

In this situation the VM _can_ keep the whole working set in
RAM, simply by evicting the stuff that's not in the working
set.

> My impression is that page replacement just hasn't gotten a lot of
> attention recently, and there is nothing wrong with that.  It's tuning,
> not a feature.

As you write above, it's a pretty damn important feature,
though.  One thing I'm experimenting with now for 2.4 rmap
is to ignore the referenced bit and page age if a page is
only in use by processes which haven't run recently, this
should help the desktop (and university) workloads by
swapping out memory from tasks which don't need it anyway
at the moment.

There may be other modifications needed, too...


regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

