Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751851AbWJAA72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbWJAA72 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 20:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWJAA72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 20:59:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:7319 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751851AbWJAA70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 20:59:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PBXkpV4KMoLLVslhdm+9vetPvCLNhYiMcwPvMdjB+ultTPmA09IYGEpp8Rda1ijIowWOGDAH/W4MyGZjNo9JEvlQrvIyEuH4TG3ReKCuTwtnew30io/vlI6MtmRc+SmKzNMvobkPRt+xzMTFyvtdZhlpGz9mwwHFCDs7KXT3gIQ=
Message-ID: <5f3c152b0609301759x22c2c2d9kc05b6977b3cce509@mail.gmail.com>
Date: Sun, 1 Oct 2006 02:59:25 +0200
From: "Eric Rannaud" <eric.rannaud@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <20060930220505.GA19338@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
	 <20060930131310.0d6494e7.akpm@osdl.org>
	 <5f3c152b0609301352w5bc52653s3e2a28e482c7d69e@mail.gmail.com>
	 <20060930140426.37918062.akpm@osdl.org>
	 <5f3c152b0609301500l52a4c6c5o2052b88621dc7ca3@mail.gmail.com>
	 <20060930220505.GA19338@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/06, Ingo Molnar <mingo@elte.hu> wrote:
> hm, does the patch below solve it?

Well, your patch applied against v2.6.18 (I tried with git HEAD
cfae35804bcb909225d6f4eb5bd29e25971614d8 but it seems there is another
problem with the megaraid driver that I'm going to report separatly),
removes the BUG from lockdep and produces the following Oops.

I tried with noapic, but I got a (somewhat) similar stack trace, but a
bit earlier, although I couldn't get anything on netconsole.

er.


----
[  274.496966] BUG: soft lockup detected on CPU#15!
[  279.610130] NMI Watchdog detected LOCKUP on CPU 15
[  279.610192] CPU 15
[  279.610281] Modules linked in: dm_snapshot dm_zero dm_mirror ext3
jbd sata_nv libata
[  279.610646] Pid: 1, comm: init Not tainted
2.6.18--ingo-lockdep-allowdeeperrec-agst-2.6.18rannaud-dirty #47
[  279.610728] RIP: 0010:[<ffffffff8104ef59>]  [<ffffffff8104ef59>]
.text.lock.lockdep+0x52/0x89
[  279.610849] RSP: 0000:ffff8102238e7bc8  EFLAGS: 00000082
[  279.610909] RAX: ffffffff81691078 RBX: 00000000000028aa RCX: 0000000000000000
[  279.610973] RDX: ffffffff81680ca0 RSI: ffff810223f757c0 RDI: ffff810223f75040
[  279.611036] RBP: ffff8102238e7c38 R08: 0000000000000002 R09: 0000000000000001
[  279.611099] R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff81680ca0
[  279.611162] R13: ffff810223f757c0 R14: ffff810223f75040 R15: 0000000000000000
[  279.611225] FS:  0000000000587850(0063) GS:ffff810223894ac0(0000)
knlGS:0000000000000000
[  279.611305] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  279.611365] CR2: 0000000000585230 CR3: 0000000223a91000 CR4: 00000000000006e0
[  279.611430] Process init (pid: 1, threadinfo ffff810223e00000, task
ffff810223f75040)
[  279.611506] Stack:  ffff8102238e7cc0 ffff8102238e7cc8
ffff8102238e7c18 ffffffff81056da0
[  279.611767]  0000000200000001 0000000000000000 ffff810223e01d78
0000000200000001
[  279.611987]  ffff810223f75750 0000000000000046 ffffffff81056830
0000000000000002
[  279.612158] Call Trace:
[  279.612260]  <IRQ> [<ffffffff81056da0>] kallsyms_lookup+0xd0/0x1f0
[  279.612362]  [<ffffffff81056830>] module_text_address+0x20/0x50
[  279.612424]  [<ffffffff8104ea6b>] lock_acquire+0x8b/0xc0
[  279.612486]  [<ffffffff81056830>] module_text_address+0x20/0x50
[  279.612549]  [<ffffffff812bd966>] _spin_lock_irqsave+0x36/0x50
[  279.612610]  [<ffffffff81056830>] module_text_address+0x20/0x50
[  279.612673]  [<ffffffff81045142>] kernel_text_address+0x22/0x40
[  279.612735]  [<ffffffff8100b270>] show_trace+0x220/0x260
[  279.612795]  [<ffffffff81063114>] softlockup_tick+0xd4/0x110
[  279.612856]  [<ffffffff8100b4f5>] dump_stack+0x15/0x20
[  279.612916]  [<ffffffff8106312a>] softlockup_tick+0xea/0x110
[  279.612978]  [<ffffffff81043c60>] delayed_work_timer_fn+0x0/0x40
[  279.613039]  [<ffffffff8103b2b3>] run_local_timers+0x13/0x20
[  279.613099]  [<ffffffff8103b567>] update_process_times+0x57/0x90
[  279.613161]  [<ffffffff8101617b>] smp_local_timer_interrupt+0x2b/0x60
[  279.613223]  [<ffffffff81016938>] smp_apic_timer_interrupt+0x58/0x70
[  279.613285]  [<ffffffff8100a76f>] apic_timer_interrupt+0x6b/0x70
[  279.613347]  [<ffffffff812bd820>] _spin_unlock_irq+0x30/0x40
[  279.613408]  [<ffffffff8103b9e6>] run_timer_softirq+0x156/0x200
[  279.613471]  [<ffffffff81037890>] __do_softirq+0x80/0x110
[  279.613532]  [<ffffffff8100adf8>] call_softirq+0x1c/0x34
[  279.613592]  [<ffffffff8100c35d>] do_softirq+0x3d/0xc0
[  279.613652]  [<ffffffff81037567>] irq_exit+0x57/0x60
[  279.613711]  [<ffffffff8101693d>] smp_apic_timer_interrupt+0x5d/0x70
[  279.613775]  [<ffffffff8100a76f>] apic_timer_interrupt+0x6b/0x70
[  279.613834]  <EOI> [<ffffffff812bd8bc>] _spin_unlock_irqrestore+0x4c/0x60
[  279.613937]  [<ffffffff8104783e>] prepare_to_wait+0x6e/0x80
[  279.613998]  [<ffffffff812bb503>] __wait_on_bit+0x33/0x80
[  279.614058]  [<ffffffff81092110>] sync_buffer+0x0/0x50
[  279.614117]  [<ffffffff81092110>] sync_buffer+0x0/0x50
[  279.614177]  [<ffffffff812bb5c8>] out_of_line_wait_on_bit+0x78/0x90
[  279.614239]  [<ffffffff81047670>] wake_bit_function+0x0/0x40
[  279.614300]  [<ffffffff810919c2>] __wait_on_buffer+0x22/0x30
[  279.614360]  [<ffffffff81094e71>] __bread+0xa1/0xc0
[  279.614427]  [<ffffffff88044dfd>] :ext3:ext3_fill_super+0x83d/0x16f0
[  279.614490]  [<ffffffff812bb945>] __mutex_unlock_slowpath+0x125/0x140
[  279.614553]  [<ffffffff8104ed1b>] trace_hardirqs_on+0x11b/0x150
[  279.614615]  [<ffffffff81097947>] get_sb_bdev+0x117/0x180
[  279.614681]  [<ffffffff880445c0>] :ext3:ext3_fill_super+0x0/0x16f0
[  279.614743]  [<ffffffff811058fe>] selinux_sb_copy_data+0x18e/0x1b6
[  279.614809]  [<ffffffff88042523>] :ext3:ext3_get_sb+0x13/0x20
[  279.614870]  [<ffffffff81096ce6>] vfs_kern_mount+0xb6/0x160
[  279.614933]  [<ffffffff81096dfa>] do_kern_mount+0x4a/0x70
[  279.614994]  [<ffffffff810afc1f>] do_mount+0x71f/0x790
[  279.615056]  [<ffffffff8106b557>] get_page_from_freelist+0x287/0x480
[  279.615120]  [<ffffffff8104ed1b>] trace_hardirqs_on+0x11b/0x150
[  279.615184]  [<ffffffff8104ed1b>] trace_hardirqs_on+0x11b/0x150
[  279.615247]  [<ffffffff8106b7c3>] __alloc_pages+0x73/0x300
[  279.615307]  [<ffffffff812bd8b9>] _spin_unlock_irqrestore+0x49/0x60
[  279.615371]  [<ffffffff81083334>] alloc_pages_current+0x84/0x90
[  279.615436]  [<ffffffff8106a98b>] __get_free_pages+0x1b/0x40
[  279.615498]  [<ffffffff810afd24>] sys_mount+0x94/0xe0
[  279.615558]  [<ffffffff812bce8a>] trace_hardirqs_on_thunk+0x35/0x37
[  279.615621]  [<ffffffff81009b4e>] system_call+0x7e/0x83
[  279.615680]
[  279.615731]
[  279.615732] Code: 83 3d 90 fc 30 00 00 7e f5 e9 66 f1 ff ff f3 90 83 3d 80 fc
[  279.616600] console shuts up ...
[  279.616655]  <3>BUG: sleeping function called from invalid context
at kernel/rwsem.c:20
[  279.775463] in_atomic():1, irqs_disabled():0
[  279.775522]
[  279.775522] Call Trace:
[  279.775626]  <NMI> [<ffffffff81028dbb>] __might_sleep+0xbb/0xd0
[  279.775728]  [<ffffffff8104a6ed>] down_read+0x1d/0x50
[  279.775789]  [<ffffffff81040212>] blocking_notifier_call_chain+0x22/0x50
[  279.775853]  [<ffffffff810327b5>] profile_task_exit+0x15/0x20
[  279.775914]  [<ffffffff810341e5>] do_exit+0x25/0x9a0
[  279.775976]  [<ffffffff81031c29>] release_console_sem+0x59/0x250
[  279.776040]  [<ffffffff812be27d>] die_nmi+0xcd/0xd0
[  279.776100]  [<ffffffff812beb05>] nmi_watchdog_tick+0x115/0x1d0
[  279.776162]  [<ffffffff812be58d>] default_do_nmi+0x8d/0x190
[  279.776223]  [<ffffffff812bec21>] do_nmi+0x61/0xa0
[  279.776285]  [<ffffffff812bdf23>] nmi+0x7f/0x80
[  279.776345]  [<ffffffff8104ef59>] .text.lock.lockdep+0x52/0x89
[  279.776406]  <EOE> <IRQ> [<ffffffff81056da0>] kallsyms_lookup+0xd0/0x1f0
[  279.776544]  [<ffffffff81056830>] module_text_address+0x20/0x50
[  279.776607]  [<ffffffff8104ea6b>] lock_acquire+0x8b/0xc0
[  279.776667]  [<ffffffff81056830>] module_text_address+0x20/0x50
[  279.776730]  [<ffffffff812bd966>] _spin_lock_irqsave+0x36/0x50
[  279.776792]  [<ffffffff81056830>] module_text_address+0x20/0x50
[  279.776854]  [<ffffffff81045142>] kernel_text_address+0x22/0x40
[  279.776918]  [<ffffffff8100b270>] show_trace+0x220/0x260
[  279.776978]  [<ffffffff81063114>] softlockup_tick+0xd4/0x110
[  279.777040]  [<ffffffff8100b4f5>] dump_stack+0x15/0x20
[  279.778250]  [<ffffffff8106312a>] softlockup_tick+0xea/0x110
[  279.778312]  [<ffffffff81043c60>] delayed_work_timer_fn+0x0/0x40
[  279.778373]  [<ffffffff8103b2b3>] run_local_timers+0x13/0x20
[  279.778434]  [<ffffffff8103b567>] update_process_times+0x57/0x90
[  279.778496]  [<ffffffff8101617b>] smp_local_timer_interrupt+0x2b/0x60
[  279.778559]  [<ffffffff81016938>] smp_apic_timer_interrupt+0x58/0x70
[  279.778622]  [<ffffffff8100a76f>] apic_timer_interrupt+0x6b/0x70
[  279.778684]  [<ffffffff812bd820>] _spin_unlock_irq+0x30/0x40
[  279.778745]  [<ffffffff8103b9e6>] run_timer_softirq+0x156/0x200
[  279.778808]  [<ffffffff81037890>] __do_softirq+0x80/0x110
[  279.778870]  [<ffffffff8100adf8>] call_softirq+0x1c/0x34
[  279.778931]  [<ffffffff8100c35d>] do_softirq+0x3d/0xc0
[  279.778991]  [<ffffffff81037567>] irq_exit+0x57/0x60
[  279.779053]  [<ffffffff8101693d>] smp_apic_timer_interrupt+0x5d/0x70
[  279.779115]  [<ffffffff8100a76f>] apic_timer_interrupt+0x6b/0x70
[  279.779176]  <EOI> [<ffffffff812bd8bc>] _spin_unlock_irqrestore+0x4c/0x60
[  279.779279]  [<ffffffff8104783e>] prepare_to_wait+0x6e/0x80
[  279.779340]  [<ffffffff812bb503>] __wait_on_bit+0x33/0x80
[  279.779400]  [<ffffffff81092110>] sync_buffer+0x0/0x50
[  279.779460]  [<ffffffff81092110>] sync_buffer+0x0/0x50
[  279.779521]  [<ffffffff812bb5c8>] out_of_line_wait_on_bit+0x78/0x90
[  279.779584]  [<ffffffff81047670>] wake_bit_function+0x0/0x40
[  279.779645]  [<ffffffff810919c2>] __wait_on_buffer+0x22/0x30
[  279.779705]  [<ffffffff81094e71>] __bread+0xa1/0xc0
[  279.779770]  [<ffffffff88044dfd>] :ext3:ext3_fill_super+0x83d/0x16f0
[  279.779832]  [<ffffffff812bb945>] __mutex_unlock_slowpath+0x125/0x140
[  279.779895]  [<ffffffff8104ed1b>] trace_hardirqs_on+0x11b/0x150
[  279.779957]  [<ffffffff81097947>] get_sb_bdev+0x117/0x180
[  279.780023]  [<ffffffff880445c0>] :ext3:ext3_fill_super+0x0/0x16f0
[  279.780086]  [<ffffffff811058fe>] selinux_sb_copy_data+0x18e/0x1b6
[  279.780153]  [<ffffffff88042523>] :ext3:ext3_get_sb+0x13/0x20
[  279.780215]  [<ffffffff81096ce6>] vfs_kern_mount+0xb6/0x160
[  279.780276]  [<ffffffff81096dfa>] do_kern_mount+0x4a/0x70
[  279.780336]  [<ffffffff810afc1f>] do_mount+0x71f/0x790
[  279.780397]  [<ffffffff8106b557>] get_page_from_freelist+0x287/0x480
[  279.780460]  [<ffffffff8104ed1b>] trace_hardirqs_on+0x11b/0x150
[  279.780524]  [<ffffffff8104ed1b>] trace_hardirqs_on+0x11b/0x150
[  279.780587]  [<ffffffff8106b7c3>] __alloc_pages+0x73/0x300
[  279.780647]  [<ffffffff812bd8b9>] _spin_unlock_irqrestore+0x49/0x60
[  279.780711]  [<ffffffff81083334>] alloc_pages_current+0x84/0x90
[  279.780772]  [<ffffffff8106a98b>] __get_free_pages+0x1b/0x40
[  279.780834]  [<ffffffff810afd24>] sys_mount+0x94/0xe0
[  279.780894]  [<ffffffff812bce8a>] trace_hardirqs_on_thunk+0x35/0x37
[  281.198364]  [<ffffffff81009b4e>] system_call+0x7e/0x83
[  281.198425]
[  281.198479] Kernel panic - not syncing: Aiee, killing interrupt handler!
[  281.198541]  <7>APIC error on CPU1: 00(08)
----





