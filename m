Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbTGCRtk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 13:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbTGCRtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 13:49:40 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:41182 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265161AbTGCRtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 13:49:33 -0400
Subject: cdrom problems in 2.5.74
From: dave <davidr@sucs.swan.ac.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1057255437.3722.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 03 Jul 2003 19:03:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting frequent problems with CDs (reading or writing) in 2.5.74
(and earlier kernels also - at least 2.5.73, maybe earlier). Typically
it hangs the program accessing the cd. I got the following errors trying
to read a cd with cdparanoia:

Hope this is useful

dave

output from dmesg:

hdc: DMA disabled
hdc: irq timeout: status=0xd0 { Busy }
ide-scsi: abort called for 584
Debug: sleeping function called from illegal context at
include/asm/semaphore.h:119
Call Trace:
 [<c012477f>] __might_sleep+0x5f/0x70
 [<c02e7b34>] scsi_sleep+0xf4/0x120
 [<c02e7a20>] scsi_sleep_done+0x0/0x20
 [<c02f9630>] idescsi_abort+0x2c0/0x360
 [<c02e6e01>] scsi_try_to_abort_cmd+0xe1/0x200
 [<c01222d2>] __wake_up_locked+0x22/0x30
 [<c02e7030>] scsi_eh_abort_cmds+0x40/0x80
 [<c02e7fff>] scsi_unjam_host+0x13f/0x1f0
 [<c01220b0>] default_wake_function+0x0/0x30
 [<c02e832c>] scsi_error_handler+0x27c/0x2c0
 [<c02e80b0>] scsi_error_handler+0x0/0x2c0
 [<c0109089>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c0122044>] schedule+0x6d4/0x6e0
 [<c01291b7>] printk+0x277/0x400
 [<c0109f35>] __down+0x135/0x350
 [<c01220b0>] default_wake_function+0x0/0x30
 [<c010cc5e>] dump_stack+0x1e/0x20
 [<c010a657>] __down_failed+0xb/0x14
 [<c02e85cf>] .text.lock.scsi_error+0x37/0x48
 [<c02e7a20>] scsi_sleep_done+0x0/0x20
 [<c02f9630>] idescsi_abort+0x2c0/0x360
 [<c02e6e01>] scsi_try_to_abort_cmd+0xe1/0x200
 [<c01222d2>] __wake_up_locked+0x22/0x30
 [<c02e7030>] scsi_eh_abort_cmds+0x40/0x80
 [<c02e7fff>] scsi_unjam_host+0x13f/0x1f0
 [<c01220b0>] default_wake_function+0x0/0x30
 [<c02e832c>] scsi_error_handler+0x27c/0x2c0
 [<c02e80b0>] scsi_error_handler+0x0/0x2c0
 [<c0109089>] kernel_thread_helper+0x5/0xc

hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
drivers/scsi/ide-scsi.c:362: spin_lock(drivers/scsi/hosts.c:dfd7d268)
already locked by drivers/scsi/scsi_error.c/712
drivers/scsi/scsi_error.c:714:
spin_unlock(drivers/scsi/hosts.c:dfd7d268) not locked
hdc: irq timeout: status=0xd0 { Busy }
ide-scsi: abort called for 738
Debug: sleeping function called from illegal context at
include/asm/semaphore.h:119
Call Trace:
 [<c012477f>] __might_sleep+0x5f/0x70
 [<c02e7b34>] scsi_sleep+0xf4/0x120
 [<c02e7a20>] scsi_sleep_done+0x0/0x20
 [<c02f9630>] idescsi_abort+0x2c0/0x360
 [<c02e6e01>] scsi_try_to_abort_cmd+0xe1/0x200
 [<c01222d2>] __wake_up_locked+0x22/0x30
 [<c02e7030>] scsi_eh_abort_cmds+0x40/0x80
 [<c02e7fff>] scsi_unjam_host+0x13f/0x1f0
 [<c01220b0>] default_wake_function+0x0/0x30
 [<c02e832c>] scsi_error_handler+0x27c/0x2c0
 [<c02e80b0>] scsi_error_handler+0x0/0x2c0
 [<c0109089>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c0122044>] schedule+0x6d4/0x6e0
 [<c01291b7>] printk+0x277/0x400
 [<c0109f35>] __down+0x135/0x350
 [<c01220b0>] default_wake_function+0x0/0x30
 [<c010cc5e>] dump_stack+0x1e/0x20
 [<c010a657>] __down_failed+0xb/0x14
 [<c02e85cf>] .text.lock.scsi_error+0x37/0x48
 [<c02e7a20>] scsi_sleep_done+0x0/0x20
 [<c02f9630>] idescsi_abort+0x2c0/0x360
 [<c02e6e01>] scsi_try_to_abort_cmd+0xe1/0x200
 [<c01222d2>] __wake_up_locked+0x22/0x30
 [<c02e7030>] scsi_eh_abort_cmds+0x40/0x80
 [<c02e7fff>] scsi_unjam_host+0x13f/0x1f0
 [<c01220b0>] default_wake_function+0x0/0x30
 [<c02e832c>] scsi_error_handler+0x27c/0x2c0
 [<c02e80b0>] scsi_error_handler+0x0/0x2c0
 [<c0109089>] kernel_thread_helper+0x5/0xc

hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
drivers/scsi/ide-scsi.c:362: spin_lock(drivers/scsi/hosts.c:dfd7d268)
already locked by drivers/scsi/scsi_error.c/712
drivers/scsi/scsi_error.c:714:
spin_unlock(drivers/scsi/hosts.c:dfd7d268) not locked
hdc: irq timeout: status=0xd0 { Busy }
ide-scsi: abort called for 1081
Debug: sleeping function called from illegal context at
include/asm/semaphore.h:119
Call Trace:
 [<c012477f>] __might_sleep+0x5f/0x70
 [<c02e7b34>] scsi_sleep+0xf4/0x120
 [<c02e7a20>] scsi_sleep_done+0x0/0x20
 [<c02f9630>] idescsi_abort+0x2c0/0x360
 [<c02e6e01>] scsi_try_to_abort_cmd+0xe1/0x200
 [<c01222d2>] __wake_up_locked+0x22/0x30
 [<c02e7030>] scsi_eh_abort_cmds+0x40/0x80
 [<c02e7fff>] scsi_unjam_host+0x13f/0x1f0
 [<c01220b0>] default_wake_function+0x0/0x30
 [<c02e832c>] scsi_error_handler+0x27c/0x2c0
 [<c02e80b0>] scsi_error_handler+0x0/0x2c0
 [<c0109089>] kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
Call Trace:
 [<c0122044>] schedule+0x6d4/0x6e0
 [<c01291b7>] printk+0x277/0x400
 [<c0109f35>] __down+0x135/0x350
 [<c01220b0>] default_wake_function+0x0/0x30
 [<c010cc5e>] dump_stack+0x1e/0x20
 [<c010a657>] __down_failed+0xb/0x14
 [<c02e85cf>] .text.lock.scsi_error+0x37/0x48
 [<c02e7a20>] scsi_sleep_done+0x0/0x20
 [<c02f9630>] idescsi_abort+0x2c0/0x360
 [<c02e6e01>] scsi_try_to_abort_cmd+0xe1/0x200
 [<c01222d2>] __wake_up_locked+0x22/0x30
 [<c02e7030>] scsi_eh_abort_cmds+0x40/0x80
 [<c02e7fff>] scsi_unjam_host+0x13f/0x1f0
 [<c01220b0>] default_wake_function+0x0/0x30
 [<c02e832c>] scsi_error_handler+0x27c/0x2c0
 [<c02e80b0>] scsi_error_handler+0x0/0x2c0
 [<c0109089>] kernel_thread_helper+0x5/0xc

hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
hdc: ATAPI reset complete
hdc: irq timeout: status=0xc0 { Busy }
drivers/scsi/ide-scsi.c:362: spin_lock(drivers/scsi/hosts.c:dfd7d268)
already locked by drivers/scsi/scsi_error.c/712
Unable to handle kernel paging request at virtual address 6b6b6bd3
 printing eip:
c02f8dce
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02f8dce>]    Tainted: PF
EFLAGS: 00010002
EIP is at idescsi_queue+0x25e/0x800
eax: 00000000   ebx: cdf37d30   ecx: dfd23084   edx: 6b6b6b6b
esi: ca10c000   edi: d886ba14   ebp: ca10dde8   esp: ca10dd8c
ds: 007b   es: 007b   ss: 0068
Process cdparanoia (pid: 4065, threadinfo=ca10c000 task=cb234980)
Stack: c05171c4 d886ba14 00000004 e0c6e9c0 cfc428f4 dfd7ce28 cfc42984
cdf37d30
       00000046 dfd230ec c0450220 ca10dde8 00000246 dfd230d8 ca060000
