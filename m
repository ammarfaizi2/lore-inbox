Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVATIxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVATIxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 03:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVATIxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 03:53:46 -0500
Received: from mail-gw0.york.ac.uk ([144.32.128.245]:14731 "EHLO
	mail-gw0.york.ac.uk") by vger.kernel.org with ESMTP id S262076AbVATIxf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 03:53:35 -0500
Date: Thu, 20 Jan 2005 08:49:45 +0000
From: Alan Jenkins <aj504@student.cs.york.ac.uk>
Subject: 2.6.9 suspend-to-disk bug (during resume)
To: linux-kernel@vger.kernel.org
References: <1106210882.7975.9.camel@linux.site>
In-Reply-To: <1106210882.7975.9.camel@linux.site> (from
	aj504@student.cs.york.ac.uk on Thu Jan 20 08:48:02 2005)
X-Mailer: Balsa 2.2.4
Message-Id: <1106210985l.8224l.0l@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-York-MailScanner: Found to be clean
X-York-MailScanner-From: aj504@student.cs.york.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/05 08:48:02, Alan Jenkins wrote:
I have noticed a similar message, and so has someone else on the list:

http://groups-beta.google.com/group/fa.linux.kernel/browse_thread/thread/1bfcbbca2d508bb3/cb69d674510d215a?q=%22bad:+scheduling+while+atomic!%22+suspend&_done=%2Fgroup%2Ffa.linux.kernel%2Fsearch%3Fgroup%3Dfa.linux.kernel%26q%3D%22bad:+scheduling+while+atomic!%22+suspend%26qt_g%3D1%26searchnow%3DSearch+this+group%26&_doneTitle=Back+to+Search&&d#cb69d674510d215a

I have an asrock motherboard with an sis chipset.
SiS seems to be the common factor.  I think its something general about
the chipset.  My messages seem to involve the network card, the sound
card and the i8042 (ps/2 port) controller:

ohci_hcd 0000:00:03.0: remove, state 1
usb usb1: USB disconnect, address 1
ohci_hcd 0000:00:03.0: USB bus 1 deregistered
ohci_hcd 0000:00:03.1: remove, state 1
usb usb2: USB disconnect, address 1
usb 2-1: USB disconnect, address 3
drivers/usb/media/stv680.c: [usb_stv680_remove_disconnected:1467]
STV(i): STV0680 disconnected
ohci_hcd 0000:00:03.1: USB bus 2 deregistered
ehci_hcd 0000:00:03.2: remove, state 1
usb usb3: USB disconnect, address 1
ehci_hcd 0000:00:03.2: USB bus 3 deregistered
PM: suspend-to-disk mode set to 'shutdown'
Stopping tasks:
=====================================================================|
Freeing memory...  -\|/-\|/-\|/-\|/-\|/-\|/-
\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-
\|/-\|/-\|/-\done (39643 pages freed)
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section:
[nosave pfn 0x398]<7>[nosave pfn 0x399]swsusp: Need to copy 23546 pages
suspend: (pages needed: 23546 + 512 free: 41972)
[nosave pfn 0x398]<7>[nosave pfn 0x399]<7>PM: Image restored
successfully.
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 10 (level, low) -> IRQ 10
bad: scheduling while atomic!
 [<c030164e>] schedule+0x4be/0x570
 [<c011ce69>] call_console_drivers+0x79/0x110
 [<c0124817>] __mod_timer+0x177/0x190
 [<c0301b8a>] schedule_timeout+0x5a/0xb0
 [<c0293ed9>] pci_conf1_read+0x109/0x110
 [<c0125210>] process_timeout+0x0/0x10
 [<d0de7f08>] snd_intel8x0_ich_chip_init+0x1a8/0x2c0 [snd_intel8x0]
 [<c02932cd>] pcibios_set_master+0x1d/0x90
 [<d0de8123>] snd_intel8x0_chip_init+0x13/0xc0 [snd_intel8x0]
 [<d0de8418>] intel8x0_resume+0x28/0x100 [snd_intel8x0]
 [<d0dfaba1>] snd_card_pci_resume+0x41/0x47 [snd]
 [<c01fa5f2>] pci_device_resume+0x22/0x30
 [<c0264756>] resume_device+0x16/0x20
 [<c02647bb>] dpm_resume+0x5b/0x70
 [<c02647e9>] device_resume+0x19/0x30
 [<c01362f5>] finish+0x5/0x40
 [<c0136448>] pm_suspend_disk+0x78/0xc0
 [<c013489c>] enter_state+0x9c/0xa0
 [<c0134a01>] state_store+0xd1/0xf0
 [<c0134930>] state_store+0x0/0xf0
 [<c018e786>] subsys_attr_store+0x36/0x50
 [<c018e9db>] flush_write_buffer+0x2b/0x40
 [<c018ea2e>] sysfs_write_file+0x3e/0x60
 [<c0157840>] vfs_write+0xb0/0x110
 [<c0157951>] sys_write+0x41/0x70
 [<c0106079>] sysenter_past_esp+0x52/0x71
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:03.2[D] -> GSI 3 (level, low) -> IRQ 3
bad: scheduling while atomic!
 [<c030164e>] schedule+0x4be/0x570
 [<c0301b8a>] schedule_timeout+0x5a/0xb0
 [<c029542a>] pci_write+0x2a/0x30
 [<c0125210>] process_timeout+0x0/0x10
 [<c01255bf>] msleep+0x1f/0x30
 [<c01f8c15>] pci_set_power_state+0x155/0x180
 [<d083c466>] sis900_resume+0x56/0x110 [sis900]
 [<c01fa5f2>] pci_device_resume+0x22/0x30
 [<c0264756>] resume_device+0x16/0x20
 [<c02647bb>] dpm_resume+0x5b/0x70
 [<c02647e9>] device_resume+0x19/0x30
 [<c01362f5>] finish+0x5/0x40
 [<c0136448>] pm_suspend_disk+0x78/0xc0
 [<c013489c>] enter_state+0x9c/0xa0
 [<c0134a01>] state_store+0xd1/0xf0
 [<c0134930>] state_store+0x0/0xf0
 [<c018e786>] subsys_attr_store+0x36/0x50
 [<c018e9db>] flush_write_buffer+0x2b/0x40
 [<c018ea2e>] sysfs_write_file+0x3e/0x60
 [<c0157840>] vfs_write+0xb0/0x110
 [<c0157951>] sys_write+0x41/0x70
 [<c0106079>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c030164e>] schedule+0x4be/0x570
 [<c01f6329>] __delay+0x9/0x10
 [<c028370a>] do_rw_taskfile+0x1fa/0x250
 [<c03017c8>] wait_for_completion+0x78/0xe0
 [<c01196a0>] default_wake_function+0x0/0x10
 [<c01196a0>] default_wake_function+0x0/0x10
 [<c027f659>] ide_do_drive_cmd+0xf9/0x150
 [<c027c97c>] generic_ide_resume+0x8c/0xb0
 [<c02838c0>] task_no_data_intr+0x0/0xa0
 [<c0259bd9>] i8042_controller_resume+0x59/0x100
 [<c0264756>] resume_device+0x16/0x20
 [<c02647bb>] dpm_resume+0x5b/0x70
 [<c02647e9>] device_resume+0x19/0x30
 [<c01362f5>] finish+0x5/0x40
 [<c0136448>] pm_suspend_disk+0x78/0xc0
 [<c013489c>] enter_state+0x9c/0xa0
 [<c0134a01>] state_store+0xd1/0xf0
 [<c0134930>] state_store+0x0/0xf0
 [<c018e786>] subsys_attr_store+0x36/0x50
 [<c018e9db>] flush_write_buffer+0x2b/0x40
 [<c018ea2e>] sysfs_write_file+0x3e/0x60
 [<c0157840>] vfs_write+0xb0/0x110
 [<c0157951>] sys_write+0x41/0x70
 [<c0106079>] sysenter_past_esp+0x52/0x71
Restarting tasks...<3>bad: scheduling while atomic!
 [<c030164e>] schedule+0x4be/0x570
 [<c0118c1c>] activate_task+0x4c/0x60
 [<c0118d12>] try_to_wake_up+0xa2/0xb0
 [<c0134d6a>] thaw_processes+0xda/0xf0
 [<c02647bb>] dpm_resume+0x5b/0x70
 [<c0136303>] finish+0x13/0x40
 [<c0136448>] pm_suspend_disk+0x78/0xc0
 [<c013489c>] enter_state+0x9c/0xa0
 [<c0134a01>] state_store+0xd1/0xf0
 [<c0134930>] state_store+0x0/0xf0
 [<c018e786>] subsys_attr_store+0x36/0x50
 [<c018e9db>] flush_write_buffer+0x2b/0x40
 [<c018ea2e>] sysfs_write_file+0x3e/0x60
 [<c0157840>] vfs_write+0xb0/0x110
 [<c0157951>] sys_write+0x41/0x70
 [<c0106079>] sysenter_past_esp+0x52/0x71
 done
bad: scheduling while atomic!
 [<c030164e>] schedule+0x4be/0x570
 [<c0157951>] sys_write+0x41/0x70
 [<c01060f2>] work_resched+0x5/0x16
bad: scheduling while atomic!
 [<c030164e>] schedule+0x4be/0x570
 [<c011a040>] sys_sched_yield+0x40/0x50
 [<c01630cb>] coredump_wait+0x2b/0x90
 [<c01631fa>] do_coredump+0xca/0x1e5
 [<c0118c1c>] activate_task+0x4c/0x60
 [<c0118d12>] try_to_wake_up+0xa2/0xb0
 [<c0125ed5>] __dequeue_signal+0xf5/0x160
 [<c0125f63>] dequeue_signal+0x23/0x90
 [<c0127b6d>] get_signal_to_deliver+0x26d/0x360
 [<c0105e2f>] do_signal+0x8f/0x160
 [<c0118a67>] recalc_task_prio+0xf7/0x260
 [<c030148f>] schedule+0x2ff/0x570
 [<c0117150>] do_page_fault+0x0/0x607
 [<c0105f37>] do_notify_resume+0x37/0x3c
 [<c0106116>] work_notifysig+0x13/0x15
note: do_acpi_sleep[7075] exited with preempt_count 1
alps.c: E6 report: 00 00 64
alps.c: E7 report: 10 00 64
evdev_connect: evdev cd92ade0 handle cd92adfc name event1
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
eth0: Abnormal interrupt,status 0x03008001.
eth0: Media Link On 10mbps half-duplex
ACPI: PCI interrupt 0000:00:03.2[D] -> GSI 3 (level, low) -> IRQ 3
ehci_hcd 0000:00:03.2: EHCI Host Controller
ehci_hcd 0000:00:03.2: irq 3, pci mem d0860000
ehci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:03.2
ehci_hcd 0000:00:03.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.8-24.10-default ehci_hcd
usb usb1: SerialNumber: 0000:00:03.2
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver  
(PCI)
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: irq 10, pci mem d0862000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.8-24.10-default ohci_hcd
usb usb2: SerialNumber: 0000:00:03.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: irq 10, pci mem d0c1a000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
usb usb3: Product: OHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.8-24.10-default ohci_hcd
usb usb3: SerialNumber: 0000:00:03.1
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
ohci_hcd 0000:00:03.1: wakeup
usb 3-1: new full speed USB device using address 2
usb 3-1: Product: USB Dual-mode Camera
usb 3-1: Manufacturer: STMicroelectronics
drivers/usb/media/stv680.c: [stv680_probe:1396] STV(i): STV0680 camera
found.
drivers/usb/media/stv680.c: [stv680_probe:1434] STV(i): registered new
video device: video0









