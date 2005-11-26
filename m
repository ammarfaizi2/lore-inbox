Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVKZLvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVKZLvZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 06:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVKZLvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 06:51:24 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:5414 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750808AbVKZLvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 06:51:24 -0500
Message-ID: <43884C38.6080203@gentoo.org>
Date: Sat, 26 Nov 2005 11:51:20 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051104)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
Subject: 2.6.14 unreproducible oops in free_block
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A gentoo user reported an oops while compiling a package on x86.

This is not reproducible and the system is generally 100% stable, but I 
thought it might be worth reporting anyway.

Unable to handle kernel paging request at virtual address 00523000
  printing eip:
c013e433
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c013e433>]    Not tainted VLI
EFLAGS: 00010016   (2.6.14-gentoo-r2)
EIP is at free_block+0x43/0xd0
eax: c7b52000   ebx: c13e8000   ecx: c13e8804   edx: 00523000
esi: c7fedd60   edi: c7fefcc0   ebp: 00000038   esp: c688bdc8
ds: 007b   es: 007b   ss: 0068
Process emerge (pid: 25586, threadinfo=c688a000 task=c1c25ad0)
Stack: 0000003c c7fe9410 c7feec00 c7fefcc0 c76cc5f4 c7fe9410 c013e518 00000000
        0000003c c7fe9400 c7fe9400 00000292 c76cc5f4 c688a000 c013e6ef c76ccac4
        c76cc5f4 c50e9040 c014872a 00000000 ffffffff c688be28 00000000 c046ec2c
Call Trace:
  [<c013e518>] cache_flusharray+0x58/0x100
  [<c013e6ef>] kmem_cache_free+0x3f/0x50
  [<c014872a>] exit_mmap+0x11a/0x150
  [<c0118462>] mmput+0x32/0xb0
  [<c015e146>] exec_mmap+0xc6/0x170
  [<c015e361>] flush_old_exec+0xe1/0x890
  [<c012e0c0>] autoremove_wake_function+0x0/0x50
  [<c0152cd9>] get_unused_fd+0x29/0xd0
  [<c018078a>] load_elf_binary+0x38a/0xc60
  [<c0139a70>] prep_new_page+0x40/0x70
  [<c0139ff4>] buffered_rmqueue+0x104/0x1e0
  [<c024f95a>] copy_from_user+0x3a/0x80
  [<c0180400>] load_elf_binary+0x0/0xc60
  [<c015ed75>] search_binary_handler+0x75/0x170
  [<c015efb7>] do_execve+0x147/0x1d0
  [<c0101979>] sys_execve+0x39/0x90
  [<c0102cab>] sysenter_past_esp+0x54/0x75
Code: 24 04 8b 15 90 d1 47 c0 8b 0c a8 8d 81 00 00 00 40 c1 e8 0c c1 e0 05 8b 5c
10 1c 8b 44 24 1c 8b 53 04 8b 74 87 14 8b 03 89 50 04 <89> 02 31 d2 2b 4b 0c c7
03 00 01 10 00 c7 43 04 00 02 20 00 89
  <6>note: emerge[25586] exited with preempt_count 1
