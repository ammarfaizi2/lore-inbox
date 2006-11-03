Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWKCWvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWKCWvy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 17:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWKCWvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 17:51:54 -0500
Received: from smtpa2.netcabo.pt ([212.113.174.17]:51523 "EHLO
	exch01smtp01.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S932080AbWKCWvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 17:51:52 -0500
Message-ID: <454BC8D1.1020001@rncbc.org>
Date: Fri, 03 Nov 2006 22:55:13 +0000
From: Rui Nuno Capela <rncbc@rncbc.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: realtime-preempt patch-2.6.18-rt7 oops
References: <42997.194.65.103.1.1162464204.squirrel@www.rncbc.org> <200611031230.24983.fzu@wemgehoertderstaat.de>
In-Reply-To: <200611031230.24983.fzu@wemgehoertderstaat.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2006 22:51:49.0517 (UTC) FILETIME=[A59C53D0:01C6FF9A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten Wiese wrote:
> 
> Does it make a difference, if you build & run with
> CONFIG_HIGH_RES_TIMERS disabled?
> 

Now with CONFIG_HIGH_RES_TIMERS not set, it seems to live longer, but
not enough. Notice the soft lockup being detected:

...
Oops: 0002 [#1]
__schedule+0x644/0xee0
 [<c011e5f1>] __activate_task+0x21/0x40
 [<c011e5f1>] __activate_task+0x21/0x40
 [<c01206ab>] try_to_wake_up+0x5b/0x450
 [<c0143c68>] __rt_mutex_adjust_prio+0x8/0x20
 [<c01444f1>] task_blocks_on_rt_mutex+0x111/0x210
 [<c02feac0>] schedule+0x30/0x100
 [<c02ff9cb>] rt_spin_lock_slowlock+0x9b/0x1b0
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
BUG: scheduling from the idle thread!
 [<c02fe149>] __schedule+0x6d9/0xee0
 [<c011e5f1>] __activate_task+0x21/0x40
 [<c011e5f1>] __activate_task+0x21/0x40
 [<c0143c68>] __rt_mutex_adjust_prio+0x8/0x20
 [<c01444f1>] task_blocks_on_rt_mutex+0x111/0x210
 [<c02feac0>] schedule+0x30/0x100
 [<c02ff9cb>] rt_spin_lock_slowlock+0x9b/0x1b0
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
PREEMPT SMP
Modules linked in: appletalk ax25 ipx p8023 ipv6 snd_seq_dummy edd
snd_pcm_oss snd_mixer_oss snd_seq_midi snd_seq_midi_event snd_seq button
battery ac w83627hf hwmon_vid hwmon i2c_isa loop dm_mod intel_rng usbhid
wacom snd_cs46xx snd_intel8x0 gameport snd_ice1712 snd_ice17xx_ak4xxx
snd_ak4xxx_adda snd_cs8427 snd_ac97_codec snd_ac97_bus i2c_i801 snd_i2c
snd_pcm i2c_core snd_mpu401_uart intel_agp snd_timer snd_rawmidi
snd_seq_device agpgart i8xx_tco snd ehci_hcd soundcore snd_page_alloc
sk98lin ide_cd cdrom shpchp ohci1394 pci_hotplug ieee1394 uhci_hcd
usbcore ext3 jbd reiserfs fan thermal processor piix ide_disk ide_core
CPU:    0
EIP:    0060:[<c011e56b>]    Not tainted VLI
EFLAGS: 00010046   (2.6.18.1-rt7.1-smp #1)
EIP is at enqueue_task+0x2b/0x90
eax: c188f708   ebx: c188f28c   ecx: 00000000   edx: dfd010d8
esi: dfd010b0   edi: c188edc0   ebp: e3659d10   esp: e3659d08
ds: 007b   es: 007b   ss: 0068   preempt: 00000004
Process kio_http (pid: 7114, ti=e3658000 task=f79282b0 task.ti=e3658000)
Stack: c188edc0 dfd010b0 e3659d20 c011e5f1 00000001 dfd010b0 e3659d84
c0120971
       00000001 c188f740 c042b024 00000000 0000001f e3658000 00000001
00000000
       00000004 00000000 00000000 00000000 00000000 00000001 00000001
c03d4280
Call Trace:
 [<c011e5f1>] __activate_task+0x21/0x40
 [<c0120971>] try_to_wake_up+0x321/0x450
 [<c0143b62>] wakeup_next_waiter+0xd2/0x1d0
 [<c0120b19>] wake_up_process_mutex+0x19/0x20
 [<c02ff861>] rt_spin_lock_slowunlock+0x41/0x70
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c01f6e54>] rb_insert_color+0x64/0xb0
 [<c013f432>] enqueue_hrtimer+0x72/0x90
 [<c02feac0>] schedule+0x30/0x100
 [<c0143018>] do_futex+0xa08/0xee0
 [<c029102d>] move_addr_to_user+0x7d/0x90
 [<c013f610>] hrtimer_wakeup+0x0/0x20
 [<c0120aa0>] default_wake_function+0x0/0x20
 [<c0197c50>] iput+0x60/0x90
 [<c014358a>] sys_futex+0x9a/0xd0
 [<c01052cd>] sysenter_past_esp+0x56/0x79
Code: 55 89 e5 56 89 c6 53 89 d3 f6 40 0c 08 74 09 a1 60 b0 35 c0 85 c0
75 4b 8b 46 1c 8d 56 28 8d 44 c3 1c 8b 48 04 89 46 28 89 50 04 <89> 11
89 4a 04 8b 46 1c 83 43 04 01 0f ab 43 08 83 7e 1c 63 89
EIP: [<c011e56b>] enqueue_task+0x2b/0x90 SS:ESP 0068:e3659d08
 <6>note: kio_http[7114] exited with preempt_count 3
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003d2>] __spin_lock_irqsave+0x22/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003d2>] __spin_lock_irqsave+0x22/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c015740f>] softlockup_tick+0xcf/0x130
 [<c01323d1>] update_process_times+0x31/0x80
 [<c0141021>] handle_update_profile+0x11/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c03003cf>] __spin_lock_irqsave+0x1f/0x40
 [<c02ff946>] rt_spin_lock_slowlock+0x16/0x1b0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c0117674>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d57>] apic_timer_interrupt+0x1f/0x24
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0120b59>] wake_up_process+0x19/0x20
 [<c01577ce>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
...

What next?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
