Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbWJKTTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWJKTTV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161354AbWJKTTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:19:21 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:30731 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S1161087AbWJKTTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:19:20 -0400
Message-ID: <452D43B6.8020406@tuxrocks.com>
Date: Wed, 11 Oct 2006 14:19:18 -0500
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Kernel panic in 2.6.19-rc1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting kernel panics within a few minutes of boot with 2.6.19-rc1 
(latest git) on x86_64.  Other than "make oldconfig", it's an identical 
configuration to a working kernel on 2.6.18.

The panic scrolls off the screen, but I copied down what was on the screen:

[<ffffffff8103e6d3>] blocking_notifier_call_chain+0x1b/0x41
[<ffffffff810332b3>] profile_task_exit+0x15/0x17
[<ffffffff81034d97>] do_exit+0x25/0x918
[<ffffffff8131b113>] sync_regs+0x0/0x72
[<ffffffff8131b767>] nmi_watchdog_tick+0xfe/0x1de
[<ffffffff8131b318>] default_do_nmi+0x83/0x1c8
[<ffffffff8131b86e>] do_nmi+0x27/0x36
[<ffffffff8131acff>] nmi+0x7f/0x90
[<ffffffff811838e0>] acpi_processor_idle+0x259/0x48d
<<EOE>> [<ffffffff8131cb55>] atomic_notifier_call_chain+0x3e/0x60
[<ffffffff81183687>] acpi_processor_idle+0x0/0x48d
[<ffffffff81008caa>] cpu_idle+0x8f/0xc6
[<ffffffff81018274>] start_secondary+0x44a/0x45a

Kernel panic - not syncing: Attempted to kill the idle task!
  CPU 0
Modules linked in: sunrpc asus_acpi lp parport_pc parport nvram ohci1394 
ieee1394 joydev uhci_hcd ehci_hcd bcm43xx i2c_i801 i2c_core
Pid: 0, comm: swapper Not tainted 2.6.19-rc1-fs2 #2
RIP: 0010: ffffffff811838e0 acpi_processor_idle+0x259/0x48d
RSP: 0x18:ffffffff8149ff18  EFLAGS: 00000092
RAX: 0000000000d58d95 RBX: 0000000000000002 RCX: 0000000000001008
RDX: 0000000000001016 RSI: 0000000000000013 RDI: 0000000000000001
RBP: ffffffff8149ff68 R08: ffff81007db42d00 R09: 000000007db42d60
R10: 000000000055cfe0 R11: 0000000000000246 R12: ffff81007db42d60
R13: 0000000000d58d95 R14: ffff81007db42c00 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff8148c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002b2838a40000 CR3: 0000000060f52000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffffffff8149e000, task ffffffff813d0420)
Stack:  0000000000000000 0000000000000001 ffffffff8149ff58 ffffffff8131cb55
  0000000000000246 ffffffff81183687 0000000000000000 0000000000000000
  0000000000000000 0000000000000000 ffffffff8149ff88 ffffffff81008caa
Call Trace:
[<ffffffff8131cb55>] atomic_notifier_call_chain+0x3e/0x60
[<ffffffff81183687>] acpi_processor_idle+0x0/0x48d
[<ffffffff81008caa>] cpu_idle+0x8f/0xc6
[<ffffffff8100703f>] rest_init+0x3f/0x41
[<ffffffff814a96c9>] start_kernel+0x21a/0x21c
[<ffffffff814a9156>] _sinittext+0x156/0x15d

Code: 80 ca ed ed 89 c3 41 f6 46 18 20 74 15 f0 ff 0d b4 79 3d 00
BUG: warning at drivers/char/vt.c:3395/do_unblank_screen()

Call Trace:
  <NMI>  [<ffffffff8100b3ab>] _show_stack+0xdb/0xea
  [<ffffffff8119ca6a>] do_unblank_screen+0x5a/0x131
  [<ffffffff8119cb4c>] unblank_screen+0xb/0xd
  [<ffffffff81020ab2>] bust_spinlocks+0x24/0x50
  [<ffffffff8131adea>] oops_end+0x1d/0x62
  [<ffffffff8131b0fe>] die_nmi+0x73/0x88
  [<ffffffff8131b767>] nmi_watchdog_tick+0xfe/0x1de
  [<ffffffff8131b318>] default_do_nmi+0x83/0x1c8
  [<ffffffff8131b86e>] do_nmi+0x27/0x36
  [<ffffffff8131acff>] nmi+0x7f/0x90
  [<ffffffff811838e0>] acpi_processor_idle+0x259/0x48d
  <<EOE>>  [<ffffffff8131cb55>] atomic_notifier_call_chain+0x3e/0x60
  [<ffffffff81183687>] acpi_processor_idle+0x0/0x48d
  [<ffffffff81008caa>] cpu_idle+0x8f/0xc6
  [<ffffffff8100703f>] rest_init+0x3f/0x41
  [<ffffffff814a96c9>] start_kernel+0x21a/0x21c
  [<ffffffff814a9156>] _sinittext+0x156/0x15d



Thanks,

Frank
