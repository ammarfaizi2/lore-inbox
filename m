Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964770AbVLITwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbVLITwD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 14:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVLITwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 14:52:03 -0500
Received: from smtpout.mac.com ([17.250.248.73]:12503 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932424AbVLITwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 14:52:00 -0500
In-Reply-To: <1134151696.3278.2.camel@localhost>
References: <r02010500-1043-55BAAD4668D211DA98840011248907EC@[10.64.61.57]> <1134148609.30856.22.camel@localhost> <E4ECF4F0-9442-4FFE-BE55-3EF7A1CC40F4@mac.com> <1134151696.3278.2.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DB1A6A43-DA12-4C5B-B195-5C01DED4CF3E@mac.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: [PATCH 2.6.15-rc5] hugetlb: make make_huge_pte global and fix coding style
Date: Fri, 9 Dec 2005 13:51:55 -0600
To: Dave Hansen <haveblue@us.ibm.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 9, 2005, at 12:08 PM, Dave Hansen wrote:

> On Fri, 2005-12-09 at 11:55 -0600, Mark Rustad wrote:
>> On Dec 9, 2005, at 11:16 AM, Dave Hansen wrote:
>>
>>> What driver needs to map huge pages?  Is it in the kernel tree
>>> now?  If
>>> not, can you post the source, please?
>>
>> It is a funky driver for an embedded system. I can't imagine it ever
>> being in the kernel tree, because not many people want to share 768M
>> of contiguous physical memory.
>>
>> I can post the source, but it really is a bunch of random stuff for
>> am embedded application. We do make it available as part of our GPL
>> source release to customers.
>
> You'd be surprised.  If we know what you're actually trying to do, we
> might be able to suggest another option.  As Adam said, having  
> userspace
> mmap a hugetlb area, then hand it to the driver would certainly keep
> your kernel modifications to a minimum.

Actually, the driver never touches any of the memory at all either  
directly or indirectly - it simply maps the memory for the processes  
that use it. Those processes actually contain PCI device drivers  
which do DMA on much of the memory. The same memory also holds data  
structures shared by those processes. If hugetlbfs could be  
guaranteed to provide contiguous memory for a file, that could be  
used in this application. We used to use remap_pfn_range in our  
driver, but recent changes there made that not work for this  
application, so I figured I may as well switch to huge pages for  
these monster areas. At least, gdb was unable to access these large  
shared areas, which is a deal-breaker for our developers.

In case you are wondering, these processes were ported onto Linux  
from a different, non-x86-based, system that had three cpus which  
could directly address each other's memory. They have now been  
running happily on top of x86 Linux now for well over a year.

-- 
Mark Rustad, MRustad@mac.com

