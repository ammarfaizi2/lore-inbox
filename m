Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbTJRRyq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 13:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbTJRRyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 13:54:45 -0400
Received: from adsl-215-226.38-151.net24.it ([151.38.226.215]:17681 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S261763AbTJRRy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 13:54:27 -0400
Date: Sat, 18 Oct 2003 19:54:23 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test7 - Suspend to Disk success
Message-ID: <20031018175423.GA1038@renditai.milesteg.arr>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Patrick Mochel <mochel@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org> <20031015172742.GZ30375@earth.li> <20031015210054.GA1492@picchio.gall.it> <20031016140644.GJ1659@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016140644.GJ1659@openzaurus.ucw.cz>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.22
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 04:06:45PM +0200, Pavel Machek wrote:
> Look at the logs, perhaps you have an oops?

Trying with -test8 I keep getting my bash killed, but there is more, now
it seesms that the sis900 network driver broke, because after resume my
NIC does not work anymore and I get timeouts sending packets.

Here is a dmesg excerpt using pmdisk with all modules my system normally
uses (alsa, ipv6, irda, ohci, ehci, ntfs, yenta_socket):

--CUT-HERE----CUT-HERE----CUT-HERE----CUT-HERE----CUT-HERE----CUT-HERE--

Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
in_atomic():0, irqs_disabled():1
Call Trace:
 [<c011d1d0>] __might_sleep+0xa0/0xd0
 [<c010bb2c>] save_v86_state+0x6c/0x200
 [<c010946e>] work_notifysig_v86+0x6/0x14
 [<c010941b>] syscall_call+0x7/0xb

Stopping tasks: ==========================================|
     osl-0900 [2430] os_wait_semaphore     : Failed to acquire semaphore[ddfe85a0|1|0], AE_TIME
Freeing memory: ............|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Attempting to suspend to disk.
PM: snapshotting memory.
PM: Image restored successfully.
Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011d1d0>] __might_sleep+0xa0/0xd0
 [<c022c1b0>] device_resume+0x20/0x50
 [<c01379d8>] finish+0x8/0x40
 [<c0138945>] pmdisk_free+0x5/0x40
 [<c0137b2e>] pm_suspend_disk+0x7e/0xc0
 [<c0136fb1>] enter_state+0xa1/0xb0
 [<c01370a7>] state_store+0x67/0x71
 [<c01874da>] subsys_attr_store+0x3a/0x40
 [<c01877bb>] flush_write_buffer+0x3b/0x50
 [<c018782a>] sysfs_write_file+0x5a/0x70
 [<c01877d0>] sysfs_write_file+0x0/0x70
 [<c01550d8>] vfs_write+0xb8/0x130
 [<c0155202>] sys_write+0x42/0x70
 [<c010941b>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011bd6d>] schedule+0x56d/0x580
 [<c0127083>] __mod_timer+0x123/0x170
 [<c0127b93>] schedule_timeout+0x63/0xc0
 [<c0127b20>] process_timeout+0x0/0x10
 [<c01c44f3>] pci_set_power_state+0xd3/0x160
 [<dea301a8>] usb_hcd_pci_resume+0x38/0x90 [usbcore]
 [<c01c6914>] pci_device_resume+0x24/0x30
 [<c022c127>] resume_device+0x27/0x30
 [<c022c164>] dpm_resume+0x34/0x60
 [<c022c1c3>] device_resume+0x33/0x50
 [<c01379d8>] finish+0x8/0x40
 [<c0138945>] pmdisk_free+0x5/0x40
 [<c0137b2e>] pm_suspend_disk+0x7e/0xc0
 [<c0136fb1>] enter_state+0xa1/0xb0
 [<c01370a7>] state_store+0x67/0x71
 [<c01874da>] subsys_attr_store+0x3a/0x40
 [<c01877bb>] flush_write_buffer+0x3b/0x50
 [<c018782a>] sysfs_write_file+0x5a/0x70
 [<c01877d0>] sysfs_write_file+0x0/0x70
 [<c01550d8>] vfs_write+0xb8/0x130
 [<c0155202>] sys_write+0x42/0x70
 [<c010941b>] syscall_call+0x7/0xb

