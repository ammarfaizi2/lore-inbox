Return-Path: <linux-kernel-owner+w=401wt.eu-S1030378AbWLaRuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbWLaRuM (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 12:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWLaRuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 12:50:12 -0500
Received: from il.qumranet.com ([62.219.232.206]:55325 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030378AbWLaRuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 12:50:11 -0500
Message-ID: <4597F851.8060800@qumranet.com>
Date: Sun, 31 Dec 2006 19:50:09 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Luca Tettamanti <kronos.it@gmail.com>
CC: linux-kernel@vger.kernel.org, kvm-devel@lists.sourceforge.net
Subject: Re: [KVM][PATCH] smp_processor_id() and sleeping functions used in
 invalid context
References: <20061231170147.GA8695@dreamland.darkstar.lan>
In-Reply-To: <20061231170147.GA8695@dreamland.darkstar.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Tettamanti wrote:
> Hello,
> I'm testing KVM on a Core2 CPU. I'm running kernel 2.6.20-git (pulled
> few hours ago), configured with SMP and PREEMPT.
>
> I'm hitting 2 different warnings:
> BUG: using smp_processor_id() in preemptible [00000001] code: kvm/7726
> caller is vmx_create_vcpu+0x9/0x2f [kvm_intel]
>
>   

[...]

> vmx_create_vcpu calls alloc_vmcs which uses smp_processor_id() in
> preemptible context and pass the result to alloc_vmcs_cpu(); at a later
> point the function may be running on a different CPU (hence the result
> of cpu_to_node may be meaningless).
>
> Second one:
> BUG: sleeping function called from invalid context at
> /home/kronos/src/linux-2.6.git/mm/slab.c:3034
> in_atomic():1, irqs_disabled():0
> 1 lock held by kvm/12706:
>  #0:  (&vcpu->mutex){--..}, at: [<f1b68d02>] kvm_dev_ioctl+0x113/0xf97
> [kvm]
>  [<b015c32a>] kmem_cache_alloc+0x1b/0x6f
>   
[...]

There are patches for both (I think) flying around.  They should land in 
Linus' tree in a few days.

Thanks,

-- 
error compiling committee.c: too many arguments to function

