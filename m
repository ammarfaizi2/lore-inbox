Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269633AbUICJ5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269633AbUICJ5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269591AbUICJzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:55:04 -0400
Received: from [64.147.162.83] ([64.147.162.83]:1472 "EHLO
	thunderbolt.ipaska.net") by vger.kernel.org with ESMTP
	id S269605AbUICJvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:51:45 -0400
Date: Fri, 3 Sep 2004 19:50:31 +1000
From: Luke Yelavich <luke@audioslack.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, free78@tin.it
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Message-ID: <20040903095031.GA22607@luke-laptop.yelavich.home>
References: <1094171082.19760.7.camel@krustophenia.net> <1094181447.4815.6.camel@orbiter> <1094192788.19760.47.camel@krustophenia.net> <20040903063658.GA11801@elte.hu> <1094194157.19760.71.camel@krustophenia.net> <20040903070500.GB13100@elte.hu> <1094197233.19760.115.camel@krustophenia.net> <87acw7bxkh.fsf@agnula.org> <1094198755.19760.133.camel@krustophenia.net> <20040903092547.GA18594@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903092547.GA18594@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thunderbolt.ipaska.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - audioslack.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 07:25:47PM EST, Ingo Molnar wrote:
> 
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > As of -R0 it's definitely stable on UP and SMP users are reporting the
> > same.  All known problems should be fixed, and there are no known
> > regressions.  You should probably post a UP version and have your
> > users test that before posting SMP packages, the latter are not quite
> > as well tested.
> 
> Florian Schmidt reported a minor bug that prevents a successful build if
> !CONFIG_LATENCY_TRACE - i've uploaded -R1 that fixes this:
>   
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-R1
> 
> there are no other changes in -R1, and there are no known pending bugs
> currently.

I think I might be having a problem here, that I didn't have with previous
patches. Bare in mind that the previous patch I tested was against 2.6.8.1
vanilla.

I am using a D-Link KVM here between my notebook and my desktop machine.
It is the desktop I am currently testing these patches on, and the KVM
requires a double-tap of the scroll lock key to switch between machines. With
the latest R0 patch, something is not working when I attempt to change from
my desktop to my notebook. The KVM usually lets out a beep when I can
use the arrow keys to switch, but it isn't here. Adding to that, my console
locks up totally for about 10 seconds, before allowing me to go on and
type commands. I also seem to get some debugging output or a trace of
some sort when rebooting, and the kernel panics with the message:
(0)Kernel Panic - not syncing: Failed exception in interrupt

Included is some dmesg output from beginning of bootup.

Let me know if any more info is needed.
-- 
Luke Yelavich
http://www.audioslack.com
luke@audioslack.com

CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Badness in schedule at kernel/sched.c:2637
 [<c0302fb0>] schedule+0x558/0x55d
 [<c0302ff5>] preempt_schedule+0x40/0x5f
 [<c010041f>] rest_init+0x67/0x73
 [<c03da780>] start_kernel+0x195/0x1d4
 [<c03da38c>] unknown_bootoption+0x0/0x147
(swapper/1): new 666 us maximum-latency critical section.
 => started at: <preempt_schedule+0x3b/0x5f>
 => ended at:   <finish_task_switch+0x37/0x93>
 [<c012f01f>] check_preempt_timing+0x11b/0x1da
 [<c01103df>] finish_task_switch+0x37/0x93
 [<c01103df>] finish_task_switch+0x37/0x93
 [<c012f212>] sub_preempt_count+0x4d/0x65
 [<c012f212>] sub_preempt_count+0x4d/0x65
 [<c01103df>] finish_task_switch+0x37/0x93
 [<c011045e>] schedule_tail+0x23/0x5c
 [<c0105f5e>] ret_from_fork+0x6/0x14
 [<c010046b>] init+0x0/0x179
 [<c0104210>] kernel_thread_helper+0x0/0xb
Badness in schedule at kernel/sched.c:2637
 [<c0302fb0>] schedule+0x558/0x55d
 [<c0302ff5>] preempt_schedule+0x40/0x5f
 [<c0110439>] finish_task_switch+0x91/0x93
 [<c011045e>] schedule_tail+0x23/0x5c
 [<c0105f5e>] ret_from_fork+0x6/0x14
 [<c010046b>] init+0x0/0x179
 [<c0104210>] kernel_thread_helper+0x0/0xb
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1e60, last bus=2
(swapper/1): new 904 us maximum-latency critical section.
 => started at: <cond_resched+0xd/0x41>
 => ended at:   <cond_resched+0xd/0x41>
 [<c012f01f>] check_preempt_timing+0x11b/0x1da
 [<c0303417>] cond_resched+0xd/0x41
 [<c0303417>] cond_resched+0xd/0x41
 [<c012f114>] touch_preempt_timing+0x36/0x3a
 [<c012f114>] touch_preempt_timing+0x36/0x3a
 [<c0303417>] cond_resched+0xd/0x41
 [<c0138b6b>] kmem_cache_alloc+0x5f/0x61
 [<c0119fe8>] __request_region+0x26/0xbd
 [<c03f1336>] pci_direct_init+0x3e/0x10e
 [<c03da807>] do_initcalls+0x2f/0xbc
 [<c01004c4>] init+0x59/0x179
 [<c010046b>] init+0x0/0x179
 [<c0104215>] kernel_thread_helper+0x5/0xb
PCI: Using configuration type 1
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub

<snip>

get_random_bytes called before random driver initialization
(swapper/1): new 6605 us maximum-latency critical section.
 => started at: <cond_resched+0xd/0x41>
 => ended at:   <cond_resched+0xd/0x41>
 [<c012f01f>] check_preempt_timing+0x11b/0x1da
 [<c0303417>] cond_resched+0xd/0x41
 [<c0303417>] cond_resched+0xd/0x41
 [<c012f114>] touch_preempt_timing+0x36/0x3a
 [<c012f114>] touch_preempt_timing+0x36/0x3a
 [<c0303417>] cond_resched+0xd/0x41
 [<c0138da7>] __kmalloc+0x89/0x90
 [<c0183f6c>] proc_create+0x86/0xd9
 [<c018416b>] create_proc_entry+0x66/0xc9
 [<c03f1fcc>] dev_proc_init+0x2b/0xa3
 [<c03f206c>] net_dev_init+0x28/0x17c
 [<c03f1ce4>] pcibios_init+0x65/0x7e
 [<c03da807>] do_initcalls+0x2f/0xbc
 [<c01004c4>] init+0x59/0x179
 [<c010046b>] init+0x0/0x179
 [<c0104215>] kernel_thread_helper+0x5/0xb
(swapper/1): new 43385 us maximum-latency critical section.
 => started at: <cond_resched+0xd/0x41>
 => ended at:   <cond_resched+0xd/0x41>
 [<c012f01f>] check_preempt_timing+0x11b/0x1da
 [<c0303417>] cond_resched+0xd/0x41
 [<c0107b1d>] do_IRQ+0x14a/0x18e
 [<c0303417>] cond_resched+0xd/0x41
 [<c012f114>] touch_preempt_timing+0x36/0x3a
 [<c012f114>] touch_preempt_timing+0x36/0x3a
 [<c0303417>] cond_resched+0xd/0x41
 [<c0138b6b>] kmem_cache_alloc+0x5f/0x61
 [<c0119fe8>] __request_region+0x26/0xbd
 [<c01efb09>] isapnp_next_rdp+0x66/0xa1
 [<c03e6d2d>] isapnp_isolate_rdp_select+0x5b/0xc5
 [<c03e6eda>] isapnp_isolate+0x143/0x1f8
 [<c03e7c15>] isapnp_init+0xbb/0x2da
 [<c03da807>] do_initcalls+0x2f/0xbc
 [<c01004c4>] init+0x59/0x179
 [<c010046b>] init+0x0/0x179
 [<c0104215>] kernel_thread_helper+0x5/0xb
(swapper/1): new 43492 us maximum-latency critical section.
 => started at: <cond_resched+0xd/0x41>
 => ended at:   <cond_resched+0xd/0x41>
 [<c012f01f>] check_preempt_timing+0x11b/0x1da
 [<c0303417>] cond_resched+0xd/0x41
 [<c0303417>] cond_resched+0xd/0x41
 [<c012f114>] touch_preempt_timing+0x36/0x3a
 [<c012f114>] touch_preempt_timing+0x36/0x3a
 [<c0303417>] cond_resched+0xd/0x41
 [<c0138b6b>] kmem_cache_alloc+0x5f/0x61
 [<c0119fe8>] __request_region+0x26/0xbd
 [<c01efb09>] isapnp_next_rdp+0x66/0xa1
 [<c03e6d2d>] isapnp_isolate_rdp_select+0x5b/0xc5
 [<c03e6eda>] isapnp_isolate+0x143/0x1f8
 [<c03e7c15>] isapnp_init+0xbb/0x2da
 [<c03da807>] do_initcalls+0x2f/0xbc
 [<c01004c4>] init+0x59/0x179
 [<c010046b>] init+0x0/0x179
 [<c0104215>] kernel_thread_helper+0x5/0xb
(swapper/1): new 43561 us maximum-latency critical section.
 => started at: <cond_resched+0xd/0x41>
 => ended at:   <cond_resched+0xd/0x41>
 [<c012f01f>] check_preempt_timing+0x11b/0x1da
 [<c0303417>] cond_resched+0xd/0x41
 [<c0107b1d>] do_IRQ+0x14a/0x18e
 [<c0303417>] cond_resched+0xd/0x41
 [<c012f114>] touch_preempt_timing+0x36/0x3a
 [<c012f114>] touch_preempt_timing+0x36/0x3a
 [<c0303417>] cond_resched+0xd/0x41
 [<c0138b6b>] kmem_cache_alloc+0x5f/0x61
 [<c0119fe8>] __request_region+0x26/0xbd
 [<c01efb09>] isapnp_next_rdp+0x66/0xa1
 [<c03e6d2d>] isapnp_isolate_rdp_select+0x5b/0xc5
 [<c03e6eda>] isapnp_isolate+0x143/0x1f8
 [<c03e7c15>] isapnp_init+0xbb/0x2da
 [<c03da807>] do_initcalls+0x2f/0xbc
 [<c01004c4>] init+0x59/0x179
 [<c010046b>] init+0x0/0x179
 [<c0104215>] kernel_thread_helper+0x5/0xb
isapnp: No Plug & Play device found
requesting new irq thread for IRQ8...
Real Time Clock Driver v1.12
Using anticipatory io scheduler
<snip>
requesting new irq thread for IRQ6...
<snip>
IRQ#6 thread started up.
eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:e0:18:df:d5:b6
eth0: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
requesting new irq thread for IRQ3...
(dhcpcd/2226): new 115753 us maximum-latency critical section.
 => started at: <tg3_open+0xc9/0x263 [tg3]>
 => ended at:   <tg3_open+0x122/0x263 [tg3]>
 [<c012f01f>] check_preempt_timing+0x11b/0x1da
 [<f88c805a>] tg3_open+0x122/0x263 [tg3]
 [<f88c805a>] tg3_open+0x122/0x263 [tg3]
 [<c012f212>] sub_preempt_count+0x4d/0x65
 [<c012f212>] sub_preempt_count+0x4d/0x65
 [<f88c805a>] tg3_open+0x122/0x263 [tg3]
 [<c029f2ad>] dev_open+0xcf/0xfe
 [<c02a30c1>] dev_mc_upload+0x3d/0x5d
 [<c02a0987>] dev_change_flags+0x5b/0x12c
 [<c029e930>] __dev_get_by_name+0xe/0xb9
 [<c02e2d4b>] devinet_ioctl+0x247/0x5c1
 [<c02e5066>] inet_ioctl+0x5f/0x9f
 [<c0301f9d>] packet_ioctl+0x14d/0x177
 [<c0296a96>] sock_ioctl+0x112/0x2df
 [<c0161e06>] sys_ioctl+0x13a/0x2a0
 [<c0106087>] syscall_call+0x7/0xb
IRQ#3 thread started up.
divert: not allocating divert_blk for non-ethernet device sit0
(IRQ 1/716): new 204218 us maximum-latency critical section.
 => started at: <__do_softirq+0x39/0x59>
 => ended at:   <__do_softirq+0x4a/0x59>
 [<c012f01f>] check_preempt_timing+0x11b/0x1da
 [<c01186d0>] __do_softirq+0x4a/0x59
 [<c01186d0>] __do_softirq+0x4a/0x59
 [<c012f212>] sub_preempt_count+0x4d/0x65
 [<c012f212>] sub_preempt_count+0x4d/0x65
 [<c01186d0>] __do_softirq+0x4a/0x59
 [<c01194d6>] do_irqd+0x71/0x91
 [<c012819f>] kthread+0xaa/0xaf
 [<c0119465>] do_irqd+0x0/0x91
 [<c01280f5>] kthread+0x0/0xaf
 [<c0104215>] kernel_thread_helper+0x5/0xb