> Subject: lockdep: increase max allowed recursion depth
> From: Ingo Molnar <mingo@elte.hu>
>
> With lots of CPUs there can be lots of deep dependencies. Will change
> the algorithm to iteration-based if it gets too deep.
>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  kernel/lockdep.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> Index: linux/kernel/lockdep.c
> ===================================================================
> --- linux.orig/kernel/lockdep.c
> +++ linux/kernel/lockdep.c
> @@ -575,6 +575,8 @@ static noinline int print_circular_bug_t
>         return 0;
>  }
>
> +#define RECURSION_LIMIT 40
> +
>  static int noinline print_infinite_recursion_bug(void)
>  {
>         __raw_spin_unlock(&hash_lock);
> @@ -595,7 +597,7 @@ check_noncircular(struct lock_class *sou
>         debug_atomic_inc(&nr_cyclic_check_recursions);
>         if (depth > max_recursion_depth)
>                 max_recursion_depth = depth;
> -       if (depth >= 20)
> +       if (depth >= RECURSION_LIMIT)
>                 return print_infinite_recursion_bug();
>         /*
>          * Check this lock's dependency list:
> @@ -645,7 +647,7 @@ find_usage_forwards(struct lock_class *s
>
>         if (depth > max_recursion_depth)
>                 max_recursion_depth = depth;
> -       if (depth >= 20)
> +       if (depth >= RECURSION_LIMIT)
>                 return print_infinite_recursion_bug();
>
>         debug_atomic_inc(&nr_find_usage_forwards_checks);
> @@ -684,7 +686,7 @@ find_usage_backwards(struct lock_class *
>
>         if (depth > max_recursion_depth)
>                 max_recursion_depth = depth;
> -       if (depth >= 20)
> +       if (depth >= RECURSION_LIMIT)
>                 return print_infinite_recursion_bug();
>
>         debug_atomic_inc(&nr_find_usage_backwards_checks);
>
