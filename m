Return-Path: <linux-kernel-owner+w=401wt.eu-S1754838AbWL1M4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838AbWL1M4M (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 07:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbWL1M4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 07:56:12 -0500
Received: from il.qumranet.com ([62.219.232.206]:36433 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754838AbWL1M4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 07:56:11 -0500
Message-ID: <4593BEE6.30206@qumranet.com>
Date: Thu, 28 Dec 2006 14:56:06 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] kvm: fix GFP_KERNEL allocation in atomic section in kvm_dev_ioctl_create_vcpu()
References: <45939755.7010603@qumranet.com> <20061228124224.GA28573@elte.hu>
In-Reply-To: <20061228124224.GA28573@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> Subject: [patch] kvm: fix GFP_KERNEL allocation in atomic section in kvm_dev_ioctl_create_vcpu()
> From: Ingo Molnar <mingo@elte.hu>
>
> fix a GFP_KERNEL allocation in atomic section bug: 
> kvm_dev_ioctl_create_vcpu() called kvm_mmu_init(), which calls 
> alloc_pages(), while holding the vcpu. The fix is to set up the MMU 
> state earlier, it does not require a loaded CPU state.
>   

Yes it does.  It calls nonpaging_init_context() which calls 
vmx_set_cr3() which promptly trashes address space of the VM that 
previously ran on that vcpu (or, if there were none, logs a vmwrite error).

-- 
error compiling committee.c: too many arguments to function

