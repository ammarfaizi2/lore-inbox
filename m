Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVCCM0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVCCM0n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVCCMY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 07:24:59 -0500
Received: from dns1.expertron.co.za ([196.25.64.193]:18363 "EHLO
	mail.expertron.co.za") by vger.kernel.org with ESMTP
	id S261608AbVCCMTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 07:19:15 -0500
Message-ID: <422700CB.2070109@expertron.co.za>
Date: Thu, 03 Mar 2005 14:19:23 +0200
From: Justin Schoeman <justin@expertron.co.za>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Tracing memory leaks (slabs) in 2.6.9+ kernels?
References: <4225768B.3010005@expertron.co.za> <20050302012444.4ed05c23.akpm@osdl.org>
In-Reply-To: <20050302012444.4ed05c23.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK - I have the patch working now, but there seems to be a flaw in the 
address reporting. When I look up the reported address in 
/proc/kallsyms, then look in the objdump of the module, the reported 
adress _does_not_ point to a call.

Am I missing something simple here?

Justin

Andrew Morton wrote:
> Justin Schoeman <justin@expertron.co.za> wrote:
> 
>>I am having a problem with memory leaking on a patched kernel.  In order 
>> to pinpoint the leak, I would like to try to trace the allocation points 
>> for the memory.
>>
>> I have found some vague references to patches that allow the user to 
>> dump the caller address for slab allocations, but I cannot find the 
>> patch itself.
>>
>> Can anybody please point me in the right direction - either for that 
>> patch, or any other way to track down leaking slabs?
> 
> 
> 
> From: Manfred Spraul <manfred@colorfullife.com>
> 
> With the patch applied,
> 
> 	echo "size-4096 0 0 0" > /proc/slabinfo
> 
> walks the objects in the size-4096 slab, printing out the calling address
> of whoever allocated that object.
> 
> It is for leak detection.
...
