Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265323AbTFRToD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 15:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265257AbTFRToD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 15:44:03 -0400
Received: from 4.54.252.64.snet.net ([64.252.54.4]:38880 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S265323AbTFRTny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 15:43:54 -0400
Message-ID: <3EF0C422.2060207@blue-labs.org>
Date: Wed, 18 Jun 2003 15:57:22 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.72 spinlock problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nessusd uses obsolete (PF_INET,SOCK_PACKET)
kernel/fork.c:140: spin_is_locked on uninitialized spinlock cd6abdc0.
Unable to handle kernel NULL pointer dereference at virtual address 000000f0
 printing eip:
c0296aaa
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0296aaa>]    Not tainted
EFLAGS: 00210097
EIP is at vsnprintf+0x2de/0x44d
eax: 000000f0   ebx: 0000000a   ecx: 000000f0   edx: fffffffe
esi: c06a6abe   edi: 00000000   ebp: cc12dd80   esp: cc12dd48
ds: 007b   es: 007b   ss: 0068
Process nmap (pid: 10403, threadinfo=cc12c000 task=cea8ca00)
Stack: c06a6aa2 c06a6e7f cd6abdc0 00000000 00000010 00000008 00000007 
00000001
       ffffffff ffffffff c06a6e7f cd6abdc0 00200046 00200296 cc12ddd0 
c012bb25
       c06a6a80 00000400 c05409cb cc12ddf0 c036ca80 c06ced3c cb6243b8 
c13026cc
Call Trace:
 [<c012bb25>] printk+0x175/0x3f8
 [<c036ca80>] ide_build_sglist+0x40/0xac
 [<c0297504>] __delay+0x14/0x18
 [<c01248a5>] schedule+0x222/0x6e9
 [<c01278c3>] remove_wait_queue+0x15c/0x161
 [<c01e4364>] devfs_d_revalidate_wait+0x22d/0x239
 [<c036cea7>] dma_timer_expiry+0x0/0xd7
 [<c0124dbc>] default_wake_function+0x0/0x2e
 [<c0124dbc>] default_wake_function+0x0/0x2e
 [<c018dd28>] do_lookup+0x5c/0x98
 [<c018e467>] link_path_walk+0x703/0xda3
 [<c0356ade>] start_request+0x177/0x285
 [<c0355872>] ide_end_request+0x142/0x281
 [<c0356ec1>] ide_do_request+0x2af/0x5a1
 [<c018f40c>] open_namei+0x7d/0x654
 [<c01596b8>] check_poison_obj+0x3b/0x195
 [<c0177fa6>] filp_open+0x41/0x64
 [<c018cd48>] getname+0x8c/0xba
 [<c01787ca>] sys_open+0x55/0x85
 [<c010af8f>] syscall_call+0x7/0xb

Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75
 <6>note: nmap[10403] exited with preempt_count 2
bad: scheduling while atomic!
Call Trace:
 [<c0124d67>] schedule+0x6e4/0x6e9
 [<c016339d>] unmap_page_range+0x41/0x67
 [<c01635a5>] unmap_vmas+0x1e2/0x345
 [<c01690ab>] exit_mmap+0xcc/0x2b3
 [<c012816b>] mmput+0xb8/0x145
 [<c012e492>] do_exit+0x27d/0xaac
 [<c010c10b>] do_divide_error+0x0/0xde
 [<c0122af4>] do_page_fault+0x15c/0x4b7
 [<c016556d>] do_anonymous_page+0x270/0x5f6
 [<c01660da>] handle_mm_fault+0x132/0x30c
 [<c0122998>] do_page_fault+0x0/0x4b7
 [<c010b9b9>] error_code+0x2d/0x38
 [<c0296aaa>] vsnprintf+0x2de/0x44d
 [<c012bb25>] printk+0x175/0x3f8
 [<c036ca80>] ide_build_sglist+0x40/0xac
 [<c0297504>] __delay+0x14/0x18
 [<c01248a5>] schedule+0x222/0x6e9
 [<c01278c3>] remove_wait_queue+0x15c/0x161
 [<c01e4364>] devfs_d_revalidate_wait+0x22d/0x239
 [<c036cea7>] dma_timer_expiry+0x0/0xd7
 [<c0124dbc>] default_wake_function+0x0/0x2e
 [<c0124dbc>] default_wake_function+0x0/0x2e
 [<c018dd28>] do_lookup+0x5c/0x98
 [<c018e467>] link_path_walk+0x703/0xda3
 [<c0356ade>] start_request+0x177/0x285
 [<c0355872>] ide_end_request+0x142/0x281
 [<c0356ec1>] ide_do_request+0x2af/0x5a1
 [<c018f40c>] open_namei+0x7d/0x654
 [<c01596b8>] check_poison_obj+0x3b/0x195
 [<c0177fa6>] filp_open+0x41/0x64
 [<c018cd48>] getname+0x8c/0xba
 [<c01787ca>] sys_open+0x55/0x85
 [<c010af8f>] syscall_call+0x7/0xb

(repeats several times)

Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
 [<c0127339>] __might_sleep+0x5f/0x72
 [<c0162430>] clear_page_tables+0xa8/0xaa
 [<c0167041>] remove_shared_vm_struct+0x3c/0x93
 [<c01691b3>] exit_mmap+0x1d4/0x2b3
 [<c012816b>] mmput+0xb8/0x145
 [<c012e492>] do_exit+0x27d/0xaac
 [<c010c10b>] do_divide_error+0x0/0xde
 [<c0122af4>] do_page_fault+0x15c/0x4b7
 [<c016556d>] do_anonymous_page+0x270/0x5f6
 [<c01660da>] handle_mm_fault+0x132/0x30c
 [<c0122998>] do_page_fault+0x0/0x4b7
 [<c010b9b9>] error_code+0x2d/0x38
 [<c0296aaa>] vsnprintf+0x2de/0x44d
 [<c012bb25>] printk+0x175/0x3f8
 [<c036ca80>] ide_build_sglist+0x40/0xac
 [<c0297504>] __delay+0x14/0x18
 [<c01248a5>] schedule+0x222/0x6e9
 [<c01278c3>] remove_wait_queue+0x15c/0x161
 [<c01e4364>] devfs_d_revalidate_wait+0x22d/0x239
 [<c036cea7>] dma_timer_expiry+0x0/0xd7
 [<c0124dbc>] default_wake_function+0x0/0x2e
 [<c0124dbc>] default_wake_function+0x0/0x2e
 [<c018dd28>] do_lookup+0x5c/0x98
 [<c018e467>] link_path_walk+0x703/0xda3
 [<c0356ade>] start_request+0x177/0x285
 [<c0355872>] ide_end_request+0x142/0x281
 [<c0356ec1>] ide_do_request+0x2af/0x5a1
 [<c018f40c>] open_namei+0x7d/0x654
 [<c01596b8>] check_poison_obj+0x3b/0x195
 [<c0177fa6>] filp_open+0x41/0x64
 [<c018cd48>] getname+0x8c/0xba
 [<c01787ca>] sys_open+0x55/0x85
 [<c010af8f>] syscall_call+0x7/0xb


