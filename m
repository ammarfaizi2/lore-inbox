Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269715AbUJHIHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269715AbUJHIHB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 04:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269745AbUJHIHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 04:07:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:63398 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269715AbUJHIGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 04:06:51 -0400
Subject: Re: 2.6.9-rc3-mm3 BUG() in flush_tlb_pending() on ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1097187487.12861.308.camel@dyn318077bld.beaverton.ibm.com>
References: <1097187487.12861.308.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1097222359.32157.123.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 17:59:19 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 08:18, Badari Pulavarty wrote:
> Hi,
> 
> I get following assert while booting 2.6.9-rc3-mm3 on p3 machine. 
> Any fixes ?

Looks like we triggered

BUG_ON(in_interrupt()) from switch_to() ... rather bad ..

Ben.

> Thanks,
> Badari
>  
> 
>         scanning pci: *..kernel BUG in __flush_tlb_pending at
> arch/ppc64/mm/tlb.c:125!
> Oops: Exception in kernel mode, sig: 5 [#1]
> SMP NR_CPUS=128 NUMA PSERIES
> NIP: C00000000003E39C XER: 0000000020000000 LR: C000000000014DF8
> REGS: c00000000f0c3550 TRAP: 0700   Not tainted  (2.6.9-rc3-mm3)
> MSR: a000000000023032 EE: 0 PR: 0 FP: 1 ME: 1 IR/DR: 11
> TASK: c00000013e983030[1401] 'pci.agent' THREAD: c00000000f0c0000 CPU: 0
> GPR00: 0000000004000000 C00000000F0C37D0 C0000000005D2D98
> C0000000006DF1A0
> GPR04: C00000003F557030 0000000BC8479B69 C0000000005D1008
> C0000000004593B0
> GPR08: 0000000000288000 C00000000F0C0000 C0000000005D1008
> 000000000000003A
> GPR12: 0000000028224482 C0000000004B9900 C00000013E9832D0
> 000001C0E7B672A0
> GPR16: C0000000005D1008 0000000000B735C0 0000000000000000
> C00000000FD85280
> GPR20: C0000000006E2E88 C00000000F0C3990 C00000003F557030
> C0000000006E1C38
> GPR24: C000000006325FFC C00000013E983030 00000000F2592693
> C00000003F557030
> GPR28: 0000000000002AF0 C00000013E983030 0000000000000000
> C0000000006DF1A0
> NIP [c00000000003e39c] .__flush_tlb_pending+0x38/0x150
> LR [c000000000014df8] .__switch_to+0xb4/0xd8
> Call Trace:
> [c00000000f0c37d0] [00000000f7fad210] 0xf7fad210 (unreliable)
> [c00000000f0c3890] [c000000000014df8] .__switch_to+0xb4/0xd8
> [c00000000f0c3920] [c00000000039b184] .schedule+0x38c/0xc3c
> [c00000000f0c3a40] [c00000000039bbd0] .cond_resched+0x4c/0x80
> [c00000000f0c3ac0] [c00000000009696c] .copy_page_range+0x29c/0x61c
> [c00000000f0c3bd0] [c00000000004f990] .copy_process+0x8c0/0x148c
> [c00000000f0c3ce0] [c0000000000505fc] .do_fork+0xa0/0x25c
> [c00000000f0c3dc0] [c0000000000146d8] .sys_clone+0x5c/0x74
> [c00000000f0c3e30] [c000000000010288] .ppc_clone+0x8/0xc
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