ohci_hcd 0000:00:03.0: USB continue from host wakeup
bad: scheduling while atomic!
Call Trace:
 [<c011bd6d>] schedule+0x56d/0x580
 [<c0127083>] __mod_timer+0x123/0x170
 [<c0127b93>] schedule_timeout+0x63/0xc0
 [<c0127b20>] process_timeout+0x0/0x10
 [<c01c44f3>] pci_set_power_state+0xd3/0x160
 [<dea301a8>] usb_hcd_pci_resume+0x38/0x90 [usbcore]
 [<c01c6914>] pci_device_resume+0x24/0x30
 [<c022c127>] resume_device+0x27/0x30
 [<c022c164>] dpm_resume+0x34/0x60
 [<c022c1c3>] device_resume+0x33/0x50
 [<c01379d8>] finish+0x8/0x40
 [<c0138945>] pmdisk_free+0x5/0x40
 [<c0137b2e>] pm_suspend_disk+0x7e/0xc0
 [<c0136fb1>] enter_state+0xa1/0xb0
 [<c01370a7>] state_store+0x67/0x71
 [<c01874da>] subsys_attr_store+0x3a/0x40
 [<c01877bb>] flush_write_buffer+0x3b/0x50
 [<c018782a>] sysfs_write_file+0x5a/0x70
 [<c01877d0>] sysfs_write_file+0x0/0x70
 [<c01550d8>] vfs_write+0xb8/0x130
 [<c0155202>] sys_write+0x42/0x70
 [<c010941b>] syscall_call+0x7/0xb

ohci_hcd 0000:00:03.1: USB continue from host wakeup
bad: scheduling while atomic!
Call Trace:
 [<c011bd6d>] schedule+0x56d/0x580
 [<c0127083>] __mod_timer+0x123/0x170
 [<c0127b93>] schedule_timeout+0x63/0xc0
 [<c0127b20>] process_timeout+0x0/0x10
 [<c01c44f3>] pci_set_power_state+0xd3/0x160
 [<dea301a8>] usb_hcd_pci_resume+0x38/0x90 [usbcore]
 [<c01c6914>] pci_device_resume+0x24/0x30
 [<c022c127>] resume_device+0x27/0x30
 [<c022c164>] dpm_resume+0x34/0x60
 [<c022c1c3>] device_resume+0x33/0x50
 [<c01379d8>] finish+0x8/0x40
 [<c0138945>] pmdisk_free+0x5/0x40
 [<c0137b2e>] pm_suspend_disk+0x7e/0xc0
 [<c0136fb1>] enter_state+0xa1/0xb0
 [<c01370a7>] state_store+0x67/0x71
 [<c01874da>] subsys_attr_store+0x3a/0x40
 [<c01877bb>] flush_write_buffer+0x3b/0x50
 [<c018782a>] sysfs_write_file+0x5a/0x70
 [<c01877d0>] sysfs_write_file+0x0/0x70
 [<c01550d8>] vfs_write+0xb8/0x130
 [<c0155202>] sys_write+0x42/0x70
 [<c010941b>] syscall_call+0x7/0xb

