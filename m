Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSHGUql>; Wed, 7 Aug 2002 16:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSHGUqk>; Wed, 7 Aug 2002 16:46:40 -0400
Received: from dsl-213-023-022-051.arcor-ip.net ([213.23.22.51]:62635 "EHLO
	starship") by vger.kernel.org with ESMTP id <S312619AbSHGUqH>;
	Wed, 7 Aug 2002 16:46:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] Rmap speedup
Date: Wed, 7 Aug 2002 22:51:14 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com,
       Rik van Riel <riel@conectiva.com.br>
References: <E17aiJv-0007cr-00@starship> <E17cXFM-0004si-00@starship> <3D518451.812ED63F@zip.com.au>
In-Reply-To: <3D518451.812ED63F@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17cXlz-0004y0-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 August 2002 22:34, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > On Wednesday 07 August 2002 21:40, Andrew Morton wrote:
> > > Daniel Phillips wrote:
> > > > What stands out for me is that rmap is now apparently at parity with
> > > > (virtual scanning) 2.4.19 for a real application, i.e., parallel make.
> > > > I'm sure we'll still see the raw setup/teardown overhead if we make a
> > > > point of going looking for it, but it would be weird if we didn't.
> > > >
> > > > So can we tentatively declare victory of the execution overhead issue?
> > >
> > > err, no.  It's still adding half a millisecond or so to each fork/exec/exit
> > > cycle.  And that is arising from, apparently, an extra two cache misses
> > > per page.  Doubt if we can take this much further.
> > 
> > But that overhead did not show up in the kernel build timings you posted,
> > which do a realistic amount of forking.  So what is the worry, exactly?
> 
> Compilation is compute-intensive, not fork-intensive.  Think shell
> scripts, arch, forking servers, ...

OK, so what is an example of a real application that does tons of forking?
We need to get numbers for that.  We also need to compare such numbers to
the supposed advantage in swapping.

> > > Is it useful to instantiate the swapped-in page into everyone's
> > > pagetables, save some minor faults?
> > 
> > That's what I was thinking, then we just have to figure out how to find
> > all those swapped-out ptes efficiently.
> 
> page->pte?

Problem: we went and gave away the page when we swapped it out, but yes,
we could save the pte chain somewhere and maybe that's a win.  It would
eat memory just when we're trying to get some back, though.

> It may be a net loss for high sharing levels.  Dunno.

High sharing levels are exactly where the swap-in problem is going to
rear its ugly head.

-- 
Daniel