dfd230d8
       d886ba14 dfd7d42c d886ba14 c05171c4 00000246 dfd7d234 dfd23084
ca10de20
Call Trace:
 [<c02e380c>] scsi_dispatch_cmd+0x2cc/0x420
 [<c02e3ab0>] scsi_done+0x0/0x70
 [<c02e63b0>] scsi_times_out+0x0/0x50
 [<c02e8abf>] scsi_init_cmd_errh+0x9f/0xd0
 [<c02ea6a6>] scsi_request_fn+0x2e6/0x720
 [<c015312e>] __alloc_pages+0x8e/0x330
 [<c02a7a9e>] blk_insert_request+0xde/0x1f0
 [<c02e86f9>] scsi_do_req+0x49/0xa0
 [<c02e8613>] scsi_insert_special_req+0x33/0x40
 [<c02fe6cf>] sg_common_write+0x16f/0x1d0
 [<c02ff980>] sg_cmd_done+0x0/0x270
 [<c02fe226>] sg_write+0x1d6/0x2a0
 [<c0192c10>] sys_select+0x220/0x4c0
 [<c017767d>] vfs_write+0xad/0x120
 [<c0138d6d>] sys_rt_sigprocmask+0x8d/0x2f0
 [<c017778f>] sys_write+0x3f/0x60
 [<c010bf0b>] syscall_call+0x7/0xb

Code: 8b 42 68 8b 40 4c 81 38 3c 4b 24 1d 74 26 89 44 24 0c c7 44
 <6>note: cdparanoia[4065] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c0122044>] schedule+0x6d4/0x6e0
 [<c01609a1>] unmap_page_range+0x41/0x70
 [<c0160bb6>] unmap_vmas+0x1e6/0x350
 [<c016679b>] exit_mmap+0xcb/0x2c0
 [<c0125606>] mmput+0xb6/0x140
 [<c012ba86>] do_exit+0x276/0xa90
 [<c010d0bc>] die+0x21c/0x220
 [<c011fc0c>] do_page_fault+0x15c/0x4ca
 [<c011fab0>] do_page_fault+0x0/0x4ca
 [<c010c915>] error_code+0x2d/0x38
 [<c02f8dce>] idescsi_queue+0x25e/0x800
 [<c02e380c>] scsi_dispatch_cmd+0x2cc/0x420
 [<c02e3ab0>] scsi_done+0x0/0x70
 [<c02e63b0>] scsi_times_out+0x0/0x50
 [<c02e8abf>] scsi_init_cmd_errh+0x9f/0xd0
 [<c02ea6a6>] scsi_request_fn+0x2e6/0x720
 [<c015312e>] __alloc_pages+0x8e/0x330
 [<c02a7a9e>] blk_insert_request+0xde/0x1f0
 [<c02e86f9>] scsi_do_req+0x49/0xa0
 [<c02e8613>] scsi_insert_special_req+0x33/0x40
 [<c02fe6cf>] sg_common_write+0x16f/0x1d0
 [<c02ff980>] sg_cmd_done+0x0/0x270
 [<c02fe226>] sg_write+0x1d6/0x2a0
 [<c0192c10>] sys_select+0x220/0x4c0
 [<c017767d>] vfs_write+0xad/0x120
 [<c0138d6d>] sys_rt_sigprocmask+0x8d/0x2f0
 [<c017778f>] sys_write+0x3f/0x60
 [<c010bf0b>] syscall_call+0x7/0xb

