Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbSJUPUw>; Mon, 21 Oct 2002 11:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261399AbSJUPUv>; Mon, 21 Oct 2002 11:20:51 -0400
Received: from franka.aracnet.com ([216.99.193.44]:38105 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261384AbSJUPUu>; Mon, 21 Oct 2002 11:20:50 -0400
Date: Mon, 21 Oct 2002 08:21:50 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
Message-ID: <2577017645.1035188509@[10.10.2.3]>
In-Reply-To: <m1bs5nvo2r.fsf@frodo.biederman.org>
References: <m1bs5nvo2r.fsf@frodo.biederman.org>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> For reference, one of the tests was TPC-H.  My code reduced the number of
>> >> allocated pte_chains from 5 million to 50 thousand.
>> > 
>> > Don't tease, what did that do for performance? I see that someone has
>> > already posted a possible problem, and the code would pass for complex for
>> > most people, so is the gain worth the pain?
>> 
>> In many cases, this will stop the box from falling over flat on it's 
>> face due to ZONE_NORMAL exhaustion (from pte-chains), or even total
>> RAM exhaustion (from PTEs). Thus the performance gain is infinite ;-)
> 
> So why has no one written a pte_chain reaper?  It is perfectly sane
> to allocate a swap entry and move an entire pte_chain to the swap
> cache.  

I think the underlying subsystem does not easily allow for dynamic regeneration, so it's non-trivial. wli was looking at doing pagetable reclaim at some point, IIRC.

IMHO, it's better not to fill memory with crap in the first place than
to invent complex methods of managing and shrinking it afterwards. You
only get into pathalogical conditions under sharing situation, else 
it's limited to about 1% of RAM (bad, but manageable) ... thus providing
this sort of sharing nixes the worst of it. Better cache warmth on 
switches (for TLB misses), faster fork+exec, etc. are nice side-effects.

The ultimate solution is per-object reverse mappings, rather than per
page, but that's a 2.7 thingy now.

M.

