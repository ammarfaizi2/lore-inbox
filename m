Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbSJXKo6>; Thu, 24 Oct 2002 06:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265388AbSJXKo6>; Thu, 24 Oct 2002 06:44:58 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54280 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265385AbSJXKo5>; Thu, 24 Oct 2002 06:44:57 -0400
Date: Thu, 24 Oct 2002 06:50:43 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave McCracken <dmccr@us.ibm.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
In-Reply-To: <188940000.1035314478@baldur.austin.ibm.com>
Message-ID: <Pine.LNX.3.96.1021024064536.14473B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, Dave McCracken wrote:

> 
> --On Tuesday, October 22, 2002 12:02:27 -0700 "Martin J. Bligh"
> <mbligh@aracnet.com> wrote:
> 
> 
> >Bill Davidsen wrote:
> >> I'm just trying to decide what this might do for a news server with
> >> hundreds of readers mmap()ing a GB history file. Benchmarks show the 2.5
> >> has more latency the 2.4, and this is likely to make that more obvious.
> > 
> > On the other hand, I don't think shared pagetables have an mmap hook,
> > though that'd be easy enough to add. And if you're not reading the whole 
> > history file, presumably the PTEs will only be sparsely instantiated
> > anyway.
> 
> Actually shared page tables work on any shared memory area, no matter how
> it was created.  When a page fault occurs and there's no pte page already
> allocated (the common case for any newly mapped region) it checks the vma
> to see if it's shared.  If it's shared, it gets the address_space for that
> vma, then walks through all the shared vmas looking for one that's mapped
> at the same address and offset and already has a pte page that can be
> shared.

That's more encouraging.
 
> So if your history file is mapped at the same address for all your
> processes then it will use shared page tables.  While it might be a nice
> add-on to allow sharing if they're mapped on the same pte page boundary,
> that doesn't seem likely enough to justify the extra work.

The reader processes are either forked (INN w/ daemon nnrpd) or pthreads
(twister, earthquake, diablo). So everything will be the same.

Another thought, how does this play with NUMA systems? I don't have the
problem, but presumably there are implications.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

