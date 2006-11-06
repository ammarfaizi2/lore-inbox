Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423777AbWKFK2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423777AbWKFK2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423787AbWKFK2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:28:30 -0500
Received: from il.qumranet.com ([62.219.232.206]:54156 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1423777AbWKFK23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:28:29 -0500
Message-ID: <454F0E4A.7030001@qumranet.com>
Date: Mon, 06 Nov 2006 12:28:26 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 1/14] KVM: userspace interface
References: <454E4941.7000108@qumranet.com>	 <20061105202934.B5F842500A7@cleopatra.q> <1162807420.3160.186.camel@laptopd505.fenrus.org>
In-Reply-To: <1162807420.3160.186.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Hi,
>
> some nitpicks about the ioctl interfaces while it still can be done ;)
>
>   

There are some changes still planned (to streamline smp support).

>   
>> Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
>> Signed-off-by: Avi Kivity <avi@qumranet.com>
>>
>> --- /dev/null	2006-10-25 17:42:42.376631750 +0200
>> +++ linux-2.6/include/linux/kvm.h	2006-10-26 15:22:01.000000000 +0200
>> @@ -0,0 +1,198 @@
>> +#ifndef __LINUX_KVM_H
>> +#define __LINUX_KVM_H
>> +
>> +/*
>> + * Userspace interface for /dev/kvm - kernel based virtual machine
>> + *
>> + * Note: this interface is considered experimental and may change without
>> + *       notice.
>> + */
>> +
>> +#include <asm/types.h>
>> +#include <linux/ioctl.h>
>> +
>> +/* for KVM_CREATE_MEMORY_REGION */
>> +struct kvm_memory_region {
>> +	__u32 slot;
>> +	__u32 flags;
>> +	__u64 guest_phys_addr;
>> +	__u64 memory_size; /* bytes */
>> +};
>>     
>
> as a general rule, it's a lot better to sort structures big-to-small, to
> make sure alignments inside the struct are minimized and don't suck too
> much. This is especially important to get right for 32/64 bit
> compatibility. This comment is true for most structures in this header
> file; please consider this at least
>   

Doesn't that cause an unnatural field order? for example, in some 
structures I separated in and out variables.  Sorting by size is a bit 
like sorting alphabetically.

Anyway I observed 32/64 bit compatibility religiously.

>   
>> +
>> +enum kvm_exit_reason {
>> +	KVM_EXIT_UNKNOWN,
>> +	KVM_EXIT_EXCEPTION,
>> +	KVM_EXIT_IO,
>> +	KVM_EXIT_CPUID,
>> +	KVM_EXIT_DEBUG,
>> +	KVM_EXIT_HLT,
>> +	KVM_EXIT_MMIO,
>> +};
>>     
>
> it's probably nicer to use explicit enum values for the interface, just
> as documentation if nothing else
>
>   

Will do.


-- 
error compiling committee.c: too many arguments to function

