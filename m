Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266072AbUBPXXo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266051AbUBPXWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:22:51 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:39100 "EHLO
	mwinf0304.wanadoo.fr") by vger.kernel.org with ESMTP
	id S266049AbUBPXWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:22:32 -0500
Subject: kernel 2.6.2 hard freeze (bsd process accounting related ?)
From: Thomas Cataldo <tomc@compaqnet.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1076973745.2805.8.camel@buffy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 17 Feb 2004 00:22:25 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My boxe (P3 smp without preempt) freezed after 3 days of uptime with
plain 2.6.2 (+ the acx100 gpl'ed driver). Here's what I have got in my
kern.log.

Tell me if I you need more information.

Here is the last oops (my logs are full of those) :

Feb 16 23:48:07 buffy kernel: Code: 0f bf 50 5c 0f bf 40 5e c1 e2 14 09 c2 01 da 89 d0 c1 e8 14 
Feb 16 23:48:07 buffy kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 0000019e
Feb 16 23:48:07 buffy kernel:  printing eip:
Feb 16 23:48:07 buffy kernel: c0137586
Feb 16 23:48:07 buffy kernel: *pde = 00000000
Feb 16 23:48:07 buffy kernel: Oops: 0000 [#17]
Feb 16 23:48:07 buffy kernel: CPU:    0
Feb 16 23:48:07 buffy kernel: EIP:    0060:[<c0137586>]    Not tainted
Feb 16 23:48:07 buffy kernel: EFLAGS: 00210286
Feb 16 23:48:07 buffy kernel: EIP is at do_acct_process+0x116/0x2a0
Feb 16 23:48:07 buffy kernel: eax: 00000142   ebx: 4005bad0   ecx: c8ab7000   edx: 00000011
Feb 16 23:48:07 buffy kernel: esi: 00000782   edi: 00000000   ebp: c56d7d00   esp: e82a85a4
Feb 16 23:48:07 buffy kernel: ds: 007b   es: 007b   ss: 0068
Feb 16 23:48:07 buffy kernel: Process mysqld (pid: 17327, threadinfo=e82a8000 task=e56c3350)
Feb 16 23:48:07 buffy kernel: Stack: 00000011 e56c365a 00000011 00000000 006c0000 000003ec 40314125 00110000 
Feb 16 23:48:07 buffy kernel:        00006eac 00000000 00000000 00000000 00000000 7173796d 0000646c 00000000 
Feb 16 23:48:07 buffy kernel:        00000000 00000000 00000000 00000000 c56d7d00 eb875dc0 e56c3350 0000000b 
Feb 16 23:48:07 buffy kernel: Call Trace:
Feb 16 23:48:07 buffy kernel:  [<c0137753>] acct_process+0x43/0x68
Feb 16 23:48:07 buffy kernel:  [<c0121455>] do_exit+0x75/0x370
Feb 16 23:48:07 buffy kernel:  [<c010a1c0>] do_divide_error+0x0/0x100
Feb 16 23:48:07 buffy kernel:  [<c01189e3>] do_page_fault+0x283/0x541
Feb 16 23:48:07 buffy kernel:  [<c0136bfe>] __print_symbol+0x12e/0x170
Feb 16 23:48:07 buffy kernel:  [<c0136b0f>] __print_symbol+0x3f/0x170
Feb 16 23:48:07 buffy kernel:  [<c01090af>] syscall_call+0x7/0xb
Feb 16 23:48:07 buffy kernel:  [<c0127636>] update_wall_time+0x16/0x40
Feb 16 23:48:07 buffy kernel:  [<c01197a8>] recalc_task_prio+0xa8/0x1d0
Feb 16 23:48:07 buffy kernel:  [<c0118760>] do_page_fault+0x0/0x541
Feb 16 23:48:07 buffy kernel:  [<c0109b19>] error_code+0x2d/0x38
Feb 16 23:48:07 buffy kernel:  [<c0137586>] do_acct_process+0x116/0x2a0
Feb 16 23:48:07 buffy kernel:  [<c0137753>] acct_process+0x43/0x68
Feb 16 23:48:07 buffy kernel:  [<c0121455>] do_exit+0x75/0x370
Feb 16 23:48:07 buffy kernel:  [<c010a1c0>] do_divide_error+0x0/0x100
Feb 16 23:48:07 buffy kernel:  [<c01189e3>] do_page_fault+0x283/0x541
Feb 16 23:48:07 buffy kernel:  [<c0136bfe>] __print_symbol+0x12e/0x170
Feb 16 23:48:07 buffy kernel:  [<c0136b0f>] __print_symbol+0x3f/0x170
Feb 16 23:48:07 buffy kernel:  [<c01090af>] syscall_call+0x7/0xb
Feb 16 23:48:07 buffy kernel:  [<c0127636>] update_wall_time+0x16/0x40
Feb 16 23:48:07 buffy kernel:  [<c0118760>] do_page_fault+0x0/0x541
Feb 16 23:48:07 buffy kernel:  [<c0109b19>] error_code+0x2d/0x38
Feb 16 23:48:07 buffy kernel:  [<c0137586>] do_acct_process+0x116/0x2a0
Feb 16 23:48:07 buffy kernel:  [<c0137753>] acct_process+0x43/0x68
Feb 16 23:48:07 buffy kernel:  [<c0121455>] do_exit+0x75/0x370
Feb 16 23:48:07 buffy kernel:  [<c010a1c0>] do_divide_error+0x0/0x100
Feb 16 23:48:07 buffy kernel:  [<c01189e3>] do_page_fault+0x283/0x541
Feb 16 23:48:07 buffy kernel:  [<c0136bfe>] __print_symbol+0x12e/0x170
Feb 16 23:48:07 buffy kernel:  [<c0136b0f>] __print_symbol+0x3f/0x170
Feb 16 23:48:07 buffy kernel:  [<c01090af>] syscall_call+0x7/0xb
Feb 16 23:48:07 buffy kernel:  [<c0127636>] update_wall_time+0x16/0x40
Feb 16 23:48:07 buffy kernel:  [<c01197a8>] recalc_task_prio+0xa8/0x1d0
Feb 16 23:48:07 buffy kernel:  [<c0118760>] do_page_fault+0x0/0x541
Feb 16 23:48:07 buffy kernel:  [<c0109b19>] error_code+0x2d/0x38
Feb 16 23:48:07 buffy kernel:  [<c0137586>] do_acct_process+0x116/0x2a0


Here is the first 2 oopes (hope that is relevant) :

Feb 16 23:48:06 buffy kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000019e
Feb 16 23:48:06 buffy kernel:  printing eip:
Feb 16 23:48:06 buffy kernel: c0137586
Feb 16 23:48:06 buffy kernel: *pde = 00000000
Feb 16 23:48:06 buffy kernel: Oops: 0000 [#1]
Feb 16 23:48:06 buffy kernel: CPU:    0
Feb 16 23:48:06 buffy kernel: EIP:    0060:[<c0137586>]    Not tainted
Feb 16 23:48:06 buffy kernel: EFLAGS: 00210286
Feb 16 23:48:06 buffy kernel: EIP is at do_acct_process+0x116/0x2a0
Feb 16 23:48:06 buffy kernel: eax: 00000142   ebx: 4005bad0   ecx: c8ab7000   edx: 00000000
Feb 16 23:48:06 buffy kernel: esi: 00000782   edi: 00000000   ebp: c56d7d00   esp: e82a9f24
Feb 16 23:48:06 buffy kernel: ds: 007b   es: 007b   ss: 0068
Feb 16 23:48:06 buffy kernel: Process mysqld (pid: 17327, threadinfo=e82a8000 task=e56c3350)
Feb 16 23:48:06 buffy kernel: Stack: 00000000 e56c365a 00000011 e82a9f4c 006c0000 000003ec 40314124 00000000 
Feb 16 23:48:06 buffy kernel:        00006eab 00000000 00000000 00000000 00000000 7173796d 0000646c 00000000 
Feb 16 23:48:06 buffy kernel:        00000000 00000000 00000000 00000000 c56d7d00 ffffffdc e56c3350 00000000 
Feb 16 23:48:06 buffy kernel: Call Trace:
Feb 16 23:48:06 buffy kernel:  [<c0137753>] acct_process+0x43/0x68
Feb 16 23:48:06 buffy kernel:  [<c0121455>] do_exit+0x75/0x370
Feb 16 23:48:06 buffy kernel:  [<c0121783>] sys_exit+0x13/0x20
Feb 16 23:48:06 buffy kernel:  [<c01090af>] syscall_call+0x7/0xb
Feb 16 23:48:06 buffy kernel: 
Feb 16 23:48:06 buffy kernel: Code: 0f bf 50 5c 0f bf 40 5e c1 e2 14 09 c2 01 da 89 d0 c1 e8 14 
Feb 16 23:48:06 buffy kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 0000019e
Feb 16 23:48:06 buffy kernel:  printing eip:
Feb 16 23:48:06 buffy kernel: c0137586
Feb 16 23:48:06 buffy kernel: *pde = 00000000
Feb 16 23:48:06 buffy kernel: Oops: 0000 [#2]
Feb 16 23:48:06 buffy kernel: CPU:    0
Feb 16 23:48:06 buffy kernel: EIP:    0060:[<c0137586>]    Not tainted
Feb 16 23:48:06 buffy kernel: EFLAGS: 00210286
Feb 16 23:48:06 buffy kernel: EIP is at do_acct_process+0x116/0x2a0
Feb 16 23:48:06 buffy kernel: eax: 00000142   ebx: 4005bad0   ecx: c8ab7000   edx: 00000001
Feb 16 23:48:06 buffy kernel: esi: 00000782   edi: 00000000   ebp: c56d7d00   esp: e82a9d8c
Feb 16 23:48:06 buffy kernel: ds: 007b   es: 007b   ss: 0068
Feb 16 23:48:06 buffy kernel: Process mysqld (pid: 17327, threadinfo=e82a8000 task=e56c3350)
Feb 16 23:48:06 buffy kernel: Stack: 00000001 e56c365a 00000011 00000000 006c0000 000003ec 40314124 00010000 
Feb 16 23:48:06 buffy kernel:        00006eab 00000000 00000000 00000000 00000000 7173796d 0000646c 00000000 
Feb 16 23:48:06 buffy kernel:        00000000 00000000 00000000 00000000 c56d7d00 eb875dc0 e56c3350 0000000b 
Feb 16 23:48:06 buffy kernel: Call Trace:
Feb 16 23:48:06 buffy kernel:  [<c0137753>] acct_process+0x43/0x68
Feb 16 23:48:06 buffy kernel:  [<c0121455>] do_exit+0x75/0x370
Feb 16 23:48:06 buffy kernel:  [<c010a1c0>] do_divide_error+0x0/0x100
Feb 16 23:48:06 buffy kernel:  [<c01189e3>] do_page_fault+0x283/0x541
Feb 16 23:48:06 buffy kernel:  [<c011b12a>] schedule+0x3ea/0x670
Feb 16 23:48:06 buffy kernel:  [<c0127c2e>] schedule_timeout+0xbe/0xc0
Feb 16 23:48:06 buffy kernel:  [<c0133124>] unqueue_me+0x54/0x70
Feb 16 23:48:06 buffy kernel:  [<c0118760>] do_page_fault+0x0/0x541
Feb 16 23:48:06 buffy kernel:  [<c0109b19>] error_code+0x2d/0x38
Feb 16 23:48:06 buffy kernel:  [<c0137586>] do_acct_process+0x116/0x2a0
Feb 16 23:48:06 buffy kernel:  [<c0137753>] acct_process+0x43/0x68
Feb 16 23:48:06 buffy kernel:  [<c0121455>] do_exit+0x75/0x370
Feb 16 23:48:06 buffy kernel:  [<c0121783>] sys_exit+0x13/0x20
Feb 16 23:48:06 buffy kernel:  [<c01090af>] syscall_call+0x7/0xb
Feb 16 23:48:06 buffy kernel: 


