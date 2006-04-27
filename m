Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWD0PPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWD0PPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbWD0PPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:15:20 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:30895 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965149AbWD0PPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:15:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=tiU8PXKlVy4jKMb4IstxMzqYtlFWxwxOsf3hnb8TiQp2Q6QWphUHgs0DcSEoKyTNjd2uSkoyrLYwsviZoIu2jrGIISUbituGtqVIAosUJqUJbobCyiJv5n3VuBCi6QD3UcGbIMJUDQ6rHCSnsG4Q4+ggpoceH6Ip9KThrCHDQl4=  ;
Message-ID: <4450C9AA.8020800@yahoo.com.au>
Date: Thu, 27 Apr 2006 23:39:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Sonny Rao <sonny@burdell.org>
CC: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, Hugh Dickins <hugh@veritas.com>,
       Jan Beulich <jbeulich@novell.com>, Zachary Amsden <zach@vmware.com>,
       linux-kernel@vger.kernel.org, anton@samba.org
Subject: Re: [PATCH] i386: PAE entries must have their low word cleared first
References: <444F95D8.76E4.0078.0@novell.com> <Pine.LNX.4.64.0604261538260.9915@blonde.wat.veritas.com> <946b367619cfd3dcd3ba547e216e494b@cl.cam.ac.uk> <444F98B2.8020003@yahoo.com.au> <20060427102700.GA1299@kevlar.burdell.org>
In-Reply-To: <20060427102700.GA1299@kevlar.burdell.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao wrote:
> On Thu, Apr 27, 2006 at 01:58:42AM +1000, Nick Piggin wrote:
> 
>>Keir Fraser wrote:
>>
>>>In more detail the problem is that, since we're still running on the 
>>>page tables while clearing them, the CPU may choose to prefetch a 
>>>half-cleared pte into its TLB, and then execute speculative memory 
>>>accesses based on that mapping (including ones that may write-allocate 
>>>cachelines, leading to problems like the AMD AGP GART deadlock Linux had 
>>>a year or so back).
>>
>>What do you mean, you're still running on the page tables? The CPU can
>>still walk the pagetables?
>>
>>Because if ptep_get_and_clear_full is passed non zero in the full
>>argument, then that specific translation should never see another
>>access. I didn't know CPUs now actually resolve TLB misses as part of
>>speculative prefetching... does this really happen?
> 
> 
> For instance, during speculative execution on POWER, we can take a
> TLB miss for a speculative load and start a table-walk.
> 
> I'm not sure what "speculative prefetching" means in this case... just
> regular hardware-initiated prefetching (where I suppose one could use the
> modifier "speculative") on POWER will only prefetch to a page-boundary.

speculative prefetching / hardware prefetching...

I believe this bug wouldn't happen as a result of speculative execution,
because a load from this virtual address should never be in the instruction
stream. So it would require some hardware initiated prefetch to establish
the tlb entry.

> 
> So, slightly OT, as this is not about x86 CPUs... but thought people
> might be interested.

Thanks!

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
