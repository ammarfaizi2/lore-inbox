Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUKFRRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUKFRRb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 12:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUKFRRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 12:17:31 -0500
Received: from mail8.spymac.net ([195.225.149.8]:52917 "EHLO mail8")
	by vger.kernel.org with ESMTP id S261422AbUKFRRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 12:17:10 -0500
Message-ID: <418D0711.70109@spymac.com>
Date: Sat, 06 Nov 2004 18:17:05 +0100
From: Gunther Persoons <gunther_persoons@spymac.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.18
References: <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu>
In-Reply-To: <20041106155720.GA14950@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>i have released the -V0.7.18 Real-Time Preemption patch, which can be
>downloaded from:
>
>   http://redhat.com/~mingo/realtime-preempt/
>
>this release includes fixes and cleanups.
>
>Changes between -V0.7.12 and -V0.7.18:
>
> - merged to 2.6.10-rc1-mm3
>
> - fixed the e1000 xmit warnings reported by Amit Shah. Same fix for tg3
>   too.
>
> - added irq-latency fix from Thomas Gleixner: re-enable interrupts
>   before adding timings to the entropy pool.
>
> - fixed excessive ksoftirqd overhead during outgoing TCP traffic. 
>   ksoftirqd kept getting re-woken while it had no way to progress.
>
> - added upstream fix from Andi Kleen for the vmalloc bug causing module
>   load problems/crashes. Added ipc/shm fix too.
>
>Changes between -V0.7.1 and -V0.7.12:
>
> - big source level cleanups: completely rearranged the mutex type
>   definitions and source files, to make it reflect the code. Made
>   all locking objects based on a new, central lock type: struct
>   rt_mutex. This type is never exposed externally, it is internal to
>   the RT code. Unified all the RT locking code in kernel/rt.c, this 
>   also simplified and sped things up. Undid collateral damage to the
>   generic rwsem code - it is now untouched and independent of the RT
>   code.
>
> - rearranged the way spinlocks interact with the RT code and cleaned 
>   up the RT spinlock definitions. Found and fixed a bug in the process:
>   rwlocks were dropping the BKL upon contention.
>
> - small x86 speedup: call __schedule not preempt_schedule_irq from
>   work_resched.
>
> - ported PREEMPT_RT to x64. This resulted in the generalization of some
>   of the x86 changes.
>
> - hopefully fixed fbcon kernel logging
>
> - hacked reiser4 to make it work on PREEMPT_REALTIME.
>
> - dropped the swap-layout-improvements patch. While it was working fine 
>   it's not necessary for latencies anymore under the PREEMPT_REALTIME
>   approach, and the swap-patch was getting intrusive.
>
> - fixed preemption-bug in drain_cpu_caches() on SMP [bug introduced by
>   PREEMPT_REALTIME]
>
> - new attempt at getting rid of the networking related deadlocks
>
> - selinux deadlock fix and RCU-code conversion to RT semantics
>
>to create a -V0.7.18 tree from scratch, the patching order is:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc1.bz2
>   http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/2.6.10-rc1-mm3.bz2
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc1-mm3-V0.7.18
>
>	Ingo
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Got a bug:

Assertion failure in __journal_unfile_buffer() at 
fs/jbd/transaction.c:1447: "jbd_is_locked_bh_state(bh)"
BUG at fs/jbd/transaction.c:1447!
------------[ cut here ]------------
kernel BUG at fs/jbd/transaction.c:1447!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: reiser4 radeon airo_cs airo ohci_hcd ehci_hcd 8139cp 
mii ohci1394 ieee1394 snd_intel8x0 snd_ac97_codec usbhid uhci_hcd 
intel_agp agpgart snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device 
snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd usbcore 
vfat fat
CPU:    0
EIP:    0060:[<c01d69d2>]    Not tainted VLI
EFLAGS: 00010246   (2.6.10-rc1-mm3-RT-V0.7.18)
EIP is at __journal_unfile_buffer+0x102/0x230
eax: 00000022   ebx: c0ef211c   ecx: c0378081   edx: cf951d7c
esi: cb2185c4   edi: cb2185c4   ebp: 00000000   esp: cf951d78
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process kjournald (pid: 6286, threadinfo=cf950000 task=cf941320)
Stack: c0378081 c037f479 000005a7 c0386db4 c036b2a3 c037f479 000005a7 
c037f5e4
       c0ef211c cb2185c4 00000000 cb299580 c01d7aec c0ef211c cf651250 
00000001
       cb2995b8 cf651014 cf950000 cf950000 c0137f43 00000000 00000000 
00000000
Call Trace:
 [<c01d7aec>] journal_commit_transaction+0x2dc/0x12a0 (52)
 [<c0137f43>] __up_mutex+0x293/0x470 (32)
 [<c011ccf0>] recalc_task_prio+0xd0/0x210 (28)
 [<c011ce8b>] activate_task+0x5b/0x90 (40)
 [<c013947a>] trace_start_sched_wakeup+0xca/0xf0 (16)
 [<c01daf39>] kjournald+0xe9/0x260 (284)
 [<c0136720>] autoremove_wake_function+0x0/0x40 (32)
 [<c0136720>] autoremove_wake_function+0x0/0x40 (32)
 [<c011d3de>] finish_task_switch+0x3e/0xb0 (20)
 [<c012a4c6>] __mod_timer+0x36/0x1c0 (48)
 [<c01dae30>] commit_timeout+0x0/0x10 (24)
 [<c01dae50>] kjournald+0x0/0x260 (12)
 [<c01042b5>] kernel_thread_helper+0x5/0x10 (16)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c0106971>] .... die+0x31/0x180
.....[<00000000>] ..   ( <= 0x0)
.. [<c013960c>] .... print_traces+0xc/0x40
.....[<00000000>] ..   ( <= 0x0)

