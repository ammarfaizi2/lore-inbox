Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTDVOco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 10:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTDVOco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 10:32:44 -0400
Received: from WebDev.iNES.RO ([80.86.100.174]:30851 "EHLO webdev.ines.ro")
	by vger.kernel.org with ESMTP id S263173AbTDVOcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 10:32:41 -0400
Date: Tue, 22 Apr 2003 17:44:45 +0300 (EEST)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
X-X-Sender: shadow@webdev.ines.ro
To: linux-kernel@vger.kernel.org
Subject: 2.5.68-mm1 oops
Message-ID: <Pine.LNX.4.50L0.0304221732160.1931-100000@webdev.ines.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I found this in logs...

Something similar just happened while running find . -name tdfx_context.c 
in the xfree sources directory...

If you need more info, just tell me what, and I'll provide.

printing eip:
c0162e65
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[find_inode_fast+21/64]    Not tainted VLI
EIP:    0060:[<c0162e65>]    Not tainted VLI
EFLAGS: 00010282
EIP is at find_inode_fast+0x15/0x40
eax: d87ded04   ebx: dfd6aa00   ecx: 000705d5   edx: 00000000
esi: da587c80   edi: 000705d5   ebp: c2ab9e0c   esp: c2ab9e08
ds: 007b   es: 007b   ss: 0068
Process updatedb (pid: 11171, threadinfo=c2ab8000 task=d2936680)
Stack: c2ab8000 c2ab9e30 c01634d0 dfd6aa00 c1539e24 000705d5 c1539e24 
000705d5 
      da587c80 dfd6aa00 c2ab9e50 c0187e57 dfd6aa00 000705d5 c1df9064 
fffffff4 
      d0d2ff30 d0d2fec4 c2ab9e70 c015721d d0d2fec4 da587c80 da587c80 
00000000 
Call Trace:
[iget_locked+80/208] iget_locked+0x50/0xd0
[<c01634d0>] iget_locked+0x50/0xd0
[ext3_lookup+103/192] ext3_lookup+0x67/0xc0
[<c0187e57>] ext3_lookup+0x67/0xc0
[real_lookup+205/256] real_lookup+0xcd/0x100
[<c015721d>] real_lookup+0xcd/0x100
[do_lookup+141/160] do_lookup+0x8d/0xa0
[<c015750d>] do_lookup+0x8d/0xa0
[link_path_walk+1170/2272] link_path_walk+0x492/0x8e0
[<c01579b2>] link_path_walk+0x492/0x8e0
[__user_walk+62/96] __user_walk+0x3e/0x60
[<c015825e>] __user_walk+0x3e/0x60
[vfs_lstat+27/96] vfs_lstat+0x1b/0x60
[<c01533fb>] vfs_lstat+0x1b/0x60
[sys_lstat64+27/64] sys_lstat64+0x1b/0x40
[<c0153a6b>] sys_lstat64+0x1b/0x40
[vfs_readdir+138/144] vfs_readdir+0x8a/0x90
[<c015c04a>] vfs_readdir+0x8a/0x90
[filldir64+0/272] filldir64+0x0/0x110
[<c015c330>] filldir64+0x0/0x110
[sys_getdents64+185/190] sys_getdents64+0xb9/0xbe
[<c015c4f9>] sys_getdents64+0xb9/0xbe
[filldir64+0/272] filldir64+0x0/0x110
[<c015c330>] filldir64+0x0/0x110
[syscall_call+7/11] syscall_call+0x7/0xb
[<c010933b>] syscall_call+0x7/0xb

Code: 04 89 1c 24 ff 55 10 89 da 85 c0 75 e6 8b 03 eb da 90 8d 74 26 00 55 
89 e5 53 8b 45 0c 8b 4d 10 8b 5d 08 
8b 00 85 c0 74 10 8b 10 <0f> 0d 02 39 48 18 74 0b 85 d2 89 d0 75 f0 31 c0 
5b c9 c3 39 98 
<6>note: updatedb[11171] exited with preempt_count 1
Call Trace:
[__might_sleep+95/112] __might_sleep+0x5f/0x70
[<c0117a1f>] __might_sleep+0x5f/0x70
[clear_page_tables+182/192] clear_page_tables+0xb6/0xc0
[<c013a526>] clear_page_tables+0xb6/0xc0
[remove_shared_vm_struct+57/160] remove_shared_vm_struct+0x39/0xa0
[<c013d349>] remove_shared_vm_struct+0x39/0xa0
[exit_mmap+299/400] exit_mmap+0x12b/0x190
[<c013eeab>] exit_mmap+0x12b/0x190
[mmput+85/176] mmput+0x55/0xb0
[<c01180d5>] mmput+0x55/0xb0
[do_exit+328/1136] do_exit+0x148/0x470
[<c011be68>] do_exit+0x148/0x470
[die+236/240] die+0xec/0xf0
[<c0109b8c>] die+0xec/0xf0
[do_page_fault+348/1235] do_page_fault+0x15c/0x4d3
[<c0114d6c>] do_page_fault+0x15c/0x4d3
[ext3_getblk+149/624] ext3_getblk+0x95/0x270
[<c0183ea5>] ext3_getblk+0x95/0x270
[wake_up_buffer+17/48] wake_up_buffer+0x11/0x30
[<c014b6c1>] wake_up_buffer+0x11/0x30
[unlock_buffer+53/80] unlock_buffer+0x35/0x50
[<c014b715>] unlock_buffer+0x35/0x50
[ll_rw_block+66/128] ll_rw_block+0x42/0x80
[<c014edf2>] ll_rw_block+0x42/0x80
[ext3_getblk+149/624] ext3_getblk+0x95/0x270
[<c0183ea5>] ext3_getblk+0x95/0x270
[ext3_find_entry+733/960] ext3_find_entry+0x2dd/0x3c0
[<c0187afd>] ext3_find_entry+0x2dd/0x3c0
[do_page_fault+0/1235] do_page_fault+0x0/0x4d3
[<c0114c10>] do_page_fault+0x0/0x4d3
[error_code+45/56] error_code+0x2d/0x38
[<c0109545>] error_code+0x2d/0x38
[find_inode_fast+21/64] find_inode_fast+0x15/0x40
[<c0162e65>] find_inode_fast+0x15/0x40
[iget_locked+80/208] iget_locked+0x50/0xd0
[<c01634d0>] iget_locked+0x50/0xd0
[ext3_lookup+103/192] ext3_lookup+0x67/0xc0
[<c0187e57>] ext3_lookup+0x67/0xc0
[real_lookup+205/256] real_lookup+0xcd/0x100
[<c015721d>] real_lookup+0xcd/0x100
[do_lookup+141/160] do_lookup+0x8d/0xa0
[<c015750d>] do_lookup+0x8d/0xa0
[link_path_walk+1170/2272] link_path_walk+0x492/0x8e0
[<c01579b2>] link_path_walk+0x492/0x8e0
[__user_walk+62/96] __user_walk+0x3e/0x60
[<c015825e>] __user_walk+0x3e/0x60
[vfs_lstat+27/96] vfs_lstat+0x1b/0x60
[<c01533fb>] vfs_lstat+0x1b/0x60
[sys_lstat64+27/64] sys_lstat64+0x1b/0x40
[<c0153a6b>] sys_lstat64+0x1b/0x40
[vfs_readdir+138/144] vfs_readdir+0x8a/0x90
[<c015c04a>] vfs_readdir+0x8a/0x90
[filldir64+0/272] filldir64+0x0/0x110
[<c015c330>] filldir64+0x0/0x110
[sys_getdents64+185/190] sys_getdents64+0xb9/0xbe
[<c015c4f9>] sys_getdents64+0xb9/0xbe
[filldir64+0/272] filldir64+0x0/0x110
[<c015c330>] filldir64+0x0/0x110
[syscall_call+7/11] syscall_call+0x7/0xb
[<c010933b>] syscall_call+0x7/0xb

