Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262080AbSJVDuB>; Mon, 21 Oct 2002 23:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbSJVDuB>; Mon, 21 Oct 2002 23:50:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3374 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262080AbSJVDuA>; Mon, 21 Oct 2002 23:50:00 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
References: <m1bs5nvo2r.fsf@frodo.biederman.org>
	<2577017645.1035188509@[10.10.2.3]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Oct 2002 21:54:21 -0600
In-Reply-To: <2577017645.1035188509@[10.10.2.3]>
Message-ID: <m17kgbuo0i.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> >> In many cases, this will stop the box from falling over flat on it's 
> >> face due to ZONE_NORMAL exhaustion (from pte-chains), or even total
> >> RAM exhaustion (from PTEs). Thus the performance gain is infinite ;-)
> > 
> > So why has no one written a pte_chain reaper?  It is perfectly sane
> > to allocate a swap entry and move an entire pte_chain to the swap
> > cache.  
> 
> I think the underlying subsystem does not easily allow for dynamic regeneration,
> so it's non-trivial. 

We swap pages out all of the time in 2.4.x, and that is all I was suggesting 
swap out some but not all of the pages, on a very long pte_chain.  And swapping
out a page is not terribly complex, unless something very drastic has changed.

> wli was looking at doing pagetable reclaim at some point,
> IIRC.
> 
> 
> IMHO, it's better not to fill memory with crap in the first place than
> to invent complex methods of managing and shrinking it afterwards. You
> only get into pathalogical conditions under sharing situation, else 
> it's limited to about 1% of RAM (bad, but manageable) ... thus providing
> this sort of sharing nixes the worst of it. Better cache warmth on 
> switches (for TLB misses), faster fork+exec, etc. are nice side-effects.

I will agree with that if everything works so the sharing happens,
this is a nice feature.

> The ultimate solution is per-object reverse mappings, rather than per
> page, but that's a 2.7 thingy now.
???

Last I checked we already had those in 2.4.x, and still in 2.5.x.  The
list of place the address space is mapped.

Eric

