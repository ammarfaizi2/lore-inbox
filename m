Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTJPLso (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 07:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbTJPLso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 07:48:44 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:33239 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S262861AbTJPLsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 07:48:40 -0400
Date: Thu, 16 Oct 2003 13:48:42 +0200
From: Ookhoi <ookhoi@humilis.net>
To: linux-kernel@vger.kernel.org
Subject: oops with 2.6.0-test7 on dell poweredge 650
Message-ID: <20031016114842.GJ20079@favonius>
Reply-To: ookhoi@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Uptime: 16:25:51 up 127 days, 17:29, 34 users,  load average: 1.16, 1.11, 1.09
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I found the following oops in dmesg. It happened during the daily
cronjob logrotate. The machine is a dell poweredge 650.
I can provide more info if wanted but tried to keep this mail
a bit small.
The machine seems oke btw.

Oops in dmesg and decoded oops (below):


Unable to handle kernel NULL pointer dereference at virtual address 0000003c
 printing eip:
c0174f15
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0174f15>]    Not tainted
EFLAGS: 00010246
EIP is at proc_pid_stat+0x7f/0x492
eax: 00000000   ebx: dee4f380   ecx: 00000000   edx: c02c988c
esi: e79ade00   edi: 00000000   ebp: dee4f380   esp: dfcc1e40
ds: 007b   es: 007b   ss: 0068
Process killall (pid: 15937, threadinfo=dfcc0000 task=f516a780)
Stack: c02c8c60 dee4f380 0000000d e79ade10 dee4f380 0000000d c0172dc0 dee4f380
       e79ade10 3f8de432 c015de52 e1a95180 e79ade10 c02c8c60 c02c8c60 c0173451
       e1a95180 e79ade10 0000000d 00000004 dee4f380 ffffffea fffffff4 e431e0f8
Call Trace:
 [<c0172dc0>] proc_pid_make_inode+0xc3/0xe0
 [<c015de52>] d_instantiate+0x4e/0x5a
 [<c0173451>] proc_pident_lookup+0xf2/0x258
 [<c0154c0f>] real_lookup+0xc8/0xea
 [<c01333af>] buffered_rmqueue+0xb3/0x13f
 [<c01334e1>] __alloc_pages+0xa6/0x314
 [<c0172422>] proc_info_read+0x54/0x138
 [<c0148d4d>] vfs_read+0xd0/0x135
 [<c0148fe0>] sys_read+0x42/0x63
 [<c0108d13>] syscall_call+0x7/0xb

Code: 8b 48 3c 85 c9 74 3e 8b 81 98 00 00 00 89 84 24 d0 00 00 00


==> Decoded oops:

ksymoops 2.4.9 on i686 2.6.0-test7.  Options used
     -v /boot/2.6.0-test7 (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.6.0-test7/ (default)
     -m /boot/System.map-2.6.0-test7 (specified)

Error (pclose_local): read_nm_symbols pclose failed 0x100
Warning (read_vmlinux): no kernel symbols in vmlinux, is /boot/2.6.0-test7 a valid vmlinux file?
No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 0000003c
c0174f15
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0174f15>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: dee4f380   ecx: 00000000   edx: c02c988c
esi: e79ade00   edi: 00000000   ebp: dee4f380   esp: dfcc1e40
ds: 007b   es: 007b   ss: 0068
Stack: c02c8c60 dee4f380 0000000d e79ade10 dee4f380 0000000d c0172dc0 dee4f380 
       e79ade10 3f8de432 c015de52 e1a95180 e79ade10 c02c8c60 c02c8c60 c0173451 
       e1a95180 e79ade10 0000000d 00000004 dee4f380 ffffffea fffffff4 e431e0f8 
Call Trace:
 [<c0172dc0>] proc_pid_make_inode+0xc3/0xe0
 [<c015de52>] d_instantiate+0x4e/0x5a
 [<c0173451>] proc_pident_lookup+0xf2/0x258
 [<c0154c0f>] real_lookup+0xc8/0xea
 [<c01333af>] buffered_rmqueue+0xb3/0x13f
 [<c01334e1>] __alloc_pages+0xa6/0x314
 [<c0172422>] proc_info_read+0x54/0x138
 [<c0148d4d>] vfs_read+0xd0/0x135
 [<c0148fe0>] sys_read+0x42/0x63
 [<c0108d13>] syscall_call+0x7/0xb
Code: 8b 48 3c 85 c9 74 3e 8b 81 98 00 00 00 89 84 24 d0 00 00 00 


>>EIP; c0174f15 <proc_pid_stat+7f/492>   <=====

>>ebx; dee4f380 <_end+1eabd968/3fc6c5e8>
>>edx; c02c988c <task_state_array+0/34>
>>esi; e79ade00 <_end+2761c3e8/3fc6c5e8>
>>ebp; dee4f380 <_end+1eabd968/3fc6c5e8>
>>esp; dfcc1e40 <_end+1f930428/3fc6c5e8>

Trace; c0172dc0 <proc_pid_make_inode+c3/e0>
Trace; c015de52 <d_instantiate+4e/5a>
Trace; c0173451 <proc_pident_lookup+f2/258>
Trace; c0154c0f <real_lookup+c8/ea>
Trace; c01333af <buffered_rmqueue+b3/13f>
Trace; c01334e1 <__alloc_pages+a6/314>
Trace; c0172422 <proc_info_read+54/138>
Trace; c0148d4d <vfs_read+d0/135>
Trace; c0148fe0 <sys_read+42/63>
Trace; c0108d13 <syscall_call+7/b>

Code;  c0174f15 <proc_pid_stat+7f/492>
00000000 <_EIP>:
Code;  c0174f15 <proc_pid_stat+7f/492>   <=====
   0:   8b 48 3c                  mov    0x3c(%eax),%ecx   <=====
Code;  c0174f18 <proc_pid_stat+82/492>
   3:   85 c9                     test   %ecx,%ecx
Code;  c0174f1a <proc_pid_stat+84/492>
   5:   74 3e                     je     45 <_EIP+0x45>
Code;  c0174f1c <proc_pid_stat+86/492>
   7:   8b 81 98 00 00 00         mov    0x98(%ecx),%eax
Code;  c0174f22 <proc_pid_stat+8c/492>
   d:   89 84 24 d0 00 00 00      mov    %eax,0xd0(%esp,1)


1 warning and 1 error issued.  Results may not be reliable.