ohci_hcd 0000:00:03.2: USB continue from host wakeup
bad: scheduling while atomic!
Call Trace:
 [<c011bd6d>] schedule+0x56d/0x580
 [<c0127083>] __mod_timer+0x123/0x170
 [<c0127b93>] schedule_timeout+0x63/0xc0
 [<c0127b20>] process_timeout+0x0/0x10
 [<c01c44f3>] pci_set_power_state+0xd3/0x160
 [<dea301a8>] usb_hcd_pci_resume+0x38/0x90 [usbcore]
 [<c01c6914>] pci_device_resume+0x24/0x30
 [<c022c127>] resume_device+0x27/0x30
 [<c022c164>] dpm_resume+0x34/0x60
 [<c022c1c3>] device_resume+0x33/0x50
 [<c01379d8>] finish+0x8/0x40
 [<c0138945>] pmdisk_free+0x5/0x40
 [<c0137b2e>] pm_suspend_disk+0x7e/0xc0
 [<c0136fb1>] enter_state+0xa1/0xb0
 [<c01370a7>] state_store+0x67/0x71
 [<c01874da>] subsys_attr_store+0x3a/0x40
 [<c01877bb>] flush_write_buffer+0x3b/0x50
 [<c018782a>] sysfs_write_file+0x5a/0x70
 [<c01877d0>] sysfs_write_file+0x0/0x70
 [<c01550d8>] vfs_write+0xb8/0x130
 [<c0155202>] sys_write+0x42/0x70
 [<c010941b>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011bd6d>] schedule+0x56d/0x580
 [<c0127b93>] schedule_timeout+0x63/0xc0
 [<c0127b20>] process_timeout+0x0/0x10
 [<c01c44f3>] pci_set_power_state+0xd3/0x160
 [<de9b3e9d>] yenta_dev_resume+0x2d/0xc0 [yenta_socket]
 [<dea301c6>] usb_hcd_pci_resume+0x56/0x90 [usbcore]
 [<c01c6914>] pci_device_resume+0x24/0x30
 [<c022c127>] resume_device+0x27/0x30
 [<c022c164>] dpm_resume+0x34/0x60
 [<c022c1c3>] device_resume+0x33/0x50
 [<c01379d8>] finish+0x8/0x40
 [<c0138945>] pmdisk_free+0x5/0x40
 [<c0137b2e>] pm_suspend_disk+0x7e/0xc0
 [<c0136fb1>] enter_state+0xa1/0xb0
 [<c01370a7>] state_store+0x67/0x71
 [<c01874da>] subsys_attr_store+0x3a/0x40
 [<c01877bb>] flush_write_buffer+0x3b/0x50
 [<c018782a>] sysfs_write_file+0x5a/0x70
 [<c01877d0>] sysfs_write_file+0x0/0x70
 [<c01550d8>] vfs_write+0xb8/0x130
 [<c0155202>] sys_write+0x42/0x70
 [<c010941b>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011bd6d>] schedule+0x56d/0x580
 [<c0127b93>] schedule_timeout+0x63/0xc0
 [<c0127b20>] process_timeout+0x0/0x10
 [<c026be6a>] socket_shutdown+0x4a/0x60
 [<c026c39c>] socket_resume+0xbc/0x110
 [<c026b722>] <4>Losing too many ticks!
TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Falling back to a sane timesource.
pcmcia_socket_dev_resume+0xc2/0xe0
 [<c01c6914>] pci_device_resume+0x24/0x30
 [<c022c127>] resume_device+0x27/0x30
 [<c022c164>] dpm_resume+0x34/0x60
 [<c022c1c3>] device_resume+0x33/0x50
 [<c01379d8>] finish+0x8/0x40
 [<c0138945>] pmdisk_free+0x5/0x40
 [<c0137b2e>] pm_suspend_disk+0x7e/0xc0
 [<c0136fb1>] enter_state+0xa1/0xb0
 [<c01370a7>] state_store+0x67/0x71
 [<c01874da>] subsys_attr_store+0x3a/0x40
 [<c01877bb>] flush_write_buffer+0x3b/0x50
 [<c018782a>] sysfs_write_file+0x5a/0x70
 [<c01877d0>] sysfs_write_file+0x0/0x70
 [<c01550d8>] vfs_write+0xb8/0x130
 [<c0155202>] sys_write+0x42/0x70
 [<c010941b>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011bd6d>] schedule+0x56d/0x580
 [<c0127b93>] schedule_timeout+0x63/0xc0
 [<c0127b20>] process_timeout+0x0/0x10
 [<c01c44f3>] pci_set_power_state+0xd3/0x160
 [<de9b3e9d>] yenta_dev_resume+0x2d/0xc0 [yenta_socket]
 [<c01c6914>] pci_device_resume+0x24/0x30
 [<c022c127>] resume_device+0x27/0x30
 [<c022c164>] dpm_resume+0x34/0x60
 [<c022c1c3>] device_resume+0x33/0x50
 [<c01379d8>] finish+0x8/0x40
 [<c0138945>] pmdisk_free+0x5/0x40
 [<c0137b2e>] pm_suspend_disk+0x7e/0xc0
 [<c0136fb1>] enter_state+0xa1/0xb0
 [<c01370a7>] state_store+0x67/0x71
 [<c01874da>] subsys_attr_store+0x3a/0x40
 [<c01877bb>] flush_write_buffer+0x3b/0x50
 [<c018782a>] sysfs_write_file+0x5a/0x70
 [<c01877d0>] sysfs_write_file+0x0/0x70
 [<c01550d8>] vfs_write+0xb8/0x130
 [<c0155202>] sys_write+0x42/0x70
 [<c010941b>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011bd6d>] schedule+0x56d/0x580
 [<c0127b93>] schedule_timeout+0x63/0xc0
 [<c0127b20>] process_timeout+0x0/0x10
 [<c026be6a>] socket_shutdown+0x4a/0x60
 [<c026c39c>] socket_resume+0xbc/0x110
 [<c026b722>] pcmcia_socket_dev_resume+0xc2/0xe0
 [<c01c6914>] pci_device_resume+0x24/0x30
 [<c022c127>] resume_device+0x27/0x30
 [<c022c164>] dpm_resume+0x34/0x60
 [<c022c1c3>] device_resume+0x33/0x50
 [<c01379d8>] finish+0x8/0x40
 [<c0138945>] pmdisk_free+0x5/0x40
 [<c0137b2e>] pm_suspend_disk+0x7e/0xc0
 [<c0136fb1>] enter_state+0xa1/0xb0
 [<c01370a7>] state_store+0x67/0x71
 [<c01874da>] subsys_attr_store+0x3a/0x40
 [<c01877bb>] flush_write_buffer+0x3b/0x50
 [<c018782a>] sysfs_write_file+0x5a/0x70
 [<c01877d0>] sysfs_write_file+0x0/0x70
 [<c01550d8>] vfs_write+0xb8/0x130
 [<c0155202>] sys_write+0x42/0x70
 [<c010941b>] syscall_call+0x7/0xb

hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue dddeb400, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Restarting tasks...<3>bad: scheduling while atomic!
Call Trace:
 [<c011bd6d>] schedule+0x56d/0x580
 [<c011b046>] wake_up_process+0x26/0x30
 [<c01373a4>] thaw_processes+0xa4/0x100
 [<c01f0f3d>] acpi_pm_finish+0x14/0x36
 [<c01379e6>] finish+0x16/0x40
 [<c0137b2e>] pm_suspend_disk+0x7e/0xc0
 [<c0136fb1>] enter_state+0xa1/0xb0
 [<c01370a7>] state_store+0x67/0x71
 [<c01874da>] subsys_attr_store+0x3a/0x40
 [<c01877bb>] flush_write_buffer+0x3b/0x50
 [<c018782a>] sysfs_write_file+0x5a/0x70
 [<c01877d0>] sysfs_write_file+0x0/0x70
 [<c01550d8>] vfs_write+0xb8/0x130
 [<c0155202>] sys_write+0x42/0x70
 [<c010941b>] syscall_call+0x7/0xb

 done
bad: scheduling while atomic!
Call Trace:
 [<c011bd6d>] schedule+0x56d/0x580
 [<c0155202>] sys_write+0x42/0x70
 [<c0109442>] work_resched+0x5/0x16

bad: scheduling while atomic!
Call Trace:
 [<c011bd6d>] schedule+0x56d/0x580
 [<c011ff36>] release_console_sem+0xc6/0xd0
 [<c011fdbc>] printk+0x12c/0x180
 [<c011cc37>] sys_sched_yield+0x87/0xd0
 [<c0161158>] coredump_wait+0x38/0xa0
 [<c01612cc>] do_coredump+0x10c/0x1f9
 [<c0128af4>] send_signal+0x94/0x150
 [<c0109625>] error_code+0x2d/0x38
 [<c0109625>] error_code+0x2d/0x38
 [<c01286c5>] __dequeue_signal+0xe5/0x190
 [<c01287a5>] dequeue_signal+0x35/0x90
 [<c012ab37>] get_signal_to_deliver+0x267/0x350
 [<c01091c0>] do_signal+0x90/0x120
 [<c0109442>] work_resched+0x5/0x16
 [<c011ad9e>] recalc_task_prio+0x8e/0x1b0
 [<c011baf9>] schedule+0x2f9/0x580
 [<c0119d40>] do_page_fault+0x0/0x530
 [<c0109287>] do_notify_resume+0x37/0x3c
 [<c0109466>] work_notifysig+0x13/0x15

note: bash[2312] exited with preempt_count 1
hub 1-0:1.0: over-current change on port 1
hub 1-0:1.0: over-current change on port 2
hub 1-0:1.0: over-current change on port 3
hub 1-0:1.0: over-current change on port 4
hub 1-0:1.0: over-current change on port 5
hub 1-0:1.0: over-current change on port 6
--CUT-HERE----CUT-HERE----CUT-HERE----CUT-HERE----CUT-HERE--

Please note that:
note: bash[2312] exited with preempt_count 1

that gets my bask exiting with a SEGFAULT

