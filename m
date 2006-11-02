Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWKBKoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWKBKoU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWKBKoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:44:19 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:27003 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1750768AbWKBKoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:44:18 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CANhNSUVZmGJA/2dsb2JhbAA
X-IronPort-AV: i="4.09,380,1157324400"; 
   d="scan'208"; a="127882818:sNHT19142487"
Message-ID: <42997.194.65.103.1.1162464204.squirrel@www.rncbc.org>
Date: Thu, 2 Nov 2006 10:43:24 -0000 (WET)
Subject: realtime-preempt patch-2.6.18-rt7 oops
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: linux-kernel@vger.kernel.org
Cc: "Ingo Molnar" <mingo@elte.hu>
User-Agent: SquirrelMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 1 (Highest)
Importance: High
X-OriginalArrivalTime: 02 Nov 2006 10:44:14.0095 (UTC) FILETIME=[D689D1F0:01C6FE6B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo et al.

For quite some time I've been running the realtime-preempt kernels with
success on all of my (home) production machines. All of them under
openSUSE 10.1 i586 (all P4), two laptops UP and one desktop SMP/HT.

While on UP kernels everything works great and without major issues to
report, problem goes here on the SMP/HT one. Simple fact: it hangs,
freezes in some non-deterministic ways. However, sometimes, it is just a
matter of a couple of dozen clicks while browsing over those
funky-ajax-enabled-web2 sites :)

I've managed to grab some of those oopses via serial console, and a sample
is shown below. I have more of those, just let me know if you want them :)

One thing to notice notice is that all .config debug switches are off --
as said before, this was production line. If I turn the .config
preempt-debug
switches on, the experience gets a lot less painful, that is, the
hard-locks just don't seem to happen (but some traces are spitted out
(on dmesg), nevertheless.

I'll beg you to have a spare look and try to hint on me whether and how I
can gather some more debug information on this issue, which has gone quite
annoying by now -- for a so-called "production machine", I mean ;)

...
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in: appletalk ax25 ipx p8023 ipv6 snd_seq_dummy edd
snd_pcm_oss snd_mixer_oss snd_seq_midi snd_seq_midi_event snd_seq w83627hf
hwmon_vid hwmon i2c_isa button battery ac loop dm_mod intel_rng usbhid
wacom shpchp pci_hotplug snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda
snd_cs8427 snd_i2c snd_mpu401_uart snd_cs46xx gameport snd_rawmidi ide_cd
snd_seq_device cdrom snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm
intel_agp snd_timer snd_page_alloc i8xx_tco snd sk98lin agpgart ehci_hcd
soundcore uhci_hcd usbcore i2c_i801 i2c_core ohci1394 ieee1394 ext3 jbd
reiserfs fan thermal processor piix ide_disk ide_core
CPU:    0
EIP:    0060:[<c011e5ab>]    Not tainted VLI
EFLAGS: 00010046   (2.6.18.1-rt7.0-smp #1)
EIP is at enqueue_task+0x2b/0x90
eax: c188f708   ebx: c188f28c   ecx: 00000000   edx: dfd010d8
esi: dfd010b0   edi: c188edc0   ebp: c03e3e8c   esp: c03e3e84
ds: 007b   es: 007b   ss: 0068   preempt: 00000004
Process swapper (pid: 0, ti=c03e2000 task=c0358840 task.ti=c03e2000)
Stack: c188edc0 dfd010b0 c03e3e9c c011e631 00000001 dfd010b0 c03e3f00
c01209b1
       00000002 1865a2d4 00000001 00000000 0000001f c03e2000 00000001
00000000
       00000004 a16a98d4 10219a55 006d16d6 c03e3ef0 00000115 00000115
c03d5280
Call Trace:
 [<c011e631>] __activate_task+0x21/0x40
 [<c01209b1>] try_to_wake_up+0x321/0x450
 [<c0144822>] wakeup_next_waiter+0xd2/0x1d0
 [<c0120b59>] wake_up_process_mutex+0x19/0x20
 [<c0300531>] rt_spin_lock_slowunlock+0x41/0x70
 [<c02ff34c>] __schedule+0xc0c/0xee0
 [<c014091a>] hrtimer_interrupt+0x18a/0x250
 [<c015848e>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e7808>] start_kernel+0x368/0x440
 [<c03e7220>] unknown_bootoption+0x0/0x280
Code: 55 89 e5 56 89 c6 53 89 d3 f6 40 0c 08 74 09 a1 80 c0 35 c0 85 c0 75
4b 8b 46 1c 8d 56 28 8d 44 c3 1c 8b 48 04 89 46 28 89 50 04 <89> 11 89 4a
04 8b 46 1c 83 43 04 01 0f ab 43 08 83 7e 1c 63 89
EIP: [<c011e5ab>] enqueue_task+0x2b/0x90 SS:ESP 0068:c03e3e84
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
 [<c01271e1>] panic+0x51/0x120
 [<c012ae90>] do_exit+0x6e0/0xa90
 [<c0106462>] show_registers+0x172/0x240
 [<c012784b>] printk+0x1b/0x20
 [<c0110068>] positive_have_wrcomb+0x8/0x10
 [<c0106831>] die+0x301/0x310
 [<c0302995>] do_page_fault+0x205/0x610
 [<c0302790>] do_page_fault+0x0/0x610
 [<c0105e09>] error_code+0x39/0x40
 [<c011007b>] generic_validate_add_page+0xb/0x100
 [<c011e5ab>] enqueue_task+0x2b/0x90
 [<c011e631>] __activate_task+0x21/0x40
 [<c01209b1>] try_to_wake_up+0x321/0x450
 [<c0144822>] wakeup_next_waiter+0xd2/0x1d0
 [<c0120b59>] wake_up_process_mutex+0x19/0x20
 [<c0300531>] rt_spin_lock_slowunlock+0x41/0x70
 [<c02ff34c>] __schedule+0xc0c/0xee0
 [<c014091a>] hrtimer_interrupt+0x18a/0x250
 [<c015848e>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e7808>] start_kernel+0x368/0x440
 [<c03e7220>] unknown_bootoption+0x0/0x280
 swapper/0[CPU#0]: BUG in smp_call_function at arch/i386/kernel/smp.c:557
 [<c0128436>] __WARN_ON+0x66/0x90
 [<c0115220>] stop_this_cpu+0x0/0x40
 [<c011501a>] smp_call_function+0xda/0xe0
 [<c012784b>] printk+0x1b/0x20
 [<c011503b>] smp_send_stop+0x1b/0x30
 [<c01271f4>] panic+0x64/0x120
 [<c012ae90>] do_exit+0x6e0/0xa90
 [<c0106462>] show_registers+0x172/0x240
 [<c012784b>] printk+0x1b/0x20
 [<c0110068>] positive_have_wrcomb+0x8/0x10
 [<c0106831>] die+0x301/0x310
 [<c0302995>] do_page_fault+0x205/0x610
 [<c0302790>] do_page_fault+0x0/0x610
 [<c0105e09>] error_code+0x39/0x40
 [<c011007b>] generic_validate_add_page+0xb/0x100
 [<c011e5ab>] enqueue_task+0x2b/0x90
 [<c011e631>] __activate_task+0x21/0x40
 [<c01209b1>] try_to_wake_up+0x321/0x450
 [<c0144822>] wakeup_next_waiter+0xd2/0x1d0
 [<c0120b59>] wake_up_process_mutex+0x19/0x20
 [<c0300531>] rt_spin_lock_slowunlock+0x41/0x70
 [<c02ff34c>] __schedule+0xc0c/0xee0
 [<c014091a>] hrtimer_interrupt+0x18a/0x250
 [<c015848e>] redirect_hardirq+0x5e/0xa0
 [<c0105ceb>] reschedule_interrupt+0x1f/0x24
 [<c0103a70>] default_idle+0x0/0x80
 [<c0103ba1>] cpu_idle+0xb1/0x120
 [<c03e7808>] start_kernel+0x368/0x440
 [<c03e7220>] unknown_bootoption+0x0/0x280
...

Bye now!
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
