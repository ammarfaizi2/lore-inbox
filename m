Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTKAW0l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 17:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTKAW0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 17:26:41 -0500
Received: from twix.hotpop.com ([204.57.55.70]:51924 "EHLO twix.hotpop.com")
	by vger.kernel.org with ESMTP id S261151AbTKAW0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 17:26:34 -0500
Message-ID: <3FA43200.5000703@hotpop.com>
Date: Sun, 02 Nov 2003 03:51:52 +0530
From: dacin <dacin@hotpop.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031005
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm1(bug in  fs/inode.c)
References: <20031030011810.633a8f5b.akpm@osdl.org>
In-Reply-To: <20031030011810.633a8f5b.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got an oops while doing some heavy file read/write operations on ext3 
fs on test9-mm1.

kernel BUG at fs/inode.c:1093!
invalid operand: 0000 [#1]
CPU: 0
EIP: 0060:[<02173fca>] Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 023075c0 ebx: 1052ce14 ecx: 023052d0 edx: 1991a000
esi: 20556400 edi: 1991a000 ebp: 1991be98 esp: 1991be8c
ds: 007b es: 007b ss: 0068
Stack: 0217a63a 21ce9b24 1052ce14 1991becc 0217a101 1052ce14 1991befc 
20556480
1991a000 1991a000 20556478 21ce9b24 001d14fa 20556400 1991a000 1991befc
1991bee8 0217a1ed 20556400 1991befc 1991befc 001d2882 00002857 1991bfa8
Call Trace:
[<0217a63a>] writeback_release+0x14/0x2e
[<0217a101>] sync_sb_inodes+0x1cb/0x25f
[<0217a1ed>] writeback_inodes+0x58/0xad
[<021430c2>] wb_kupdate+0xb5/0x134
[<02143b2c>] __pdflush+0x110/0x1f7
[<02143c13>] pdflush+0x0/0x15
[<02143c24>] pdflush+0x11/0x15
[<0214300d>] wb_kupdate+0x0/0x134
[<0210b275>] kernel_thread_helper+0x5/0xb
Code: 00 00 00 ba 3c 3f 17 02 8b 40 24 85 c0 74 08 8b 40 18 85 c0 0f 45 
d0 89 1c 24 ff d2 8b 5d fc 89 ec 5d c3 89 1c 24 ff 50 14 eb bb <0f> 0b 
45 04 3f 19 2d 02 eb a6 55 89 e5 83 ec 1c 8b 45 08 89 5d


 >>EIP; 02173fca <iput+72/7c> <=====

 >>eax; 023075c0 <ext3_sops+0/48>
 >>ebx; 1052ce14 <__crc_create_proc_ide_drives+4c4915/6d0acd>
 >>ecx; 023052d0 <inode_in_use+0/8>
 >>edx; 1991a000 <__crc_iget_locked+12eb2/2316c>
 >>esi; 20556400 <__crc_bio_init+2becf2/2c8bd0>
 >>edi; 1991a000 <__crc_iget_locked+12eb2/2316c>
 >>ebp; 1991be98 <__crc_iget_locked+14d4a/2316c>
 >>esp; 1991be8c <__crc_iget_locked+14d3e/2316c>

Trace; 0217a63a <writeback_release+14/2e>
Trace; 0217a101 <sync_sb_inodes+1cb/25f>
Trace; 0217a1ed <writeback_inodes+58/ad>
Trace; 021430c2 <wb_kupdate+b5/134>
Trace; 02143b2c <__pdflush+110/1f7>
Trace; 02143c13 <pdflush+0/15>
Trace; 02143c24 <pdflush+11/15>
Trace; 0214300d <wb_kupdate+0/134>
Trace; 0210b275 <kernel_thread_helper+5/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code; 02173f9f <iput+47/7c>
00000000 <_EIP>:
Code; 02173f9f <iput+47/7c>
0: 00 00 add %al,(%eax)
Code; 02173fa1 <iput+49/7c>
2: 00 ba 3c 3f 17 02 add %bh,0x2173f3c(%edx)
Code; 02173fa7 <iput+4f/7c>
8: 8b 40 24 mov 0x24(%eax),%eax
Code; 02173faa <iput+52/7c>
b: 85 c0 test %eax,%eax
Code; 02173fac <iput+54/7c>
d: 74 08 je 17 <_EIP+0x17>
Code; 02173fae <iput+56/7c>
f: 8b 40 18 mov 0x18(%eax),%eax
Code; 02173fb1 <iput+59/7c>
12: 85 c0 test %eax,%eax
Code; 02173fb3 <iput+5b/7c>
14: 0f 45 d0 cmovne %eax,%edx
Code; 02173fb6 <iput+5e/7c>
17: 89 1c 24 mov %ebx,(%esp,1)
Code; 02173fb9 <iput+61/7c>
1a: ff d2 call *%edx
Code; 02173fbb <iput+63/7c>
1c: 8b 5d fc mov 0xfffffffc(%ebp),%ebx
Code; 02173fbe <iput+66/7c>
1f: 89 ec mov %ebp,%esp
Code; 02173fc0 <iput+68/7c>
21: 5d pop %ebp
Code; 02173fc1 <iput+69/7c>
22: c3 ret
Code; 02173fc2 <iput+6a/7c>
23: 89 1c 24 mov %ebx,(%esp,1)
Code; 02173fc5 <iput+6d/7c>
26: ff 50 14 call *0x14(%eax)
Code; 02173fc8 <iput+70/7c>
29: eb bb jmp ffffffe6 <_EIP+0xffffffe6>

This decode from eip onwards should be reliable

Code; 02173fca <iput+72/7c>
00000000 <_EIP>:
Code; 02173fca <iput+72/7c> <=====
0: 0f 0b ud2a <=====
Code; 02173fcc <iput+74/7c>
2: 45 inc %ebp
Code; 02173fcd <iput+75/7c>
3: 04 3f add $0x3f,%al
Code; 02173fcf <iput+77/7c>
5: 19 2d 02 eb a6 55 sbb %ebp,0x55a6eb02
Code; 02173fd5 <bmap+1/59>
b: 89 e5 mov %esp,%ebp
Code; 02173fd7 <bmap+3/59>
d: 83 ec 1c sub $0x1c,%esp
Code; 02173fda <bmap+6/59>
10: 8b 45 08 mov 0x8(%ebp),%eax
Code; 02173fdd <bmap+9/59>
13: 89 .byte 0x89
Code; 02173fde <bmap+a/59>
14: 5d pop %ebp

2 warnings issued. Results may not be reliable.

===========================================================================================================

Unable to handle kernel NULL pointer dereference at virtual address 00000064
02179fb9
*pde = 00000000
Oops: 0000 [#1]
CPU: 0
EIP: 0060:[<02179fb9>] Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010287
eax: 20cb4080 ebx: 13290d14 ecx: 13290d1c edx: 00000001
esi: 20cb4000 edi: 00000000 ebp: 21d19ecc esp: 21d19ea0
ds: 007b es: 007b ss: 0068
Stack: 182a7414 21d19efc 20cb4080 21d18000 21d18000 20cb4078 21ce9924 
001b3ea2
20cb4000 21d18000 21d19efc 21d19ee8 0217a1ed 20cb4000 21d19efc 21d19efc
001b522a 0000b548 21d19fa8 021430c2 21d19efc 001b3ea2 001ac972 00000000
Call Trace:
[<0217a1ed>] writeback_inodes+0x58/0xad
[<021430c2>] wb_kupdate+0xb5/0x134
[<02143b2c>] __pdflush+0x110/0x1f7
[<02143c13>] pdflush+0x0/0x15
[<02143c24>] pdflush+0x11/0x15
[<0214300d>] wb_kupdate+0x0/0x134
[<0210b275>] kernel_thread_helper+0x5/0xb
Code: 80 00 00 00 89 49 04 3b 5d dc 74 34 8d 46 78 ba 00 e0 ff ff 21 e2 
89 45 e8 89 55 e0 8b 8e 84 00 00 00 8d 59 f8 8b bb 9c 00 00 00 <8b> 47 
64 89 45 ec 8b 40 08 85 c0 74 38 3b 35 68 f2 3a 02 74 08


 >>EIP; 02179fb9 <sync_sb_inodes+83/25f> <=====

 >>eax; 20cb4080 <__crc_scsi_block_requests+104e3e/2478b4>
 >>ebx; 13290d14 <__crc_ide_add_proc_entries+27f121/2cd7f1>
 >>ecx; 13290d1c <__crc_ide_add_proc_entries+27f129/2cd7f1>
 >>esi; 20cb4000 <__crc_scsi_block_requests+104dbe/2478b4>
 >>ebp; 21d19ecc <__crc_per_cpu__kstat+4b924b/55f2c4>
 >>esp; 21d19ea0 <__crc_per_cpu__kstat+4b921f/55f2c4>

Trace; 0217a1ed <writeback_inodes+58/ad>
Trace; 021430c2 <wb_kupdate+b5/134>
Trace; 02143b2c <__pdflush+110/1f7>
Trace; 02143c13 <pdflush+0/15>
Trace; 02143c24 <pdflush+11/15>
Trace; 0214300d <wb_kupdate+0/134>
Trace; 0210b275 <kernel_thread_helper+5/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code; 02179f8e <sync_sb_inodes+58/25f>
00000000 <_EIP>:
Code; 02179f8e <sync_sb_inodes+58/25f>
0: 80 00 00 addb $0x0,(%eax)
Code; 02179f91 <sync_sb_inodes+5b/25f>
3: 00 89 49 04 3b 5d add %cl,0x5d3b0449(%ecx)
Code; 02179f97 <sync_sb_inodes+61/25f>
9: dc 74 34 8d fdivl 0xffffff8d(%esp,%esi,1)
Code; 02179f9b <sync_sb_inodes+65/25f>
d: 46 inc %esi
Code; 02179f9c <sync_sb_inodes+66/25f>
e: 78 ba js ffffffca <_EIP+0xffffffca>
Code; 02179f9e <sync_sb_inodes+68/25f>
10: 00 e0 add %ah,%al
Code; 02179fa0 <sync_sb_inodes+6a/25f>
12: ff (bad)
Code; 02179fa1 <sync_sb_inodes+6b/25f>
13: ff 21 jmp *(%ecx)
Code; 02179fa3 <sync_sb_inodes+6d/25f>
15: e2 89 loop ffffffa0 <_EIP+0xffffffa0>
Code; 02179fa5 <sync_sb_inodes+6f/25f>
17: 45 inc %ebp
Code; 02179fa6 <sync_sb_inodes+70/25f>
18: e8 89 55 e0 8b call 8be055a6 <_EIP+0x8be055a6>
Code; 02179fab <sync_sb_inodes+75/25f>
1d: 8e 84 00 00 00 8d 59 movl 0x598d0000(%eax,%eax,1),%es
Code; 02179fb2 <sync_sb_inodes+7c/25f>
24: f8 clc
Code; 02179fb3 <sync_sb_inodes+7d/25f>
25: 8b bb 9c 00 00 00 mov 0x9c(%ebx),%edi

This decode from eip onwards should be reliable

Code; 02179fb9 <sync_sb_inodes+83/25f>
00000000 <_EIP>:
Code; 02179fb9 <sync_sb_inodes+83/25f> <=====
0: 8b 47 64 mov 0x64(%edi),%eax <=====
Code; 02179fbc <sync_sb_inodes+86/25f>
3: 89 45 ec mov %eax,0xffffffec(%ebp)
Code; 02179fbf <sync_sb_inodes+89/25f>
6: 8b 40 08 mov 0x8(%eax),%eax
Code; 02179fc2 <sync_sb_inodes+8c/25f>
9: 85 c0 test %eax,%eax
Code; 02179fc4 <sync_sb_inodes+8e/25f>
b: 74 38 je 45 <_EIP+0x45>
Code; 02179fc6 <sync_sb_inodes+90/25f>
d: 3b 35 68 f2 3a 02 cmp 0x23af268,%esi
Code; 02179fcc <sync_sb_inodes+96/25f>
13: 74 08 je 1d <_EIP+0x1d>

Call Trace:
[<02120a7b>] __might_sleep+0xb8/0xd9
[<02123c3a>] profile_exit_task+0x22/0x5e
[<021253fa>] do_exit+0x7b/0x403
[<0211cb21>] do_page_fault+0x0/0x570
[<0210d95e>] do_divide_error+0x0/0xdd
[<0211cd04>] do_page_fault+0x1e3/0x570
[<02161e95>] blkdev_writepage+0x20/0x24
[<02161d32>] blkdev_get_block+0x0/0x53
[<0217b8d2>] mpage_writepages+0x257/0x349
[<02161e75>] blkdev_writepage+0x0/0x24
[<0211cb21>] do_page_fault+0x0/0x570
[<0217007b>] fcntl_getlk64+0x159/0x1a4
[<02179fb9>] sync_sb_inodes+0x83/0x25f
[<0217a1ed>] writeback_inodes+0x58/0xad
[<021430c2>] wb_kupdate+0xb5/0x134
[<02143b2c>] __pdflush+0x110/0x1f7
[<02143c13>] pdflush+0x0/0x15
[<02143c24>] pdflush+0x11/0x15
[<0214300d>] wb_kupdate+0x0/0x134
[<0210b275>] kernel_thread_helper+0x5/0xb
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; 02120a7b <__might_sleep+b8/d9>
Trace; 02123c3a <profile_exit_task+22/5e>
Trace; 021253fa <do_exit+7b/403>
Trace; 0211cb21 <do_page_fault+0/570>
Trace; 0210d95e <do_divide_error+0/dd>
Trace; 0211cd04 <do_page_fault+1e3/570>
Trace; 02161e95 <blkdev_writepage+20/24>
Trace; 02161d32 <blkdev_get_block+0/53>
Trace; 0217b8d2 <mpage_writepages+257/349>
Trace; 02161e75 <blkdev_writepage+0/24>
Trace; 0211cb21 <do_page_fault+0/570>
Trace; 0217007b <fcntl_getlk64+159/1a4>
Trace; 02179fb9 <sync_sb_inodes+83/25f>
Trace; 0217a1ed <writeback_inodes+58/ad>
Trace; 021430c2 <wb_kupdate+b5/134>
Trace; 02143b2c <__pdflush+110/1f7>
Trace; 02143c13 <pdflush+0/15>
Trace; 02143c24 <pdflush+11/15>
Trace; 0214300d <wb_kupdate+0/134>
Trace; 0210b275 <kernel_thread_helper+5/b>


3 warnings issued. Results may not be reliable.




