Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751824AbWFVPUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbWFVPUU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 11:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWFVPUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 11:20:19 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:11469 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751824AbWFVPUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 11:20:18 -0400
Date: Thu, 22 Jun 2006 16:20:16 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Franck <vagabon.xyz@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
In-Reply-To: <449AB01A.5000608@innova-card.com>
Message-ID: <Pine.LNX.4.64.0606221617420.5869@skynet.skynet.ie>
References: <20060621034857.35cfe36f.akpm@osdl.org> <449AB01A.5000608@innova-card.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Franck Bui-Huu wrote:

> Andrew,
>
> Andrew Morton wrote:
>>
>>
>> All 1738 patches:
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/patch-list
>>
>
> Is the following patch really needed ?
>
> flatmem-relax-requirement-for-memory-to-start-at-pfn-0.patch
>
> """
> The FLATMEM memory model assumes that memory is in one contigious area
> based at pfn 0.  If we initialise node 0 to start at any other offset we
> will incorrectly map pfn's to the wrong struct page *.  The key to the
> memory model is the contigious nature of the memory not the location of it.
> Relax the requirement for the area to start at 0.
> """
>
> Should ARCH_PFN_OFFSET macro be used instead in order to make pfn/page
> convertions work when node 0 start offset do not start at 0 ?
>

What happens if you have ARCH_PFN_OFFSET as

#define ARCH_PFN_OFFSET (0UL)

?

What arch is this?

> My physical memory start at 0x20000000. So node 0 starts at an offset
> different from 0. I setup ARCH_PFN_OFFSET this way
>
> 	#define ARCH_PFN_OFFSET    (0x20000000 << PAGE_SHIFT)
>

If physical memory starts at 0x20000000, why is the PFN not
0x20000000 >> PAGE_SHIFT ?

> Until now (2.6.17), it works well, but this patch breaks my machine.
>
> If you need more details about my memory mapping, feel free to ask.
>
> Thanks
>
> 		Franck
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
