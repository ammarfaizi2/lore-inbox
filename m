Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVFXWh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVFXWh5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 18:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263291AbVFXWf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 18:35:57 -0400
Received: from unused.mind.net ([69.9.134.98]:9189 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S261630AbVFXWeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 18:34:02 -0400
Date: Fri, 24 Jun 2005 15:31:54 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-Reply-To: <20050624070639.GB5941@elte.hu>
Message-ID: <Pine.LNX.4.58.0506241510040.32173@echo.lysdexia.org>
References: <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org>
 <20050621131249.GB22691@elte.hu> <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org>
 <20050622082450.GA19957@elte.hu> <Pine.LNX.4.58.0506221434170.22191@echo.lysdexia.org>
 <20050622220007.GA28258@elte.hu> <Pine.LNX.4.58.0506221558260.22649@echo.lysdexia.org>
 <20050623001023.GC11486@elte.hu> <Pine.LNX.4.58.0506231330450.27096@echo.lysdexia.org>
 <Pine.LNX.4.58.0506231755020.27757@echo.lysdexia.org> <20050624070639.GB5941@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2005, Ingo Molnar wrote:

> do you have the NMI watchdog enabled? Find below 
> serial-logging-earlyprintk-nmi.txt.

I had a serial console up, but not NMI watchdog until now.  Here's some 
NMI watchdog traces from both -50-17 and -50-18:

**********************************
*** 2.6.12-RT-V0.7.50-17       ***
**********************************

NMI watchdog detected lockup on CPU#1 (50000/50000)

Pid: 2899, comm:            lockupcli
EIP: 0073:[<08048392>] CPU: 1
EIP is at 0x8048392
 ESP: 007b:bfebb440 EFLAGS: 00003082    Not tainted  (2.6.12-RT-V0.7.50-17)
EAX: 00000000 EBX: 452a3ff4 ECX: bfebb4ec EDX: 452a3ff4
ESI: bfebb4e4 EDI: bfebb470 EBP: bfebb458 DS: 007b ES: 007b
CR0: 8005003b CR2: 451a5590 CR3: 139ac000 CR4: 000006d0
NMI show regs on CPU#0:
NMI Watchdog detected LOCKUP on CPU1, eip 08048392, registers:
Modules linked in: eeprom lm85 i2c_sensor i2c_isa i2c_i801 i2c_dev i2c_core realtime microcode snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc ns83820
CPU:    1
EIP:    0073:[<08048392>]    Not tainted VLI
EFLAGS: 00003082   (2.6.12-RT-V0.7.50-17) 
EIP is at 0x8048392
eax: 00000000   ebx: 452a3ff4   ecx: bfebb4ec   edx: 452a3ff4
esi: bfebb4e4   edi: bfebb470   ebp: bfebb458   esp: bfebb440
ds: 007b   es: 007b   ss: 007b   preempt: 00010001
Process lockupcli (pid: 2899, threadinfo=d7060000 task=de5126d0)
console shuts up ...
 
Pid: 0, comm:              swapper
EIP: 0060:[<c0100bc8>] CPU: 0
EIP is at default_idle+0x2a/0x33
 EFLAGS: 00000246    Not tainted  (2.6.12-RT-V0.7.50-17)
EAX: 00000000 EBX: c0414000 ECX: c13e72e0 EDX: c0414000
ESI: c0414000 EDI: c0443380 EBP: c0443300 DS: 007b ES: 007b
CR0: 8005003b CR2: 080dcd9c CR3: 1e0e5000 CR4: 000006d0
 [<c0100c7a>] cpu_idle+0x76/0xaf (4)
 [<c0416911>] start_kernel+0x195/0x1fb (36)
 [<c0416338>] unknown_bootoption+0x0/0x1d8 (20)
(           IRQ 4-304  |#0): new 3 us maximum-latency wakeup.
(      gdmgreeter-2858 |#1): new 4 us maximum-latency wakeup.
(               X-2829 |#0): new 10 us maximum-latency wakeup.
( softirq-timer/0-4    |#0): new 11 us maximum-latency wakeup.
BUG: soft lockup detected on CPU#1!
 [<c0140e5e>] softlockup_tick+0xa3/0xb4 (8)
 [<c0111473>] smp_apic_timer_interrupt+0xbd/0xc9 (28)
 [<c01036fc>] apic_timer_interrupt+0x1c/0x24 (24)
 [<c0110bd2>] smp_call_function+0x92/0x11f (44)
 [<c010b550>] mce_checkregs+0x0/0xa3 (36)
 [<c0137040>] up_mutex+0x2b/0x70 (28)
 [<c010b626>] mce_work_fn+0x33/0x6d (12)
 [<c010b550>] mce_checkregs+0x0/0xa3 (4)
 [<c012ec54>] worker_thread+0x1e0/0x289 (20)
 [<c010b5f3>] mce_work_fn+0x0/0x6d (28)
 [<c011936e>] default_wake_function+0x0/0x22 (28)
 [<c011936e>] default_wake_function+0x0/0x22 (32)
 [<c013338a>] kthread+0x7c/0xcd (16)
 [<c012ea74>] worker_thread+0x0/0x289 (20)
 [<c01333b1>] kthread+0xa3/0xcd (4)
 [<c013330e>] kthread+0x0/0xcd (28)
 [<c0101009>] kernel_thread_helper+0x5/0xb (16)
NMI show regs on CPU#1:

Pid: 21, comm:             events/1
EIP: 0060:[<c0111a67>] CPU: 1
EIP is at nmi_show_all_regs+0x8d/0x104
 EFLAGS: 00000046    Not tainted  (2.6.12-RT-V0.7.50-17)
EAX: 00000000 EBX: c044b838 ECX: 00000000 EDX: 00000000
ESI: 00028917 EDI: 00000000 EBP: c14bfeb0 DS: 007b ES: 007b
CR0: 8005003b CR2: 451721c0 CR3: 1e0e5000 CR4: 000006d0
 [<c0140e63>] softlockup_tick+0xa8/0xb4 (24)
 [<c0111473>] smp_apic_timer_interrupt+0xbd/0xc9 (28)
 [<c01036fc>] apic_timer_interrupt+0x1c/0x24 (24)
 [<c0110bd2>] smp_call_function+0x92/0x11f (44)
 [<c010b550>] mce_checkregs+0x0/0xa3 (36)
 [<c0137040>] up_mutex+0x2b/0x70 (28)
 [<c010b626>] mce_work_fn+0x33/0x6d (12)
 [<c010b550>] mce_checkregs+0x0/0xa3 (4)
 [<c012ec54>] worker_thread+0x1e0/0x289 (20)
 [<c010b5f3>] mce_work_fn+0x0/0x6d (28)
 [<c011936e>] default_wake_function+0x0/0x22 (28)
 [<c011936e>] default_wake_function+0x0/0x22 (32)
 [<c013338a>] kthread+0x7c/0xcd (16)
 [<c012ea74>] worker_thread+0x0/0x289 (20)
 [<c01333b1>] kthread+0xa3/0xcd (4)
 [<c013330e>] kthread+0x0/0xcd (28)
 [<c0101009>] kernel_thread_helper+0x5/0xb (16)
NMI show regs on CPU#0:

Pid: 2940, comm:            lockupcli
EIP: 0073:[<08048392>] CPU: 0
EIP is at 0x8048392
 ESP: 007b:bfa21af0 EFLAGS: 00003086    Not tainted  (2.6.12-RT-V0.7.50-17)
EAX: 00000000 EBX: 452a3ff4 ECX: bfa21b9c EDX: 452a3ff4
ESI: bfa21b94 EDI: bfa21b20 EBP: bfa21b08 DS: 007b ES: 007b
CR0: 8005003b CR2: 451a5590 CR3: 1397d000 CR4: 000006d0
NMI watchdog detected lockup on CPU#0 (50000/50000)

Pid: 2940, comm:            lockupcli
EIP: 0073:[<08048392>] CPU: 0
EIP is at 0x8048392
 ESP: 007b:bfa21af0 EFLAGS: 00003086    Not tainted  (2.6.12-RT-V0.7.50-17)
EAX: 00000000 EBX: 452a3ff4 ECX: bfa21b9c EDX: 452a3ff4
ESI: bfa21b94 EDI: bfa21b20 EBP: bfa21b08 DS: 007b ES: 007b
CR0: 8005003b CR2: 451a5590 CR3: 1397d000 CR4: 000006d0
NMI show regs on CPU#1:
NMI Watchdog detected LOCKUP on CPU0, eip 08048392, registers:
Modules linked in: eeprom lm85 i2c_sensor i2c_isa i2c_i801 i2c_dev i2c_core realtime microcode snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc ns83820
CPU:    0
EIP:    0073:[<08048392>]    Not tainted VLI
EFLAGS: 00003086   (2.6.12-RT-V0.7.50-17) 
EIP is at 0x8048392

Pid: 21, comm:             events/1
EIP: 0060:[<c0110bd2>] CPU: 1
eax: 00000000   ebx: 452a3ff4   ecx: bfa21b9c   edx: 452a3ff4
EIP is at smp_call_function+0x92/0x11f
 EFLAGS: 00000297    Not tainted  (2.6.12-RT-V0.7.50-17)
EAX: 00000000 EBX: 00000001 ECX: 00000000 EDX: 000c08fb
ESI: 00000001 EDI: c033fbe4 EBP: 00000000 DS: 007b ES: 007b
CR0: 8005003b CR2: 451721c0 CR3: 1e0e5000 CR4: 000006d0
esi: bfa21b94   edi: bfa21b20   ebp: bfa21b08   esp: bfa21af0
 [<c010b550>]ds: 007b   es: 007b   ss: 007b   preempt: 00010001
 mce_checkregs+0x0/0xa3 (28)
Process lockupcli (pid: 2940, threadinfo=d3d62000 task=dec5a650) [<c0137040>]
 up_mutex+0x2b/0x70 (28)
 [<c010b626>]console shuts up ...
  mce_work_fn+0x33/0x6d (12)
 [<c010b550>] mce_checkregs+0x0/0xa3 (4)
 [<c012ec54>] worker_thread+0x1e0/0x289 (20)
 [<c010b5f3>] mce_work_fn+0x0/0x6d (28)
 [<c011936e>] default_wake_function+0x0/0x22 (28)
 [<c011936e>] default_wake_function+0x0/0x22 (32)
 [<c013338a>] kthread+0x7c/0xcd (16)
 [<c012ea74>] worker_thread+0x0/0x289 (20)
 [<c01333b1>] kthread+0xa3/0xcd (4)
 [<c013330e>] kthread+0x0/0xcd (28)
 [<c0101009>] kernel_thread_helper+0x5/0xb (16)
(      watchdog/1-19   |#1): new 46581633 us maximum-latency wakeup.
BUG: soft lockup detected on CPU#0!
 [<c0140e5e>] softlockup_tick+0xa3/0xb4 (8)
 [<c0111473>] smp_apic_timer_interrupt+0xbd/0xc9 (28)
 [<c01036fc>] apic_timer_interrupt+0x1c/0x24 (24)
 [<c02ee5c4>] schedule+0x54/0x13a (44)
 [<c01b6e9c>] kjournald+0x3a2/0x3ab (20)
 [<c013380f>] autoremove_wake_function+0x0/0x4b (40)
 [<c013380f>] autoremove_wake_function+0x0/0x4b (32)
 [<c0102b76>] ret_from_fork+0x6/0x14 (20)
 [<c01b6af0>] commit_timeout+0x0/0x9 (20)
 [<c01b6afa>] kjournald+0x0/0x3ab (16)
 [<c0101009>] kernel_thread_helper+0x5/0xb (16)
NMI show regs on CPU#1:

Pid: 13, comm:      softirq-timer/1
EIP: 0060:[<c02efcf7>] CPU: 1
EIP is at _raw_spin_lock+0x15/0x60
 EFLAGS: 00000046    Not tainted  (2.6.12-RT-V0.7.50-17)
EAX: 00000001 EBX: c0408f04 ECX: 00000000 EDX: 00000000
ESI: c1498000 EDI: 00001c80 EBP: c13f87e0 DS: 007b ES: 007b
CR0: 8005003b CR2: 451721c0 CR3: 1e0e5000 CR4: 000006d0
 [<c0127d50>] run_timer_softirq+0x7d/0x392 (12)
 [<c02e007b>] tcpdiag_rcv+0x21/0x176 (40)
 [<c01241af>] ksoftirqd+0xf4/0x189 (20)
 [<c01240bb>] ksoftirqd+0x0/0x189 (40)
 [<c01333b1>] kthread+0xa3/0xcd (4)
 [<c013330e>] kthread+0x0/0xcd (28)
 [<c0101009>] kernel_thread_helper+0x5/0xb (16)
NMI show regs on CPU#0:

Pid: 1274, comm:            kjournald
EIP: 0060:[<c0111a6f>] CPU: 0
EIP is at nmi_show_all_regs+0x95/0x104
 EFLAGS: 00000046    Not tainted  (2.6.12-RT-V0.7.50-17)
EAX: 00000000 EBX: c044b838 ECX: 00000000 EDX: 00000000
ESI: 00027d5c EDI: 00000000 EBP: dd6adf1c DS: 007b ES: 007b
CR0: 8005003b CR2: 451a5590 CR3: 1e2ef000 CR4: 000006d0
 [<c0140e63>] softlockup_tick+0xa8/0xb4 (24)
 [<c0111473>] smp_apic_timer_interrupt+0xbd/0xc9 (28)
 [<c01036fc>] apic_timer_interrupt+0x1c/0x24 (24)
 [<c02ee5c4>] schedule+0x54/0x13a (44)
 [<c01b6e9c>] kjournald+0x3a2/0x3ab (20)
 [<c013380f>] autoremove_wake_function+0x0/0x4b (40)
 [<c013380f>] autoremove_wake_function+0x0/0x4b (32)
 [<c0102b76>] ret_from_fork+0x6/0x14 (20)
 [<c01b6af0>] commit_timeout+0x0/0x9 (20)
 [<c01b6afa>] kjournald+0x0/0x3ab (16)
 [<c0101009>] kernel_thread_helper+0x5/0xb (16)
NMI watchdog detected lockup on CPU#0 (50000/50000)

Pid: 2941, comm:            lockupcli
EIP: 0073:[<08048392>] CPU: 0
EIP is at 0x8048392
 ESP: 007b:bfb44640 EFLAGS: 00003082    Not tainted  (2.6.12-RT-V0.7.50-17)
EAX: 00000000 EBX: 452a3ff4 ECX: bfb446ec EDX: 452a3ff4
ESI: bfb446e4 EDI: bfb44670 EBP: bfb44658 DS: 007b ES: 007b
CR0: 8005003b CR2: 451a5590 CR3: 16741000 CR4: 000006d0
NMI show regs on CPU#1:
NMI Watchdog detected LOCKUP on CPU0, eip 08048392, registers:
Modules linked in: eeprom lm85 i2c_sensor i2c_isa i2c_i801 i2c_dev i2c_core realtime microcode snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc ns83820
CPU:    0
EIP:    0073:[<08048392>]    Not tainted VLI
EFLAGS: 00003082   (2.6.12-RT-V0.7.50-17) 
EIP is at 0x8048392

Pid: 0, comm:              swapper
EIP: 0060:[<c0100bc8>] CPU: 1
eax: 00000000   ebx: 452a3ff4   ecx: bfb446ec   edx: 452a3ff4
esi: bfb446e4   edi: bfb44670   ebp: bfb44658   esp: bfb44640
EIP is at default_idle+0x2a/0x33
 EFLAGS: 00000246    Not tainted  (2.6.12-RT-V0.7.50-17)
EAX: 00000000 EBX: def12000 ECX: c13f72e0 EDX: def12000
ESI: def12000 EDI: c0443380 EBP: c0443300 DS: 007b ES: 007b
CR0: 8005003b CR2: 080ddcfc CR3: 1e0e5000 CR4: 000006d0
 [<c0100c7a>]ds: 007b   es: 007b   ss: 007b   preempt: 00010001
 cpu_idle+0x76/0xaf (4)
Process lockupcli (pid: 2941, threadinfo=d3d62000 task=d673e130)
console shuts up ...
 <4>hdb: dma_timer_expiry: dma status == 0x64
hdb: DMA interrupt recovery
hdb: lost interrupt
NMI watchdog detected lockup on CPU#1 (50000/50000)

Pid: 2943, comm:            lockupcli
EIP: 0073:[<08048392>] CPU: 1
EIP is at 0x8048392
 ESP: 007b:bfdf1460 EFLAGS: 00003086    Not tainted  (2.6.12-RT-V0.7.50-17)
EAX: 00000000 EBX: 452a3ff4 ECX: bfdf150c EDX: 452a3ff4
ESI: bfdf1504 EDI: bfdf1490 EBP: bfdf1478 DS: 007b ES: 007b
CR0: 8005003b CR2: 451a5590 CR3: 18750000 CR4: 000006d0
NMI show regs on CPU#0:
NMI Watchdog detected LOCKUP on CPU1, eip 08048392, registers:
Modules linked in: eeprom lm85 i2c_sensor i2c_isa i2c_i801 i2c_dev i2c_core realtime microcode snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc ns83820
CPU:    1
EIP:    0073:[<08048392>]    Not tainted VLI
EFLAGS: 00003086   (2.6.12-RT-V0.7.50-17) 
EIP is at 0x8048392

Pid: 0, comm:              swapper
EIP: 0060:[<c0100bc8>] CPU: 0
eax: 00000000   ebx: 452a3ff4   ecx: bfdf150c   edx: 452a3ff4
EIP is at default_idle+0x2a/0x33
 EFLAGS: 00000246    Not tainted  (2.6.12-RT-V0.7.50-17)
EAX: 00000000 EBX: c0414000 ECX: c13e72e0 EDX: c0414000
ESI: c0414000 EDI: c0443380 EBP: c0443300 DS: 007b ES: 007b
CR0: 8005003b CR2: b7f7376e CR3: 1e13e000 CR4: 000006d0
 [<c0100c7a>]esi: bfdf1504   edi: bfdf1490   ebp: bfdf1478   esp: bfdf1460
 cpu_idle+0x76/0xaf (4)
ds: 007b   es: 007b   ss: 007b   preempt: 00010001
 [<c0416911>]Process lockupcli (pid: 2943, threadinfo=da2c2000 task=de150230) start_kernel+0x195/0x1fb (36)

 [<c0416338>]console shuts up ...
 unknown_bootoption+0x0/0x1d8 (20)
 <3>BUG: soft lockup detected on CPU#1!
 [<c0140e5e>] softlockup_tick+0xa3/0xb4 (8)
 [<c0111473>] smp_apic_timer_interrupt+0xbd/0xc9 (28)
 [<c01036fc>] apic_timer_interrupt+0x1c/0x24 (24)
 [<c011a0a1>] __cond_resched+0x3f/0x41 (44)
 [<c02eed6c>] cond_resched+0x1c/0x25 (16)
 [<c01509b1>] unmap_vmas+0x13e/0x188 (8)
 [<c0154f2b>] exit_mmap+0x5d/0x118 (48)
 [<c011be29>] mmput+0x2c/0x89 (56)
 [<c0121316>] do_exit+0xcb/0x3dd (16)
 [<c011eba7>] printk+0x17/0x1b (16)
 [<c01049aa>] default_do_nmi+0x0/0x17c (24)
 [<c0111cdc>] nmi_watchdog_tick+0x1fe/0x2a8 (24)
 [<c0104a2a>] default_do_nmi+0x80/0x17c (52)
 [<c015482c>] unmap_vma_list+0x1c/0x28 (24)
 [<c0154bea>] sys_munmap+0x45/0x4e (44)
 [<c0104b77>] do_nmi+0x4e/0x5b (28)
 [<c010388e>] nmi_stack_correct+0x1d/0x22 (20)
NMI show regs on CPU#1:

Pid: 2943, comm:            lockupcli
EIP: 0060:[<c0111a6f>] CPU: 1
EIP is at nmi_show_all_regs+0x95/0x104
 EFLAGS: 00003046    Not tainted  (2.6.12-RT-V0.7.50-17)
EAX: 00000000 EBX: c044b838 ECX: 00000000 EDX: 00000000
ESI: 00043196 EDI: 00000000 EBP: da2c3e18 DS: 007b ES: 007b
CR0: 8005003b CR2: 451a5590 CR3: 00447000 CR4: 000006d0
 [<c0140e63>] softlockup_tick+0xa8/0xb4 (24)
 [<c0111473>] smp_apic_timer_interrupt+0xbd/0xc9 (28)
 [<c01036fc>] apic_timer_interrupt+0x1c/0x24 (24)
 [<c011a0a1>] __cond_resched+0x3f/0x41 (44)
 [<c02eed6c>] cond_resched+0x1c/0x25 (16)
 [<c01509b1>] unmap_vmas+0x13e/0x188 (8)
 [<c0154f2b>] exit_mmap+0x5d/0x118 (48)
 [<c011be29>] mmput+0x2c/0x89 (56)
 [<c0121316>] do_exit+0xcb/0x3dd (16)
 [<c011eba7>] printk+0x17/0x1b (16)
 [<c01049aa>] default_do_nmi+0x0/0x17c (24)
 [<c0111cdc>] nmi_watchdog_tick+0x1fe/0x2a8 (24)
 [<c0104a2a>] default_do_nmi+0x80/0x17c (52)
 [<c015482c>] unmap_vma_list+0x1c/0x28 (24)
 [<c0154bea>] sys_munmap+0x45/0x4e (44)
 [<c0104b77>] do_nmi+0x4e/0x5b (28)
 [<c010388e>] nmi_stack_correct+0x1d/0x22 (20)
NMI show regs on CPU#0:

Pid: 0, comm:              swapper
EIP: 0060:[<c0100bc8>] CPU: 0
EIP is at default_idle+0x2a/0x33
 EFLAGS: 00000246    Not tainted  (2.6.12-RT-V0.7.50-17)
EAX: 00000000 EBX: c0414000 ECX: c13e72e0 EDX: c0414000
ESI: c0414000 EDI: c0443380 EBP: c0443300 DS: 007b ES: 007b
CR0: 8005003b CR2: b7f7376e CR3: 1e13e000 CR4: 000006d0
 [<c0100c7a>] cpu_idle+0x76/0xaf (4)
 [<c0416911>] start_kernel+0x195/0x1fb (36)
 [<c0416338>] unknown_bootoption+0x0/0x1d8 (20)

NMI watchdog detected lockup on CPU#0 (50000/50000)

Pid: 2949, comm:            lockupcli
EIP: 0073:[<08048392>] CPU: 0
EIP is at 0x8048392
 ESP: 007b:bfdc8f00 EFLAGS: 00003086    Not tainted  (2.6.12-RT-V0.7.50-17)
EAX: 00000000 EBX: 452a3ff4 ECX: bfdc8fac EDX: 452a3ff4
ESI: bfdc8fa4 EDI: bfdc8f30 EBP: bfdc8f18 DS: 007b ES: 007b
CR0: 8005003b CR2: 451a5590 CR3: 13c35000 CR4: 000006d0
NMI show regs on CPU#1:
NMI Watchdog detected LOCKUP on CPU0, eip 08048392, registers:
Modules linked in: eeprom lm85 i2c_sensor i2c_isa i2c_i801 i2c_dev i2c_core realtime microcode snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc ns83820
CPU:    0
EIP:    0073:[<08048392>]    Not tainted VLI
EFLAGS: 00003086   (2.6.12-RT-V0.7.50-17) 
EIP is at 0x8048392
eax: 00000000   ebx: 452a3ff4   ecx: bfdc8fac   edx: 452a3ff4
esi: bfdc8fa4   edi: bfdc8f30   ebp: bfdc8f18   esp: bfdc8f00
ds: 007b   es: 007b   ss: 007b   preempt: 00010001
Process lockupcli (pid: 2949, threadinfo=d3c3c000 task=da2ed290)
console shuts up ...
 
Pid: 0, comm:              swapper
EIP: 0060:[<c0100bc8>] CPU: 1
EIP is at default_idle+0x2a/0x33
 EFLAGS: 00000246    Not tainted  (2.6.12-RT-V0.7.50-17)
EAX: 00000000 EBX: def12000 ECX: c13f72e0 EDX: def12000
ESI: def12000 EDI: c0443380 EBP: c0443300 DS: 007b ES: 007b
CR0: 8005003b CR2: 080f3c04 CR3: 1d9e6000 CR4: 000006d0
 [<c0100c7a>] cpu_idle+0x76/0xaf (4)




**********************************
*** 2.6.12-RT-V0.7.50-18-debug ***
**********************************

NMI watchdog detected lockup on CPU#0 (50000/50000)

Pid: 3264, comm:            lockupcli
EIP: 0073:[<08048392>] CPU: 0
EIP is at 0x8048392
 ESP: 007b:bfab1800 EFLAGS: 00003086    Not tainted  (2.6.12-RT-V0.7.50-18-debug)
EAX: 00000000 EBX: 452a3ff4 ECX: bfab18ac EDX: 452a3ff4
ESI: bfab18a4 EDI: bfab1830 EBP: bfab1818 DS: 007b ES: 007b
CR0: 8005003b CR2: 451a5590 CR3: 1e10d000 CR4: 000006d0
 [<c01010ec>] show_regs+0x14b/0x173 (36)
 [<c0112d6e>] nmi_watchdog_tick+0x17b/0x2a1 (52)
 [<c0104e34>] default_do_nmi+0x7a/0x17a (96)
 [<c0104faa>] do_nmi+0x6f/0x81 (24)
 [<c0103b7a>] nmi_stack_correct+0x1d/0x22 (-323987356)
---------------------------
| preempt count: 00010002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c0370c2a>] .... _raw_spin_lock+0x1b/0x85
.....[<c0112d34>] ..   ( <= nmi_watchdog_tick+0x141/0x2a1)
.. [<c013effb>] .... print_traces+0x1b/0x52
.....[<c0103de5>] ..   ( <= shoce+0xc2/0xd4)

------------------------------
| showing all locks held by: |  (lockupcli/3264 [ddcf0cc0,  54]):
------------------------------

NMI show regs on CPU#1:


NMI watchdog detected lockup on CPU#0 (50000/50000)

Pid: 3031, comm:            lockupcli
EIP: 0073:[<08048392>] CPU: 0
EIP is at 0x8048392
 ESP: 007b:bfdca9e0 EFLAGS: 00003082    Not tainted  (2.6.12-RT-V0.7.50-18-debug)
EAX: 00000000 EBX: 452a3ff4 ECX: bfdcaa8c EDX: 452a3ff4
ESI: bfdcaa84 EDI: bfdcaa10 EBP: bfdca9f8 DS: 007b ES: 007b
CR0: 8005003b CR2: 451a5590 CR3: 122bd000 CR4: 000006d0
 [<c01010ec>] show_regs+0x14b/0x173 (36)
 [<c0112d6e>] nmi_watchdog_tick+0x17b/0x2a1 (52)
 [<c0104e34>] default_do_nmi+0x7a/0x17a (96)
 [<c0104faa>] do_nmi+0x6f/0x81 (24)
 [<c0103b7a>] nmi_stack_correct+0x1d/0x22 (-308213180)
---------------------------
| preempt count: 00010002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c0370c2a>] .... _raw_spin_lock+0x1b/0x85
.....[<c0112d34>] ..   ( <= nmi_watchdog_tick+0x141/0x2a1)
.. [<c013effb>] .... print_traces+0x1b/0x52
.....[<103de5>] ..   ( <= show_trace+0xc2/0xd4)

------------------------------
| showing all locks held by: |  (lockupcli/3031 [ddeac660, 118]):
------------------------------

NMI show regs on CPU#1:


NMI watchdog detected lockup on CPU#1 (50000/50000)

Pid: 2937, comm:            lockupcli
EIP: 0073:[<08048392>] CPU: 1
EIP is at 0x8048392
 ESP: 007b:bff205d0 EFLAGS: 00003082    Not tainted  (2.6.12-RT-V0.7.50-18-debug)
EAX: 00000000 EBX: 452a3ff4 ECX: bff2067c EDX: 452a3ff4
ESI: bff20674 EDI: bff20600 EBP: bff205e8 DS: 007b ES: 007b
CR0: 8005003b CR2: 451a5590 CR3: 1382e000 CR4: 000006d0
 [<c01010ec>] show_regs+0x14b/0x173 (36)
 [<c0112d6e>] nmi_watchdog_tick+0x17b/0x2a1 (52)
 [<c0104e34>] default_do_nmi+0x7a/0x17a (96)
 [<c0104faa>] do_nmi+0x6f/0x81 (24)
 [<c0103b7a>] nmi_stack_correct+0x1d/0x22 (-373864908)
---------------------------
| preempt count: 00010002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c0370c2a>] .... _raw_spin_lock+0x1b/0x85
.....[<c0112d34>] ..   ( <= nmi_watchdog_tick+0x141/0x2a1)
.. [<c013effb>] .... print_traces+0x1b/0x52
.....[<c0103de5>] ..   ( <= show_trace+0xc2/0xd4)

------------------------------
| showing all locks held by: |  (lockupcli/2937 [de4ed980,  54]):
------------------------------

NMI show regs on CPU#0:

