Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751827AbWFVPyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbWFVPyK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 11:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbWFVPyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 11:54:10 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:35793 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751827AbWFVPyI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 11:54:08 -0400
Date: Thu, 22 Jun 2006 16:54:06 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Franck <vagabon.xyz@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
In-Reply-To: <449ABC3E.5070609@innova-card.com>
Message-ID: <Pine.LNX.4.64.0606221649070.5869@skynet.skynet.ie>
References: <20060621034857.35cfe36f.akpm@osdl.org> <449AB01A.5000608@innova-card.com>
 <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie> <449ABC3E.5070609@innova-card.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Franck Bui-Huu wrote:

> Mel Gorman wrote:
>> On Thu, 22 Jun 2006, Franck Bui-Huu wrote:
>>>
>>> Should ARCH_PFN_OFFSET macro be used instead in order to make pfn/page
>>> convertions work when node 0 start offset do not start at 0 ?
>>>
>>
>> What happens if you have ARCH_PFN_OFFSET as
>>
>> #define ARCH_PFN_OFFSET (0UL)
>>
>> ?
>
> It's the default value (see memory_model.h). It means that pfn start
> for node 0 is 0, therefore your physical memory address starts at 0.
>

I know, but what I'm getting at is that ARCH_PFN_OFFSET may be unnecessary 
with flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch applied. 
ARCH_PFN_OFFSET is used as

#define page_to_pfn(page)       ((unsigned long)((page) - mem_map) + \
                                  ARCH_PFN_OFFSET)

because it knew that the map may not start at PFN 0. With 
flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch, the map will 
start at PFN 0 even if physical memory does not start until later.

>>
>> What arch is this?
>>
>
> well I'm working on MIPS, but you can take a look at ARM that does the
> same thing better...
>
>>> My physical memory start at 0x20000000. So node 0 starts at an offset
>>> different from 0. I setup ARCH_PFN_OFFSET this way
>>>
>>>     #define ARCH_PFN_OFFSET    (0x20000000 << PAGE_SHIFT)
>>>
>>
>> If physical memory starts at 0x20000000, why is the PFN not
>> 0x20000000 >> PAGE_SHIFT ?
>>
>
> It is a typo...
>

ok

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
