Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSJVFzA>; Tue, 22 Oct 2002 01:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262230AbSJVFzA>; Tue, 22 Oct 2002 01:55:00 -0400
Received: from franka.aracnet.com ([216.99.193.44]:55275 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262214AbSJVFy7>; Tue, 22 Oct 2002 01:54:59 -0400
Date: Mon, 21 Oct 2002 22:55:57 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Bill Davidsen <davidsen@tmr.com>, Dave McCracken <dmccr@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
Message-ID: <2629464880.1035240956@[10.10.2.3]>
In-Reply-To: <m17kgbuo0i.fsf@frodo.biederman.org>
References: <m17kgbuo0i.fsf@frodo.biederman.org>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> In many cases, this will stop the box from falling over flat on it's 
>> >> face due to ZONE_NORMAL exhaustion (from pte-chains), or even total
>> >> RAM exhaustion (from PTEs). Thus the performance gain is infinite ;-)
>> > 
>> > So why has no one written a pte_chain reaper?  It is perfectly sane
>> > to allocate a swap entry and move an entire pte_chain to the swap
>> > cache.  
>> 
>> I think the underlying subsystem does not easily allow for dynamic regeneration,
>> so it's non-trivial. 
> 
> We swap pages out all of the time in 2.4.x, and that is all I was suggesting 
> swap out some but not all of the pages, on a very long pte_chain.  And swapping
> out a page is not terribly complex, unless something very drastic has changed.

Right, it's swapping out the controlling structures without swapping
out the pages themselves that's harder.
 
>> IMHO, it's better not to fill memory with crap in the first place than
>> to invent complex methods of managing and shrinking it afterwards. You
>> only get into pathalogical conditions under sharing situation, else 
>> it's limited to about 1% of RAM (bad, but manageable) ... thus providing
>> this sort of sharing nixes the worst of it. Better cache warmth on 
>> switches (for TLB misses), faster fork+exec, etc. are nice side-effects.
> 
> I will agree with that if everything works so the sharing happens,
> this is a nice feature.

I think it will for most of the situations we run aground with now
(normally 5000 oracle tasks sharing a 2Gb shared segment, or some
such monster).
 
>> The ultimate solution is per-object reverse mappings, rather than per
>> page, but that's a 2.7 thingy now.
> ???
> 
> Last I checked we already had those in 2.4.x, and still in 2.5.x.  The
> list of place the address space is mapped.

It's more complicated than that ... I'll let Rik or one of the K42
guys who understand it better than I do explain it (yeah, I'm wimping
out on you ;-))

M.

