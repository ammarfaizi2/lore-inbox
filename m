Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWGNIB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWGNIB0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 04:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWGNIB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 04:01:26 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:18704 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S964803AbWGNIBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 04:01:25 -0400
Message-ID: <44B74F24.2060209@shadowen.org>
Date: Fri, 14 Jul 2006 09:00:36 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-git4 and 2.6.18-rc1-mm1 OOM's on boot
References: <44B528F4.6080409@google.com> <20060712181636.d7cbbb99.akpm@osdl.org> <44B5A0DD.9070200@google.com> <44B654EA.3030301@shadowen.org>
In-Reply-To: <44B654EA.3030301@shadowen.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> Martin Bligh wrote:
>> Andrew Morton wrote:
>>> On Wed, 12 Jul 2006 09:53:08 -0700
>>> Martin Bligh <mbligh@google.com> wrote:
>>>
>>>
>>>> -git3 was fine
>>>> (bootlog for git3: http://test.kernel.org/abat/40748/debug/console.log)
>>>>
>>>> -mm1 has the same issue
>>>>
>>>> Slightly different manifestations across 2 boots
>>>>
>>>> http://test.kernel.org/abat/40760/debug/console.log
>>>> http://test.kernel.org/abat/40837/debug/console.log
>>>
>>>
>>>  [<c0136fcf>] out_of_memory+0x29/0xf6
>>>  [<c0137f48>] __alloc_pages+0x1ed/0x276
>>>  [<c014db73>] kmem_getpages+0x63/0xc1
>>>  [<c014e960>] cache_grow+0xaa/0x139
>>>  [<c014eb6a>] cache_alloc_refill+0x17b/0x1c0
>>>  [<c014f1ef>] __kmalloc+0x83/0x93
>>>  [<c0168cf5>] alloc_fd_array+0x19/0x24
>>>  [<c0169122>] alloc_fdtable+0xb2/0xef
>>>  [<c016917f>] expand_fdtable+0x20/0x7d
>>>  [<c0169221>] expand_files+0x45/0x50
>>>  [<c0161263>] locate_fd+0x70/0x8e
>>>  [<c01612aa>] dupfd+0x29/0x61
>>>  [<c01613dc>] sys_dup+0x1b/0x23
>>>  [<c01027d3>] syscall_call+0x7/0xb
>>>
>>> I suspect that's because I had me a little mistake.
>>>
>>> --- a/fs/file.c~alloc_fdtable-expansion-fix
>>> +++ a/fs/file.c
>>> @@ -240,7 +240,7 @@ static struct fdtable *alloc_fdtable(int
>>>      if (!fdt)
>>>            goto out;
>>>  
>>> -    nfds = max_t(int, 8 * L1_CACHE_BYTES, roundup_pow_of_two(nfds));
>>> +    nfds = max_t(int, 8 * L1_CACHE_BYTES, roundup_pow_of_two(nr + 1));
>>>      if (nfds > NR_OPEN)
>>>          nfds = NR_OPEN;
>>>  
>>> _
>>>
>>
>> Thanks, that was affecting several machines.
>>
>> Andy, any chance we can do an across-all-machines run of that one on top
>> of -mm1? Thanks,
>>
>> M.
> 
> Yep, I've run this with badari's fix as a set across the whole family. I 
> did all dbenchall runs for now as this example is showing on that and 
> badari's is triggered same.  If there is any measure of success there 
> I'll throw in the externals too.

General goodness from this one.  Except where we're getting issues with 
the e1000's.  That seems to be fixed up by backing out some driver changes.

All moot, as -mm2 is showing similar goodness.

-apw

