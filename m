Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUGPDKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUGPDKZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 23:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266290AbUGPDKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 23:10:25 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:18641 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266195AbUGPDKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 23:10:12 -0400
Message-ID: <c0c067900407152010520b270e@mail.gmail.com>
Date: Thu, 15 Jul 2004 23:10:11 -0400
From: Dan Merillat <harik.attar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Bug report for Reiserfs on 2.6.4-rc2
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know 2.6.4-rc2 is old, but in case this hasn't already been found
and fixed I got nailed
by this.  I'm using reiserfs un a logical volume, and I recently
resized it (while it was having
pretty hefty IO)  I'm going to classify this as a "don't do that in
the future" type bug.  Also, I'm
upgrading to latest kernel.org.  So much for my 62 day uptime. :-)


Unable to handle kernel NULL pointer dereference at virtual address 00000000
c01948ba
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01948ba>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: 00000000   ecx: 00000028   edx: d09db000
esi: d09db140   edi: 00001000   ebp: cb65bb68   esp: cb65bb14
ds: 007b   es: 007b   ss: 0068
Stack: cb65bdf8 cedabc00 cebe8db0 00000001 cb65bb58 c01b18f0 cecda630 00004d3e 
       00001000 00000002 cb65bb10 00000018 00004d3d cecb3000 00000000 cedabc00 
       00000000 00000000 00000028 cb65bba4 00001000 cb65bbb4 c0194f1f cb65bdf8 
Call Trace: [<c011c11e>] recalc_task_prio+0x8e/0x1b0
 [<c01a3870>] reiserfs_file_write+0x0/0x88d
 [<c015893e>] vfs_write+0xce/0x140
 [<c0158a4f>] sys_write+0x3f/0x60
 [<c041caeb>] syscall_call+0x7/0xb
Code: 8b 45 08 8b 40 10 89 45 e8 8b 1b 8b 80 6c 01 00 00 8b 50 08 89 5d e4 ff 80
 e4 01 00 00 8d 34 ca 85 f6 0f 84 99 04 00 00 8b 46 04 <8b> 00 a8 04 0f 85 6d 04
 00 00 8b 4d 10 0f b7 16 3b 11 0f 8f 55 
Trace; c01b2250 <search_for_position_by_key+1a0/3c0>
Trace; c015da7b <alloc_buffer_head+3b/60>
Trace; c019c474 <make_cpu_key+54/60>
Trace; c01b0f93 <pathrelse+23/40>
Trace; c01a326d <reiserfs_prepare_file_region_for_write+36d/970>
Trace; c01a3870 <reiserfs_file_write+0/88d>
Trace; c01a3e5c <reiserfs_file_write+5ec/88d>
Trace; c011c2dc <try_to_wake_up+9cCode;  c0194895 <scan_bitmap_block+15/4f0>
   6:   89 45 e8                  mov    %eax,0xffffffe8(%ebp)
Code;  c0194898 <scan_bitmap_block+18/4f0>
   9:   8b 1b                     mov    (%ebx),%ebx
Code;  c019489a <scan_bitmap_block+1a/4f0>
   b:   8b 80 6c 01 00 00         mov    0x16c(%eax),%eax
Code;  c01948a0 <scan_bitmap_block+20/4f0>
  11:   8b 50 08                  mov    0x8(%eax),%edx
Code;  c01948a3 <scan_bitmap_block+23/4f0>
  14:   89 5d e4                  mov    %ebx,0xffffffe4(%ebp)
Code;  c01948a6 <scan_bitmap_block+26/4f0>
  17:   ff 80 e4 01 00 00         incl   0x1e4(%eax)
Code;  c01948ac <scan_bitmap_block+2c/4f0>
  1d:   8d 34 ca                  lea    (%edx,%ecx,8),%esi
Code;  c01948af <scan_bitmap_block+2f/4f0>
  20:   85 f6                     test   %esi,%esi
Code;  c01948b1 <scan_bitmap_block+31/4f0>
  22:   0f 84 99 04 00 00         je     4c1 <_EIP+0x4c1>
Code;  c01948b7 <scan_bitmap_block+37/4f0>
  28:   8b 46 04                  mov    0x4(%esi),%eax
/140>
Trace; c011c11e <recalc_task_prio+8e/1b0>
Trace; c01a3870 <reiserfs_file_write+0/88d>
Trace; c015893e <vfs_write+ce/140>
Trace; c0158a4f <sys_write+3f/60>
Trace; c041caeb <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c019488f <scan_bitmap_block+f/4f0>
00000000 <_EIP>:
Code;  c019488f <scan_bitmap_block+f/4f0>
   0:   8b 45 08                  mov    0x8(%ebp),%eax
Code;  c0194892 <scan_bitmap_block+12/4f0>
   3:   8b 40 10                  mov    0x10(%eax),%eax


>>EIP; c01948ba <scan_bitmap_block+3a/4f0>   <=====

>>edx; d09db000 <pg0+103d0000/3f9f2000>
>>esi; d09db140 <pg0+103d0140/3f9f2000>
>>ebp; cb65bb68 <pg0+b050b68/3f9f2000>
>>esp; cb65bb14 <pg0+b050b14/3f9f2000>

Trace; c01b18f0 <search_by_key+680/e40>
Trace; c0194f1f <scan_bitmap+1af/220>
Trace; c0195976 <reiserfs_allocate_blocknrs+1e6/7d0>
Trace; c01b9ad7 <journal_begin+27/30>
Trace; c01a1740 <reiserfs_allocate_blocks_for_region+1c0/14b0>
Trace; c01b1262 <is_tree_node+62/70>

 [<c01b18f0>] search_by_key+0x680/0xe40
 [<c0194f1f>] scan_bitmap+0x1af/0x220
 [<c0195976>] reiserfs_allocate_blocknrs+0x1e6/0x7d0
 [<c01b9ad7>] journal_begin+0x27/0x30
 [<c01a1740>] reiserfs_allocate_blocks_for_region+0x1c0/0x14b0
 [<c01b1262>] is_tree_node+0x62/0x70
 [<c01b2250>] search_for_position_by_key+0x1a0/0x3c0
 [<c015da7b>] alloc_buffer_head+0x3b/0x60
 [<c019c474>] make_cpu_key+0x54/0x60
 [<c01b0f93>] pathrelse+0x23/0x40
 [<c01a326d>] reiserfs_prepare_file_region_for_write+0x36d/0x970
 [<c01a3870>] reiserfs_file_write+0x0/0x88d
 [<c01a3e5c>] reiserfs_file_write+0x5ec/0x88d
 [<c011c2dc>] try_to_wake_up+0x9c/0x140
