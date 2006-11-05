Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161343AbWKEQoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161343AbWKEQoV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 11:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161341AbWKEQoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 11:44:21 -0500
Received: from smtpa2.netcabo.pt ([212.113.174.17]:55814 "EHLO
	exch01smtp01.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1161343AbWKEQoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 11:44:17 -0500
Message-ID: <454E15B0.2050008@rncbc.org>
Date: Sun, 05 Nov 2006 16:47:44 +0000
From: Rui Nuno Capela <rncbc@rncbc.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Mike Galbraith <efault@gmx.de>, Karsten Wiese <fzu@wemgehoertderstaat.de>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: realtime-preempt patch-2.6.18-rt7 oops
References: <42997.194.65.103.1.1162464204.squirrel@www.rncbc.org> <200611031230.24983.fzu@wemgehoertderstaat.de> <454BC8D1.1020001@rncbc.org> <454BF608.20803@rncbc.org> <454C714B.8030403@rncbc.org> <454E0976.8030303@rncbc.org>
In-Reply-To: <454E0976.8030303@rncbc.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Nov 2006 16:44:15.0464 (UTC) FILETIME=[A1326680:01C700F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Nuno Capela wrote:
> After a suggestion from Mike Galbraith, I now turned to pure and
> original 2.6.18-rt7 and configured with:
> 
> CONFIG_FRAME_POINTER=y
> CONFIG_UNWIND_INFO=y
> CONFIG_STACK_UNWIND=y
> 
> Nasty things still do happen, as the following capture can tell as evidence:
> 

Some more evidence, just happening:

...
Oops: 0002 [#1]
 [<c0106455>] show_trace_log_lvl+0x185/0x1a0
 [<c0106ae2>] show_trace+0x12/0x20
 [<c0106c49>] dump_stack+0x19/0x20
 [<c02f8d2f>] __schedule+0x63f/0xea0
 [<c02f9700>] schedule+0x30/0x100
 [<c02fa5db>] rt_spin_lock_slowlock+0x9b/0x1b0
 [<c02fadb2>] rt_spin_lock+0x22/0x30
 [<c02fd8b1>] kprobe_flush_task+0x11/0x50
 [<c02f91fa>] __schedule+0xb0a/0xea0
 [<c0103b61>] cpu_idle+0xb1/0x120
 [<c011760f>] start_secondary+0x43f/0x500
BUG: scheduling from the idle thread!
 [<c0106455>] show_trace_log_lvl+0x185/0x1a0
 [<c0106ae2>] show_trace+0x12/0x20
 [<c0106c49>] dump_stack+0x19/0x20
 [<c02f8dba>] __schedule+0x6ca/0xea0
 [<c02f9700>] schedule+0x30/0x100
PREEMPT SMP
Modules linked in: appletalk ax25 ipx p8023 ipv6 snd_seq_dummy
snd_pcm_oss edd snd_mixer_oss snd_seq_midi snd_seq_midi_event snd_seq
w83627hf hwmon_vid button hwmon battery i2c_isa ac loop dm_mod intel_rng
usbhid wacom shpchp snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda
snd_cs8427 pci_hotplug snd_intel8x0 snd_i2c i8xx_tco snd_cs46xx
snd_mpu401_uart gameport snd_rawmidi snd_ac97_codec snd_ac97_bus sk98lin
snd_seq_device snd_pcm snd_timer snd ehci_hcd snd_page_alloc uhci_hcd
soundcore usbcore i2c_i801 i2c_core intel_agp ide_cd agpgart cdrom
ohci1394 ieee1394 ext3 jbd reiserfs fan thermal processor piix ide_disk
ide_core
CPU:    0
EIP:    0060:[<c011f4cb>]    Not tainted VLI
EFLAGS: 00010046   (2.6.18-rt7.0-smp #1)
EIP is at enqueue_task+0x2b/0x90
eax: c188f28c   ebx: c188ee10   ecx: 00000000   edx: dfd490d8
esi: dfd490b0   edi: c188edc0   ebp: c042be34   esp: c042be2c
ds: 007b   es: 007b   ss: 0068   preempt: 00000004
Process swapper (pid: 0, ti=c042a000 task=c0352840 task.ti=c042a000)
Stack: c188edc0 dfd490b0 c042be44 c011f551 00000001 dfd490b0 c042bea8
c01218c1
       00000401 00000100 00000000 00000000 0000001f c042a000 00000001
00000000
       00000004 c180edc0 dfd485b0 c042be88 c011f551 00000001 a1fdbacf
c042bea4
Call Trace:
 [<c011f551>] __activate_task+0x21/0x40
 [<c01218c1>] try_to_wake_up+0x321/0x450
 [<c0121a69>] wake_up_process_mutex+0x19/0x20
 [<c0144ab7>] wakeup_next_waiter+0xd7/0x1b0
 [<c02fa46c>] rt_spin_lock_slowunlock+0x4c/0x70
 [<c02fad88>] rt_spin_unlock+0x38/0x40
 [<c02fd8da>] kprobe_flush_task+0x3a/0x50
 [<c02f91fa>] __schedule+0xb0a/0xea0
 [<c0103b61>] cpu_idle+0xb1/0x120
 [<c01006d3>] rest_init+0x43/0x50
 [<c042f890>] start_kernel+0x360/0x440
Code: 55 89 e5 56 89 c6 53 89 d3 f6 40 0c 08 74 09 a1 60 60 35 c0 85 c0
75 4b 8b 46 1c 8d 56 28 8d 44 c3 1c 8b 48 04 89 46 28 89 50 04 <89> 11
89 4a 04 8b 46 1c 83 43 04 01 0f ab 43 08 83 7e 1c 63 89
EIP: [<c011f4cb>] enqueue_task+0x2b/0x90 SS:ESP 0068:c042be2c
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
 [<c0106455>] show_trace_log_lvl+0x185/0x1a0
 [<c0106ae2>] show_trace+0x12/0x20
 [<c0106c49>] dump_stack+0x19/0x20
 [<c0128081>] panic+0x51/0x110
 [<c012bcd6>] do_exit+0x6e6/0xaa0
 [<c0106a88>] die+0x2f8/0x300
 [<c02fc9a1>] do_page_fault+0x1f1/0x5e0
 [<c0105e45>] error_code+0x39/0x40
 [<c011f4cb>] enqueue_task+0x2b/0x90
 [<c011f551>] __activate_task+0x21/0x40
 [<c01218c1>] try_to_wake_up+0x321/0x450
 [<c0121a69>] wake_up_process_mutex+0x19/0x20
 [<c0144ab7>] wakeup_next_waiter+0xd7/0x1b0
 [<c02fa46c>] rt_spin_lock_slowunlock+0x4c/0x70
 [<c02fad88>] rt_spin_unlock+0x38/0x40
 [<c02fd8da>] kprobe_flush_task+0x3a/0x50
 [<c02f91fa>] __schedule+0xb0a/0xea0
 [<c0103b61>] cpu_idle+0xb1/0x120
 [<c01006d3>] rest_init+0x43/0x50
 [<c042f890>] start_kernel+0x360/0x440
 swapper/0[CPU#0]: BUG in smp_call_function at arch/i386/kernel/smp.c:557
 [<c0106455>] show_trace_log_lvl+0x185/0x1a0
 [<c0106ae2>] show_trace+0x12/0x20
 [<c0106c49>] dump_stack+0x19/0x20
 [<c01292e3>] __WARN_ON+0x63/0x80
 [<c0115fbc>] smp_call_function+0xbc/0xd0
 [<c0115fee>] smp_send_stop+0x1e/0x30
 [<c0128094>] panic+0x64/0x110
 [<c012bcd6>] do_exit+0x6e6/0xaa0
 [<c0106a88>] die+0x2f8/0x300
 [<c02fc9a1>] do_page_fault+0x1f1/0x5e0
 [<c0105e45>] error_code+0x39/0x40
 [<c011f4cb>] enqueue_task+0x2b/0x90
 [<c011f551>] __activate_task+0x21/0x40
 [<c01218c1>] try_to_wake_up+0x321/0x450
 [<c0121a69>] wake_up_process_mutex+0x19/0x20
 [<c0144ab7>] wakeup_next_waiter+0xd7/0x1b0
 [<c02fa46c>] rt_spin_lock_slowunlock+0x4c/0x70
 [<c02fad88>] rt_spin_unlock+0x38/0x40
 [<c02fd8da>] kprobe_flush_task+0x3a/0x50
 [<c02f91fa>] __schedule+0xb0a/0xea0
 [<c0103b61>] cpu_idle+0xb1/0x120
 [<c01006d3>] rest_init+0x43/0x50
 [<c042f890>] start_kernel+0x360/0x440
...

Another one:

...
Oops: 0002 [#1]
 [<c0106455>] show_trace_log_lvl+0x185/0x1a0
 [<c0106ae2>] show_trace+0x12/0x20
 [<c0106c49>] dump_stack+0x19/0x20
 [<c02f8d2f>] __schedule+0x63f/0xea0
 [<c02f9700>] schedule+0x30/0x100
 [<c02fa5db>] rt_spin_lock_slowlock+0x9b/0x1b0
 [<c02fadb2>] rt_spin_lock+0x22/0x30
 [<c02fd8b1>] kprobe_flush_task+0x11/0x50
PREEMPT SMP
Modules linked in: appletalk ax25 ipx p8023 ipv6 edd snd_seq_dummy
snd_pcm_oss snd_mixer_oss snd_seq_midi snd_seq_midi_event snd_seq button
w83627hf hwmon_vid battery hwmon i2c_isa ac loop dm_mod intel_rng usbhid
wacom sk98lin snd_cs46xx shpchp pci_hotplug snd_ice1712
snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_i2c snd_mpu401_uart
gameport intel_agp snd_rawmidi agpgart snd_intel8x0 snd_seq_device
i8xx_tco i2c_i801 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd
soundcore ehci_hcd snd_page_alloc i2c_core uhci_hcd usbcore ohci1394
ide_cd ieee1394 cdrom ext3 jbd reiserfs fan thermal processor piix
ide_disk ide_core
CPU:    0
EIP:    0060:[<c011f4cb>]    Not tainted VLI
EFLAGS: 00010046   (2.6.18-rt7.0-smp #1)
EIP is at enqueue_task+0x2b/0x90
eax: c188f708   ebx: c188f28c   ecx: 00000000   edx: dfd490d8
esi: dfd490b0   edi: c188edc0   ebp: f63d1c0c   esp: f63d1c04
ds: 007b   es: 007b   ss: 0068   preempt: 00000004
Process kio_http (pid: 4485, ti=f63d0000 task=f7840230 task.ti=f63d0000)
Stack: c188edc0 dfd490b0 f63d1c1c c011f551 00000001 dfd490b0 f63d1c80
c01218c1
       ff405d89 ff415e8a ff415e8a 00000000 0000001f f63d0000 00000001
00000000
       00000004 c0476028 c188edc0 c0465240 f63d1c60 c01f47f5 00000001
f63d1ce4
Call Trace:
 [<c011f551>] __activate_task+0x21/0x40
 [<c01218c1>] try_to_wake_up+0x321/0x450
 [<c0121a69>] wake_up_process_mutex+0x19/0x20
 [<c0144ab7>] wakeup_next_waiter+0xd7/0x1b0
 [<c02fa46c>] rt_spin_lock_slowunlock+0x4c/0x70
 [<c02fad88>] rt_spin_unlock+0x38/0x40
 [<c02fd8da>] kprobe_flush_task+0x3a/0x50
 [<c02f91fa>] __schedule+0xb0a/0xea0
 [<c02f9700>] schedule+0x30/0x100
 [<c02fa7ad>] rt_mutex_slowlock+0xbd/0x280
 [<c02fa538>] rt_mutex_lock+0x38/0x40
 [<c01456fe>] rt_down_read+0x2e/0x50
 [<c0142868>] futex_wake+0x28/0xe0
 [<c0143828>] do_futex+0x388/0xf90
 [<c01444b9>] sys_futex+0x89/0xc0
 [<c0105309>] sysenter_past_esp+0x56/0x79
 [<b7faf410>] 0xb7faf410
Code: 55 89 e5 56 89 c6 53 89 d3 f6 40 0c 08 74 09 a1 60 60 35 c0 85 c0
75 4b 8b 46 1c 8d 56 28 8d 44 c3 1c 8b 48 04 89 46 28 89 50 04 <89> 11
89 4a 04 8b 46 1c 83 43 04 01 0f ab 43 08 83 7e 1c 63 89
EIP: [<c011f4cb>] enqueue_task+0x2b/0x90 SS:ESP 0068:f63d1c04
 <6>note: kio_http[4485] exited with preempt_count 3
BUG: soft lockup detected on CPU#0! [swapper:0]
 [<c0106455>] show_trace_log_lvl+0x185/0x1a0
 [<c0106ae2>] show_trace+0x12/0x20
 [<c0106c49>] dump_stack+0x19/0x20
 [<c01596fa>] softlockup_tick+0xca/0x100
 [<c0131eb2>] run_local_timers+0x12/0x20
 [<c01331f4>] update_process_times+0x34/0x80
 [<c0141de4>] handle_update_profile+0x14/0x30
 [<c0118644>] smp_apic_timer_interrupt+0x54/0x70
 [<c0105d93>] apic_timer_interrupt+0x1f/0x24
 [<c02faff2>] __spin_lock_irqsave+0x22/0x40
 [<c02fa557>] rt_spin_lock_slowlock+0x17/0x1b0
 [<c02fadb2>] rt_spin_lock+0x22/0x30
 [<c02fd8b1>] kprobe_flush_task+0x11/0x50
 [<c02f91fa>] __schedule+0xb0a/0xea0
 [<c0103b61>] cpu_idle+0xb1/0x120
 [<c01006d3>] rest_init+0x43/0x50
 [<c042f890>] start_kernel+0x360/0x440
...

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
