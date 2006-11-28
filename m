Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936006AbWK1SLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936006AbWK1SLZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 13:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936009AbWK1SLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 13:11:24 -0500
Received: from smtp3.Stanford.EDU ([171.67.20.26]:6087 "EHLO
	smtp3.stanford.edu") by vger.kernel.org with ESMTP id S936006AbWK1SLW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 13:11:22 -0500
Subject: 2.6.19-rc6-rt7: Kernel BUG at kernel/rtmutex.c:672
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
Cc: nando@ccrma.Stanford.EDU
Content-Type: multipart/mixed; boundary="=-AOYwjgGsp9TVOQESHHCq"
Date: Tue, 28 Nov 2006 10:11:14 -0800
Message-Id: <1164737474.15887.10.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AOYwjgGsp9TVOQESHHCq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

(testing -rt8 but just in case)

I got this overnight, found the machine catatonic this morning, machine
is an Athlon X2 4400 running FC6 x86_64 booting into a rebuilt
2.6.19-rc6-rt7 rpm package based on Ingo's packages (same .config except
for 4KSTACKS=off). I'm including a dmesg after the reboot and the bug
traces. 

(a normal non-root user was left logged in and was running jackd with
realtime privileges, irqs' priority reordered with the rtirq script - I
was getting, and still are under -rt8, lots of audio xruns but that's
for another thread). 

-- Fernando


