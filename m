Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbTEEQQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTEEQQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:16:51 -0400
Received: from franka.aracnet.com ([216.99.193.44]:37811 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262578AbTEEQQs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:16:48 -0400
Date: Mon, 05 May 2003 09:28:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 637] New: oops bad scheduling while atomic
Message-ID: <9130000.1052152124@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=637

           Summary: oops bad scheduling while atomic
    Kernel Version: 2.5.68 sched-2.5.68-B2 Preemptible Kernel
            Status: NEW
          Severity: low
             Owner: rml@tech9.net
         Submitter: builderbert@snet.net


Distribution:
I was just doing a compile of gcc 3.2.3 and got the following oops at some
point during the compile (not exactly sure where -- I killed the job and
then later checked dmesg).

Hardware Environment:
AMD Duron 900
VIA VT8363/8365
VT82C586B PIPC Bus Master IDE

Software Environment:
RedHat 7.3
Rusty's modutils

Problem Description:

oops below
(when restarting, I also noticed /dev/hda2 had been umounted...)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0164125
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0164125>]    Not tainted
EFLAGS: 00010286
EIP is at find_inode_fast+0x15/0x40
eax: c43eb444   ebx: dfd3e800   ecx: 00004216   edx: 00000000
esi: dfd3e800   edi: 00004216   ebp: dfd3e800   esp: d55a5e34
ds: 007b   es: 007b   ss: 0068
Process find (pid: 23535, threadinfo=d55a4000 task=ce69e740)
Stack: d55a4000 c01647b0 dfd3e800 c15262d4 00004216 c15262d4 00004216
dfd3e800
       c9faa8c0 c9faa8c0 c0185b64 dfd3e800 00004216 d9bb1034 fffffff4
cb72e82c
       cb72e7c4 c0158920 cb72e7c4 c9faa8c0 00000000 d55a5f48 dffea780
d55a5ef4
Call Trace:
 [<c01647b0>] iget_locked+0x50/0xc0
 [<c0185b64>] ext3_lookup+0x84/0x160
 [<c0158920>] real_lookup+0xc0/0xf0
 [<c0158c1e>] do_lookup+0x9e/0xb0
 [<c01590b9>] link_path_walk+0x489/0x8d0
 [<c0159979>] __user_walk+0x49/0x60
 [<c0154c1c>] vfs_lstat+0x1c/0x60
 [<c01552ab>] sys_lstat64+0x1b/0x40
 [<c010abf7>] syscall_call+0x7/0xb

Code: 0f 0d 02 39 48 18 74 0a 85 d2 89 d0 75 f0 31 c0 5b c3 39 98
 <6>note: find[23535] exited with preempt_count 2
bad: scheduling while atomic!
Call Trace:
 [<c0118e55>] schedule+0x395/0x3a0
 [<c013d633>] unmap_page_range+0x43/0x70
 [<c013d820>] unmap_vmas+0x1c0/0x220
 [<c014158b>] exit_mmap+0x7b/0x190
 [<c011a744>] mmput+0x54/0xb0
 [<c011e2e9>] do_exit+0x119/0x370
 [<c010b3f1>] die+0xe1/0xf0
 [<c01174ea>] do_page_fault+0x14a/0x457
 [<c014eadb>] __getblk+0x2b/0x60
 [<c01818c9>] ext3_getblk+0x99/0x2b0
 [<c011a480>] autoremove_wake_function+0x0/0x50
 [<c014d4ef>] wake_up_buffer+0xf/0x30
 [<c014d543>] unlock_buffer+0x33/0x60
 [<c0150ad5>] ll_rw_block+0x45/0x80
 [<c01857d0>] ext3_find_entry+0x330/0x410
 [<c01173a0>] do_page_fault+0x0/0x457
 [<c010ada1>] error_code+0x2d/0x38
 [<c0164125>] find_inode_fast+0x15/0x40
 [<c01647b0>] iget_locked+0x50/0xc0
 [<c0185b64>] ext3_lookup+0x84/0x160
 [<c0158920>] real_lookup+0xc0/0xf0
 [<c0158c1e>] do_lookup+0x9e/0xb0
 [<c01590b9>] link_path_walk+0x489/0x8d0
 [<c0159979>] __user_walk+0x49/0x60
 [<c0154c1c>] vfs_lstat+0x1c/0x60
 [<c01552ab>] sys_lstat64+0x1b/0x40
 [<c010abf7>] syscall_call+0x7/0xb


Steps to reproduce:
not sure -- was doing a compile test of gcc 3.2.3


