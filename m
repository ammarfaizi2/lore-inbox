Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266261AbUAHTDt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUAHTDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:03:49 -0500
Received: from mail-4.tiscali.it ([195.130.225.150]:61737 "EHLO
	mail-4.tiscali.it") by vger.kernel.org with ESMTP id S266261AbUAHTDn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:03:43 -0500
Date: Thu, 8 Jan 2004 20:03:40 +0100
Message-ID: <3FE5F1110001ED59@mail-4.tiscali.it>
From: m.andreolini@tiscali.it
Subject: problems with suspend-to-disk (ACPI), 2.6.1-rc2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I encountered a problem while resuming from a suspend-to-disk. I'm using
the
2.6.1-rc2 kernel, running on an Athlon XP 2000.
>From a bash shell, I type:

echo 4 > /proc/acpi/sleep

and the system seems to suspend fine. When resuming, the bash seems to get
killed and I get the following output from dmesg (running from another shell):

<snipped dmesg output>
Stopping tasks: =====================|
Freeing memory: ....................|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: completing PM request, suspend
resume= option should be used to set suspend device/critical section: Counting
pages to copy[nosave c035b000] (pages needed: 5362+512=5874 free: 174839)
Alloc pagedir
[nosave c035b000]<4>Freeing prev allocated pagedir
bad: scheduling while atomic!
Call Trace:
 [<c0119d16>] schedule+0x586/0x590
 [<c0124f5c>] __mod_timer+0xfc/0x170
 [<c0125ab3>] schedule_timeout+0x63/0xc0
 [<c0125a40>] process_timeout+0x0/0x10
 [<c01da44b>] pci_set_power_state+0xeb/0x190
 [<ec947823>] sis900_resume+0x63/0x130 [sis900]
 [<c01dc9a6>] pci_device_resume+0x26/0x30
 [<c021edb9>] resume_device+0x29/0x30
 [<c021edf4>] dpm_resume+0x34/0x60
 [<c021ee39>] device_resume+0x19/0x30
 [<c013625c>] drivers_resume+0x3c/0x40
 [<c013652d>] do_magic_resume_2+0x5d/0xe0
 [<c0136546>] do_magic_resume_2+0x76/0xe0
 [<c02653af>] do_magic+0x11f/0x130
 [<c013676c>] do_software_suspend+0x6c/0x90
 [<c01f67bb>] acpi_system_write_sleep+0xab/0xc9
 [<c015470e>] vfs_write+0xbe/0x130
 [<c0154832>] sys_write+0x42/0x70
 [<c010949b>] syscall_call+0x7/0xb

eth0: Media Link Off
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue ebd77a00, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Fixing swap signatures... <3>bad: scheduling while atomic!
Call Trace:
 [<c0119d16>] schedule+0x586/0x590
 [<c023486d>] do_ide_request+0x1d/0x30
 [<c0220ff7>] generic_unplug_device+0x77/0x80
 [<c022119b>] blk_run_queues+0xab/0xc0
 [<c011ac5e>] io_schedule+0xe/0x20
 [<c0138721>] wait_on_page_bit+0xb1/0xe0
 [<c011b490>] autoremove_wake_function+0x0/0x50
 [<c011b490>] autoremove_wake_function+0x0/0x50
 [<c014f41b>] swap_readpage+0x5b/0x90
 [<c014f511>] rw_swap_page_sync+0xc1/0x100
 [<c013595c>] mark_swapfiles+0x7c/0x1b0
 [<c0136566>] do_magic_resume_2+0x96/0xe0
 [<c02653af>] do_magic+0x11f/0x130
 [<c013676c>] do_software_suspend+0x6c/0x90
 [<c01f67bb>] acpi_system_write_sleep+0xab/0xc9
 [<c015470e>] vfs_write+0xbe/0x130
 [<c0154832>] sys_write+0x42/0x70
 [<c010949b>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0119d16>] schedule+0x586/0x590
 [<c023486d>] do_ide_request+0x1d/0x30
 [<c0220ff7>] generic_unplug_device+0x77/0x80
 [<c022116f>] blk_run_queues+0x7f/0xc0
 [<c011ac5e>] io_schedule+0xe/0x20
 [<c0138721>] wait_on_page_bit+0xb1/0xe0
 [<c011b490>] autoremove_wake_function+0x0/0x50
 [<c011b490>] autoremove_wake_function+0x0/0x50
 [<c014f389>] swap_writepage+0x99/0xd0
 [<c014f511>] rw_swap_page_sync+0xc1/0x100
 [<c01359cf>] mark_swapfiles+0xef/0x1b0
 [<c0136566>] do_magic_resume_2+0x96/0xe0
 [<c02653af>] do_magic+0x11f/0x130
 [<c013676c>] do_software_suspend+0x6c/0x90
 [<c01f67bb>] acpi_system_write_sleep+0xab/0xc9
 [<c015470e>] vfs_write+0xbe/0x130
 [<c0154832>] sys_write+0x42/0x70
 [<c010949b>] syscall_call+0x7/0xb

ok
Restarting tasks...<3>bad: scheduling while atomic!
Call Trace:
 [<c0119d16>] schedule+0x586/0x590
 [<c0118efe>] try_to_wake_up+0x9e/0x160
 [<c0118fde>] wake_up_process+0x1e/0x20
 [<c01353d8>] thaw_processes+0xb8/0x100
 [<c013675e>] do_software_suspend+0x5e/0x90
 [<c01f67bb>] acpi_system_write_sleep+0xab/0xc9
 [<c015470e>] vfs_write+0xbe/0x130
 [<c0154832>] sys_write+0x42/0x70
 [<c010949b>] syscall_call+0x7/0xb

 done
bad: scheduling while atomic!
Call Trace:
 [<c0119d16>] schedule+0x586/0x590
 [<c0154832>] sys_write+0x42/0x70
 [<c01094c2>] work_resched+0x5/0x16

bad: scheduling while atomic!
Call Trace:
 [<c0119d16>] schedule+0x586/0x590
 [<c01187d6>] fixup_exception+0x16/0x40
 [<c0117b8e>] __is_prefetch+0x6e/0x220
 [<c0117e50>] do_page_fault+0x110/0x512
 [<c011abc7>] sys_sched_yield+0x87/0xd0
 [<c0160c48>] coredump_wait+0x38/0xa0
 [<c0160d9b>] do_coredump+0xeb/0x1ec
 [<c0118ffa>] wake_up_state+0x1a/0x20
 [<c0126e04>] specific_send_sig_info+0xc4/0x130
 [<c0126818>] __dequeue_signal+0xe8/0x190
 [<c01268f5>] dequeue_signal+0x35/0xa0
 [<c0128dca>] get_signal_to_deliver+0x20a/0x380
 [<c0109272>] do_signal+0xe2/0x120
 [<c0118d50>] recalc_task_prio+0x90/0x1a0
 [<c0119ac4>] schedule+0x334/0x590
 [<c0117d40>] do_page_fault+0x0/0x512
 [<c0109309>] do_notify_resume+0x59/0x5c
 [<c01094e6>] work_notifysig+0x13/0x15

note: bash[3501] exited with preempt_count 1
eth0: Abnormal interrupt,status 0x03008200.

<end of snipped dmesg output>

Does anyone have a clue of what's going on? I have been experiencing the
same problem since early 2.6.0, also with Andrew Morton's patchset.
The problem does not show up when kernel preemption is turned off.
Please CC any answer since I'm not subscribed to the list.

TIA
Mauro Andreolini

__________________________________________________________________
Tiscali ADSL SENZA CANONE:
Attivazione GRATIS, contributo adesione GRATIS, modem GRATIS,
50 ore di navigazione GRATIS.  ABBONARTI TI COSTA SOLO UN CLICK!
http://point.tiscali.it/adsl/index.shtml