--=-AOYwjgGsp9TVOQESHHCq
Content-Disposition: attachment; filename=msg.1
Content-Type: text/plain; name=msg.1; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Nov 28 03:26:39 localhost kernel: ----------- [cut here ] --------- [please bite here ] ---------
Nov 28 03:26:39 localhost kernel: Kernel BUG at kernel/rtmutex.c:672
Nov 28 03:26:39 localhost kernel: invalid opcode: 0000 [1] PREEMPT SMP 
Nov 28 03:26:39 localhost kernel: CPU 1 
Nov 28 03:26:39 localhost kernel: Modules linked in: hidp rfcomm l2cap bluetooth sunrpc ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink iptable_filter ip_tables ip6t_REJECT xt_tcpudp ip6table_filter ip6_tables x_tables cpufreq_ondemand dm_mirror dm_multipath dm_mod video sbs i2c_ec button battery asus_acpi ac radeon drm ipv6 parport_pc lp parport snd_intel8x0 snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_ac97_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_ac97_bus snd_i2c floppy snd_mpu401_uart snd_rawmidi snd_seq_device snd_timer snd k8temp i2c_nforce2 i2c_core sg hwmon shpchp snd_page_alloc forcedeth soundcore pata_amd pcspkr skge serio_raw ohci1394 ieee1394 ide_cd cdrom sata_sil ata_generic sata_nv libata sd_mod scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
Nov 28 03:26:39 localhost kernel: Pid: 27, comm: events/1 Not tainted 2.6.18-1.0001.3.rt7.fc6.ccrma #1
Nov 28 03:26:39 localhost kernel: RIP: 0010:[<ffffffff80267823>]  [<ffffffff80267823>] rt_spin_lock_slowlock+0x6c/0x1bb
Nov 28 03:26:39 localhost kernel: RSP: 0018:ffff810037e73cb0  EFLAGS: 00010046
Nov 28 03:26:39 localhost kernel: RAX: ffff810037fef040 RBX: ffff81000407b020 RCX: ffff81000407b048
Nov 28 03:26:39 localhost kernel: RDX: ffff810037fef040 RSI: 0000000000000282 RDI: ffff81000407b020
Nov 28 03:26:39 localhost kernel: RBP: ffff810037e73d40 R08: 0000000000000000 R09: ffff810004070580
Nov 28 03:26:39 localhost kernel: R10: 0000000000000000 R11: ffff810058bfbaf8 R12: 0000000000000282
Nov 28 03:26:39 localhost kernel: R13: ffff810037fd2800 R14: ffff810037fd9100 R15: 0000000000000000
Nov 28 03:26:39 localhost kernel: FS:  00002b9f610b2220(0000) GS:ffff81007ff81bc0(0000) knlGS:0000000000000000
Nov 28 03:26:39 localhost kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
Nov 28 03:26:39 localhost kernel: CR2: 00002aaaab069acc CR3: 00000000596f7000 CR4: 00000000000006e0
Nov 28 03:26:39 localhost kernel: Process events/1 (pid: 27, threadinfo ffff810037e72000, task ffff810037fef040)
Nov 28 03:26:39 localhost kernel: Stack:  ffff810037e73ca8 ffff810037e73cb8 ffff810037e73cb8 0000000000000062
Nov 28 03:26:39 localhost kernel:  ffff810037e73cd0 ffff810037e73cd0 ffff810037e73ce0 ffff810037e73ce0
Nov 28 03:26:39 localhost kernel:  0000000000000000 ffff810037f929c0 0000000000000000 ffff810037f929c0
Nov 28 03:26:39 localhost kernel: Call Trace:
Nov 28 03:26:39 localhost kernel:  [<ffffffff802681be>] rt_spin_lock+0x1f/0x21
Nov 28 03:26:39 localhost kernel:  [<ffffffff802dbf7d>] drain_array+0x7d/0x122
Nov 28 03:26:39 localhost kernel:  [<ffffffff802dc833>] cache_reap+0xef/0x26a
Nov 28 03:26:39 localhost kernel:  [<ffffffff8024ffd0>] run_workqueue+0x9a/0xe6
Nov 28 03:26:39 localhost kernel:  [<ffffffff8024c71d>] worker_thread+0xeb/0x11e
Nov 28 03:26:39 localhost kernel:  [<ffffffff80233800>] kthread+0xf5/0x128
Nov 28 03:26:39 localhost kernel:  [<ffffffff802620f8>] child_rip+0xa/0x12
Nov 28 03:26:39 localhost kernel: DWARF2 unwinder stuck at child_rip+0xa/0x12
Nov 28 03:26:39 localhost kernel: 
Nov 28 03:26:39 localhost kernel: Leftover inexact backtrace:
Nov 28 03:26:39 localhost kernel: 
Nov 28 03:26:39 localhost kernel:  [<ffffffff8023370b>] kthread+0x0/0x128
Nov 28 03:26:39 localhost kernel:  [<ffffffff802620ee>] child_rip+0x0/0x12
Nov 28 03:26:39 localhost kernel: 
Nov 28 03:26:39 localhost kernel: skipping trace printing on CPU#1 != -1
Nov 28 03:26:39 localhost kernel: 
Nov 28 03:26:39 localhost kernel: Code: 0f 0b 68 48 1a 4b 80 c2 a0 02 41 be 04 00 00 00 4c 87 32 4d 
Nov 28 03:26:39 localhost kernel: RIP  [<ffffffff80267823>] rt_spin_lock_slowlock+0x6c/0x1bb
Nov 28 03:26:39 localhost kernel:  RSP <ffff810037e73cb0>
Nov 28 03:26:39 localhost kernel:  <6>note: events/1[27] exited with preempt_count 1
Nov 28 03:26:39 localhost kernel: NMI Watchdog detected LOCKUP on CPU 1
Nov 28 03:26:39 localhost kernel: CPU 0:
Nov 28 03:26:39 localhost kernel: Modules linked in: hidp rfcomm l2cap bluetooth sunrpc ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink iptable_filter ip_tables ip6t_REJECT xt_tcpudp ip6table_filter ip6_tables x_tables cpufreq_ondemand dm_mirror dm_multipath dm_mod video sbs i2c_ec button battery asus_acpi ac radeon drm ipv6 parport_pc lp parport snd_intel8x0 snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_ac97_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_ac97_bus snd_i2c floppy snd_mpu401_uart snd_rawmidi snd_seq_device snd_timer snd k8temp i2c_nforce2 i2c_core sg hwmon shpchp snd_page_alloc forcedeth soundcore pata_amd pcspkr skge serio_raw ohci1394 ieee1394 ide_cd cdrom sata_sil ata_generic sata_nv libata sd_mod scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
Nov 28 03:26:39 localhost kernel: CPU 1 Pid: 0, comm: swapper Not tainted 2.6.18-1.0001.3.rt7.fc6.ccrma #1
Nov 28 03:26:39 localhost kernel: RIP: 0010:[<ffffffff802a66f4>] 
Nov 28 03:26:39 localhost kernel: Modules linked in: hidp rfcomm [<ffffffff802a66f4>] enqueue_hrtimer+0x44/0x12d
Nov 28 03:26:39 localhost kernel: RSP: 0018:ffffffff80936ef8  EFLAGS: 00000083
Nov 28 03:26:39 localhost kernel: RAX: ffff810066e15dc8 RBX: ffff8100040697d0 RCX: ffffffff802a66dd
Nov 28 03:26:39 localhost kernel: RDX: 00002009aa461b62 RSI: ffff8100040697d0 RDI: 00002009a6fb2104
Nov 28 03:26:39 localhost kernel: RBP: ffffffff80936f28 R08: 00002009a6be1804 R09: 0000000000000001
Nov 28 03:26:39 localhost kernel: R10: ffffffff80982078 R11: 000000000000001f R12: ffff810004069758
Nov 28 03:26:39 localhost kernel: R13: ffff810066e15dd8 R14: 0000000000000000 R15: ffff810066e15dc8
Nov 28 03:26:39 localhost kernel: FS:  0000000040800940(0000) GS:ffffffff80657200(0000) knlGS:00000000f7eb26c0
Nov 28 03:26:39 localhost kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
Nov 28 03:26:39 localhost kernel: CR2: 00002ac12e68e000 CR3: 0000000066cbe000 CR4: 00000000000006e0
Nov 28 03:26:39 localhost kernel: 
Nov 28 03:26:39 localhost kernel: Call Trace:
Nov 28 03:26:39 localhost kernel:  l2cap bluetooth sunrpc ip_conntrack_netbios_ns ipt_REJECT xt_state ip_conntrack nfnetlink iptable_filter [<ffffffff802a7552>] hrtimer_interrupt+0x136/0x1aa
Nov 28 03:26:39 localhost kernel:  ip_tables ip6t_REJECT xt_tcpudp [<ffffffff8027ae7b>] smp_apic_timer_interrupt+0x68/0x83
Nov 28 03:26:39 localhost kernel:  ip6table_filter ip6_tables x_tables cpufreq_ondemand [<ffffffff80261f16>] apic_timer_interrupt+0x66/0x70
Nov 28 03:26:39 localhost kernel:  dm_mirror dm_multipath dm_mod video sbs i2c_ec button battery asus_acpi ac radeon drm ipv6 parport_pc lp parport snd_intel8x0 snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_ac97_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_ac97_bus snd_i2c floppy snd_mpu401_uart snd_rawmidi snd_seq_device snd_timer snd k8temp i2c_nforce2 i2c_core sg hwmon shpchp snd_page_alloc forcedeth soundcore pata_amd pcspkr skge serio_raw ohci1394 ieee1394 ide_cd cdrom sata_sil ata_generic sata_nv libata sd_mod scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
Nov 28 03:26:39 localhost kernel: Pid: 27, comm: events/1 Not tainted 2.6.18-1.0001.3.rt7.fc6.ccrma #1
Nov 28 03:26:39 localhost kernel: RIP: 0010:[<ffffffff80268487>]  [<ffffffff80268487>] __spin_lock_irqsave+0x1d/0x26
Nov 28 03:26:39 localhost kernel: RSP: 0018:ffff810037e73938  EFLAGS: 00000086
Nov 28 03:26:39 localhost kernel: DWARF2 unwinder stuck at apic_timer_interrupt+0x66/0x70
Nov 28 03:26:39 localhost kernel: 
Nov 28 03:26:39 localhost kernel: Leftover inexact backtrace:
Nov 28 03:26:39 localhost kernel: 
Nov 28 03:26:39 localhost kernel:  <IRQ> RAX: 0000000000000096 RBX: ffff81000407b020 RCX: 0000000000020000
Nov 28 03:26:39 localhost kernel: RDX: ffff810037e73fd8 RSI: 00000000000000d0 RDI: ffff81000407b020
Nov 28 03:26:39 localhost kernel:  <EOI> RBP: ffff810037e73938 R08: 00000000ffffffff R09: 0000000000000020
Nov 28 03:26:39 localhost kernel: R10: 0000000000000000 R11: 0000000000007206 R12: ffff8100067ad2c0
Nov 28 03:26:39 localhost kernel: R13: 00000000000000d0 R14: ffff810037e73a78 R15: 000000000000000b
Nov 28 03:26:39 localhost kernel:  [<ffffffff8026f32c>] default_idle+0x37/0x60
Nov 28 03:26:39 localhost kernel: FS:  00002b9f610b2220(0000) GS:ffff81007ff81bc0(0000) knlGS:0000000000000000
Nov 28 03:26:39 localhost kernel:  [<ffffffff8024b73f>] enter_idle+0x22/0x24
Nov 28 03:26:39 localhost kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
Nov 28 03:26:39 localhost kernel:  [<ffffffff8024b8f2>] cpu_idle+0x98/0xed
Nov 28 03:26:39 localhost kernel: CR2: 00002aaaab069acc CR3: 00000000596f7000 CR4: 00000000000006e0
Nov 28 03:26:39 localhost kernel:  [<ffffffff8026e66c>] rest_init+0x53/0x55
Nov 28 03:26:39 localhost kernel: Process events/1 (pid: 27, threadinfo ffff810037e72000, task ffff810037fef040)
Nov 28 03:26:39 localhost kernel:  [<ffffffff808d9774>] start_kernel+0x269/0x26b
Nov 28 03:26:39 localhost kernel: Stack:  ffff810037e739d8 [<ffffffff808d9158>] _sinittext+0x158/0x15f
Nov 28 03:26:39 localhost kernel:  ffffffff802677d8 ffff810037e73cb0 ffff810037e73c08
Nov 28 03:26:39 localhost kernel: skipping trace printing on CPU#0 != -1
Nov 28 03:26:39 localhost kernel: 
Nov 28 03:26:39 localhost kernel:  0000000000000000 ffff810037fef040 ffffffff804a9c08 000000000000000b
Nov 28 03:26:39 localhost kernel:  ffff810037e73a58 ffffffff80294778 0000003000000020 ffff810037e73a68
Nov 28 03:26:39 localhost kernel: Call Trace:
Nov 28 03:26:39 localhost kernel:  [<ffffffff802677d8>] rt_spin_lock_slowlock+0x21/0x1bb
Nov 28 03:26:39 localhost kernel:  [<ffffffff802681be>] rt_spin_lock+0x1f/0x21
Nov 28 03:26:39 localhost kernel:  [<ffffffff802dceb5>] kmem_cache_zalloc+0x38/0xf4
Nov 28 03:26:39 localhost kernel:  [<ffffffff802c7450>] taskstats_exit_alloc+0x33/0x83
Nov 28 03:26:39 localhost kernel:  [<ffffffff80214fd9>] do_exit+0x158/0x997
Nov 28 03:26:39 localhost kernel:  [<ffffffff8026fe32>] kernel_math_error+0x0/0x96
Nov 28 03:26:39 localhost kernel:  [<ffffffff8026933a>] do_trap+0xdc/0xeb
Nov 28 03:26:39 localhost kernel:  [<ffffffff80270438>] do_invalid_op+0xa7/0xb3
Nov 28 03:26:39 localhost kernel:  [<ffffffff80268d1d>] error_exit+0x0/0x84
Nov 28 03:26:39 localhost kernel: DWARF2 unwinder stuck at error_exit+0x0/0x84
Nov 28 03:26:39 localhost kernel: 
Nov 28 03:26:39 localhost kernel: Leftover inexact backtrace:
Nov 28 03:26:39 localhost kernel: 
Nov 28 03:26:39 localhost kernel:  [<ffffffff80267823>] rt_spin_lock_slowlock+0x6c/0x1bb
Nov 28 03:26:39 localhost kernel:  [<ffffffff802681be>] rt_spin_lock+0x1f/0x21
Nov 28 03:26:39 localhost kernel:  [<ffffffff802dbf7d>] drain_array+0x7d/0x122
Nov 28 03:26:39 localhost kernel:  [<ffffffff802dc833>] cache_reap+0xef/0x26a
Nov 28 03:26:39 localhost kernel:  [<ffffffff802dc744>] cache_reap+0x0/0x26a
Nov 28 03:26:39 localhost kernel:  [<ffffffff8024ffd0>] run_workqueue+0x9a/0xe6
Nov 28 03:26:39 localhost kernel:  [<ffffffff8024c632>] worker_thread+0x0/0x11e
Nov 28 03:26:39 localhost kernel:  [<ffffffff8024c71d>] worker_thread+0xeb/0x11e
Nov 28 03:26:39 localhost kernel:  [<ffffffff8028f4a2>] default_wake_function+0x0/0x14
Nov 28 03:26:39 localhost kernel:  [<ffffffff80233800>] kthread+0xf5/0x128
Nov 28 03:26:39 localhost kernel:  [<ffffffff80228c38>] schedule_tail+0x82/0x11b
Nov 28 03:26:39 localhost kernel:  [<ffffffff802620f8>] child_rip+0xa/0x12
Nov 28 03:26:39 localhost kernel:  [<ffffffff8023370b>] kthread+0x0/0x128
Nov 28 03:26:39 localhost kernel:  [<ffffffff802620ee>] child_rip+0x0/0x12
Nov 28 03:26:39 localhost kernel: 
Nov 28 03:26:39 localhost kernel: skipping trace printing on CPU#1 != -1
Nov 28 03:26:39 localhost kernel: 
Nov 28 03:26:39 localhost kernel: Code: 83 3f 00 7e f9 eb f2 c9 c3 55 48 89 e5 fa 65 48 8b 04 25 10 
Nov 28 03:26:39 localhost kernel:  <1>Fixing recursive fault but reboot is needed!
Nov 28 03:26:39 localhost kernel: BUG: scheduling while atomic: events/1/0x00000002/27, CPU#1
Nov 28 03:26:39 localhost kernel: 
Nov 28 03:26:39 localhost kernel: Call Trace:
Nov 28 03:26:39 localhost kernel:  [<ffffffff8026f79f>] dump_trace+0xaa/0x3f0
Nov 28 03:26:39 localhost kernel:  [<ffffffff8026fb21>] show_trace+0x3c/0x5a
Nov 28 03:26:39 localhost kernel:  [<ffffffff8026fb54>] dump_stack+0x15/0x17
Nov 28 03:26:39 localhost kernel:  [<ffffffff802658eb>] __schedule+0xa3/0xe57
Nov 28 03:26:39 localhost kernel:  [<ffffffff80266a40>] schedule+0xd8/0xf8
Nov 28 03:26:39 localhost kernel:  [<ffffffff80214f8c>] do_exit+0x10b/0x997
Nov 28 03:26:39 localhost kernel:  [<ffffffff802693db>] sync_regs+0x0/0x72
Nov 28 03:26:39 localhost kernel:  [<ffffffff80269af4>] nmi_watchdog_tick+0x1b1/0x2a8
Nov 28 03:26:39 localhost kernel:  [<ffffffff80269759>] default_do_nmi+0x83/0x1c8
Nov 28 03:26:39 localhost kernel:  [<ffffffff80269c10>] do_nmi+0x25/0x3a
Nov 28 03:26:39 localhost kernel:  [<ffffffff80268fbf>] nmi+0x7f/0x90
Nov 28 03:26:39 localhost kernel: DWARF2 unwinder stuck at nmi+0x7f/0x90
Nov 28 03:26:39 localhost kernel: 
Nov 28 03:26:39 localhost kernel: Leftover inexact backtrace:
Nov 28 03:26:39 localhost kernel: 
Nov 28 03:26:39 localhost kernel:  <NMI>  [<ffffffff80268487>] __spin_lock_irqsave+0x1d/0x26
Nov 28 03:26:39 localhost kernel:  <<EOE>>  [<ffffffff802677d8>] rt_spin_lock_slowlock+0x21/0x1bb
Nov 28 03:26:39 localhost kernel:  [<ffffffff80294778>] printk+0x67/0x69
Nov 28 03:26:39 localhost kernel:  [<ffffffff80294778>] printk+0x67/0x69
Nov 28 03:26:39 localhost kernel:  [<ffffffff802681be>] rt_spin_lock+0x1f/0x21
Nov 28 03:26:39 localhost kernel:  [<ffffffff802dceb5>] kmem_cache_zalloc+0x38/0xf4
Nov 28 03:26:39 localhost kernel:  [<ffffffff802ac08a>] rt_up_read+0x4d/0x52
Nov 28 03:26:39 localhost kernel:  [<ffffffff802c7450>] taskstats_exit_alloc+0x33/0x83
Nov 28 03:26:39 localhost kernel:  [<ffffffff80214fd9>] do_exit+0x158/0x997
Nov 28 03:26:39 localhost kernel:  [<ffffffff803a784e>] unblank_screen+0xb/0xd
Nov 28 03:26:39 localhost kernel:  [<ffffffff8026fe32>] kernel_math_error+0x0/0x96
Nov 28 03:26:39 localhost kernel:  [<ffffffff8026933a>] do_trap+0xdc/0xeb
Nov 28 03:26:39 localhost kernel:  [<ffffffff8026af1e>] notifier_call_chain+0x29/0x3e
Nov 28 03:26:39 localhost kernel:  [<ffffffff80270438>] do_invalid_op+0xa7/0xb3
Nov 28 03:26:39 localhost kernel:  [<ffffffff80267823>] rt_spin_lock_slowlock+0x6c/0x1bb
Nov 28 03:26:39 localhost kernel:  [<ffffffff80266786>] thread_return+0xe7/0x1a9
Nov 28 03:26:39 localhost kernel:  [<ffffffff8028db0f>] task_rq_lock+0x3d/0x6f
Nov 28 03:26:39 localhost kernel:  [<ffffffff80268d1d>] error_exit+0x0/0x84
Nov 28 03:26:39 localhost kernel:  [<ffffffff80267823>] rt_spin_lock_slowlock+0x6c/0x1bb
Nov 28 03:26:39 localhost kernel:  [<ffffffff802681be>] rt_spin_lock+0x1f/0x21
Nov 28 03:26:39 localhost kernel:  [<ffffffff802dbf7d>] drain_array+0x7d/0x122
Nov 28 03:26:39 localhost kernel:  [<ffffffff802dc833>] cache_reap+0xef/0x26a
Nov 28 03:26:39 localhost kernel:  [<ffffffff802dc744>] cache_reap+0x0/0x26a
Nov 28 03:26:39 localhost kernel:  [<ffffffff8024ffd0>] run_workqueue+0x9a/0xe6
Nov 28 03:26:39 localhost kernel:  [<ffffffff8024c632>] worker_thread+0x0/0x11e
Nov 28 03:26:39 localhost kernel:  [<ffffffff8024c71d>] worker_thread+0xeb/0x11e
Nov 28 03:26:39 localhost kernel:  [<ffffffff8028f4a2>] default_wake_function+0x0/0x14
Nov 28 03:26:39 localhost kernel:  [<ffffffff80233800>] kthread+0xf5/0x128
Nov 28 03:26:39 localhost kernel:  [<ffffffff80228c38>] schedule_tail+0x82/0x11b
Nov 28 03:26:39 localhost kernel:  [<ffffffff802620f8>] child_rip+0xa/0x12
Nov 28 03:26:39 localhost kernel:  [<ffffffff8023370b>] kthread+0x0/0x128
Nov 28 03:26:39 localhost kernel:  [<ffffffff802620ee>] child_rip+0x0/0x12
Nov 28 03:26:39 localhost kernel: 
Nov 28 03:26:39 localhost kernel: skipping trace printing on CPU#1 != -1

