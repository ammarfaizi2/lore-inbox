Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTEHCqG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 22:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbTEHCqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 22:46:06 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:24257 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S263025AbTEHCp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 22:45:59 -0400
Message-ID: <3EB9D4D0.2040900@blue-labs.org>
Date: Wed, 07 May 2003 23:53:52 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030504
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: OOPS garbage, spinlock issue, 2.5.69
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nessusd uses obsolete (PF_INET,SOCK_PACKET)
kernel/fork.c:136: spin_is_locked on uninitialized spinlock c2fd5dc0.
kernel/fork.c:136: spin_lock(
^P^B^G
^P^B[7m^X<F2>`<A0>
^P^Bc2fd5dc0) already locked by ^B/0
kernel/fork.c:138: spin_is_locked on uninitialized spinlock c2fd5dc0.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c2fd5ddf
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c2fd5ddf>]    Not tainted
EFLAGS: 00010286
EIP is at 0xc2fd5ddf
eax: 00000000   ebx: c4a1f8b8   ecx: 00b83ee8   edx: c4a1f700
esi: c052fa85   edi: 00000088   ebp: c2fd5dd8   esp: c2fd5dc0
ds: 007b   es: 007b   ss: 0068
Process nmap (pid: 29049, threadinfo=c2fd4000 task=ce310000)
Stack: 00000088 c052fa85 c2fd5dd8 c2fd5de0 c4a1f8b8 c4a1f700 00b83ee8 
00000000
       c4a1f700 0702100a 000060a0 0000f218 0000012b 0702100a c4a1f910 
c4a1f8b8
       c1e89520 00000000 00000000 0702100a 1b02100a 00000000 00000000 
00000000
Call Trace:
 [<c046f417>] inet_stream_connect+0x2e5/0x49c
 [<c040f381>] move_addr_to_kernel+0x6b/0x6f
 [<c0411141>] sys_connect+0x78/0x99
 [<c040f691>] sock_map_fd+0x118/0x12e
 [<c040f6c1>] sockfd_lookup+0x1a/0x72
 [<c041157c>] sys_setsockopt+0x6c/0xa0
 [<c0411c1a>] sys_socketcall+0xb2/0x262
 [<c010afaf>] syscall_call+0x7/0xb

Code: 00 00 f7 a1 c4 0a 10 02 07 a0 60 00 00 18 f2 00 00 2b 01 00
 <3>kernel/fork.c:136: spin_is_locked on uninitialized spinlock ca379dc0.
Unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:
c028a08e
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c028a08e>]    Not tainted
EFLAGS: 00010097
EIP is at vsnprintf+0x2de/0x44d
eax: 00000010   ebx: 0000000a   ecx: 00000010   edx: fffffffe
esi: c0687bba   edi: 00000000   ebp: c7d49d80   esp: c7d49d48
ds: 007b   es: 007b   ss: 0068
Process nmap (pid: 29202, threadinfo=c7d48000 task=c7af1980)
Stack: c0687b9e c0687f7f ca379dc0 00000000 00000010 00000008 00000007 
00000001
       ffffffff ffffffff c0687f7f c0687b80 00000046 00000296 c7d49dd0 
c012a85a
       c0687b80 00000400 c052848b c7d49df0 c7f924a4 c7d49dc0 c0123db7 
c35b9dbc
Call Trace:
 [<c012a85a>] printk+0x17a/0x3f8
 [<c0123db7>] __wake_up_common+0x38/0x57
 [<c0123856>] schedule+0x211/0x6d8
 [<c012662d>] remove_wait_queue+0x142/0x150
 [<c01df090>] devfs_d_revalidate_wait+0x22d/0x239
 [<c014ebd0>] find_get_page+0x7b/0x163
 [<c0123d6d>] default_wake_function+0x0/0x12
 [<c0123d6d>] default_wake_function+0x0/0x12
 [<c0188f30>] do_lookup+0x5c/0x98
 [<c018966f>] link_path_walk+0x703/0xda3
 [<c016276b>] handle_mm_fault+0x132/0x30c
 [<c018a614>] open_namei+0x7d/0x654
 [<c0156697>] check_poison_obj+0x3b/0x195
 [<c017467e>] filp_open+0x41/0x64
 [<c0187f50>] getname+0x8c/0xba
 [<c0174ea8>] sys_open+0x55/0x85
 [<c010afaf>] syscall_call+0x7/0xb

Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75
 <6>note: nmap[29202] exited with preempt_count 2
bad: scheduling while atomic!
Call Trace:
 [<c0123d18>] schedule+0x6d3/0x6d8
 [<c015f9cd>] unmap_page_range+0x41/0x67
 [<c015fbd5>] unmap_vmas+0x1e2/0x345
 [<c016570e>] exit_mmap+0xcc/0x2b3
 [<c0126ec2>] mmput+0xa7/0x134
 [<c012d09f>] do_exit+0x27d/0xaac
 [<c010c107>] do_divide_error+0x0/0xde
 [<c0121920>] do_page_fault+0x15c/0x4bf
 [<c016276b>] handle_mm_fault+0x132/0x30c
 [<c0122c65>] try_to_wake_up+0x32d/0x468
 [<c01217c4>] do_page_fault+0x0/0x4bf
 [<c010b9d9>] error_code+0x2d/0x38
 [<c028a08e>] vsnprintf+0x2de/0x44d
 [<c012a85a>] printk+0x17a/0x3f8
 [<c0123db7>] __wake_up_common+0x38/0x57
 [<c0123856>] schedule+0x211/0x6d8
 [<c012662d>] remove_wait_queue+0x142/0x150
 [<c01df090>] devfs_d_revalidate_wait+0x22d/0x239
 [<c014ebd0>] find_get_page+0x7b/0x163
 [<c0123d6d>] default_wake_function+0x0/0x12
 [<c0123d6d>] default_wake_function+0x0/0x12
 [<c0188f30>] do_lookup+0x5c/0x98
 [<c018966f>] link_path_walk+0x703/0xda3
 [<c016276b>] handle_mm_fault+0x132/0x30c
 [<c018a614>] open_namei+0x7d/0x654
 [<c0156697>] check_poison_obj+0x3b/0x195
 [<c017467e>] filp_open+0x41/0x64
 [<c0187f50>] getname+0x8c/0xba
 [<c0174ea8>] sys_open+0x55/0x85
 [<c010afaf>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c0123d18>] schedule+0x6d3/0x6d8
 [<c015f9cd>] unmap_page_range+0x41/0x67
 [<c015fbd5>] unmap_vmas+0x1e2/0x345
 [<c016570e>] exit_mmap+0xcc/0x2b3
 [<c0126ec2>] mmput+0xa7/0x134
 [<c012d09f>] do_exit+0x27d/0xaac
 [<c010c107>] do_divide_error+0x0/0xde
 [<c0121920>] do_page_fault+0x15c/0x4bf
 [<c016276b>] handle_mm_fault+0x132/0x30c
 [<c0122c65>] try_to_wake_up+0x32d/0x468
 [<c01217c4>] do_page_fault+0x0/0x4bf
 [<c010b9d9>] error_code+0x2d/0x38
 [<c028a08e>] vsnprintf+0x2de/0x44d
 [<c012a85a>] printk+0x17a/0x3f8
 [<c0123db7>] __wake_up_common+0x38/0x57
 [<c0123856>] schedule+0x211/0x6d8
 [<c012662d>] remove_wait_queue+0x142/0x150
 [<c01df090>] devfs_d_revalidate_wait+0x22d/0x239
 [<c014ebd0>] find_get_page+0x7b/0x163
 [<c0123d6d>] default_wake_function+0x0/0x12
 [<c0123d6d>] default_wake_function+0x0/0x12
 [<c0188f30>] do_lookup+0x5c/0x98
 [<c018966f>] link_path_walk+0x703/0xda3
 [<c016276b>] handle_mm_fault+0x132/0x30c
 [<c018a614>] open_namei+0x7d/0x654
 [<c0156697>] check_poison_obj+0x3b/0x195
 [<c017467e>] filp_open+0x41/0x64
 [<c0187f50>] getname+0x8c/0xba
 [<c0174ea8>] sys_open+0x55/0x85
 [<c010afaf>] syscall_call+0x7/0xb

(above repeats several times)


Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
 [<c01260bc>] __might_sleep+0x5f/0x73
 [<c015ea54>] clear_page_tables+0xa8/0xaa
 [<c01636ba>] remove_shared_vm_struct+0x3c/0x93
 [<c0165816>] exit_mmap+0x1d4/0x2b3
 [<c0126ec2>] mmput+0xa7/0x134
 [<c012d09f>] do_exit+0x27d/0xaac
 [<c010c107>] do_divide_error+0x0/0xde
 [<c0121920>] do_page_fault+0x15c/0x4bf
 [<c016276b>] handle_mm_fault+0x132/0x30c
 [<c0122c65>] try_to_wake_up+0x32d/0x468
 [<c01217c4>] do_page_fault+0x0/0x4bf
 [<c010b9d9>] error_code+0x2d/0x38
 [<c028a08e>] vsnprintf+0x2de/0x44d
 [<c012a85a>] printk+0x17a/0x3f8
 [<c0123db7>] __wake_up_common+0x38/0x57
 [<c0123856>] schedule+0x211/0x6d8
 [<c012662d>] remove_wait_queue+0x142/0x150
 [<c01df090>] devfs_d_revalidate_wait+0x22d/0x239
 [<c014ebd0>] find_get_page+0x7b/0x163
 [<c0123d6d>] default_wake_function+0x0/0x12
 [<c0123d6d>] default_wake_function+0x0/0x12
 [<c0188f30>] do_lookup+0x5c/0x98
 [<c018966f>] link_path_walk+0x703/0xda3
 [<c016276b>] handle_mm_fault+0x132/0x30c
 [<c018a614>] open_namei+0x7d/0x654
 [<c0156697>] check_poison_obj+0x3b/0x195
 [<c017467e>] filp_open+0x41/0x64
 [<c0187f50>] getname+0x8c/0xba
 [<c0174ea8>] sys_open+0x55/0x85
 [<c010afaf>] syscall_call+0x7/0xb


