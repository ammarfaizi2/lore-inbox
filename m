Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUGNAZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUGNAZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 20:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267264AbUGNAZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 20:25:30 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:41925 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S267263AbUGNAZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 20:25:28 -0400
Message-ID: <40F47D75.1060706@metaparadigm.com>
Date: Wed, 14 Jul 2004 08:25:25 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Lutz Vieweg <lkv@isg.de>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: How to find out which pages were copied-on-write?
References: <40EACC0C.6060606@isg.de> <20040709113125.GA8897@lnx-holt.americas.sgi.com> <40EF0346.4040407@isg.de> <40EFA4C8.1050409@metaparadigm.com> <40F2C882.7070406@isg.de> <40F36216.1080603@metaparadigm.com> <40F3DDC4.7060104@isg.de> <40F3F993.6040602@metaparadigm.com> <40F40238.3080103@isg.de>
In-Reply-To: <40F40238.3080103@isg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/04 23:39, Lutz Vieweg wrote:
> Michael Clark wrote:
> 
>> On 07/13/04 21:04, Lutz Vieweg wrote:
>>
>>>> You don't use mmap for speed but rather for convenience.
>>>
>>>
>>> But isn't an advantage with mmap() that there's no need for the kernel
>>> to copy what is to be written to a dedicated buffer? The kernel
>>> could initiate DMA writes directly from the working memory...
>>
>>
>> Yes, but page faults are expensive too. Each time a page is written
>> out it needs to be marked read only again and will cause a page fault
>> for the next write access from userspace. For certain workloads this
>> can easily add up to more than copy_(to|from)_user in read/write.
> 
> 
> But I would need exactly the same number of pagefaults if I implemented
> the "mark-dirty-on-write" logic in userspace using SIGSEGV and signal
> handlers, as it is done by the LPSM software...

Yes, that's sort of my point although you get the commit semantics
you want, albeit a little more usersapce signal overhead and an mprotect
call (you've already taken the exception so the extra signal overhead
shouldn't be too much), but perhaps less overall page faults than
MAP_SHARED (which is the mmap variant that writes dirtied pages back
to backing store) as you control when to mark the page clean again
ie. do the writeout at your commit point and not before.

Really my point was you don't use mmap for speed but rather for convenience.

~mc
