Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423117AbWJaKzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423117AbWJaKzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 05:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423131AbWJaKzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 05:55:31 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:24503 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1423117AbWJaKz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 05:55:27 -0500
Message-ID: <45472B68.1050506@in.ibm.com>
Date: Tue, 31 Oct 2006 16:24:32 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Pavel Emelianov <xemul@openvz.org>
CC: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, menage@google.com,
       linux-mm@kvack.org
Subject: Re: [ckrm-tech] RFC: Memory Controller
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com> <4546212B.4010603@openvz.org> <454638D2.7050306@in.ibm.com> <45470DF4.70405@openvz.org>
In-Reply-To: <45470DF4.70405@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Emelianov wrote:
> Balbir Singh wrote:
>> Pavel Emelianov wrote:
>>> [snip]
>>>
>>>> Reclaimable memory
>>>>
>>>> (i)   Anonymous pages - Anonymous pages are pages allocated by the user space,
>>>>       they are mapped into the user page tables, but not backed by a file.
>>> I do not agree with such classification.
>>> When one maps file then kernel can remove page from address
>>> space as there is already space on disk for it. When one
>>> maps an anonymous page then kernel won't remove this page
>>> for sure as system may simply be configured to be swapless.
>> Yes, I agree if there is no swap space, then anonymous memory is pinned.
>> Assuming that we'll end up using a an abstraction on top of the
>> existing reclaim mechanism, the mechanism would know if a particular
>> type of memory is reclaimable or not.
> 
> If memory is considered to be unreclaimable then actions should be
> taken at mmap() time, not later! Rejecting mmap() is the only way to
> limit user in unreclaimable memory consumption.

That's like disabling memory over-commit in the regular kernel.
Don't you think this should again be based on the systems configuration
of over-commit?

[snip]

> 
>> I understand that kernel memory accounting is the first priority for
>> containers, but accounting kernel memory requires too many changes
>> to the VM core, hence I was hesitant to put it up as first priority.
> 
> Among all the kernel-code-intrusive patches in BC patch set
> kmemsize hooks are the most "conservative" - only one place
> is heavily patched - this is slab allocator. Buddy is patched,
> but _significantly_ smaller. The rest of the patch adds __GFP_BC
> flags to some allocations and SLAB_BC to some kmem_caches.
> 
> User memory controlling patch is much heavier...
> 

Please see the patching of Rohit's memory controller for user
level patching. It seems much simpler.

> I'd set priorities of development that way:
> 
> 1. core infrastructure (mainly headers)
> 2. interface
> 3. kernel memory hooks and accounting
> 4. mappings hooks and accounting
> 5. physical pages hooks and accounting
> 6. user pages reclamation
> 7. moving threads between beancounters
> 8. make beancounter persistent

I would prefer a different set

1 & 2, for now we could use any interface and then start developing the
controller. As we develop the new controller, we are likely to find the
need to add/enhance the interface, so freezing in on 1 & 2 might not be
a good idea.

I would put 4, 5 and 6 ahead of 3, based on the changes I see in Rohit's
memory controller.

Then take up the rest.

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