--=-AOYwjgGsp9TVOQESHHCq
Content-Disposition: attachment; filename=dmesg.1
Content-Type: text/plain; name=dmesg.1; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.6.18-1.0001.3.rt7.fc6.ccrma (machbuild@planetforge.stanford.edu) (gcc version 4.1.1 20061011 (Red Hat 4.1.1-30)) #1 SMP PREEMPT Mon Nov 27 20:06:20 EST 2006
Command line: ro root=LABEL=/ rhgb quiet
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
 BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 524272) 1 entries of 3200 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f6c90
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x000000007fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x000000007fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x000000007fff7bc0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000007fff0000
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 524272) 1 entries of 3200 used
NUMA: Using 63 for the hash shift.
Using node hash shift of 63
Bootmem setup node 0 0000000000000000-000000007fff0000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   524272
On node 0 totalpages: 524175
  DMA zone: 96 pages used for memmap
  DMA zone: 2299 pages reserved
  DMA zone: 1604 pages, LIFO batch:0
  DMA32 zone: 12191 pages used for memmap
  DMA32 zone: 507985 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
Nvidia board detected. Ignoring ACPI timer override.
If you got timer trouble try acpi_use_timer_override
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 70144 bytes of per cpu data
Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
Built 1 zonelists.  Total pages: 509589
Kernel command line: ro root=LABEL=/ rhgb quiet
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 4096 (order: 12, 32768 bytes)
Clock event device pit configured with caps set: 07
Console: colour VGA+ 80x25
num_possible_cpus(): 2
CPU#0: allocated 6291408 bytes trace buffer.
CPU#0: allocated 6291408 bytes max-trace buffer.
CPU#1: allocated 6291408 bytes trace buffer.
CPU#1: allocated 6291408 bytes max-trace buffer.
allocated 12582816 bytes out-trace buffer.
tracer: a total of 37748448 bytes allocated.
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
CPU 0: aperture @ f0000000 size 32 MB
Aperture too small (32 MB)
AGP bridge at 00:00:00
Aperture from AGP @ f0000000 size 4096 MB (APSIZE 0)
Aperture too small (0 MB)
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Memory: 1930732k/2097088k available (2589k kernel code, 165968k reserved, 1852k data, 352k init)
Calibrating delay using timer specific routine.. 4424.19 BogoMIPS (lpj=8848387)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12561211
Detected 12.561 MHz APIC timer.
lapic max_delta_ns: 667818289
Clock event device pit new caps set: 01
Clock event device lapic configured with caps set: 06
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4421.75 BogoMIPS (lpj=8843515)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
Clock event device pit new caps set: 01
Clock event device lapic configured with caps set: 06
Brought up 2 CPUs
testing NMI watchdog ... OK.
migration_cost=485
checking if image is initramfs... it is
Freeing initrd memory: 1525k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
agpgart: Detected AGP bridge 0
agpgart: Aperture conflicts with PCI mapping.
agpgart: Aperture from AGP @ f0000000 size 4096 MB
agpgart: Aperture too small (0 MB)
agpgart: No usable aperture found.
agpgart: Consider rebooting with iommu=memaper=2 to get a good aperture.
PCI-DMA: Disabling IOMMU.
pnp: 00:00: ioport range 0x1000-0x107f could not be reserved
pnp: 00:00: ioport range 0x1080-0x10ff has been reserved
pnp: 00:00: ioport range 0x1400-0x147f has been reserved
pnp: 00:00: ioport range 0x1480-0x14ff could not be reserved
pnp: 00:00: ioport range 0x1800-0x187f has been reserved
pnp: 00:00: ioport range 0x1880-0x18ff has been reserved
PCI: Bridge: 0000:00:0b.0
  IO window: 7000-7fff
  MEM window: f2000000-f3ffffff
  PREFETCH window: e0000000-efffffff
