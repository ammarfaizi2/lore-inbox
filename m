Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbTFRIAy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 04:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbTFRIAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 04:00:54 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:19841 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S265086AbTFRH7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 03:59:36 -0400
Date: Wed, 18 Jun 2003 18:16:00 +1000
From: CaT <cat@zip.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: swsusp@lister.fornax.hu, linux-kernel@vger.kernel.org
Subject: Re: [FIX, please test] Re: 2.5.70-bk16 - nfs interferes with s4bios suspend
Message-ID: <20030618081600.GA484@zip.com.au>
References: <20030613033703.GA526@zip.com.au> <20030615183111.GD315@elf.ucw.cz> <20030616001141.GA364@zip.com.au> <20030616104710.GA12173@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030616104710.GA12173@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 12:47:10PM +0200, Pavel Machek wrote:
> > I didn't have any actual nfs mounts at the time but I tried it
> > with an otherwise similar system. It went through, got to freeing
> > memory, showed me a bunch of fullstops being drawn and then went
> > into an endless BUG loop. All I could pick out (after many a moment
> > of staring) was 'schedule in atmoic'.
> > 
> > I'll do a proper test with a console cable present in a few days. I
> > can't atm cos I'm not on the same network and don't have a 2nd 
> > computer to hook up the null-modem cable to.

