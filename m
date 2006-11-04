Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753585AbWKDCEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbWKDCEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 21:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753586AbWKDCEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 21:04:45 -0500
Received: from smtpa2.netcabo.pt ([212.113.174.17]:386 "EHLO
	exch01smtp01.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1753585AbWKDCEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 21:04:44 -0500
Message-ID: <454BF608.20803@rncbc.org>
Date: Sat, 04 Nov 2006 02:08:08 +0000
From: Rui Nuno Capela <rncbc@rncbc.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Karsten Wiese <fzu@wemgehoertderstaat.de>, Ingo Molnar <mingo@elte.hu>
Subject: Re: realtime-preempt patch-2.6.18-rt7 oops
References: <42997.194.65.103.1.1162464204.squirrel@www.rncbc.org> <200611031230.24983.fzu@wemgehoertderstaat.de> <454BC8D1.1020001@rncbc.org>
In-Reply-To: <454BC8D1.1020001@rncbc.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Nov 2006 02:04:42.0187 (UTC) FILETIME=[9775A1B0:01C6FFB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Karsten Wiese wrote:
>> Does it make a difference, if you build & run with
>> CONFIG_HIGH_RES_TIMERS disabled?
>>
> 

More food for thought; still with CONFIG_HIGH_RES_TIMERS not set:

...
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in: appletalk ax25 ipx p8023 ipv6 edd snd_seq_dummy
snd_pcm_oss snd_mixer_oss snd_seq_midi snd_seq_midi_event w83627hf
hwmon_vid snd_seq button hwmon i2c_isa battery ac loop dm_mod usbhid
wacom intel_rng ehci_hcd shpchp pci_hotplug snd_ice1712
snd_ice17xx_ak4xxx intel_agp snd_ak4xxx_adda snd_cs8427 snd_i2c
snd_intel8x0 i2c_i801 snd_mpu401_uart agpgart i2c_core uhci_hcd ide_cd
cdrom usbcore ohci1394 ieee1394 snd_cs46xx gameport snd_rawmidi
snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd
soundcore snd_page_alloc i8xx_tco sk98lin ext3 jbd reiserfs fan thermal
processor piix ide_disk ide_core
CPU:    1
EIP:    0060:[<c011e56b>]    Not tainted VLI
EFLAGS: 00210046   (2.6.18.1-rt7.1-smp #1)
EIP is at enqueue_task+0x2b/0x90
eax: c180f708   ebx: c180f28c   ecx: 00000000   edx: c0357868
esi: c0357840   edi: c180edc0   ebp: f7291cd0   esp: f7291cc8
ds: 007b   es: 007b   ss: 0068   preempt: 00000004
Process ssh-agent (pid: 3751, ti=f7290000 task=dfcb2630 task.ti=f7290000)
Stack: c180edc0 c0357840 f7291ce0 c011e5f1 00000001 c0357840 f7291d44
c0120971
       38c0f067 ff898284 c17181e0 00000000 0000001f f7290000 00000000
00000001
       00000004 dfd010b0 c0357840 7e7ad015 00000009 b7ca1000 f7bc7ef0
c03d4280
Call Trace:
 [<c011e5f1>] __activate_task+0x21/0x40
 [<c0120971>] try_to_wake_up+0x321/0x450
 [<c0143b62>] wakeup_next_waiter+0xd2/0x1d0
 [<c0120b19>] wake_up_process_mutex+0x19/0x20
 [<c02ff861>] rt_spin_lock_slowunlock+0x41/0x70
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c01439cb>] _atomic_dec_and_spin_lock+0x2b/0x40
 [<c01968ae>] dput+0x1e/0x140
 [<c02fefc5>] preempt_schedule_irq+0x55/0x80
 [<c010526c>] need_resched+0x20/0x24
 [<c010a41a>] convert_fxsr_to_user+0x10a/0x1a0
 [<c010a92d>] save_i387+0x12d/0x1e0
 [<c0104546>] setup_sigcontext+0x106/0x190
 [<c0104e49>] do_notify_resume+0x5e9/0x710
 [<c02fefc5>] preempt_schedule_irq+0x55/0x80
 [<c010526c>] need_resched+0x20/0x24
 [<c01923dd>] sys_select+0x4d/0x1b0
 [<c0104759>] restore_sigcontext+0x169/0x190
 [<c01053cc>] work_notifysig+0x13/0x1b
Code: 55 89 e5 56 89 c6 53 89 d3 f6 40 0c 08 74 09 a1 60 b0 35 c0 85 c0
75 4b 8b 46 1c 8d 56 28 8d 44 c3 1c 8b 48 04 89 46 28 89 50 04 <89> 11
89 4a 04 8b 46 1c 83 43 04 01 0f ab 43 08 83 7e 1c 63 89
EIP: [<c011e56b>] enqueue_task+0x2b/0x90 SS:ESP 0068:f7291cc8
 <6>note: ssh-agent[3751] exited with preempt_count 3

...
Oops: 0002 [#1]
__schedule+0x644/0xee0
 [<c011e5f1>] __activate_task+0x21/0x40
 [<c011e5f1>] __activate_task+0x21/0x40
 [<c01206ab>] try_to_wake_up+0x5b/0x450
 [<c01206ab>] try_to_wake_up+0x5b/0x450
 [<c0143c68>] __rt_mutex_adjust_prio+0x8/0x20
 [<c01444f1>] task_blocks_on_rt_mutex+0x111/0x210
 [<c01f42d2>] __next_cpu+0x12/0x30
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
 [<c01206ab>] try_to_wake_up+0x5b/0x450
 [<c0143c68>] __rt_mutex_adjust_prio+0x8/0x20
 [<c01444f1>] task_blocks_on_rt_mutex+0x111/0x210
 [<c01f42d2>] __next_cpu+0x12/0x30
 [<c02feac0>] schedule+0x30/0x100
 [<c02ff9cb>] rt_spin_lock_slowlock+0x9b/0x1b0
 [<c0302b6e>] kprobe_flush_task+0xe/0x50
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
PREEMPT SMP
Modules linked in: appletalk ax25 ipx p8023 ipv6 edd snd_seq_dummy
snd_pcm_oss snd_mixer_oss snd_seq_midi snd_seq_midi_event w83627hf
snd_seq hwmon_vid hwmon i2c_isa button battery ac loop dm_mod intel_rng
usbhid wacom shpchp snd_cs46xx i2c_i801 pci_hotplug gameport i2c_core
intel_agp ide_cd cdrom ehci_hcd uhci_hcd agpgart snd_ice1712
snd_ice17xx_ak4xxx snd_ak4xxx_adda ohci1394 i8xx_tco usbcore sk98lin
snd_cs8427 ieee1394 snd_i2c snd_mpu401_uart snd_rawmidi snd_seq_device
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore
snd_page_alloc ext3 jbd reiserfs fan thermal processor piix ide_disk
ide_core
CPU:    0
EIP:    0060:[<c011e56b>]    Not tainted VLI
EFLAGS: 00010046   (2.6.18.1-rt7.1-smp #1)
EIP is at enqueue_task+0x2b/0x90
eax: c188f28c   ebx: c188ee10   ecx: 00000000   edx: dfd010d8
esi: dfd010b0   edi: c188edc0   ebp: c03e1e8c   esp: c03e1e84
ds: 007b   es: 007b   ss: 0068   preempt: 00000004
Process swapper (pid: 0, ti=c03e0000 task=c0357840 task.ti=c03e0000)
Stack: c188edc0 dfd010b0 c03e1e9c c011e5f1 00000001 dfd010b0 c03e1f00
c0120971
       f7bc3930 c03e1eb8 00000001 00000000 0000001f c03e0000 00000001
00000000
       00000004 dfd13670 c03e1f30 00000001 dfd005b0 c180edc0 dfd005b0
c03d4280
Call Trace:
 [<c011e5f1>] __activate_task+0x21/0x40
 [<c0120971>] try_to_wake_up+0x321/0x450
 [<c0143b62>] wakeup_next_waiter+0xd2/0x1d0
 [<c0120b19>] wake_up_process_mutex+0x19/0x20
 [<c02ff861>] rt_spin_lock_slowunlock+0x41/0x70
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
Code: 55 89 e5 56 89 c6 53 89 d3 f6 40 0c 08 74 09 a1 60 b0 35 c0 85 c0
75 4b 8b 46 1c 8d 56 28 8d 44 c3 1c 8b 48 04 89 46 28 89 50 04 <89> 11
89 4a 04 8b 46 1c 83 43 04 01 0f ab 43 08 83 7e 1c 63 89
EIP: [<c011e56b>] enqueue_task+0x2b/0x90 SS:ESP 0068:c03e1e84
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
 [<c01271a1>] panic+0x51/0x120
 [<c012ae50>] do_exit+0x6e0/0xa90
 [<c0106462>] show_registers+0x172/0x240
 [<c012780b>] printk+0x1b/0x20
 [<c0110068>] positive_have_wrcomb+0x8/0x10
 [<c0106831>] die+0x301/0x310
 [<c0301cc5>] do_page_fault+0x205/0x610
 [<c0301ac0>] do_page_fault+0x0/0x610
 [<c0105e09>] error_code+0x39/0x40
 [<c011007b>] generic_validate_add_page+0xb/0x100
 [<c011e56b>] enqueue_task+0x2b/0x90
 [<c011e5f1>] __activate_task+0x21/0x40
 [<c0120971>] try_to_wake_up+0x321/0x450
 [<c0143b62>] wakeup_next_waiter+0xd2/0x1d0
 [<c0120b19>] wake_up_process_mutex+0x19/0x20
 [<c02ff861>] rt_spin_lock_slowunlock+0x41/0x70
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
 swapper/0[CPU#0]: BUG in smp_call_function at arch/i386/kernel/smp.c:557
 [<c01283f6>] __WARN_ON+0x66/0x90
 [<c0115220>] stop_this_cpu+0x0/0x40
 [<c011501a>] smp_call_function+0xda/0xe0
 [<c012780b>] printk+0x1b/0x20
 [<c011503b>] smp_send_stop+0x1b/0x30
 [<c01271b4>] panic+0x64/0x120
 [<c012ae50>] do_exit+0x6e0/0xa90
 [<c0106462>] show_registers+0x172/0x240
 [<c012780b>] printk+0x1b/0x20
 [<c0110068>] positive_have_wrcomb+0x8/0x10
 [<c0106831>] die+0x301/0x310
 [<c0301cc5>] do_page_fault+0x205/0x610
 [<c0301ac0>] do_page_fault+0x0/0x610
 [<c0105e09>] error_code+0x39/0x40
 [<c011007b>] generic_validate_add_page+0xb/0x100
 [<c011e56b>] enqueue_task+0x2b/0x90
 [<c011e5f1>] __activate_task+0x21/0x40
 [<c0120971>] try_to_wake_up+0x321/0x450
 [<c0143b62>] wakeup_next_waiter+0xd2/0x1d0
 [<c0120b19>] wake_up_process_mutex+0x19/0x20
 [<c02ff861>] rt_spin_lock_slowunlock+0x41/0x70
 [<c02fe67c>] __schedule+0xc0c/0xee0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e5808>] start_kernel+0x368/0x440
 [<c03e5220>] unknown_bootoption+0x0/0x280
...


I will now try turning on some .config debug options, e.g.
CONFIG_PREEMPT, and if I can catch something I'll be back here with some
more dumps ;)

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
