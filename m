Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312883AbSCZABZ>; Mon, 25 Mar 2002 19:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312884AbSCZABQ>; Mon, 25 Mar 2002 19:01:16 -0500
Received: from lakemtao02.cox.net ([68.1.17.243]:53184 "EHLO
	lakemtao02.cox.net") by vger.kernel.org with ESMTP
	id <S312883AbSCZABE>; Mon, 25 Mar 2002 19:01:04 -0500
Message-ID: <3C9F8C95.8090506@sandia.gov>
Date: Mon, 25 Mar 2002 12:46:13 -0800
From: Kevin Pedretti <ktpedre@sandia.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: do_exit() and lock_kernel() semantics
In-Reply-To: <003301c1d439$97a26030$010411ac@local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

>>Thus, for each receive we have to convert the virt address of the
>>user-land receive buffer to a physical address (in the kernel region)
>>before doing the memcpy (copy_to_user doesn't work from interrupt
>>context).
>>
>
>Why do you want to do that at interrupt time?
>I'd call map_user_kiobuf() when the user-land buffer is set up, and then
>write directly (i.e. with kmap_atomic()) into the pages stored in
>iobuf->maplist[]. It avoids the page table scan at interrupt time.
>
>Which platform do you use? map_user_kiobuf() doesn't enforce cache
>coherency internally, outside of i386 you might need additional
>flush_cache_whatever (see Documentation/cachetlb.txt)
>
>--
>    Manfred
>

I'm guessing the reason is that this module was initially developed on 
2.0 and ported to 2.2. and 2.4.  I think the kiobuf stuff is only in 
2.4+, right?  I should probably work on converting things, although our 
production Cplant cluster is still using 2.2.  It might help reduce our 
latency, although I'm guessing the page table walk is pretty quick.

This module needs to work on Alpha, i386, and ia64 so I'd have to look 
into the cache issues.

Thanks,
Kevin  

