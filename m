Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132392AbRDFUJU>; Fri, 6 Apr 2001 16:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132395AbRDFUJK>; Fri, 6 Apr 2001 16:09:10 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:20348 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S132392AbRDFUIv>; Fri, 6 Apr 2001 16:08:51 -0400
Date: Fri, 6 Apr 2001 16:08:25 -0400 (EDT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: Wayne Whitney <whitney@math.berkeley.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: memory allocation problems
In-Reply-To: <Pine.LNX.4.30.0104061227240.25381-100000@mf1.private>
Message-ID: <Pine.LNX.4.10.10104061544360.19450-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > note, though, that you *CAN* actually malloc a lot more than 1G: you
> > just have to avoid causing mmaps that chop your VM at
> > TASK_UNMAPPED_BASE:
> 
> Neat trick.  I didn't realize that you could avoid allocating the mmap()
> buffers for stdin and stdout.

noone ever said you had to use stdio.  or even use libc, for that matter!

> As was pointed out to me in January, another solution for i386 would be to
> fix a maximum stack size and have the mmap() allocations grow downward
> from the "top" of the stack (3GB - max stack size).  I'm not sure why that
> is not currently done.

problems get fixed when there's some pain involved: people bumping 
into a limit, or painfully bad code, etc.  not enough people are 
feeling any pain about the current design.

this (and the "move TASK_UNMAPPED_BASE" workaround) have been known
for years; I think someone even coded up a "grow vmareas down" patch
the last time we all discussed this.

> I once wrote a tiny patch to do this, and ran it successfully for a couple
> days, but knowing so little about the kernel I probably did it in a
> completely wrong, inefficient way.  For example, some of the vma
> structures are sorted in increasing address order, and so perhaps to do
> this properly one should change them to decreasing address order.

oh, I guess you did the patch ;)
seriously, resubmit it when 2.5 opens up.  the fact is that we currently
have two things that grow up, and one that grows down.  so obviously,
one up-grower must have an arbitrary limit.  switching vma's to down-growing
is a good solution, since it's actually *good* to limit stack growth.  
I wonder whether fortraners still put all their data on the stack;
they wouldn't be happy ;)

a simple workaround would be to turn TASK_UNMAPPED_AREA into a variable,
either system-wide or thread-specific (like ia64 already has!).  that's 
compatible with the improved vmas-down approach, too.

regards, mark hahn.

