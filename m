Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311342AbSCLUpk>; Tue, 12 Mar 2002 15:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311343AbSCLUpV>; Tue, 12 Mar 2002 15:45:21 -0500
Received: from dsl-213-023-043-170.arcor-ip.net ([213.23.43.170]:26755 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311342AbSCLUpT>;
	Tue, 12 Mar 2002 15:45:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: [CFT] delayed allocation and multipage I/O patches for 2.5.6.
Date: Tue, 12 Mar 2002 21:40:02 +0100
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C8D9999.83F991DB@zip.com.au> <E16kkID-0001qr-00@starship> <3C8E6544.1AE28413@zip.com.au>
In-Reply-To: <3C8E6544.1AE28413@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16kt3y-0000BL-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 12, 2002 09:29 pm, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > On March 12, 2002 07:00 am, Andrew Morton wrote:
> > >   Identifies readahead thrashing.
> > >
> > >     Currently, it just performs a shrink on the readahead window when thrashing
> > >     occurs.  This greatly reduces the amount of pointless I/O which we perform,
> > >     and will reduce the CPU load.  The idea is that the readahead window
> > >     dynamically adjusts to a sustainable size.  It improves things, but not
> > >     hugely, experimentally.
> > 
> > The question is, does it wipe out a nasty corner case?  If so then the improvement
> > for the averge case is just a nice fringe benefit.  A carefully constructed test
> > that triggers the corner case would be most interesting.
> 
> There are many test scenarios.  The one I use is:
> 
> - 64 megs of memory.
> 
> - Process A loops across N 10-megabyte files, reading 4k from each one
>   and terminates when all N files are fully read.
> 
> - Process B loops, repeatedly reading a one gig file off another disk.
> 
> The total wallclock time for process A exhibits *massive* step jumps
> as you vary N.  In stock 2.5.6 the runtime jumps from 40 seconds to
> ten minutes when N is increased from 40 to 60.
> 
> With my changes, the rate of increase of runtime-versus-N is lower,
> and happens at later N.  But it's still very sudden and very bad.
> 
> Yes, it's a known-and-nasty corner case.  Worth fixing if the
> fix is clean.  But IMO the problem is not common enough to
> justify significantly compromising the common case.

It's a given the common case should be optimal.  I'm sure there's an algorithm that
fixes up your test case, which by the way isn't that uncommon - it's Rik's '100 ftp
processes' case.  I'll buy the suggestion it isn't common enough to drop everything
right now and go fix it.

-- 
Daniel
