Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWIFTSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWIFTSO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 15:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWIFTSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 15:18:14 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:54235 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751498AbWIFTSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 15:18:12 -0400
Message-ID: <44FF1EE4.3060005@in.ibm.com>
Date: Thu, 07 Sep 2006 00:47:56 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Hugh Dickins <hugh@veritas.com>, Matt Helsley <matthltc@us.ibm.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
 memory)
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com> <44FEC7E4.7030708@sw.ru>
In-Reply-To: <44FEC7E4.7030708@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
> Balbir Singh wrote:
>> Kirill Korotaev wrote:
>>
>>> Core Resource Beancounters (BC) + kernel/user memory control.
>>>
>>> BC allows to account and control consumption
>>> of kernel resources used by group of processes.
>>>
>>> Draft UBC description on OpenVZ wiki can be found at
>>> http://wiki.openvz.org/UBC_parameters
>>>
>>> The full BC patch set allows to control:
>>> - kernel memory. All the kernel objects allocatable
>>> on user demand should be accounted and limited
>>> for DoS protection.
>>> E.g. page tables, task structs, vmas etc.
>>
>> One of the key requirements of resource management for us is to be able to
>> migrate tasks across resource groups. Since bean counters do not associate
>> a list of tasks associated with them, I do not see how this can be done
>> with the existing bean counters.
> It was discussed multiple times already.
> The key problem here is the objects which do not _belong_ to tasks.
> e.g. IPC objects. They exist in global namespace and can't be reaccounted.
> At least no one proposed the policy to reaccount.
> And please note, IPCs are not the only such objects.
> 
> But I guess your comment mostly concerns user pages, yeah?

Yes.

> In this case reaccounting can be easily done using page beancounters
> which are introduced in this patch set.
> So if it is a requirement, then lets cooperate and create such functionality.
> 

Sure, let's cooperate and talk.

> So for now I see 2 main requirements from people:
> - memory reclamation
> - tasks moving across beancounters
> 

Some not quite so urgent ones - like support for guarantees. I think this can
be worked out as we make progress.

> I agree with these requirements and lets move into this direction.
> But moving so far can't be done without accepting:
> 1. core functionality
> 2. accounting
> 

Some of the core functionality might be a limiting factor for the requirements.
Lets agree on the requirements, I think its a great step forward and then
build the core functionality with these requirements in mind.

> Thanks,
> Kirill
> 
-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