Was able to capture the output for this case (it's long). The result
without preempt is below this one.

> > Pre-empt is on btw.

Stopping tasks: XFree86 entered refrigerator
=init entered refrigerator
=khubd entered refrigerator
=pdflush entered refrigerator
=pdflush entered refrigerator
=kswapd0 entered refrigerator
=pccardd entered refrigerator
=pccardd entered refrigerator
=kseriod entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=portmap entered refrigerator
=rpciod entered refrigerator
=lockd entered refrigerator
=syslogd entered refrigerator
=klogd entered refrigerator
=acpid entered refrigerator
=gpm entered refrigerator
=inetd entered refrigerator
=cupsd entered refrigerator
=sshd entered refrigerator
=rpc.statd entered refrigerator
=atd entered refrigerator
=cron entered refrigerator
=xdm entered refrigerator
=getty entered refrigerator
=getty entered refrigerator
=xdm entered refrigerator
=hogarth-wm-coma entered refrigerator
=ssh-agent entered refrigerator
=afterstep entered refrigerator
=aterm entered refrigerator
=aterm entered refrigerator
=bash entered refrigerator
=bash entered refrigerator
=aterm entered refrigerator
=bash entered refrigerator
=sendmail entered refrigerator
=|
Freeing memory: .................................|
Syncing disks before copy
Suspending devices
Suspending device c054a48c
Suspending devices
Suspending device c054a48c
suspending: hda <0>Suspending devices
Suspending device c054a48c
uhci-hcd 0000:00:07.2: suspend to state 3
resume= option should be used to set suspend device/critical section: Counting pages to copy[nosave c0501000] (pages needed: 10763+512=11275 free: 54756)
Alloc pagedir
...etc...
Debug: sleeping function called from illegal context at include/linux/rwsem.h:66
Call Trace:
 [<c011a2a3>] __might_sleep+0x5f/0x6c
 [<c0270ada>] sysdev_restore+0x1a/0x11c
 [<c0270fec>] device_resume+0x24/0xb8
 [<c012f5ea>] drivers_unsuspend+0xa/0x18
 [<c012f864>] suspend_save_image+0x8/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

uhci-hcd 0000:00:07.2: resume
bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0122bee>] schedule_timeout+0x7e/0xa4
 [<c0122b60>] process_timeout+0x0/0x10
 [<c0204392>] pci_set_power_state+0xfe/0x124
 [<c0285a85>] e100_resume+0x19/0x44
 [<c0206088>] pci_device_resume+0x20/0x28
 [<c027103b>] device_resume+0x73/0xb8
 [<c012f5ea>] drivers_unsuspend+0xa/0x18
 [<c012f864>] suspend_save_image+0x8/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0280a8a>] e100_wait_exec_cmplx+0x26/0x38
 [<c0119e0e>] sys_sched_yield+0xce/0xd8
 [<c0119e4b>] yield+0x17/0x1c
 [<c0283482>] e100_exec_non_cu_cmd+0x156/0x22c
 [<c028377e>] e100_load_microcode+0x142/0x16c
 [<c0283abc>] e100_configure_device+0x20/0xdc
 [<c0283ba2>] e100_deisolate_driver+0x2a/0x104
 [<c0285aa4>] e100_resume+0x38/0x44
 [<c0206088>] pci_device_resume+0x20/0x28
 [<c027103b>] device_resume+0x73/0xb8
 [<c012f5ea>] drivers_unsuspend+0xa/0x18
 [<c012f864>] suspend_save_image+0x8/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0280a8a>] e100_wait_exec_cmplx+0x26/0x38
 [<c0119e0e>] sys_sched_yield+0xce/0xd8
 [<c0119e4b>] yield+0x17/0x1c
 [<c0283482>] e100_exec_non_cu_cmd+0x156/0x22c
 [<c0282f79>] e100_setup_iaaddr+0x49/0x70
 [<c0283afe>] e100_configure_device+0x62/0xdc
 [<c0283ba2>] e100_deisolate_driver+0x2a/0x104
 [<c0285aa4>] e100_resume+0x38/0x44
 [<c0206088>] pci_device_resume+0x20/0x28
 [<c027103b>] device_resume+0x73/0xb8
 [<c012f5ea>] drivers_unsuspend+0xa/0x18
 [<c012f864>] suspend_save_image+0x8/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0280a8a>] e100_wait_exec_cmplx+0x26/0x38
 [<c0119e0e>] sys_sched_yield+0xce/0xd8
 [<c0119e4b>] yield+0x17/0x1c
 [<c0283482>] e100_exec_non_cu_cmd+0x156/0x22c
 [<c0281602>] e100_set_multi_exec+0x82/0xa4
 [<c0283b1c>] e100_configure_device+0x80/0xdc
 [<c0283ba2>] e100_deisolate_driver+0x2a/0x104
 [<c0285aa4>] e100_resume+0x38/0x44
 [<c0206088>] pci_device_resume+0x20/0x28
 [<c027103b>] device_resume+0x73/0xb8
 [<c012f5ea>] drivers_unsuspend+0xa/0x18
 [<c012f864>] suspend_save_image+0x8/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0280a8a>] e100_wait_exec_cmplx+0x26/0x38
 [<c0119e0e>] sys_sched_yield+0xce/0xd8
 [<c0119e4b>] yield+0x17/0x1c
 [<c0283482>] e100_exec_non_cu_cmd+0x156/0x22c
 [<c028614f>] e100_config+0xb3/0x114
 [<c0286091>] e100_force_config+0x49/0x54
 [<c0283b69>] e100_configure_device+0xcd/0xdc
 [<c0283ba2>] e100_deisolate_driver+0x2a/0x104
 [<c0285aa4>] e100_resume+0x38/0x44
 [<c0206088>] pci_device_resume+0x20/0x28
 [<c027103b>] device_resume+0x73/0xb8
 [<c012f5ea>] drivers_unsuspend+0xa/0x18
 [<c012f864>] suspend_save_image+0x8/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c011a2a3>] __might_sleep+0x5f/0x6c
 [<c0263845>] uart_resume_port+0x2d/0x100
 [<c02662e6>] serial8250_resume_port+0x1e/0x28
 [<c0266fcd>] pciserial_resume_one+0x39/0x5c
 [<c0206088>] pci_device_resume+0x20/0x28
 [<c027103b>] device_resume+0x73/0xb8
 [<c012f5ea>] drivers_unsuspend+0xa/0x18
 [<c012f864>] suspend_save_image+0x8/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0122bee>] schedule_timeout+0x7e/0xa4
 [<c02662e6>] serial8250_resume_port+0x1e/0x28
 [<c0122b60>] process_timeout+0x0/0x10
 [<c0266904>] pci_xircom_init+0x1c/0x24
 [<c0266fb6>] pciserial_resume_one+0x22/0x5c
 [<c0206088>] pci_device_resume+0x20/0x28
 [<c027103b>] device_resume+0x73/0xb8
 [<c012f5ea>] drivers_unsuspend+0xa/0x18
 [<c012f864>] suspend_save_image+0x8/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

