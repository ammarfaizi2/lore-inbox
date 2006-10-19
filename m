Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945956AbWJSBfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945956AbWJSBfs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 21:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945960AbWJSBfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 21:35:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:22581 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1945956AbWJSBfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 21:35:48 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,326,1157353200"; 
   d="scan'208"; a="148693765:sNHT21046991"
Message-ID: <4536D668.80302@intel.com>
Date: Thu, 19 Oct 2006 09:35:36 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64 add NX mask for PTE entry
References: <4535F0A4.1090709@intel.com> <200610181258.45176.ak@suse.de>
In-Reply-To: <200610181258.45176.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is oops message everytime when rebooting system,
and oops place is random, my machine is Pentium Dual core with
1G memory, no NX protection supports.

PMD value should be 0x000000003e4001e3 but not 0x800000003e4001e3,
possibly there should be finer dump_pagetable() function to point
out detail error type by page fault error code.

thanks
bibo,mao

Kernel 2.6.19-rc2 on an x86_64
INIT: Sending processes the TERM signal
Unable to handle kernel paging request at ffff81003e5fcde0 RIP:
  [<ffffffff812b9918>] __lock_text_start+0x0/0xf
PGD 8063 PUD 9063 PMD 800000003e4001e3 BAD
Oops: 000b [1] SMP
CPU 0
Modules linked in: i2c_dev i2c_core e1000 ext3 jbd
Pid: 4629, comm: default.hotplug Not tainted 2.6.19-rc2 #2
RIP: 0010:[<ffffffff812b9918>]  [<ffffffff812b9918>] 
__lock_text_start+0x0/0xf
RSP: 0018:ffff81003354fe50  EFLAGS: 00010286
RAX: 00002b756d31c000 RBX: ffff81003e5fcda0 RCX: ffff81000000a400
RDX: ffff810033c02a90 RSI: 0000000000000005 RDI: ffff81003e5fcde0
RBP: ffff81003e8914c0 R08: 00002b756d0f7000 R09: ffff81000000a400
R10: 0000003d31831e88 R11: 0000000000000286 R12: ffff81003f4c6138
R13: 0000000000000000 R14: 0000000000000000 R15: ffff81003354feb8
FS:  0000000000000000(0000) GS:ffffffff81435000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffff81003e400fe0 CR3: 0000000034366000 CR4: 00000000000006e0
Process default.hotplug (pid: 4629, threadinfo ffff81003354e000, task 
ffff81003e
ee5710)
Stack:  ffffffff810659de ffff81003f4c6138 ffff8100373ef8c8 00002b756d0f7000
  ffffffff81061959 0000000000000008 ffff810001571860 ffff810033a44558
  ffff81003e7a5940 0000000000000000 00000000006c4470 0000000000000000
Call Trace:
  [<ffffffff810659de>] unlink_file_vma+0x23/0x3d
  [<ffffffff81061959>] free_pgtables+0x66/0xb2
  [<ffffffff81067a45>] exit_mmap+0x88/0xe8
  [<ffffffff81030196>] mmput+0x31/0xa0
  [<ffffffff810350ed>] do_exit+0x1ec/0x82e
  [<ffffffff8103dfd7>] sys_rt_sigaction+0x85/0xa4
  [<ffffffff810357db>] sys_exit_group+0x0/0xe
  [<ffffffff81009b4e>] system_call+0x7e/0x83


Code: f0 ff 0f 79 09 f3 90 83 3f 00 7e f9 eb f2 c3 31 c0 87 07 85
RIP  [<ffffffff812b9918>] __lock_text_start+0x0/0xf
  RSP <ffff81003354fe50>
CR2: ffff81003e5fcde0

Andi Kleen wrote:
> On Wednesday 18 October 2006 11:15, bibo,mao wrote:
>> Hi,
>>     If function change_page_attr_addr calls revert_page to revert
>> to original pte value, mk_pte_phys does not mask NX bit. If NX bit
>> is set on no NX hardware supported x86_64 machine, there is will
>> be RSVD type page fault and system will crash. This patch adds NX
>> mask bit for PTE entry.
> 
> Hmm, weird. I wonder why that didn't trip up earlier. Did you
> actually see that happening? 
> 
> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
