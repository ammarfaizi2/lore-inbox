Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293211AbSBWVRS>; Sat, 23 Feb 2002 16:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293210AbSBWVQ7>; Sat, 23 Feb 2002 16:16:59 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:37835 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S293209AbSBWVQu>;
	Sat, 23 Feb 2002 16:16:50 -0500
Message-ID: <3C780702.9060109@sgi.com>
Date: Sat, 23 Feb 2002 15:17:54 -0600
From: Stephen Lord <lord@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <3C773C02.93C7753E@zip.com.au.suse.lists.linux.kernel> <1014444810.1003.53.camel@phantasy.suse.lists.linux.kernel> <3C773C02.93C7753E@zip.com.au.suse.lists.linux.kernel> <1014449389.1003.149.camel@phantasy.suse.lists.linux.kernel> <3C774AC8.5E0848A2@zip.com.au.suse.lists.linux.kernel> <3C77F503.1060005@sgi.com.suse.lists.linux.kernel> <3C77FB35.16844FE7@zip.com.au.suse.lists.linux.kernel>,		Andrew Morton's message of "23 Feb 2002 21:36:17 +0100" <p73y9hjq5mw.fsf@oldwotan.suse.de> <3C78045C.668AB945@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Andi Kleen wrote:
>
>>Andrew Morton <akpm@zip.com.au> writes:
>>
>>>>I can tell you that Irix has just such a global counter for the amount of
>>>>delayed allocate pages - and it gets to be a major point of cache contention
>>>>once you get to larger cpu counts. So avoiding that from the start would
>>>>be good.
>>>>
>>>Ah, good info.  Thanks.  I'll fix it with a big "FIXME" comment for now,
>>>fix it for real when Rusty's per-CPU infrastructure appears.
>>>
>>Just curious -- how do you want to fix it for real?
>>As far as I can see a delalloc counter needs to be exact to avoid OOM
>>deadlocks, but making it per CPU would require doing the accounting inexact.
>>
>
>The counter is used only for making writeback decisions.  It is
>completely analogous to nr_buffers_type[BUF_DIRTY], except it counts
>pages.   So it does not need to be exact for readers.
>
>If we needed exact reader-accounting for the number of dirty pages in the
>machine then we'd need a ton of new locking in fun places like __free_pte(),
>and that still doesn't account for pages which are only pte-dirty, and it's
>not obvious what we'd do with reader-exact dirty page info anyway?
>
>
You do want to avoid a leak in one direction or the other, the os would 
start to think it
had lots of dirty pages, but not be able to find them, or think there is 
no shortage
when in fact there was.

Steve


