Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWHRIKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWHRIKe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWHRIKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:10:34 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:50721 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751065AbWHRIKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:10:33 -0400
Message-ID: <44E57689.9070209@sw.ru>
Date: Fri, 18 Aug 2006 12:12:57 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting	(core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>	<1155754029.9274.21.camel@localhost.localdomain>	<44E46FC4.2050002@sw.ru> <1155825379.9274.39.camel@localhost.localdomain>
In-Reply-To: <1155825379.9274.39.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Thu, 2006-08-17 at 17:31 +0400, Kirill Korotaev wrote:
> 
>>>How many things actually use this?  Can we have the slab ubcs
>>
>>without
>>
>>>the struct page pointer?
>>
>>slab doesn't use this pointer on the page.
>>It is used for pages allocated by buddy
>>alocator implicitly (e.g. LDT pages, page tables, ...). 
> 
> 
> Hmmm.  There aren't _that_ many of those cases, right?  Are there any
> that absolutely need raw access to the buddy allocator?  I'm pretty sure
> that pagetables can be moved over to a slab, as long as we bump up the
> alignment.
LDT takes from 1 to 16 pages. and is allocated by vmalloc.
do you propose to replace it with slab which can fail due to memory
fragmentation?

the same applies to fdset, fdarray, ipc ids and iptables entries.

> It does seem a wee bit silly to have the pointer in _all_ of the struct
> pages, even the ones for which we will never do any accounting (and even
> on kernels that never need it).  But, a hashing scheme sounds like a
> fine idea.
It seems a silly for you since 2nd patchset accounting user pages
is not here yet. As you can see we added a union into page,
which is shared between kernel memory and user memory accounting.

THERE IS NOT USER ACCOUNTING HERE YET GUYS! :) THIS FIELD WILL BE USED!!!

Thanks,
Kirill

