Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282976AbRLIEna>; Sat, 8 Dec 2001 23:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282979AbRLIEnU>; Sat, 8 Dec 2001 23:43:20 -0500
Received: from zok.SGI.COM ([204.94.215.101]:57766 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S282976AbRLIEnG>;
	Sat, 8 Dec 2001 23:43:06 -0500
Date: Sat, 8 Dec 2001 20:44:37 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Jack Steiner <steiner@sgi.com>
cc: Dipankar Sarma <dipankar@in.ibm.com>, Niels Christiansen <nchr@us.ibm.com>,
        kiran@linux.ibm.com, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
In-Reply-To: <200112090346.VAA10532@fsgi055.americas.sgi.com>
Message-ID: <Pine.SGI.4.21.0112082027310.203252-100000@sam.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think Jack got his attribution wrong.  Which is good for me,
since I wrote what Jack just gently demolished <grin>.


On Sat, 8 Dec 2001, Jack Steiner wrote:

> I think it depends on whether the slab allocator manages
> memory by cpu or node. Since the number of cpus per node
> is rather small (<=8) for most NUMA systems, I would expect
> the slab allocator to manage by node.  Managing by cpu would
> likely add extra fragmentation and no real performance benefit.

I wasn't intending to suggest that the slab allocator manage by
cpu, rather than by node.  Pretty clearly, that would be silly.
Rather I was doing two things:

  1) Suggesting that if some code asking for memory wanted
     it on a node near to some cpu, that it not convert that
     cpu to a node _before_ the call, but rather, pass in the
     cpu, and let the called routine, kmem_cache_alloc_node()
     or renamed to kmem_cache_alloc_cpu() map the cpu to the
     node, inside the call.

  2) Suggesting (against common usage in the kernel, as Jack
     describes, so probably I'm tilting at wind mills) that
     we distinguish between nodes and and chunks of memory
     that I've started calling memory blocks.

I think (1) is sensible enough - the entire discussion leading
up to the code example involved getting memory near to some
cpu or other - so let the call state just that, and let the
details of translating to whatever units the slab allocator
works with be handled inside the call.  Don't make each
caller remember to perform a CPU_TO_NODE conversion - it's
just a little silly duplication of code (a kernel a few
bytes larger), a slightly less direct interface, and one
more detail to impose on each person coding such a call.

As to (2) I'd have to get Jack in a room with a white board, and
at this point, I'm placing no bets on what we would conclude
(well, actually I'd bet on Jack if forced ... his batting
average is pretty good ;).


                          I won't rest till it's the best ...
			  Manager, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

