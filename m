Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992547AbWJTHY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992547AbWJTHY7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992549AbWJTHY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:24:59 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:12228 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S2992547AbWJTHY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:24:58 -0400
Message-ID: <453879C5.3030905@qumranet.com>
Date: Fri, 20 Oct 2006 09:24:53 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] KVM: mmu virtualization
References: <4537818D.4060204@qumranet.com> <45378377.9080604@qumranet.com> <Pine.LNX.4.61.0610192220510.8142@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0610192220510.8142@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2006 07:24:57.0432 (UTC) FILETIME=[D8711580:01C6F418]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> +static int is_write_protection(void)
>> +{
>> +    return guest_cr0() & CR0_WP_MASK;
>> +}
>> +
>> +static int is_cpuid_PSE36(void)
>> +{
>> +    return 1;
>> +}
>> +
>> +static int is_present_pte(unsigned long pte)
>> +{
>> +    return pte & PT_PRESENT_MASK;
>> +}
>> +
>> +static int is_writeble_pte(unsigned long pte)
>> +{
>> +    return pte & PT_WRITABLE_MASK;
>> +}
>> +
>> +static int is_io_pte(unsigned long pte)
>> +{
>> +    return pte & PT_SHADOW_IO_MARK;
>> +}
>>     
>
> Unless the above will grow in size by later patches, or is taken address of,
> mark them static inline.
>
>   

gcc inlines them well enough based on size.  That means I don't have to 
keep adding/removing inline declarations.

>> +static void nonpaging_new_cr3(struct kvm_vcpu *vcpu)
>> +{
>> +}
>>     
>
> Remove it unless needed shortly afterwards.
>
>   

That's a (*callback)().

>> +static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, gva_t vaddr)
>> +{
>> +    return vaddr;
>> +}
>>     
>
> Candidate for inline too.
>
>   

Ditto.


>> +static void nonpaging_inval_page(struct kvm_vcpu *vcpu, gva_t addr)
>> +{
>> +}
>>     
>
> Removal candidate
>
>   

Ditto.

>> +int kvm_mmu_reset_context(struct kvm_vcpu *vcpu)
>> +{
>> +    destroy_kvm_mmu(vcpu);
>> +    return init_kvm_mmu(vcpu);
>> +}
>>     
>
> Inline candidate.
>
>   

It's used in another file. gcc will probably inline its callees.

>> Index: linux-2.6/drivers/kvm/paging_tmpl.h
>> ===================================================================
>> +    #define PT_DIR_BASE_ADDR_MASK PT32_DIR_BASE_ADDR_MASK
>> +    #define PT_INDEX(addr, level) PT32_INDEX(addr, level)
>> +    #define SHADOW_PT_INDEX(addr, level) PT64_INDEX(addr, level)
>> +    #define PT_LEVEL_MASK(level) PT32_LEVEL_MASK(level)
>> +    #define PT_PTE_COPY_MASK PT32_PTE_COPY_MASK
>> +    #define PT_NON_PTE_COPY_MASK PT32_NON_PTE_COPY_MASK
>> +#else
>> +    error
>> +#endif
>>     
>
> 	#error Free Ad Space Here
> it is.
>
>   

Will fix.  Thanks for the review.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