------------[ cut here ]------------
kernel BUG at mm/mmap.c:1965!
invalid operand: 0000 [#2]
PREEMPT
CPU:    0
EIP:    0060:[<c014874a>]    Not tainted VLI
EFLAGS: 00010202   (2.6.14-gentoo-r2)
EIP is at exit_mmap+0x13a/0x150
eax: 0000004c   ebx: 00000000   ecx: c7fefcc0   edx: c487a754
esi: 00000000   edi: 00000001   ebp: c688a000   esp: c688be60
ds: 007b   es: 007b   ss: 0068
Process emerge (pid: 25589, threadinfo=c688a000 task=c1c25ad0)
Stack: 00000000 ffffffff c688be74 00000000 c046ec2c 000007fb c431adc0 c431adfc
        00000000 0000000b c0118462 c688a000 c1c25ad0 c011cb48 0000000a 00000000
        0000000b c688bfbc 00000001 c782b200 0000000b c688a000 c688a000 c011ce4f
Call Trace:
  [<c0118462>] mmput+0x32/0xb0
  [<c011cb48>] do_exit+0xd8/0x370
  [<c011ce4f>] do_group_exit+0x2f/0xa0
  [<c0126026>] get_signal_to_deliver+0x1f6/0x330
  [<c0102ac0>] do_signal+0x60/0x140
  [<c0369080>] do_page_fault+0x0/0x5c5
  [<c010379b>] error_code+0x4f/0x54
  [<c0369300>] do_page_fault+0x280/0x5c5
  [<c0369080>] do_page_fault+0x0/0x5c5
  [<c0102bd7>] do_notify_resume+0x37/0x3c
  [<c0102d96>] work_notifysig+0x13/0x19
Code: 00 8b 5e 0c 89 f0 e8 d6 de ff ff 89 de 85 f6 75 f0 8b bf 8c 00 00 00 85 ff
75 10 83 c4 18 5b 5e 5f 5d c3 0f 20 d8 0f 22 d8 eb 94 <0f> 0b ad 07 4d 43 39 c0
eb e6 e8 27 f2 21 00 eb d1 90 8d 74 26
  <1>Fixing recursive fault but reboot is needed!
Unable to handle kernel paging request at virtual address ca0ff4cc
  printing eip:
c013e451
*pde = 00000000
Oops: 0002 [#3]
PREEMPT
CPU:    0
EIP:    0060:[<c013e451>]    Not tainted VLI
EFLAGS: 00010013   (2.6.14-gentoo-r2)
EIP is at free_block+0x61/0xd0
eax: 00ffffff   ebx: c13e8000   ecx: 02345d2c   edx: 00000018
esi: c7fedd60   edi: c7fefcc0   ebp: 00000004   esp: c7f93edc
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=c7f92000 task=c7fc9030)
Stack: 00000018 c7fe9410 c7fe9410 c7fe9400 00000018 00000000 c013ebe3 00000000
        c7fefcc0 c7fe0fb0 c7fedd60 00000002 c7fefcc0 c013ecb3 00000000 c7f92000
        c7fe0fb0 c7f92000 c7f92000 c7fefd0c c7fc9158 c047d080 00000293 c047d084
Call Trace:
  [<c013ebe3>] drain_array_locked+0x73/0xc0
  [<c013ecb3>] cache_reap+0x83/0x1e0
  [<c0129f0e>] worker_thread+0x1ae/0x280
  [<c013ec30>] cache_reap+0x0/0x1e0
  [<c0117140>] default_wake_function+0x0/0x10
  [<c0117140>] default_wake_function+0x0/0x10
  [<c0129d60>] worker_thread+0x0/0x280
  [<c012dbc5>] kthread+0x95/0xd0
  [<c012db30>] kthread+0x0/0xd0
  [<c0100f55>] kernel_thread_helper+0x5/0x10
Code: 1c 8b 53 04 8b 74 87 14 8b 03 89 50 04 89 02 31 d2 2b 4b 0c c7 03 00 01 10
00 c7 43 04 00 02 20 00 89 c8 f7 77 10 89 c1 8b 43 14 <89> 44 8b 1c ff 4b 10 89
4b 14 8b 46 18 40 89 46 18 8b 53 10 85
  <6>note: events/0[3] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at virtual address 00000008
  printing eip:
c015483c
*pde = 00000000
Oops: 0000 [#4]
PREEMPT
CPU:    0
EIP:    0060:[<c015483c>]    Not tainted VLI
EFLAGS: 00010282   (2.6.14-gentoo-r2)
EIP is at __fput+0x1c/0x150
eax: 00000000   ebx: c7f92000   ecx: c5d7c2ac   edx: c76c7b40
esi: c76c7b40   edi: c76c7b40   ebp: c431a040   esp: c7f93f54
ds: 007b   es: 007b   ss: 0068
Process cron (pid: 25590, threadinfo=c7f92000 task=c7fc9030)
Stack: c7ac22dc 00000000 c7f92000 c5d7c284 c76c7b40 c431a040 c0146651 00000000
        c431a040 c5d7c284 c0147f1e b7dea000 b7de9000 c01482c8 b7de9000 b7dea000
        c76cc6a4 c431a040 c431a070 ffff0001 c7f92000 c0148370 b7de9000 80010670
Call Trace:
  [<c0146651>] remove_vm_struct+0x51/0x90
  [<c0147f1e>] unmap_vma_list+0xe/0x20
  [<c01482c8>] do_munmap+0xe8/0x150
  [<c0148370>] sys_munmap+0x40/0x70
  [<c0102cab>] sysenter_past_esp+0x54/0x75
Code: d0 e9 09 00 00 00 89 f6 8d bc 27 00 00 00 00 83 ec 18 89 5c 24 08 89 74 24
0c 89 c6 89 7c 24 10 89 6c 24 14 8b 40 08 89 44 24 04 <8b> 78 08 8b 48 20 0f b7
46 1c 8b 6e 0c 83 e0 02 83 f8 01 0f b7


Original bug report is at http://bugs.gentoo.org/113537

Daniel
