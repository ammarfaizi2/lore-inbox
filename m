Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWEARc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWEARc2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWEARc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:32:28 -0400
Received: from smtp-out.google.com ([216.239.45.12]:62407 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932169AbWEARc1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:32:27 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=neAqyvgakvSBVQIZWD2PtCqQdVGmoVJ9IIPpv3qxO6BGKfxmwBHJzStlRD9jeC060
	exNjcmeKuiM5r6ZTHaZMA==
Message-ID: <44564613.7070702@google.com>
Date: Mon, 01 May 2006 10:32:03 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: apw@shadowen.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 2.6.17-rc2-mm1
References: <4450F5AD.9030200@google.com>	<20060428012022.7b73c77b.akpm@osdl.org>	<44561A1E.7000103@google.com> <20060501100731.051f4eff.akpm@osdl.org>
In-Reply-To: <20060501100731.051f4eff.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Martin J. Bligh" <mbligh@google.com> wrote:
> 
>>Andrew Morton wrote:
>>
>>>(I did s/linux-kernel@google.com/linux-kernel@vger.kernel.org/)
>>>
>>>Martin Bligh <mbligh@google.com> wrote:
>>>
>>>
>>>>Still crashes in LTP on x86_64:
>>>>(introduced in previous release)
>>>>
>>>>http://test.kernel.org/abat/29674/debug/console.log
>>>
>>>
>>>What a mess.  A doublefault inside an NMI watchdog timeout.  I think.  It's
>>>hard to see.  Some CPUs are stuck on a CPU scheduler lock, others seem to
>>>be stuck in flush_tlb_others.  One of these could be a consequence of the
>>>other, or both could be a consequence of something else.
>>
>>OK, well the latest one seems cleaner, on -rc3-mm1.
>>http://test.kernel.org/abat/30007/debug/console.log
>>
>>Just has the double fault, with no NMI watchdog timeouts. Not that
>>it means any more to me, but still ;-) mtest01 seems to be able to
>>reproduce this every time, but I don't have an appropriate box here
>>to diagnose it with (this was a 4x Opteron inside IBM), and it's
>>definitely something in -mm that's not in mainline.

Andy, any chance you could do another run on elm3b6 of ltp with:
2.6.17-rc3 + http://test.kernel.org/patches/2.6.17-rc3-mm1-64

Which is:

x86_64-add-compat_sys_vmsplice-and-use-it-in.patch
i386-x86-64-fix-acpi-disabled-lapic-handling.patch
x86_64-mm-defconfig-update.patch
x86_64-mm-phys-apicid.patch
x86_64-mm-memset-always-inline.patch
x86_64-mm-amd-core-cpuid.patch
x86_64-mm-amd-cpuid4.patch
x86_64-mm-alternatives.patch
x86_64-mm-pci-dma-cleanup.patch
x86_64-mm-ia32-unistd-cleanup.patch
x86_64-mm-large-bzimage.patch
x86_64-mm-topology-comment.patch
x86_64-mm-agp-select.patch
x86_64-mm-iommu_gart_bitmap-search-to-cross-next_bit.patch
x86_64-mm-new-compat-ptrace.patch
x86_64-mm-disable-agp-resource-check.patch
x86_64-mm-avoid-irq0-ioapic-pin-collision.patch
x86_64-mm-gart-direct-call.patch
x86_64-mm-new-northbridge.patch
x86_64-mm-iommu-warning.patch
x86_64-mm-serialize-assign_irq_vector-use-of-static-variables.patch
x86_64-mm-simplify-ioapic_register_intr.patch
x86_64-mm-i386-apic-overwrite.patch
x86_64-mm-i386-up-generic-arch.patch
x86_64-mm-iommu-enodev.patch
x86_64-mm-fix-die_lock-nesting.patch
x86_64-mm-add-nmi_exit-to-die_nmi.patch
x86_64-mm-compat-printk.patch
x86_64-mm-hotadd-reserve-fix-fix-fix.patch
x86_64-mm-compat-printk-fix.patch
x86_64-mm-new-northbridge-fix.patch
x86-64-calgary-iommu-introduce-iommu_detected.patch
x86-64-calgary-iommu-calgary-specific-bits.patch
x86-64-calgary-iommu-hook-it-in.patch
x86-64-check-for-valid-dma-data-direction-in-the-dma-api.patch

Thanks,

M.
