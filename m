Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316994AbSEWTjO>; Thu, 23 May 2002 15:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316995AbSEWTjN>; Thu, 23 May 2002 15:39:13 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7176 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316994AbSEWTjM>; Thu, 23 May 2002 15:39:12 -0400
Date: Thu, 23 May 2002 15:34:06 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        William Lee Irwin III <wli@holomorphy.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org,
        andrea@suse.de, riel@surriel.com, akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
In-Reply-To: <Pine.LNX.4.44.0205231009430.1006-100000@home.transmeta.com>
Message-ID: <Pine.LNX.3.96.1020523152322.12605A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2002, Linus Torvalds wrote:

> 
> 
> On Thu, 23 May 2002, Bill Davidsen wrote:
> > On Wed, 22 May 2002, Linus Torvalds wrote:
> >
> > > Making the _generic_ code jump through hoops because some stupid special
> > > case that nobody else is interested in is bad.

> > Thoughts in no particular order:
> >  - set LPS based on a capability on the program
> >  - set LPS based on a flag of some nature on the file
> >  - set LPS based on the number of processes mapping the file
> >
> > I mention these because it would be nice to get better behaviour from
> > programs which aren't optimized for Linux and may never be.
> 
> One of the problems with LPS is that it simply _will_not_ be coherent with
> read/write and the regular page cache.
> 
> If you make the LPS decision on some process capability or other flag, you
> have to accept the mixing of small pages and large pages - because other
> processes that do _not_ have the capability will not get the LPS.
>
> And once you go there, you have not just started using different pages,
> you've changed the _semantics_ of the pages: they are no longer coherent
> with other processes accessing the same file.

That's the case with a capability, obviously, it's less clear that if you
had a flag on the file that could happen, since any processes doing a
mmap() on the file would get LPS.
 
> And that's ignoring the fact that the regular interfaces change in other
> ways, ie the alignment restrictions on mmap() etc change _radically_.

mmap() returns results codes, I personally would have no problem with a
program having to cope with getting one if that's what it takes. This
wasn't (and isn't) my issue, but it seems that Linux has been so clever in
other ways that it would be desirable to address the problems caused by
crappy application software.
 
> In other words, don't do it. It changes semantics, and because it changes
> semantics the program _has_ to be aware of it. In other words, the program
> has to be compiled for the behaviour.
> 
> Now, we can make those semantics _easier_ to use, so that the changes to
> existing programs are minimal. But changes there will be.

Then I hope someone gets the shared, paged or otherwise smaller entries
working, I suspect some of my machine have more memory in page tables than
user memory :-(_

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

