Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030462AbWHXTL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030462AbWHXTL3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 15:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbWHXTL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 15:11:29 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:52142 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030462AbWHXTL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 15:11:28 -0400
Message-ID: <44EDF9DD.3040904@us.ibm.com>
Date: Thu, 24 Aug 2006 12:11:25 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>
Subject: Re: [RFC][PATCH] Manage jbd allocations from its own slabs
References: <1156374495.30517.5.camel@dyn9047017100.beaverton.ibm.com> <20060824185342.GA20935@infradead.org>
In-Reply-To: <20060824185342.GA20935@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Wed, Aug 23, 2006 at 04:08:15PM -0700, Badari Pulavarty wrote:
>   
>> Hi,
>>
>> Here is the fix to "bh: Ensure bh fits within a page" problem
>> caused by JBD.
>>
>> BTW, I realized that this problem can happen only with 1k, 2k
>> filesystems - as 4k, 8k allocations disable slab debug 
>> automatically. But for completeness, I created slabs for those
>> also.
>>
>> What do you think ? I ran basic tests and things are fine.
>>     
>
> Why can't you just use alloc_page?  I bet the whole slab overhead
> eats more memory than what's wasted when using alloc_pages.  Especially
> as the typical usecase is a 4k blocks filesystem with 4k pagesize
> where the overhead of alloc_page is non-existant.
>   

Yes. That was what proposed earlier. But for 1k, 2k allocations we end 
up wasting whole page.
Isn't it ? Thats why I created right sized slabs and disable slab-debug. 
I guess, I can do this
only for 1k, 2k filesystems and directly use alloc_page() for 4k and 8k 
- but that would make
code ugly and also it doesn't handle cases for bigger base pagesize 
systems (64k power).

Thanks,
Badari