Debug: sleeping function called from illegal context at
include/asm/semaphore.h:119
Call Trace:
 [<c012477f>] __might_sleep+0x5f/0x70
 [<c015fa1d>] clear_page_tables+0xad/0xb0
 [<c0164649>] remove_shared_vm_struct+0x39/0xa0
 [<c01668a2>] exit_mmap+0x1d2/0x2c0
 [<c0125606>] mmput+0xb6/0x140
 [<c012ba86>] do_exit+0x276/0xa90
 [<c010d0bc>] die+0x21c/0x220
 [<c011fc0c>] do_page_fault+0x15c/0x4ca
 [<c011fab0>] do_page_fault+0x0/0x4ca
 [<c010c915>] error_code+0x2d/0x38
 [<c02f8dce>] idescsi_queue+0x25e/0x800
 [<c02e380c>] scsi_dispatch_cmd+0x2cc/0x420
 [<c02e3ab0>] scsi_done+0x0/0x70
 [<c02e63b0>] scsi_times_out+0x0/0x50
 [<c02e8abf>] scsi_init_cmd_errh+0x9f/0xd0
 [<c02ea6a6>] scsi_request_fn+0x2e6/0x720
 [<c015312e>] __alloc_pages+0x8e/0x330
 [<c02a7a9e>] blk_insert_request+0xde/0x1f0
 [<c02e86f9>] scsi_do_req+0x49/0xa0
 [<c02e8613>] scsi_insert_special_req+0x33/0x40
 [<c02fe6cf>] sg_common_write+0x16f/0x1d0
 [<c02ff980>] sg_cmd_done+0x0/0x270
 [<c02fe226>] sg_write+0x1d6/0x2a0
 [<c0192c10>] sys_select+0x220/0x4c0
 [<c017767d>] vfs_write+0xad/0x120
 [<c0138d6d>] sys_rt_sigprocmask+0x8d/0x2f0
 [<c017778f>] sys_write+0x3f/0x60
 [<c010bf0b>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0122044>] schedule+0x6d4/0x6e0
 [<c02ea402>] scsi_request_fn+0x42/0x720
 [<c01228b5>] wait_for_completion+0x155/0x340
 [<c01220b0>] default_wake_function+0x0/0x30
 [<c01220b0>] default_wake_function+0x0/0x30
 [<c02e8613>] scsi_insert_special_req+0x33/0x40
 [<c02e89fa>] scsi_wait_req+0xca/0xf0
 [<c02e8750>] scsi_wait_done+0x0/0x1e0
 [<c01589b6>] kmem_cache_alloc+0x146/0x190
 [<c02e4b42>] ioctl_internal_command+0x52/0x190
 [<c02e4ce6>] scsi_set_medium_removal+0x66/0x90
 [<c015c241>] invalidate_inode_pages+0x21/0x30
 [<c0303857>] cdrom_release+0x67/0x120
 [<c0184992>] blkdev_put+0x2c2/0x340
 [<c0197d23>] dput+0x23/0x680
 [<c0178792>] __fput+0x112/0x120
 [<c017676a>] filp_close+0x15a/0x220
 [<c012563c>] mmput+0xec/0x140
 [<c012a7dc>] put_files_struct+0x6c/0xe0
 [<c012bc03>] do_exit+0x3f3/0xa90
 [<c010d0bc>] die+0x21c/0x220
 [<c011fc0c>] do_page_fault+0x15c/0x4ca
 [<c011fab0>] do_page_fault+0x0/0x4ca
 [<c010c915>] error_code+0x2d/0x38
 [<c02f8dce>] idescsi_queue+0x25e/0x800
 [<c02e380c>] scsi_dispatch_cmd+0x2cc/0x420
 [<c02e3ab0>] scsi_done+0x0/0x70
 [<c02e63b0>] scsi_times_out+0x0/0x50
 [<c02e8abf>] scsi_init_cmd_errh+0x9f/0xd0
 [<c02ea6a6>] scsi_request_fn+0x2e6/0x720
 [<c015312e>] __alloc_pages+0x8e/0x330
 [<c02a7a9e>] blk_insert_request+0xde/0x1f0
 [<c02e86f9>] scsi_do_req+0x49/0xa0
 [<c02e8613>] scsi_insert_special_req+0x33/0x40
 [<c02fe6cf>] sg_common_write+0x16f/0x1d0
 [<c02ff980>] sg_cmd_done+0x0/0x270
 [<c02fe226>] sg_write+0x1d6/0x2a0
 [<c0192c10>] sys_select+0x220/0x4c0
 [<c017767d>] vfs_write+0xad/0x120
 [<c0138d6d>] sys_rt_sigprocmask+0x8d/0x2f0
 [<c017778f>] sys_write+0x3f/0x60
 [<c010bf0b>] syscall_call+0x7/0xb


