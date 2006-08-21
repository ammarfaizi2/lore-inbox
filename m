Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751844AbWHUKsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbWHUKsf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 06:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWHUKsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 06:48:35 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:35634 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751844AbWHUKse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 06:48:34 -0400
Message-ID: <44E9901F.1030605@sw.ru>
Date: Mon, 21 Aug 2006 14:51:11 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting	(core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru> <1155932779.26155.87.camel@linuxchandra>
In-Reply-To: <1155932779.26155.87.camel@linuxchandra>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> Kirill,
> 
> IMO, a UBC with resource constraint(limit in this case) should behave no
> different than a kernel with limited memory. i.e it should do
> reclamation before it starts failing allocation requests. It could even
> do it preemptively.
first, please notice, that this thread is not about user memory.
we can discuss it later when about to control user memory. And
I still need to notice, that different models of user memory control
can exist. With and without reclamation.

> There is no guarantee support which is required for providing QoS.
where? in UBC? in UBC _there_ are guarentees, even in regard to OOM killer.

> Each controller modifying the infrastructure code doesn't look good. We
> can have proper interfaces to add a new resource controller.
controllers do not modify interfaces nor core. They just add
themself to the list of resources and setup default limits.
do you think it is worth creating infrastructure for these
2 one-line-changes?

> chandra
> On Wed, 2006-08-16 at 19:40 +0400, Kirill Korotaev wrote:
> 
>>Introduce UB_KMEMSIZE resource which accounts kernel
>>objects allocated by task's request.
>>
>>Reference to UB is kept on struct page or slab object.
>>For slabs each struct slab contains a set of pointers
>>corresponding objects are charged to.
>>
>>Allocation charge rules:
>> define1. Pages - if allocation is performed with __GFP_UBC flag - page
>>    is charged to current's exec_ub.
>> 2. Slabs - kmem_cache may be created with SLAB_UBC flag - in this
>>    case each allocation is charged. Caches used by kmalloc are
>>    created with SLAB_UBC | SLAB_UBC_NOCHARGE flags. In this case
>>    only __GFP_UBC allocations are charged.
>>
>>Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
>>Signed-Off-By: Kirill Korotaev <dev@sw.ru>
>>
> <snip>

