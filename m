Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751818AbWG1GUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbWG1GUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 02:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWG1GUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 02:20:46 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:6042 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751818AbWG1GUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 02:20:45 -0400
Message-ID: <44C9ACB3.7090002@de.ibm.com>
Date: Fri, 28 Jul 2006 08:20:35 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch 1/2] CPU hotplug compatible alloc_percpu
References: <1153761414.2986.136.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20060725230259.f5a27306.akpm@osdl.org>
In-Reply-To: <20060725230259.f5a27306.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 24 Jul 2006 19:16:54 +0200
> Martin Peschke <mp3@de.ibm.com> wrote:
> 
>> This patch splits alloc_percpu() up into two phases. Likewise for
>> free_percpu(). This allows clients to limit initial allocations to
>> online cpu's, and to populate or depopulate per-cpu data at run time as
>> needed:
>>
>>   struct my_struct *obj;
>>
>>   /* initial allocation for online cpu's */
>>   obj = percpu_alloc(sizeof(struct my_struct), GFP_KERNEL);
>>
>>   ...
>>
>>   /* populate per-cpu data for cpu coming online */
>>   ptr = percpu_populate(obj, sizeof(struct my_struct), GFP_KERNEL, cpu);
>>
>>   ...
>>
>>   /* access per-cpu object */
>>   ptr = percpu_ptr(obj, smp_processor_id());
>>
>>   ...
>>
>>   /* depopulate per-cpu data for cpu going offline */
>>   percpu_depopulate(obj, cpu);
>>
>>   ...
>>
>>   /* final removal */
>>   percpu_free(obj);
> 
> That looks pretty thorough.
> 
> The one little nit I'd have is that the code passes cpumasks by value.  See
> the tricks in <linux/cpumask.h> which pretend to take the caller's cpumask
> by value but which instead pass it via const reference to the callee.
> 
> CONFIG_NR_CPUS=1024 leads to a 128-byte cpumask_t.  It's worth doing.

Oops. I will send a patch.

