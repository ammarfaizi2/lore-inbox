Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269463AbRHWR7M>; Thu, 23 Aug 2001 13:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269436AbRHWR7C>; Thu, 23 Aug 2001 13:59:02 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:44298 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269390AbRHWR6s>; Thu, 23 Aug 2001 13:58:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: 2.4.8/2.4.9 problem
Date: Thu, 23 Aug 2001 20:05:24 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel <linux-kernel@vger.kernel.org>, riel@conectiva.com.br
In-Reply-To: <200108171310.PAA26032@lambik.cc.kuleuven.ac.be> <20010823144024Z16183-32384+397@humbolt.nl.linux.org> <20010823173920.652a175a.skraw@ithnet.com>
In-Reply-To: <20010823173920.652a175a.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010823175857Z16193-32384+411@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 23, 2001 05:39 pm, Stephan von Krawczynski wrote:
> On Thu, 23 Aug 2001 16:46:54 +0200
> Daniel Phillips <phillips@bonn-fries.net> wrote:
> 
> > Marcelo already posted a patch to fix this problem (bounce buffer 
allocation). 
> > Look under subject "Re: With Daniel Phillips Patch (was: aic7xxx with 
2.4.9 on
> > 7899P)" with a correction in his next post.
> 
> Aehm, Daniel, just to inform you: Marcelos patch does not solve the
> problem. I just proofed it here. Is completely the same with or without 
> patch.

That's because you have a different problem.  Marcelo's patch solves a
problem with bounce buffer allocation.  Your problem is a higher-order atomic 
allocation, very different.  Now lets take a close look at it and try to kill 
it.

> I tried another thing which might be interesting. I think your opinion is 
> that page_launder gives you free memory if available when the system runs 
> short. But it does not. I tried the following:
> DEF_PRIORITY in vmscan.c set to 0. This should come out as page_launder 
> doing the complete pagelist over in search of free pages. And guess what: 
> it does not find enough to keep the system running. In other words: at 
> least the search strategy in page_launder is broken, too. I can see 500 
> Megs of Inact_dirty mem, but page_launder cannot find enough clean ones to 
> keep a simple filecopy running.
> Any ideas left.

It's not a simple filecopy, it involves nfs, if I recall correctly.  Or maybe 
you have a different test case now?  Could you please (re)summarize the 
conditions that cause the allocation failures, and supply the rest of the 
information you consider relevant.

Could you please also list the problems that remain if you remove the 
"allocation failed" kprint completely.

--
Daniel
