Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132338AbRDFTmF>; Fri, 6 Apr 2001 15:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132352AbRDFTl4>; Fri, 6 Apr 2001 15:41:56 -0400
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:16036 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S132338AbRDFTlt>; Fri, 6 Apr 2001 15:41:49 -0400
Date: Fri, 6 Apr 2001 12:40:36 -0700 (PDT)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>, <majer@endeca.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: memory allocation problems
In-Reply-To: <Pine.LNX.4.10.10104061433030.19450-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.30.0104061227240.25381-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2001, Mark Hahn wrote:

> note, though, that you *CAN* actually malloc a lot more than 1G: you
> just have to avoid causing mmaps that chop your VM at
> TASK_UNMAPPED_BASE:

Neat trick.  I didn't realize that you could avoid allocating the mmap()
buffers for stdin and stdout.

As was pointed out to me in January, another solution for i386 would be to
fix a maximum stack size and have the mmap() allocations grow downward
from the "top" of the stack (3GB - max stack size).  I'm not sure why that
is not currently done.

I once wrote a tiny patch to do this, and ran it successfully for a couple
days, but knowing so little about the kernel I probably did it in a
completely wrong, inefficient way.  For example, some of the vma
structures are sorted in increasing address order, and so perhaps to do
this properly one should change them to decreasing address order.

Cheers,
Wayne


