Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSIJQ5A>; Tue, 10 Sep 2002 12:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSIJQ47>; Tue, 10 Sep 2002 12:56:59 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:16559 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S314078AbSIJQ47>;
	Tue, 10 Sep 2002 12:56:59 -0400
Message-ID: <3D7E2579.3070206@colorfullife.com>
Date: Tue, 10 Sep 2002 19:01:45 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
References: <3D7D105D.7050604@colorfullife.com> <3D7D16ED.B09C9B47@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Manfred Spraul wrote:
> 
>>Andrew Morton wrote:
>>
>>>Nobody seems to have come forth to implement a thought-out scatter/gather,
>>>map-user-pages library infrastructure so I'd be a bit reluctant to
>>>break stuff without offering a replacement.
>>>
>>
>>We'd need one.
>>
>>get_user_pages() is broken if a kernel module access the virtual address
>>of the page and the cpu caches are not coherent:
> 
> 
> OK.  Most users seem to just want to put the pages under DMA though.
> 
> 
>>Most of the flush functions need the vma pointer, but it's impossible to
>>guarantee that it still exists when the get_user_pages() user calls
>>page_cache_release().
> 
> 
> Well presumably, if the driver is altering user memory by hand,
> it is synchronous and they can hang onto mmap_sem while doing it?
 >

That's how it's done right now, and it works, but IMHO it's ugly.
You switch from RAID-1 to RAID-5, and suddenly you might get 
unexplainable data corruptions with O_DIRECT.

--
	Manfred

