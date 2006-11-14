Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966209AbWKNRAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966209AbWKNRAv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 12:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966211AbWKNRAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 12:00:51 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:26294 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S966209AbWKNRAu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 12:00:50 -0500
Date: Tue, 14 Nov 2006 22:30:53 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Reuben Farrelly <reuben-linuxkernel@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5-mm2
Message-ID: <20061114170053.GA22649@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061114014125.dd315fff.akpm@osdl.org> <4559A91C.10009@reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4559A91C.10009@reub.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 10:31:40PM +1100, Reuben Farrelly wrote:

Hi Reuben,

> Oops:
> 
> (davej cc'd - I think it's his specialty)
> 

[snip]

> ------------[ cut here ]------------
> kernel BUG at drivers/cpufreq/cpufreq_userspace.c:138!
> invalid opcode: 0000 [1] SMP
> last sysfs file:
> CPU 0
> Modules linked in:
> Pid: 1, comm: swapper Not tainted 2.6.19-rc5-mm2 #1
> RIP: 0010:[<ffffffff80435299>]  [<ffffffff80435299>] 
> cpufreq_governor_userspace+0x4e/0x1aa
> RSP: 0000:ffff81003f61fb40  EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff81003ef4a0d8 RCX: 0000000000000003
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff81003ef4a0d8
> RBP: ffff81003f61fb60 R08: 0000000000000002 R09: 0000000000000001
> R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000000
> R13: 00000000ffffffea R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffffff80652000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000000 CR3: 0000000000201000 CR4: 00000000000006e0
> Process swapper (pid: 1, threadinfo ffff81003f61e000, task ffff810037ff0040)
> Stack:  ffff81003f61fb60 ffff81003ef4a0d8 0000000000000001 ffff81003ef4a0d8
>  ffff81003f61fb90 ffffffff80433b11 ffffffff805d0e80 ffff81003f61fc20
>  0000000000000000 ffff81003ef4a0d8 ffff81003f61fbc0 ffffffff80434278
> Call Trace:
>  [<ffffffff80433b11>] __cpufreq_governor+0x51/0x9b
>  [<ffffffff80434278>] __cpufreq_set_policy+0xf8/0x13b
>  [<ffffffff804343e9>] cpufreq_set_policy+0x3c/0x93
>  [<ffffffff80435125>] cpufreq_add_dev+0x315/0x427
>  [<ffffffff803b6f87>] sysdev_driver_register+0x87/0xdb
>  [<ffffffff80434a8e>] cpufreq_register_driver+0x9e/0x120
>  [<ffffffff806837b2>] acpi_cpufreq_init+0xbe/0xc9
>  [<ffffffff802666c0>] init+0x160/0x31c
>  [<ffffffff8025deb8>] child_rip+0xa/0x12
> 
> 

Hmmm.. The BUG indicates policy->cur i.e current frequency is 0.

In this scenario, policy->cur variable was last set inside 
acpi_cpufreq_cpu_init when cpufreq_add_dev made a call to 
cpufreq_driver->init(policy).

Are you able to reproduce this with 2.6.19-rc5-mm1? 

Because AFAICS, there ain't many changes w.r.t x86_64 acpi-cpufreq 
from 2.6.19-rc5-mm1 to 2.6.19-rc5-mm2. 

> 
> I've put the full config up at 
> http://www.reub.net/files/kernel/configs/2.6.19-rc5-mm1-brokencpufreq

I hope the name 2.6.19-rc5-'mm1'-brokencpufreq is by mistake :-)

> Disable cpufreq in the config and the kernel otherwise boots and works fine.
> 
> Reuben

regards,
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