Devices Resumed
Devices Resumed
Writing data to swap (10763 pages): .<3>bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] <3>e100: eth0 NIC Link is Up 100 Mbps Full duplex
acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0118e00>] schedule+0x3c/0x348
 [<c0119e5e>] io_schedule+0xe/0x18
 [<c01308e7>] wait_on_page_bit+0x9f/0xbc
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c011a5d8>] autoremove_wake_function+0x0/0x3c
 [<c0145093>] rw_swap_page_sync+0x8f/0xbc
 [<c012f03d>] write_suspend_image+0xd9/0x2dc
 [<c012f5f1>] drivers_unsuspend+0x11/0x18
 [<c012f86e>] suspend_save_image+0x12/0x1c
 [<c012fa4f>] do_magic_suspend_2+0x17/0xa8
 [<c01173ed>] do_magic+0x4d/0x130
 [<c012fb41>] do_software_suspend+0x61/0x88
 [<c012fb98>] software_suspend+0x30/0x34
 [<c0231e5e>] acpi_system_write_sleep+0xda/0x11c
 [<c014924e>] vfs_write+0x9e/0xd0
 [<c0149300>] sys_write+0x30/0x50
 [<c0108e3f>] syscall_call+0x7/0xb

I hit the power button here and shut the box down.

> Turn it off. You don't want to debug preempt and nfs at the same time.

And this is with preempt off:

Stopping tasks: XFree86 entered refrigerator
=pdflush entered refrigerator
=klogd entered refrigerator
=khubd entered refrigerator
=pdflush entered refrigerator
=kswapd0 entered refrigerator
=pccardd entered refrigerator
=pccardd entered refrigerator
=kseriod entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=kjournald entered refrigerator
=portmap entered refrigerator
=rpciod entered refrigerator
=lockd entered refrigerator
=syslogd entered refrigerator
=acpid entered refrigerator
=gpm entered refrigerator
=inetd entered refrigerator
=cupsd entered refrigerator
=sendmail entered refrigerator
=sendmail entered refrigerator
=sshd entered refrigerator
=rpc.statd entered refrigerator
=atd entered refrigerator
=cron entered refrigerator
=fetchmail entered refrigerator
=xdm entered refrigerator
=getty entered refrigerator
=getty entered refrigerator
=xdm entered refrigerator
=sendmail entered refrigerator
=procmail entered refrigerator
=sendmail entered refrigerator
=init entered refrigerator
=procmail entered refrigerator
=|
Freeing memory: .........................|
Syncing disks before copy
Suspending devices
Suspending device c052c48c
Suspending devices
Suspending device c052c48c
suspending: hda ------------[ cut here ]------------
kernel BUG at drivers/ide/ide-disk.c:1110!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0290e16>]    Not tainted
EFLAGS: 00010286
EIP is at idedisk_suspend+0x4a/0x60
eax: c134e4b4   ebx: 00000001   ecx: 00000000   edx: cd851dc8
esi: c052c48c   edi: 00000001   ebp: cd851ef4   esp: cd851ee0
ds: 007b   es: 007b   ss: 0068
Process sleepbtn.sh (pid: 416, threadinfo=cd850000 task=cda4b9c0)
Stack: c052c48c c040887d c052c48c c052c6d4 00000000 cd851f14 c026178b c052c6d4 
       00000004 00000001 00000003 cd851f68 cd851f5c cd851f2c c012c64d 00000004 
       00000001 00000004 00000000 cd851f34 c012cad0 cd851f3c c012cb35 cd851f74 
Call Trace:
 [<c026178b>] device_suspend+0x6b/0xe8
 [<c012c64d>] drivers_suspend+0x15/0x68
 [<c012cad0>] do_software_suspend+0x5c/0x8c
 [<c012cb35>] software_suspend+0x35/0x3c
 [<c022433e>] acpi_system_write_sleep+0xda/0x11c
 [<c014455e>] vfs_write+0x9e/0xd0
 [<c0144610>] sys_write+0x30/0x50
 [<c0108cf3>] syscall_call+0x7/0xb

Code: 0f 0b 56 04 38 85 40 c0 89 f6 31 c0 8d 65 f8 5b 5e 89 ec 5d 

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
