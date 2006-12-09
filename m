Return-Path: <linux-kernel-owner+w=401wt.eu-S1758826AbWLIR1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758826AbWLIR1A (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 12:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758483AbWLIR1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 12:27:00 -0500
Received: from 200.red-82-159-198.user.auna.net ([82.159.198.200]:42210 "EHLO
	indy.cmartin.tk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758267AbWLIR07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 12:26:59 -0500
Subject: general protection fault: 0000 [1] PREEMPT SMP with
	2.6.19-rc6-g2ea58144
From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <carlos@cmartin.tk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Date: Sat, 09 Dec 2006 18:26:55 +0100
Message-Id: <1165685215.4563.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 This appeared on my syslog, I thought someone would know how to fix it.

 My hardware is an AMD Athlon64X2 and my filesystem reiserfs on both
PATA and SATA discs, if that helps.

-----8<------------8<--------
general protection fault: 0000 [1] PREEMPT SMP
CPU 1
Modules linked in: af_packet cpufreq_ondemand powernow_k8 binfmt_misc lp
fan button ac battery ipv6 snd_intel8x0 snd_ac97_codec snd_ac97_bus
snd_pcm_oss snd_pcm snd_mixer_oss snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_timer snd_seq_device snd analog
parport_pc parport ns558 gameport psmouse k8temp snd_page_alloc ohci_hcd
forcedeth ehci_hcd usbcore pcspkr ide_cd cdrom evdev unix
Pid: 12099, comm: firefox-bin Not tainted 2.6.19-rc6-g2ea58144 #1
RIP: 0010:[<ffffffff802a5fe5>]  [<ffffffff802a5fe5>] set_page_dirty
+0x30/0x5b
RSP: 0018:ffff81001b937b88  EFLAGS: 00010286
RAX: 0100000000000060 RBX: ffff81007f7bbee8 RCX: ffff81000102c740
RDX: ffffffff802ca2c2 RSI: 800000005a7fb065 RDI: ffff81007f7bbee8
RBP: ffff81001b937b88 R08: ffff81007e3e7981 R09: 0000000000000000
R10: ffff81005c92df38 R11: 0000000000000206 R12: 000000005a7fb065
R13: 00000000017ef000 R14: ffff81005c92df78 R15: 0000000001800000
FS:  000000004580a960(0000) GS:ffff81007e3e78c0(0000)
knlGS:00000000f7e416c0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002aaaac8e58c0 CR3: 0000000000201000 CR4: 00000000000006e0
Process firefox-bin (pid: 12099, threadinfo ffff81001b936000, task
ffff8100202b8100)
Stack:  ffff81001b937c68 ffffffff80207b03 ffff81000102ea60
0000000000000000
 ffff81001b937c80 ffffffffffffffff 0000000000000000 ffff810064fd2768
 ffff81001b937c88 0000000000000000 0000000000000000 0000000100000046
Call Trace:
 [<ffffffff80207b03>] unmap_vmas+0x3b0/0x73f
 [<ffffffff8023955f>] exit_mmap+0x84/0x123
 [<ffffffff8023b90f>] mmput+0x41/0xb2
 [<ffffffff80241dd6>] exit_mm+0xe7/0xf0
 [<ffffffff802152c6>] do_exit+0x207/0x8ef
 [<ffffffff8022aacb>] get_signal_to_deliver+0x56/0x449
 [<ffffffff80249508>] debug_mutex_init+0x0/0x45
 [<ffffffff8022ae6d>] get_signal_to_deliver+0x3f8/0x449
 [<ffffffff8025d1bb>] sysret_signal+0x21/0x31
 [<ffffffff8025a7be>] do_notify_resume+0xa4/0x7b6
 [<ffffffff8027f0fa>] default_wake_function+0x0/0xf
 [<ffffffff80299f2a>] sys_futex+0x102/0x120
 [<ffffffff8025d1bb>] sysret_signal+0x21/0x31
 [<ffffffff8025d477>] ptregscall_common+0x67/0xb0


Code: 48 8b 40 20 48 85 c0 48 0f 44 c2 ff d0 89 c2 eb 16 8b 07 31
RIP  [<ffffffff802a5fe5>] set_page_dirty+0x30/0x5b
 RSP <ffff81001b937b88>
 <3>BUG: sleeping function called from invalid context at
kernel/rwsem.c:20
in_atomic():1, irqs_disabled():0

Call Trace:
 [<ffffffff8020b8bf>] __might_sleep+0xb2/0xb4
 [<ffffffff80293b3d>] down_read+0x1d/0x45
 [<ffffffff8028bd20>] blocking_notifier_call_chain+0x1b/0x41
 [<ffffffff80283cc4>] profile_task_exit+0x15/0x17
 [<ffffffff802150e4>] do_exit+0x25/0x8ef
 [<ffffffff8026807e>] kernel_math_error+0x0/0x96
 [<ffffffff80268d70>] do_general_protection+0x10a/0x115
 [<ffffffff80263cbd>] error_exit+0x0/0x96
 [<ffffffff802ca2c2>] __set_page_dirty_buffers+0x0/0xfd
 [<ffffffff802a5fe5>] set_page_dirty+0x30/0x5b
 [<ffffffff80207b03>] unmap_vmas+0x3b0/0x73f
 [<ffffffff8023955f>] exit_mmap+0x84/0x123
 [<ffffffff8023b90f>] mmput+0x41/0xb2
 [<ffffffff80241dd6>] exit_mm+0xe7/0xf0
 [<ffffffff802152c6>] do_exit+0x207/0x8ef
 [<ffffffff8022aacb>] get_signal_to_deliver+0x56/0x449
 [<ffffffff80249508>] debug_mutex_init+0x0/0x45
 [<ffffffff8022ae6d>] get_signal_to_deliver+0x3f8/0x449
 [<ffffffff8025d1bb>] sysret_signal+0x21/0x31
 [<ffffffff8025a7be>] do_notify_resume+0xa4/0x7b6
 [<ffffffff8027f0fa>] default_wake_function+0x0/0xf
 [<ffffffff80299f2a>] sys_futex+0x102/0x120
 [<ffffffff8025d1bb>] sysret_signal+0x21/0x31
 [<ffffffff8025d477>] ptregscall_common+0x67/0xb0

Fixing recursive fault but reboot is needed!
BUG: scheduling while atomic: firefox-bin/0x00000002/12099

Call Trace:
 [<ffffffff802603ab>] __sched_text_start+0x5b/0x794
 [<ffffffff80293b96>] up_read+0x26/0x2a
 [<ffffffff8028bd3a>] blocking_notifier_call_chain+0x35/0x41
 [<ffffffff802151cc>] do_exit+0x10d/0x8ef
 [<ffffffff8026807e>] kernel_math_error+0x0/0x96
 [<ffffffff80268d70>] do_general_protection+0x10a/0x115
 [<ffffffff80263cbd>] error_exit+0x0/0x96
 [<ffffffff802ca2c2>] __set_page_dirty_buffers+0x0/0xfd
 [<ffffffff802a5fe5>] set_page_dirty+0x30/0x5b
 [<ffffffff80207b03>] unmap_vmas+0x3b0/0x73f
 [<ffffffff8023955f>] exit_mmap+0x84/0x123
 [<ffffffff8023b90f>] mmput+0x41/0xb2
 [<ffffffff80241dd6>] exit_mm+0xe7/0xf0
 [<ffffffff802152c6>] do_exit+0x207/0x8ef
 [<ffffffff8022aacb>] get_signal_to_deliver+0x56/0x449
 [<ffffffff80249508>] debug_mutex_init+0x0/0x45
 [<ffffffff8022ae6d>] get_signal_to_deliver+0x3f8/0x449
 [<ffffffff8025d1bb>] sysret_signal+0x21/0x31
 [<ffffffff8025a7be>] do_notify_resume+0xa4/0x7b6
 [<ffffffff8027f0fa>] default_wake_function+0x0/0xf
 [<ffffffff80299f2a>] sys_futex+0x102/0x120
 [<ffffffff8025d1bb>] sysret_signal+0x21/0x31
 [<ffffffff8025d477>] ptregscall_common+0x67/0xb0
------------8<---------------8<----------------
-- 
Carlos Martín Nieto    |   http://www.cmartin.tk
Hobbyist programmer    |


