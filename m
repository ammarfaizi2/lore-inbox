Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWIFNDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWIFNDL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWIFNDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:03:11 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:1200 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750884AbWIFNDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:03:09 -0400
Message-ID: <44FEC7E4.7030708@sw.ru>
Date: Wed, 06 Sep 2006 17:06:44 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alexey Dobriyan <adobriyan@mail.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Hugh Dickins <hugh@veritas.com>, Srivatsa <vatsa@in.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
 memory)
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
In-Reply-To: <44FDAB81.5050608@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Kirill Korotaev wrote:
> 
>> Core Resource Beancounters (BC) + kernel/user memory control.
>>
>> BC allows to account and control consumption
>> of kernel resources used by group of processes.
>>
>> Draft UBC description on OpenVZ wiki can be found at
>> http://wiki.openvz.org/UBC_parameters
>>
>> The full BC patch set allows to control:
>> - kernel memory. All the kernel objects allocatable
>> on user demand should be accounted and limited
>> for DoS protection.
>> E.g. page tables, task structs, vmas etc.
> 
> 
> One of the key requirements of resource management for us is to be able to
> migrate tasks across resource groups. Since bean counters do not associate
> a list of tasks associated with them, I do not see how this can be done
> with the existing bean counters.
It was discussed multiple times already.
The key problem here is the objects which do not _belong_ to tasks.
e.g. IPC objects. They exist in global namespace and can't be reaccounted.
At least no one proposed the policy to reaccount.
And please note, IPCs are not the only such objects.

But I guess your comment mostly concerns user pages, yeah?
In this case reaccounting can be easily done using page beancounters
which are introduced in this patch set.
So if it is a requirement, then lets cooperate and create such functionality.

So for now I see 2 main requirements from people:
- memory reclamation
- tasks moving across beancounters

I agree with these requirements and lets move into this direction.
But moving so far can't be done without accepting:
1. core functionality
2. accounting

Thanks,
Kirill

