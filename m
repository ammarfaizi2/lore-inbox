Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272587AbTG1AFc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272586AbTG1AF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:05:28 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:4824 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S272765AbTG0XWc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:22:32 -0400
From: root@mauve.demon.co.uk
Message-Id: <200307272337.AAA17310@mauve.demon.co.uk>
Subject: 2.6.0-test1 usb-storage oops.
To: linux-kernel@vger.kernel.org
Date: Mon, 28 Jul 2003 00:37:48 +0100 (BST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

modprobe usb-storage
insert and remove USB storage device thrice.
cd /proc/scsi
rmmod usb-storage
rmmod scsi-mod
ls

Seems to reproduce

Unfortunately I have been unable to run ksymoops on this, due to the machine
I did it on being in bits for unrelated hardware reasons shortly after.
However, I believe it may be helpfull.
If it needs to be ksymoopsed, then mail me, and I'll try to put the machine
back together.

Jul 28 00:05:19 mauve kernel: Unable to handle kernel paging request at address
cc8ad820
Jul 28 00:05:19 mauve kernel:  printing eip:
Jul 28 00:05:19 mauve kernel: c0183b5c
Jul 28 00:05:19 mauve kernel: *pde = 0bf3a067
Jul 28 00:05:19 mauve kernel: *pte = 00000000
Jul 28 00:05:19 mauve kernel: Oops: 0000 [#1]
Jul 28 00:05:19 mauve kernel: CPU:    0
Jul 28 00:05:19 mauve kernel: EIP:    0060:[<c0183b5c>]    Not tainted
Jul 28 00:05:19 mauve kernel: EFLAGS: 00010202
Jul 28 00:05:19 mauve kernel: EIP is at proc_readfd+0x24c/0x260
Jul 28 00:05:19 mauve kernel: eax: c633c000   ebx: c6fed0d4   ecx: 00000000   edx: cc8ad820
Jul 28 00:05:19 mauve kernel: esi: c8a6b8c8   edi: 00000001   ebp: c633de24   esp: c633de0c
Jul 28 00:05:19 mauve kernel: ds: 007b   es: 007b   ss: 0068
Jul 28 00:05:19 mauve kernel: Process ls (pid: 5456, threadinfo=c633c000 task=c5636680)
Jul 28 00:05:19 mauve kernel: Stack: c6fed0d4 000011f9 c6fed38c 0000000b c633bdcf c8a6b91b c633de50 c0186432
Jul 28 00:05:19 mauve kernel:        cbfd5668 000011f9 c8a6b8c8 c8a6b8c8 ffffffea 00000000 fffffff4 c6fed3f4
Jul 28 00:05:19 mauve kernel:        c6fed38c c633de74 c01647a6 c6fed38c c633bd4Jul 28 00:05:19 mauve kernel: Call Trace:
Jul 28 00:05:19 mauve kernel:  [<c0186432>] kmsg_poll+0x42/0x60
Jul 28 00:05:19 mauve kernel:  [<c01647a6>] may_open+0x86/0x1d0
Jul 28 00:05:19 mauve kernel:  [<c0164a45>] open_namei+0x155/0x430
Jul 28 00:05:19 mauve kernel:  [<c0164ef1>] sys_mknod+0x21/0x190
Jul 28 00:05:19 mauve kernel:  [<c01426c6>] s_show+0xa6/0x260
Jul 28 00:05:19 mauve kernel:  [<c0165830>] sys_unlink+0x40/0x140
Jul 28 00:05:19 mauve kernel:  [<c016089b>] exec_mmap+0x11b/0x140
Jul 28 00:05:19 mauve kernel:  [<c0160f1b>] flush_old_exec+0x65b/0x850
Jul 28 00:05:19 mauve kernel:  [<c016989d>] flock_to_posix_lock+0x8d/0x150
Jul 28 00:05:19 mauve kernel:  [<c01696b0>] init_once+0x0/0x20
Jul 28 00:05:19 mauve kernel:  [<c010a2ab>] syscall_call+0x7/0xb
Jul 28 00:05:19 mauve kernel:
Jul 28 00:05:19 mauve kernel: Code: 83 3a 02 74 60 ff 82 a0 00 00 00 b8 00 e0 ff ff 21 e0 ff 48
Jul 28 00:05:19 mauve kernel:  <6>note: ls[5456] exited with preempt_count 2
Jul 28 00:05:19 mauve kernel: bad: scheduling while atomic!
Jul 28 00:05:19 mauve kernel: Call Trace:
Jul 28 00:05:19 mauve kernel:  [<c011b759>] schedule+0x3b9/0x3c0
Jul 28 00:05:19 mauve kernel:  [<c0147dfe>] do_anonymous_page+0xbe/0x200
Jul 28 00:05:19 mauve kernel:  [<c014800a>] do_no_page+0xca/0x2e0
Jul 28 00:05:19 mauve kernel:  [<c014bcc6>] sys_mremap+0x16/0x8c
Jul 28 00:05:19 mauve kernel:  [<c011d276>] mmput+0x66/0xc0
Jul 28 00:05:19 mauve kernel:  [<c0121058>] do_exit+0x148/0x480
Jul 28 00:05:19 mauve kernel:  [<c010aafc>] die+0xec/0xf0
Jul 28 00:05:19 mauve kernel:  [<c0119e6d>] do_page_fault+0x15d/0x4dc
Jul 28 00:05:19 mauve kernel:  [<c0140d94>] kmem_cache_create+0x64/0x4e0
Jul 28 00:05:19 mauve kernel:  [<c01426a4>] s_show+0x84/0x260
Jul 28 00:05:19 mauve kernel:  [<c01838ce>] proc_pid_readlink+0x10e/0x120
Jul 28 00:05:20 mauve kernel:  [<c01838fd>] pid_alive+0x1d/0x30
Jul 28 00:05:20 mauve kernel:  [<c016f9be>] generic_forget_inode+0x10e/0x150
Jul 28 00:05:20 mauve kernel:  [<c0119d10>] do_page_fault+0x0/0x4dc
Jul 28 00:05:20 mauve kernel:  [<c010a455>] error_code+0x2d/0x38
Jul 28 00:05:20 mauve kernel:  [<c0183b5c>] proc_readfd+0x24c/0x260
Jul 28 00:05:20 mauve kernel:  [<c0186432>] kmsg_poll+0x42/0x60
Jul 28 00:05:20 mauve kernel:  [<c01647a6>] may_open+0x86/0x1d0
Jul 28 00:05:20 mauve kernel:  [<c0164a45>] open_namei+0x155/0x430
Jul 28 00:05:20 mauve kernel:  [<c0164ef1>] sys_mknod+0x21/0x190
Jul 28 00:05:20 mauve kernel:  [<c01426c6>] s_show+0xa6/0x260
Jul 28 00:05:20 mauve kernel:  [<c0165830>] sys_unlink+0x40/0x140
Jul 28 00:05:20 mauve kernel:  [<c016089b>] exec_mmap+0x11b/0x140
Jul 28 00:05:20 mauve kernel:  [<c0160f1b>] flush_old_exec+0x65b/0x850
Jul 28 00:05:20 mauve kernel:  [<c016989d>] flock_to_posix_lock+0x8d/0x150
Jul 28 00:05:20 mauve kernel:  [<c01696b0>] init_once+0x0/0x20
Jul 28 00:05:20 mauve kernel:  [<c010a2ab>] syscall_call+0x7/0xb
Jul 28 00:05:20 mauve kernel:
Jul 28 00:05:20 mauve kernel: Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Jul 28 00:05:20 mauve kernel: Call Trace:
Jul 28 00:05:20 mauve kernel:  [<c011cb91>] __might_sleep+0x61/0x80
Jul 28 00:05:20 mauve kernel:  [<c01476ad>] do_wp_page+0x1dd/0x320
Jul 28 00:05:20 mauve kernel:  [<c014a319>] detach_vmas_to_be_unmapped+0x29/0x60Jul 28 00:05:20 mauve kernel:  [<c014bd7b>] filemap_sync_pte+0x1b/0xa0
Jul 28 00:05:20 mauve kernel:  [<c011d276>] mmput+0x66/0xc0
Jul 28 00:05:20 mauve kernel:  [<c0121058>] do_exit+0x148/0x480
Jul 28 00:05:20 mauve kernel:  [<c010aafc>] die+0xec/0xf0
Jul 28 00:05:20 mauve kernel:  [<c0119e6d>] do_page_fault+0x15d/0x4dc
Jul 28 00:05:20 mauve kernel:  [<c0140d94>] kmem_cache_create+0x64/0x4e0
Jul 28 00:05:20 mauve kernel:  [<c01426a4>] s_show+0x84/0x260
Jul 28 00:05:20 mauve kernel:  [<c01838ce>] proc_pid_readlink+0x10e/0x120
Jul 28 00:05:20 mauve kernel:  [<c01838fd>] pid_alive+0x1d/0x30
Jul 28 00:05:20 mauve kernel:  [<c016f9be>] generic_forget_inode+0x10e/0x150
Jul 28 00:05:20 mauve kernel:  [<c0119d10>] do_page_fault+0x0/0x4dc
Jul 28 00:05:20 mauve kernel:  [<c010a455>] error_code+0x2d/0x38
Jul 28 00:05:20 mauve kernel:  [<c0183b5c>] proc_readfd+0x24c/0x260
Jul 28 00:05:20 mauve kernel:  [<c0186432>] kmsg_poll+0x42/0x60
Jul 28 00:05:20 mauve kernel:  [<c01647a6>] may_open+0x86/0x1d0
Jul 28 00:05:20 mauve kernel:  [<c0164a45>] open_namei+0x155/0x430
Jul 28 00:05:20 mauve kernel:  [<c0164ef1>] sys_mknod+0x21/0x190
Jul 28 00:05:20 mauve kernel:  [<c01426c6>] s_show+0xa6/0x260
Jul 28 00:05:20 mauve kernel:  [<c0165830>] sys_unlink+0x40/0x140
Jul 28 00:05:20 mauve kernel:  [<c016089b>] exec_mmap+0x11b/0x140
Jul 28 00:05:20 mauve kernel:  [<c0160f1b>] flush_old_exec+0x65b/0x850
Jul 28 00:05:20 mauve kernel:  [<c016989d>] flock_to_posix_lock+0x8d/0x150
Jul 28 00:05:20 mauve kernel:  [<c01696b0>] init_once+0x0/0x20
Jul 28 00:05:20 mauve kernel:  [<c010a2ab>] syscall_call+0x7/0xb
Jul 28 00:05:20 mauve kernel:

