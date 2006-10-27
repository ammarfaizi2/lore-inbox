Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423692AbWJ0Fx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423692AbWJ0Fx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 01:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423708AbWJ0Fx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 01:53:57 -0400
Received: from mis011.exch011.intermedia.net ([64.78.21.10]:32821 "EHLO
	mis011.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1423692AbWJ0Fx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 01:53:56 -0400
Message-ID: <45419EEC.6010901@qumranet.com>
Date: Fri, 27 Oct 2006 07:53:48 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-kernel@vger.kernel.org, kvm-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/13] KVM: kvm data structures
References: <4540EE2B.9020606@qumranet.com> <20061026172456.91391A0209@cleopatra.q> <200610270055.45560.arnd@arndb.de>
In-Reply-To: <200610270055.45560.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Oct 2006 05:53:55.0761 (UTC) FILETIME=[49EC7A10:01C6F98C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Thursday 26 October 2006 19:24, Avi Kivity wrote:
>   
>> +struct kvm {
>> +       spinlock_t lock; /* protects everything except vcpus */
>> +       int nmemslots;
>> +       struct kvm_memory_slot memslots[KVM_MEMORY_SLOTS];
>> +       struct list_head active_mmu_pages;
>> +       struct kvm_vcpu vcpus[KVM_MAX_VCPUS];
>> +       int memory_config_version;
>> +       int busy;
>> +};
>>     
>
> Assuming that you move to the host-user == guest-real memory
> model, will this data structure still be needed? It would
> be really nice if a guest could simply consist of a number
> of vcpu structures that happen to be used from threads in the
> same process address space, but I find it hard to tell if
> that is realistic.
>   

We'd still need the shadow page table data structures (or the nested 
page tables pgd).

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

