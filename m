Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262253AbSJARKU>; Tue, 1 Oct 2002 13:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262244AbSJARI7>; Tue, 1 Oct 2002 13:08:59 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:38809 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262246AbSJARIR>; Tue, 1 Oct 2002 13:08:17 -0400
Date: Tue, 1 Oct 2002 14:13:29 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@digeo.com>,
       Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: qsbench, interesting results
In-Reply-To: <E17wQQv-0005vB-00@starship>
Message-ID: <Pine.LNX.4.44L.0210011407480.653-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Daniel Phillips wrote:
> On Tuesday 01 October 2002 18:52, Rik van Riel wrote:

> > > The operative phrase here is "if that affects the usual case".
> > > Actually, the quicksort bench is not that bad a model of a usual case,
> > > i.e., a working set 50% bigger than RAM.
> >
> > Having the working set of one process larger than RAM is
> > a highly unusual case ...
>
> No it's not, it's very similar to having several processes active whose
> working sets add up to more than RAM.

It's similar, but not the same.  If you simply have too many
processes running at the same time we could fix the problem
with load control, reducing the number of running processes
until stuff fits in RAM.

With one process that needs 150% of RAM as its working set,
there simply is no way to win.


> > > The page replacement algorithm ought to do something sane with it,
> >
> > ... page replacement ought to give this process less RAM
> > because it isn't going to get enough to run anyway. No need
> > to have a process like qsbench make other processes run
> > slow, too.
>
> It should run the process as efficiently as possible, given that there
> isn't any competition.

If there is no competition I agree.  However, if the system has
something else running at the same time as qsbench I think the
system should make an effort to have _only_ qsbench thrashing
and not every other process in the system as well.


> > The difference there is that desktops don't have a working
> > set larger than RAM. They've got a few (dozen?) of processes,
> > each of which has a working set that easily fits in ram and
> > a bunch of pages, or whole processes, which aren't currently
> > in use.
>
> Try loading a high res photo in gimp and running any kind of interesting
> script-fu on it.  If it doesn't thrash, boot with half the memory and
> repeat.

But, should just the gimp thrash, or should every process on the
machine thrash ?


> > There may be other modifications needed, too...
>
> No doubt, and for the first time, we've got a solid base to build on.

This will help a lot in fine-tuning the VM.  I should do some more
procps work and extend vmstat to understand all the knew VM statistics
being exported in /proc...

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

