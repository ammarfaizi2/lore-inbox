Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbTIRSVW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 14:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbTIRSVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 14:21:22 -0400
Received: from [4.5.103.38] ([4.5.103.38]:45741 "EHLO gallant.omgwallhack.org")
	by vger.kernel.org with ESMTP id S261458AbTIRSVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 14:21:18 -0400
Subject: Problem with ohci1394/sbp2
From: Julian Blake Kongslie <jblake@omgwallhack.org>
To: bcollins@debian.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux1394-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1063909274.1253.12.camel@festa.omgwallhack.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 18 Sep 2003 11:21:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm on 2.6.0-test5, and have been having this problem since at least
-test3.

Whenever I plug in my external drive enclosure, I get this:

Sep 18 11:00:14 festa kernel: ieee1394: Node changed: 0-00:1023 -> 0-01:1023
Sep 18 11:00:14 festa kernel: SCSI subsystem initialized
Sep 18 11:00:14 festa kernel: sbp2: $Rev: 1034 $ Ben Collins <bcollins@debian.org>
Sep 18 11:00:14 festa kernel: scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
Sep 18 11:00:14 festa ntpd[1009]: kernel time discipline status change 41
Sep 18 11:00:15 festa ieee1394.agent[1231]: ... can't load module sbp2
Sep 18 11:00:15 festa ieee1394.agent[1231]: missing kernel or user mode driver sbp2 
Sep 18 11:00:15 festa kernel: ieee1394: sbp2: Logged into SBP-2 device
Sep 18 11:00:15 festa kernel: arch/i386/kernel/semaphore.c:84: spin_is_locked on uninitialized spinlock de1d98b8.
Sep 18 11:00:15 festa kernel: Unable to handle kernel paging request at virtual address 6b6b6b6b
Sep 18 11:00:15 festa kernel:  printing eip:
Sep 18 11:00:15 festa kernel: c02d2d79
Sep 18 11:00:15 festa kernel: *pde = 00000000
Sep 18 11:00:15 festa kernel: Oops: 0000 [#1]
Sep 18 11:00:15 festa kernel: CPU:    0
Sep 18 11:00:15 festa kernel: EIP:    0060:[<c02d2d79>]    Not tainted
Sep 18 11:00:15 festa kernel: EFLAGS: 00010097
Sep 18 11:00:15 festa kernel: EIP is at vsnprintf+0x319/0x450
Sep 18 11:00:16 festa kernel: eax: 6b6b6b6b   ebx: 0000000a   ecx: 6b6b6b6b   edx: fffffffe
Sep 18 11:00:16 festa kernel: esi: c05db56b   edi: 00000000   ebp: de0b7d74   esp: de0b7d3c
Sep 18 11:00:16 festa kernel: ds: 007b   es: 007b   ss: 0068
Sep 18 11:00:16 festa kernel: Process modprobe (pid: 1241, threadinfo=de0b6000 task=de0caf90)
Sep 18 11:00:16 festa kernel: Stack: c05db55d c05db93f 00000054 00000000 0000000a ffffffff 00000001 00000002 
Sep 18 11:00:16 festa kernel:        ffffffff ffffffff c05db93f c05db540 00000046 0000019b de0b7dc4 c012caa0 
Sep 18 11:00:16 festa kernel:        c05db540 00000400 c04bdbb2 de0b7ddc 00000086 ddf046ac de1d9880 00000004 
Sep 18 11:00:16 festa kernel: Call Trace:
Sep 18 11:00:16 festa kernel:  [<c012caa0>] printk+0x170/0x3f0
Sep 18 11:00:16 festa kernel:  [<eaa704cc>] dma_trm_flush+0x12c/0x180 [ohci1394]
Sep 18 11:00:16 festa kernel:  [<c010b2b1>] __down+0x1e1/0x350
Sep 18 11:00:16 festa kernel:  [<c01258b0>] default_wake_function+0x0/0x30
Sep 18 11:00:16 festa kernel:  [<eaab6e72>] hpsb_send_packet+0xa2/0x1b0 [ieee1394]
Sep 18 11:00:16 festa kernel:  [<c010b93b>] __down_failed+0xb/0x14
Sep 18 11:00:16 festa kernel:  [<ed03c020>] .text.lock.sbp2+0x5/0x35 [sbp2]
Sep 18 11:00:16 festa kernel:  [<ed0397a0>] sbp2_start_device+0x210/0x3f0 [sbp2]
Sep 18 11:00:16 festa kernel:  [<ed039545>] sbp2_start_ud+0x115/0x160 [sbp2]
Sep 18 11:00:16 festa kernel:  [<ed038ff8>] sbp2_probe+0x38/0x50 [sbp2]
Sep 18 11:00:16 festa kernel:  [<c033f77d>] bus_match+0x3d/0x70
Sep 18 11:00:16 festa kernel:  [<c033f8e0>] driver_attach+0x70/0xb0
Sep 18 11:00:16 festa kernel:  [<c033fbf5>] bus_add_driver+0xa5/0xc0
Sep 18 11:00:16 festa kernel:  [<c03400a8>] driver_register+0x88/0x90
Sep 18 11:00:16 festa kernel:  [<eaabe9b7>] hpsb_register_protocol+0x17/0x30 [ieee1394]
Sep 18 11:00:16 festa kernel:  [<ed03bfef>] sbp2_module_init+0x7f/0xab [sbp2]
Sep 18 11:00:16 festa kernel:  [<c014d637>] sys_init_module+0x1e7/0x3c0
Sep 18 11:00:16 festa kernel:  [<c010d20b>] syscall_call+0x7/0xb
Sep 18 11:00:16 festa kernel: 
Sep 18 11:00:16 festa kernel: Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75 
Sep 18 11:00:16 festa kernel:  <6>note: modprobe[1241] exited with preempt_count 2
Sep 18 11:00:27 festa kernel: Slab corruption: start=de1d9880, expend=de1d98f7, problemat=de1d98c0
Sep 18 11:00:27 festa kernel: Last user: [<eaab61ac>](free_hpsb_packet+0x2c/0x40 [ieee1394])
Sep 18 11:00:27 festa kernel: Data: ****************************************************************6A ******************************************************A5 
Sep 18 11:00:27 festa kernel: Next: 71 F0 2C .AC 61 AB EA 71 F0 2C .....................
Sep 18 11:00:27 festa kernel: slab error in check_poison_obj(): cache `hpsb_packet': object was modified after freeing
Sep 18 11:00:27 festa kernel: Call Trace:
Sep 18 11:00:27 festa kernel:  [<c015ba5c>] check_poison_obj+0x17c/0x1d0
Sep 18 11:00:27 festa kernel:  [<c015bc60>] slab_destroy+0x1b0/0x1c0
Sep 18 11:00:27 festa kernel:  [<c015ef91>] reap_timer_fnc+0x211/0x4b0
Sep 18 11:00:27 festa kernel:  [<c015ed80>] reap_timer_fnc+0x0/0x4b0
Sep 18 11:00:27 festa kernel:  [<c0137246>] run_timer_softirq+0x196/0x460
Sep 18 11:00:27 festa kernel:  [<c01154df>] timer_interrupt+0x8f/0x270
Sep 18 11:00:27 festa kernel:  [<c035078a>] e100intr+0x26a/0x330
Sep 18 11:00:27 festa kernel:  [<c0131a0b>] do_softirq+0xab/0xb0
Sep 18 11:00:27 festa kernel:  [<c010f465>] do_IRQ+0x255/0x3b0
Sep 18 11:00:27 festa kernel:  [<c010d378>] common_interrupt+0x18/0x20
Sep 18 11:00:27 festa kernel:  [<c011007b>] probe_irq_off+0x8b/0x1c0
Sep 18 11:00:27 festa kernel:  [<c011e7f2>] apm_bios_call_simple+0x72/0xd0
Sep 18 11:00:27 festa kernel:  [<c011e9a5>] apm_do_idle+0x25/0x80
Sep 18 11:00:27 festa kernel:  [<c011ead2>] apm_cpu_idle+0xa2/0x150
Sep 18 11:00:27 festa kernel:  [<c0105000>] _stext+0x0/0x100
Sep 18 11:00:27 festa kernel:  [<c010a0f4>] cpu_idle+0x34/0x40
Sep 18 11:00:27 festa kernel:  [<c05ae81a>] start_kernel+0x1fa/0x280
Sep 18 11:00:27 festa kernel:  [<c05ae4e0>] unknown_bootoption+0x0/0x110
Sep 18 11:00:27 festa kernel: 
Sep 18 11:00:54 festa kernel: Debug: sleeping function called from invalid context at kernel/sched.c:1516
Sep 18 11:00:54 festa kernel: Call Trace:
Sep 18 11:00:54 festa kernel:  [<c01280a1>] __might_sleep+0x61/0x80
Sep 18 11:00:54 festa kernel:  [<c0125fa0>] wait_for_completion+0x20/0x320
Sep 18 11:00:54 festa kernel:  [<c013a120>] kill_proc_info+0x40/0x60
Sep 18 11:00:54 festa kernel:  [<eaabf807>] nodemgr_remove_host+0x57/0xa0 [ieee1394]
Sep 18 11:00:54 festa kernel:  [<eaaba8ec>] highlevel_remove_host+0x8c/0xb0 [ieee1394]
Sep 18 11:00:54 festa kernel:  [<eaa762c5>] ohci1394_pci_remove+0x45/0x340 [ohci1394]
Sep 18 11:00:54 festa kernel:  [<c02dff5b>] pci_device_remove+0x3b/0x40
Sep 18 11:00:54 festa kernel:  [<c033f986>] device_release_driver+0x66/0x70
Sep 18 11:00:54 festa kernel:  [<c033f9bb>] driver_detach+0x2b/0x40
Sep 18 11:00:54 festa kernel:  [<c033fc68>] bus_remove_driver+0x58/0x90
Sep 18 11:00:54 festa kernel:  [<c03400ca>] driver_unregister+0x1a/0x45
Sep 18 11:00:54 festa kernel:  [<c02e0347>] pci_unregister_driver+0x17/0x30
Sep 18 11:00:54 festa kernel:  [<eaa76b82>] ohci1394_cleanup+0x12/0x16 [ohci1394]
Sep 18 11:00:54 festa kernel:  [<c014b259>] sys_delete_module+0x129/0x1b0
Sep 18 11:00:54 festa kernel:  [<c016bbb8>] sys_munmap+0x58/0x80
Sep 18 11:00:54 festa kernel:  [<c010d20b>] syscall_call+0x7/0xb
Sep 18 11:00:54 festa kernel: 
Sep 18 11:00:54 festa kernel: bad: scheduling while atomic!
Sep 18 11:00:54 festa kernel: Call Trace:
Sep 18 11:00:54 festa kernel:  [<c0125859>] schedule+0x729/0x730
Sep 18 11:00:54 festa kernel:  [<c010d6fe>] dump_stack+0x1e/0x30
Sep 18 11:00:54 festa kernel:  [<c01280a1>] __might_sleep+0x61/0x80
Sep 18 11:00:54 festa kernel:  [<c01260c0>] wait_for_completion+0x140/0x320
Sep 18 11:00:54 festa kernel:  [<c01258b0>] default_wake_function+0x0/0x30
Sep 18 11:00:54 festa kernel:  [<c01258b0>] default_wake_function+0x0/0x30
Sep 18 11:00:54 festa kernel:  [<c013a120>] kill_proc_info+0x40/0x60
Sep 18 11:00:54 festa kernel:  [<eaabf807>] nodemgr_remove_host+0x57/0xa0 [ieee1394]
Sep 18 11:00:54 festa kernel:  [<eaaba8ec>] highlevel_remove_host+0x8c/0xb0 [ieee1394]
Sep 18 11:00:54 festa kernel:  [<eaa762c5>] ohci1394_pci_remove+0x45/0x340 [ohci1394]
Sep 18 11:00:54 festa kernel:  [<c02dff5b>] pci_device_remove+0x3b/0x40
Sep 18 11:00:54 festa kernel:  [<c033f986>] device_release_driver+0x66/0x70
Sep 18 11:00:54 festa kernel:  [<c033f9bb>] driver_detach+0x2b/0x40
Sep 18 11:00:54 festa kernel:  [<c033fc68>] bus_remove_driver+0x58/0x90
Sep 18 11:00:54 festa kernel:  [<c03400ca>] driver_unregister+0x1a/0x45
Sep 18 11:00:54 festa kernel:  [<c02e0347>] pci_unregister_driver+0x17/0x30
Sep 18 11:00:54 festa kernel:  [<eaa76b82>] ohci1394_cleanup+0x12/0x16 [ohci1394]
Sep 18 11:00:54 festa kernel:  [<c014b259>] sys_delete_module+0x129/0x1b0
Sep 18 11:00:54 festa kernel:  [<c016bbb8>] sys_munmap+0x58/0x80
Sep 18 11:00:54 festa kernel:  [<c010d20b>] syscall_call+0x7/0xb
Sep 18 11:00:54 festa kernel: 
Sep 18 11:01:06 festa kernel: Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
Sep 18 11:01:06 festa kernel: Call Trace:
Sep 18 11:01:06 festa kernel:  [<c01280a1>] __might_sleep+0x61/0x80
Sep 18 11:01:06 festa kernel:  [<c01108e9>] save_v86_state+0x69/0x210
Sep 18 11:01:06 festa kernel:  [<c015415b>] filemap_nopage+0x28b/0x310
Sep 18 11:01:06 festa kernel:  [<c0111757>] handle_vm86_fault+0xb7/0xa10
Sep 18 11:01:06 festa kernel:  [<c016885e>] do_no_page+0x2ae/0x610
Sep 18 11:01:06 festa kernel:  [<c010e1f0>] do_general_protection+0x0/0xa0
Sep 18 11:01:06 festa kernel:  [<c010d3b5>] error_code+0x2d/0x38
Sep 18 11:01:06 festa kernel:  [<c010d20b>] syscall_call+0x7/0xb

I cannot access the drive - it is not shown in /proc/scsi/scsi, there
are no devices for it in /dev/scsi.

I am running without ACPI, without APIC, with APM, on a single-processor
Intel Pentium 3 machine.

This drive works perfectly in 2.4.22, and in Windows.

I can provide any information you might need, and I'm willing to test
patches or wild guesses.

Please CC me with replies.

