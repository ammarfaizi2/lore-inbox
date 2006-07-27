Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWG0DiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWG0DiU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 23:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWG0DiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 23:38:20 -0400
Received: from mail.fieldses.org ([66.93.2.214]:30158 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751255AbWG0DiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 23:38:20 -0400
Date: Wed, 26 Jul 2006 23:38:19 -0400
To: linux-kernel@vger.kernel.org
Subject: BUG() on apm resume in 2.6.18-rc2
Message-ID: <20060727033819.GA368@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After suspending to ram and then resuming, I'm getting the following on
2.6.18-rc2.  I also checked the latest git (54721324...) with the same
results.  The last that I know was OK was 2.6.17.

Let me know if any more information would be useful.

Copied by hand as fast as I could type, so there are probably typos....

--b.

2.6.18-rc2-g64821324
BUG: unable to handle kernel paging request at virtual address c0729c38
 printing eip:
c0109204
*pde = 009bf027
*pte = 00729000
Oops: 0000 [#1]
PREEMPT DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c0109204>]    Not tainted VLI
EFLAGS: 00010246   (2.6.18-rc2-g64821324 #134)
EIP is at mcheck_init+0x4/0x80
eax: 000010ff   ebx: f584bd90   ecx: c010a230   edx: 00000000
esi: 00004102   edi: 00004102   ebp: f5887ef8   esp: f5887ef4
ds: 007b   es: 007b  ss: 0068
Process apmd (pid: 4032, ti=f5887000 task=f5cf0560 task.ti=f5887000)
Stack: f584bd90 f5887f08 c04e1dcf c070a220 00000000 f5887f14 c04e1dfd c09b1080
       f5887f28 c010c820 00000002 00000002 f6a35f74 f5887f4c c010d72e 00000000
       00000000 00000000 f5cf0ad0 00000246 f53e3f28 00000000 f5887f70 c016cf8b
Call Trace:
 [<c01036fc>] show_stack_log_lvl+0x9c/0xd0
 [<c01038fe>] show_registers+0x17e/0x210
 [<c0103a92>] die+0x102/0x2c0
 [<c05683b5>] do_page_fault+0x305/0x630
 [<c0103159>] error_code+0x39/0x40
 [<c04e1dcf>] __restore_processor_state+0x16f/0x190
 [<c04e1dfd>] restore_processor_state+0xd/0x10
 [<c010c820>] suspend+0xa0/0x1c0
 [<c010d72e>] do_ioctl+0x13e/0x170
 [<c016cf8b>] do_ioctl+0x6b/0x80
 [<c016cff1>] vfs_ioctl+0x51/0x2c0
 [<c016d290>] sys_ioctl+0x30/0x50
 [<c0102e37>] syscall_call+0x7/0xb
Code: 90 90 90 90 90 90 90 55 89 e5 e8 48 f7 28 00 50 68 38 66 59 c0 e8 1d d7 00
 00 58 5a c9 c3 89 f6 8d bc 27 00 00 00 00 55 89 e5 53 <83> 3d 38 9c 72 c0 01 8b
 5d 08 74 20 8a 43 01 3c 02 74 1e 3c 05
EIP: [<c0109204>] mcheck_init+0x4/0x80 SS:ESP 0068:f5887ef4
 <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
in_atomic(0:0, irqs_disabled():1
 [<c0103776>] show_trace+0x16/0x20
 [<c0103d1b>] dump_stack+0x1b/0x20
 [<c0111815>] __might_sleep+0x95/0xa0
 [<c012c603>] down_read+0x13/0x40
 [<c01239be>] blocking_notifier_call_chain+0xe/0x30
 [<c01172d3>] profile_task_exit+0x13/0x20
 [<c0118acb>] do_exit+0x1b/0x940
 [<c0103c44>] die+0x2b4/0x2c0
 [<c05683b5>= do_page_fault+0x305/0x630
 [<c0103159>] error_code+0x39/0x40
 [<c04e1dcf>] __restore_processor_state+0x16f/0x190
 [<c04e1dfd>] restore_processor_state+0xd/0x10
 [<c010c820>] supsend+0xa0/0x1c0
 [<c010d72e>] do_ioctl+0x13e/0x170
 [<c016cf8b>] do_ioctl+0x6b/0x80
 [<c016cff1>] vfs_ioctl+0x51/0x2c0
 [<c016d290>] sys_ioctl+0x30/0x50
 [<c0102e37>] syscall_call+0x7/0xb