PCI: Bridge: 0000:00:0e.0
  IO window: 8000-afff
  MEM window: f4000000-f5ffffff
  PREFETCH window: 88000000-880fffff
PCI: Setting latency timer of device 0000:00:0e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 65536 (order: 10, 4194304 bytes)
TCP bind hash table entries: 32768 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 65536 bind 32768)
TCP reno registered
Initializing RT-Tester: OK
audit: initializing netlink socket (disabled)
audit(1164736363.384:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: SONY DVD RW DW-Q28A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
ide-floppy driver 0.99.newide
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
kvm: no hardware support
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ processors (version 2.00.00)
powernow-k8: invalid freq entries 3900000 kHz vs. 65535000 kHz
powernow-k8: invalid freq entries 3900000 kHz vs. 65535000 kHz
powernow-k8: invalid freq entries 3900000 kHz vs. 65535000 kHz
powernow-k8: invalid freq entries 3900000 kHz vs. 65535000 kHz
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8
powernow-k8:    1 : fid 0x2 (1000 MHz), vid 0x12
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 352k freed
Write protecting the kernel read-only data: 486k
Time: tsc clocksource has been installed.
Clock event device pit disabled
Clock event device lapic configured with caps set: 08
Switched to high resolution mode on CPU 0
Clock event device lapic configured with caps set: 08
Switched to high resolution mode on CPU 1
input: AT Translated Set 2 keyboard as /class/input/input0
Time: acpi_pm clocksource has been installed.
USB Universal Host Controller Interface driver v3.0
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 22 (level, high) -> IRQ 22
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 22, io mem 0xf6003000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 21 (level, high) -> IRQ 21
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: OHCI Host Controller
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.1: irq 21, io mem 0xf6004000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 20 (level, high) -> IRQ 20
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: EHCI Host Controller
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:02.2: debug port 3
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: irq 20, io mem 0xf6005000
ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 8 ports detected
SCSI subsystem initialized
libata version 2.00 loaded.
sata_nv 0000:00:0a.0: version 2.0
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSJ] -> GSI 22 (level, high) -> IRQ 22
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 22
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 22
scsi0 : sata_nv
input: ImExPS/2 Logitech Wheel Mouse as /class/input/input1
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-6, max UDMA/133, 156299375 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : sata_nv
ata2: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      ST380817AS       3.42 PQ: 0 ANSI: 5
SCSI device sda: 156299375 512-byte hdwr sectors (80025 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156299375 512-byte hdwr sectors (80025 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
sata_sil 0000:02:0d.0: version 2.0
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt 0000:02:0d.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
ata3: SATA max UDMA/100 cmd 0xFFFFC2000001A080 ctl 0xFFFFC2000001A08A bmdma 0xFFFFC2000001A000 irq 17
ata4: SATA max UDMA/100 cmd 0xFFFFC2000001A0C0 ctl 0xFFFFC2000001A0CA bmdma 0xFFFFC2000001A008 irq 17
scsi2 : sata_sil
ata3: SATA link down (SStatus 0 SControl 310)
scsi3 : sata_sil
ata4: SATA link down (SStatus 0 SControl 310)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sda1: orphan cleanup on readonly fs
ext3_orphan_cleanup: deleting unreferenced inode 3297257
ext3_orphan_cleanup: deleting unreferenced inode 4381354
ext3_orphan_cleanup: deleting unreferenced inode 4381357
ext3_orphan_cleanup: deleting unreferenced inode 4381356
ext3_orphan_cleanup: deleting unreferenced inode 4388213
ext3_orphan_cleanup: deleting unreferenced inode 4388526
ext3_orphan_cleanup: deleting unreferenced inode 587530
ext3_orphan_cleanup: deleting unreferenced inode 4603326
ext3_orphan_cleanup: deleting unreferenced inode 4404086
ext3_orphan_cleanup: deleting unreferenced inode 4392044
ext3_orphan_cleanup: deleting unreferenced inode 4404088
ext3_orphan_cleanup: deleting unreferenced inode 4404015
ext3_orphan_cleanup: deleting unreferenced inode 4404014
ext3_orphan_cleanup: deleting unreferenced inode 4341418
ext3_orphan_cleanup: deleting unreferenced inode 4341417
ext3_orphan_cleanup: deleting unreferenced inode 4538945
ext3_orphan_cleanup: deleting unreferenced inode 4404412
EXT3-fs: sda1: 17 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
audit(1164736371.905:2): enforcing=1 old_enforcing=0 auid=4294967295
security:  3 users, 6 roles, 1569 types, 170 bools, 1 sens, 1024 cats
security:  59 classes, 48714 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev sda1, type ext3), uses xattr
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1164736372.126:3): policy loaded auid=4294967295
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
input: PC Speaker as /class/input/input2
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:02:0e.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[18]  MMIO=[f5008000-f50087ff]  Max Packet=[4096]  IR/IT contexts=[4/8]
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x1c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x2000
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.57.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [APCH] -> GSI 21 (level, high) -> IRQ 21
PCI: Setting latency timer of device 0000:00:05.0 to 64
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eth0: forcedeth.c: subsystem: 01458:e000 bound to 0000:00:05.0
ACPI: PCI Interrupt 0000:02:0a.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:02:0b.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 19
skge 1.9 addr 0xf5000000 irq 19 chip Yukon-Lite rev 9
skge eth1: addr 00:14:85:02:11:83
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 20 (level, high) -> IRQ 20
PCI: Setting latency timer of device 0000:00:06.0 to 64
sd 0:0:0:0: Attached scsi generic sg0 type 0
intel8x0_measure_ac97_clock: measured 52633 usecs
intel8x0: clocking to 46930
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00148556000157de]
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
SELinux: initialized (dev ramfs, type ramfs), uses genfs_contexts
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC5] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized radeon 1.25.0 20060524 on minor 0
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
EXT3 FS on sda1, internal journal
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Adding 4096564k swap on /dev/sda2.  Priority:-1 extents:1 across:4096564k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 344 bytes per conntrack
process `sysctl' is using deprecated sysctl (syscall) net.ipv6.neigh.lo.base_reachable_time; Use net.ipv6.neigh.lo.base_reachable_time_ms instead.
skge eth0: enabling interface
ADDRCONF(NETDEV_UP): eth0: link is not ready
skge eth0: Link is up at 100 Mbps, full duplex, flow control both
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
eth1: no link during initialization.
ADDRCONF(NETDEV_UP): eth1: link is not ready
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
eth0: no IPv6 routers present
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata1.00: tag 0 cmd 0xb0 Emask 0x1 stat 0x51 err 0x4 (device error)
ata1: EH complete
SCSI device sda: 156299375 512-byte hdwr sectors (80025 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156299375 512-byte hdwr sectors (80025 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:drm_unlock] *ERROR* Process 3260 using kernel context 0
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
Buffer I/O error on device fd0, logical block 0
end_request: I/O error, dev fd0, sector 0
Buffer I/O error on device fd0, logical block 0
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
Buffer I/O error on device fd0, logical block 0
end_request: I/O error, dev fd0, sector 0
Buffer I/O error on device fd0, logical block 0

--=-AOYwjgGsp9TVOQESHHCq--