Code: 05 00 00 68 79 f4 37 c0 68 a3 b2 36 c0 68 b4 6d 38 c0 e8 a2 b4 f4 
ff 68 a7 05 00 00 68 79 f4 37 c0 68 81 80 37 c0 e8 8e b4 f4 ff <0f> 0b 
a7 05 79 f4 37 c0 83 c4 20 e9 07 ff ff ff 8d b4 26 00 00
 kjournald:6286 BUG: lock held at task exit time!
 [cf651250] {&journal->j_list_lock}
.. held by:         kjournald/ 6286 [cf941320, 116]
... acquired at:  journal_commit_transaction+0x2a9/0x12a0

BUG at kernel/timer.c:166!
------------[ cut here ]------------
kernel BUG at kernel/timer.c:166!
invalid operand: 0000 [#2]
PREEMPT
Modules linked in: reiser4 radeon airo_cs airo ohci_hcd ehci_hcd 8139cp 
mii ohci1394 ieee1394 snd_intel8x0 snd_ac97_codec usbhid uhci_hcd 
intel_agp agpgart snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device 
snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd usbcore 
vfat fat
CPU:    0
EIP:    0060:[<c012a5f2>]    Not tainted VLI
EFLAGS: 00010296   (2.6.10-rc1-mm3-RT-V0.7.18)
EIP is at __mod_timer+0x162/0x1c0
eax: 0000001b   ebx: 00000000   ecx: c0378081   edx: c13ddcc8
esi: cf951f90   edi: cb299480   ebp: cf651014   esp: c13ddcc4
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process pdflush (pid: 165, threadinfo=c13dc000 task=c13db970)
Stack: c0378081 c037a8eb 000000a6 00000000 c037f48e cb299480 cf651000 
cb299480
       cf651014 c01d4c37 cf951f90 0008ec57 00000000 cf651000 c01d4d60 
cf651000
       cb299480 cf651014 c13e7780 c13e77c4 c0138573 c13e77c4 00000001 
c0149843
Call Trace:
 [<c01d4c37>] get_transaction+0x67/0xd0 (40)
 [<c01d4d60>] start_this_handle+0xc0/0x3e0 (20)
 [<c0138573>] up_mutex+0x23/0xa0 (24)
 [<c0149843>] cache_grow+0x133/0x250 (12)
 [<c0137f43>] __up_mutex+0x293/0x470 (36)
 [<c0149e5b>] kmem_cache_alloc+0x4b/0xd0 (16)
 [<c0149e5b>] kmem_cache_alloc+0x4b/0xd0 (12)
 [<c0138573>] up_mutex+0x23/0xa0 (12)
 [<c0149e5b>] kmem_cache_alloc+0x4b/0xd0 (12)
 [<c0149e5b>] kmem_cache_alloc+0x4b/0xd0 (12)
 [<c01d5154>] journal_start+0x94/0xc0 (32)
 [<c01c7dd5>] ext3_ordered_writepage+0x65/0x190 (24)
 [<c0183fc1>] mpage_writepages+0x261/0x410 (28)
 [<c01c7d70>] ext3_ordered_writepage+0x0/0x190 (24)
 [<c0137f43>] __up_mutex+0x293/0x470 (52)
 [<c0182063>] __sync_single_inode+0x53/0x280 (16)
 [<c01466f9>] do_writepages+0x39/0x40 (28)
 [<c018206f>] __sync_single_inode+0x5f/0x280 (16)
 [<c01822be>] __writeback_single_inode+0x2e/0x140 (36)
 [<c036483d>] __down_mutex+0xed/0x390 (24)
 [<c036483d>] __down_mutex+0xed/0x390 (12)
 [<c0364a04>] __down_mutex+0x2b4/0x390 (16)
 [<c0182569>] generic_sync_sb_inodes+0x199/0x300 (40)
 [<c01827cc>] writeback_inodes+0xcc/0xe0 (48)
 [<c0146f80>] pdflush+0x0/0x30 (24)
 [<c01464d3>] wb_kupdate+0x93/0x110 (4)
 [<c0146e78>] __pdflush+0xb8/0x1c0 (56)
 [<c0146e80>] __pdflush+0xc0/0x1c0 (36)
 [<c0146f9e>] pdflush+0x1e/0x30 (20)
 [<c0146440>] wb_kupdate+0x0/0x110 (20)
 [<c03634f1>] schedule+0x31/0x100 (20)
 [<c0136243>] kthread+0x83/0xc0 (8)
 [<c01361c0>] kthread+0x0/0xc0 (20)
 [<c01042b5>] kernel_thread_helper+0x5/0x10 (16)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c0106971>] .... die+0x31/0x180
.....[<00000000>] ..   ( <= 0x0)
.. [<c013960c>] .... print_traces+0xc/0x40
.....[<00000000>] ..   ( <= 0x0)

Code: e4 00 00 39 5e 4c 58 0f 84 6a ff ff ff 68 e0 32 3c c0 e9 27 ff ff 
ff 68 a6 00 00 00 68 eb a8 37 c0 68 81 80 37 c0 e8 6e 78 ff ff <0f> 0b 
a6 00 eb a8 37 c0 83 c4 0c e9 ab fe ff ff 68 a5 00 00 00
 pdflush:165 BUG: lock held at task exit time!
 [cf725840] {&s->s_umount}
.. held by:           pdflush/  165 [c13db970, 115]
... acquired at:  writeback_inodes+0x4b/0xe0
pdflush:165 BUG: lock held at task exit time!
 [cf651014] {&journal->j_state_lock}
.. held by:           pdflush/  165 [c13db970, 115]
... acquired at:  start_this_handle+0x61/0x3e0

