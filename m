Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267810AbUHEQ7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267810AbUHEQ7i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUHEQ5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:57:38 -0400
Received: from mail5.criticalmass.com ([216.18.94.253]:18244 "EHLO
	mail5.criticalmass.com") by vger.kernel.org with ESMTP
	id S267806AbUHEQxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:53:38 -0400
Date: Thu, 5 Aug 2004 10:53:34 -0600
From: Joe Chamberlain <joec@criticalmass.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.7 Oops: kernel BUG at kernel/timer.c:155!
Message-Id: <20040805105334.1a6d1bcb.joec@criticalmass.com>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-why-are-you-reading-headers: Try this egg, incontinent bastard!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC: joec@criticalmass.com on replies

Chrooted bind 9.2.3 stopped serving requests, shortly afterwards the ssh
session stopped responding, machine was then power cycled.

Slackware-current 20030925
Linux version 2.6.7 (root@luna2) (gcc version 3.2.3) #1 Mon Jul 26
10:41:50 MDT 2004

The running kernel, the kernel that crashed and /usr/src/linux/vmlinux
are all one and the same (though I am booting from bzImage and not
vmlinux.) The kernel is compiled monolithically, there are no
(un)loadable modules.

I followed the instructions in Documentation/oops-tracing.txt but there
was 1 error and 1 warning:
...
Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
...
1 warning and 1 error issued.  Results may not be reliable.

ksymoops, syslog, ver_linux, dmesg, ioports, iomem, .config and others
are at: 
http://216.18.94.24/kernel/ksymoops_output.txt
http://216.18.94.24/kernel/syslog_snipped.txt
http://216.18.94.24/kernel/
Let me know if you want these files emailed to you.

This is a snip of ksymoops_output_notimestamps.txt:
 kernel BUG at kernel/timer.c:155!
 invalid operand: 0000 [#5]
 CPU:    0
 EIP:    0060:[<c01219a1>]    Not tainted
 EFLAGS: 00010246   (2.6.7) 
 eax: 00000000   ebx: cf5e65ac   ecx: 00001388   edx: cfc61fc0
 esi: cfc61fc0   edi: cf5e6604   ebp: 00000000   esp: cec17c68
 ds: 007b   es: 007b   ss: 0068
 Stack: ce83dd48 cec17eb0 00000000 cf5e65ac cfe944d8 cf5e6604 00000000
c01cb853         cfc61fc0 1bc85721 cfe944d8 cfe944d8 c01d3818 00000000
cfe944d8 c01cb945         cfe944d8 cf5e65ac 00000050 00000001 00000000
00000035 00000000 0000000a  Call Trace:
  [<c01cb853>] get_transaction+0x63/0xc0
  [<c01d3818>] __jbd_kmalloc+0x28/0x30
  [<c01cb945>] start_this_handle+0x95/0x400
  [<c023ee72>] copy_to_user+0x52/0x70
  [<c01cbda9>] journal_start+0xa9/0xd0
  [<c01c1a7c>] ext3_writepage_trans_blocks+0x1c/0x90
  [<c01bef4c>] ext3_prepare_write+0x3c/0x160
  [<c01359b0>] find_lock_page+0x30/0x100
  [<c01377ea>] generic_file_aio_write_nolock+0x3ca/0xb60
  [<c023ee72>] copy_to_user+0x52/0x70
  [<c030e72c>] move_addr_to_user+0x5c/0x70
  [<c013809f>] generic_file_aio_write+0x7f/0xa0
  [<c01bc5c4>] ext3_file_write+0x44/0xe0
  [<c0153f9b>] do_sync_write+0x8b/0xc0
  [<c01678d0>] __pollwait+0x0/0xd0
  [<c0168008>] sys_select+0x258/0x540
  [<c015408e>] vfs_write+0xbe/0x130
  [<c01541b2>] sys_write+0x42/0x70
  [<c010520b>] syscall_call+0x7/0xb
 Code: 0f 0b 9b 00 76 c2 39 c0 e9 a0 fe ff ff 89 f6 83 ec 14 31 c0 


>>EIP; c01219a1 <__mod_timer+171/180>   <=====

>>ebx; cf5e65ac <pg0+f1275ac/3fb3f000>
>>edx; cfc61fc0 <pg0+f7a2fc0/3fb3f000>
>>esi; cfc61fc0 <pg0+f7a2fc0/3fb3f000>
>>edi; cf5e6604 <pg0+f127604/3fb3f000>
>>esp; cec17c68 <pg0+e758c68/3fb3f000>

Trace; c01cb853 <get_transaction+63/c0>
Trace; c01d3818 <__jbd_kmalloc+28/30>
Trace; c01cb945 <start_this_handle+95/400>
Trace; c023ee72 <copy_to_user+52/70>
Trace; c01cbda9 <journal_start+a9/d0>
Trace; c01c1a7c <ext3_writepage_trans_blocks+1c/90>
Trace; c01bef4c <ext3_prepare_write+3c/160>
Trace; c01359b0 <find_lock_page+30/100>
Trace; c01377ea <generic_file_aio_write_nolock+3ca/b60>
Trace; c023ee72 <copy_to_user+52/70>
Trace; c030e72c <move_addr_to_user+5c/70>
Trace; c013809f <generic_file_aio_write+7f/a0>
Trace; c01bc5c4 <ext3_file_write+44/e0>
Trace; c0153f9b <do_sync_write+8b/c0>
Trace; c01678d0 <__pollwait+0/d0>
Trace; c0168008 <sys_select+258/540>
Trace; c015408e <vfs_write+be/130>
Trace; c01541b2 <sys_write+42/70>
Trace; c010520b <syscall_call+7/b>

Code;  c01219a1 <__mod_timer+171/180>
00000000 <_EIP>:
Code;  c01219a1 <__mod_timer+171/180>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01219a3 <__mod_timer+173/180>
   2:   9b                        fwait
Code;  c01219a4 <__mod_timer+174/180>
   3:   00 76 c2                  add    %dh,0xffffffc2(%esi)
Code;  c01219a7 <__mod_timer+177/180>
   6:   39 c0                     cmp    %eax,%eax
Code;  c01219a9 <__mod_timer+179/180>
   8:   e9 a0 fe ff ff            jmp    fffffead <_EIP+0xfffffead>
Code;  c01219ae <__mod_timer+17e/180>
   d:   89 f6                     mov    %esi,%esi
Code;  c01219b0 <add_timer_on+0/a0>
   f:   83 ec 14                  sub    $0x14,%esp
Code;  c01219b3 <add_timer_on+3/a0>
  12:   31 c0                     xor    %eax,%eax

  [<c0117ad7>] __might_sleep+0xb7/0xf0
  [<c011c37a>] do_exit+0xaa/0x420
  [<c0105e40>] do_invalid_op+0x0/0xe0
  [<c0105acc>] die+0xfc/0x100
  [<c0105f10>] do_invalid_op+0xd0/0xe0
  [<c01219a1>] __mod_timer+0x171/0x180
  [<c0321972>] nf_hook_slow+0xf2/0x130
  [<c032f840>] dst_output+0x0/0x30
  [<c032f2fa>] ip_push_pending_frames+0x3ca/0x430
  [<c032f840>] dst_output+0x0/0x30
  [<c01053b5>] error_code+0x2d/0x38
  [<c01219a1>] __mod_timer+0x171/0x180
  [<c01cb853>] get_transaction+0x63/0xc0
  [<c01d3818>] __jbd_kmalloc+0x28/0x30
  [<c01cb945>] start_this_handle+0x95/0x400
  [<c023ee72>] copy_to_user+0x52/0x70
  [<c01cbda9>] journal_start+0xa9/0xd0
  [<c01c1a7c>] ext3_writepage_trans_blocks+0x1c/0x90
  [<c01bef4c>] ext3_prepare_write+0x3c/0x160
  [<c01359b0>] find_lock_page+0x30/0x100
  [<c01377ea>] generic_file_aio_write_nolock+0x3ca/0xb60
  [<c023ee72>] copy_to_user+0x52/0x70
  [<c030e72c>] move_addr_to_user+0x5c/0x70
  [<c013809f>] generic_file_aio_write+0x7f/0xa0
  [<c01bc5c4>] ext3_file_write+0x44/0xe0
  [<c0153f9b>] do_sync_write+0x8b/0xc0
  [<c01678d0>] __pollwait+0x0/0xd0
  [<c0168008>] sys_select+0x258/0x540
  [<c015408e>] vfs_write+0xbe/0x130
  [<c01541b2>] sys_write+0x42/0x70
  [<c010520b>] syscall_call+0x7/0xb
  [<c038a237>] schedule+0x4b7/0x4c0
  [<c0143c63>] unmap_page_range+0x53/0x80
  [<c0143e50>] unmap_vmas+0x1c0/0x1d0
  [<c0148280>] exit_mmap+0x80/0x170
  [<c0118245>] mmput+0x65/0x90
  [<c011c463>] do_exit+0x193/0x420
  [<c0105e40>] do_invalid_op+0x0/0xe0
  [<c0105acc>] die+0xfc/0x100
  [<c0105f10>] do_invalid_op+0xd0/0xe0
  [<c01219a1>] __mod_timer+0x171/0x180
  [<c0321972>] nf_hook_slow+0xf2/0x130
  [<c032f840>] dst_output+0x0/0x30
  [<c032f2fa>] ip_push_pending_frames+0x3ca/0x430
  [<c032f840>] dst_output+0x0/0x30
  [<c01053b5>] error_code+0x2d/0x38
  [<c01219a1>] __mod_timer+0x171/0x180
  [<c01cb853>] get_transaction+0x63/0xc0
  [<c01d3818>] __jbd_kmalloc+0x28/0x30
  [<c01cb945>] start_this_handle+0x95/0x400
  [<c023ee72>] copy_to_user+0x52/0x70
  [<c01cbda9>] journal_start+0xa9/0xd0
  [<c01c1a7c>] ext3_writepage_trans_blocks+0x1c/0x90
  [<c01bef4c>] ext3_prepare_write+0x3c/0x160
  [<c01359b0>] find_lock_page+0x30/0x100
  [<c01377ea>] generic_file_aio_write_nolock+0x3ca/0xb60
  [<c023ee72>] copy_to_user+0x52/0x70
  [<c030e72c>] move_addr_to_user+0x5c/0x70
  [<c013809f>] generic_file_aio_write+0x7f/0xa0
  [<c01bc5c4>] ext3_file_write+0x44/0xe0
  [<c0153f9b>] do_sync_write+0x8b/0xc0
  [<c01678d0>] __pollwait+0x0/0xd0
  [<c0168008>] sys_select+0x258/0x540
  [<c015408e>] vfs_write+0xbe/0x130
  [<c01541b2>] sys_write+0x42/0x70
  [<c010520b>] syscall_call+0x7/0xb

Thank you for your time.