Now the dmesg output with only 2 modules (ipv6, md5) that I cuold not
unload:

--CUT-HERE----CUT-HERE----CUT-HERE----CUT-HERE----CUT-HERE--

Stopping tasks: =======================================|
     osl-0900 [366] os_wait_semaphore     : Failed to acquire semaphore[ddfe85a0|1|0], AE_TIME
Freeing memory: ........|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Attempting to suspend to disk.
PM: snapshotting memory.
PM: Image restored successfully.
Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011d1d0>] __might_sleep+0xa0/0xd0
 [<c022c1b0>] device_resume+0x20/0x50
 [<c01379d8>] finish+0x8/0x40
 [<c0138945>] pmdisk_free+0x5/0x40
 [<c0137b2e>] pm_suspend_disk+0x7e/0xc0
 [<c0136fb1>] enter_state+0xa1/0xb0
 [<c01370a7>] state_store+0x67/0x71
 [<c01874da>] subsys_attr_store+0x3a/0x40
 [<c01877bb>] flush_write_buffer+0x3b/0x50
 [<c018782a>] sysfs_write_file+0x5a/0x70
 [<c01877d0>] sysfs_write_file+0x0/0x70
 [<c01550d8>] vfs_write+0xb8/0x130
 [<c0155202>] sys_write+0x42/0x70
 [<c010941b>] syscall_call+0x7/0xb

hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue dddeb400, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Restarting tasks...<3>bad: scheduling while atomic!
Call Trace:
 [<c011bd6d>] schedule+0x56d/0x580
 [<c011b046>] wake_up_process+0x26/0x30
 [<c01373a4>] thaw_processes+0xa4/0x100
 [<c01f0f3d>] acpi_pm_finish+0x14/0x36
 [<c01379e6>] finish+0x16/0x40
 [<c0137b2e>] pm_suspend_disk+0x7e/0xc0
 [<c0136fb1>] enter_state+0xa1/0xb0
 [<c01370a7>] state_store+0x67/0x71
 [<c01874da>] subsys_attr_store+0x3a/0x40
 [<c01877bb>] flush_write_buffer+0x3b/0x50
 [<c018782a>] sysfs_write_file+0x5a/0x70
 [<c01877d0>] sysfs_write_file+0x0/0x70
 [<c01550d8>] vfs_write+0xb8/0x130
 [<c0155202>] sys_write+0x42/0x70
 [<c010941b>] syscall_call+0x7/0xb

 done
bad: scheduling while atomic!
Call Trace:
 [<c011bd6d>] schedule+0x56d/0x580
 [<c0155202>] sys_write+0x42/0x70
 [<c0109442>] work_resched+0x5/0x16

bad: scheduling while atomic!
Call Trace:
 [<c011bd6d>] schedule+0x56d/0x580
 [<c011ff36>] release_console_sem+0xc6/0xd0
 [<c011fdbc>] printk+0x12c/0x180
 [<c011cc37>] sys_sched_yield+0x87/0xd0
 [<c0161158>] coredump_wait+0x38/0xa0
 [<c01612cc>] do_coredump+0x10c/0x1f9
 [<c0128af4>] send_signal+0x94/0x150
 [<c0109625>] error_code+0x2d/0x38
 [<c0109625>] error_code+0x2d/0x38
 [<c01286c5>] __dequeue_signal+0xe5/0x190
 [<c01287a5>] dequeue_signal+0x35/0x90
 [<c012ab37>] get_signal_to_deliver+0x267/0x350
 [<c01091c0>] do_signal+0x90/0x120
 [<c0109442>] work_resched+0x5/0x16
 [<c011ad9e>] recalc_task_prio+0x8e/0x1b0
 [<c011baf9>] schedule+0x2f9/0x580
 [<c0119d40>] do_page_fault+0x0/0x530
 [<c0109287>] do_notify_resume+0x37/0x3c
 [<c0109466>] work_notifysig+0x13/0x15

note: bash[1042] exited with preempt_count 1
Losing too many ticks!
TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Falling back to a sane timesource.
--CUT-HERE----CUT-HERE----CUT-HERE----CUT-HERE----CUT-HERE--

A lot less bad: errors, but still the bash gets killed and the network
card doesn't work. Probably it just need ifdown/ifup, but I didn't try.

I can send .config file on request (this mail is big enough).

Hope it helps, bye.

-- 
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/

