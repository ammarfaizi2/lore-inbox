Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRA3Tgr>; Tue, 30 Jan 2001 14:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129818AbRA3Tgh>; Tue, 30 Jan 2001 14:36:37 -0500
Received: from apop.jaist.ac.jp ([150.65.7.20]:29178 "EHLO
	mailspool.jaist.ac.jp") by vger.kernel.org with ESMTP
	id <S129669AbRA3TgX>; Tue, 30 Jan 2001 14:36:23 -0500
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.1
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Capitol Reef)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010131043618E.amatsus@jaist.ac.jp>
Date: Wed, 31 Jan 2001 04:36:18 +0900
From: MATSUSHIMA Akihiro <amatsus@jaist.ac.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

When I boot my system (Vine Linux 2.1), my system crashes.
This oops is reproducable with the kernels: 2.4.0-ac11,
2.4.0-ac12 and 2.4.1(probably all >= 2.4.0-ac).
The decoded oops follows:

---------
ksymoops 2.3.7 on i586 2.4.1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1/ (default)
     -m /usr/src/linux/System.map (default)

Unable to handle kernel NULL pointer dereference at virtual address 00000008
c4c188dc
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c4c188dc>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: c3d01dec   ecx: c3d01ea0   edx: 00000000
esi: c3e47000   edi: c3d01e54   ebp: c3d01eb4   esp: c3d01d64
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 69, stackpage=c3d01000)
Stack: c3d01dec c3e47000 c3d01e54 c3d01eb4 00000001 c0149d9b c11db060 00000001 
       c3d01de4 c3d01eb0 c11db060 c4c19328 c119c000 c3d01de0 c3d01de4 c3d01de8 
       c3d01ea0 c3d01e54 c3d01dec c3e47000 00000301 c119c000 00000000 c3d01f28 
Call Trace: [<c0149d9b>] [<c4c19328>] [<c0149d9b>] [<c013f24f>] [<c01401d6>] [<c0134714>] [<c01
291e3>] 
       [<c01263a7>] [<c4c21860>] [<c4c21860>] [<c4c21236>] [<c4c21820>] [<c013244a>] [<c013266c
>] [<c4c21860>] 
       [<c4c21860>] [<c01331b5>] [<c4c21860>] [<c0132fec>] [<c013336c>] [<c0108d43>] 
Code: 0f b7 40 08 66 89 41 08 80 61 13 f7 8a 41 12 66 c7 41 0a 00 

>>EIP; c4c188dc <[fat]parse_options+3d/7f4>   <=====
Trace; c0149d9b <ext2_get_block+23/480>
Trace; c4c19328 <[fat]fat_read_super+da/8c0>
Trace; c0149d9b <ext2_get_block+23/480>
Trace; c013f24f <destroy_inode+2f/34>
Trace; c01401d6 <iput+14e/154>
Trace; c0134714 <blkdev_get+f8/114>
Trace; c01291e3 <__alloc_pages+db/2d0>
Trace; c01263a7 <kmem_cache_grow+db/220>
Trace; c4c21860 <[vfat]vfat_fs_type+0/17>
Trace; c4c21860 <[vfat]vfat_fs_type+0/17>
Trace; c4c21236 <[vfat]vfat_read_super+22/84>
Trace; c4c21820 <[vfat]vfat_dir_inode_operations+0/40>
Trace; c013244a <read_super+fe/170>
Trace; c013266c <get_sb_bdev+150/1a8>
Trace; c4c21860 <[vfat]vfat_fs_type+0/17>
Trace; c4c21860 <[vfat]vfat_fs_type+0/17>
Trace; c01331b5 <do_mount+179/2b4>
Trace; c4c21860 <[vfat]vfat_fs_type+0/17>
Trace; c0132fec <copy_mount_options+50/a0>
Trace; c013336c <sys_mount+7c/c0>
Trace; c0108d43 <system_call+33/40>
Code;  c4c188dc <[fat]parse_options+3d/7f4>
00000000 <_EIP>:
Code;  c4c188dc <[fat]parse_options+3d/7f4>   <=====
   0:   0f b7 40 08               movzwl 0x8(%eax),%eax   <=====
Code;  c4c188e0 <[fat]parse_options+41/7f4>
   4:   66 89 41 08               mov    %ax,0x8(%ecx)
Code;  c4c188e4 <[fat]parse_options+45/7f4>
   8:   80 61 13 f7               andb   $0xf7,0x13(%ecx)
Code;  c4c188e8 <[fat]parse_options+49/7f4>
   c:   8a 41 12                  mov    0x12(%ecx),%al
Code;  c4c188eb <[fat]parse_options+4c/7f4>
   f:   66 c7 41 0a 00 00         movw   $0x0,0xa(%ecx)
---------

Regards,
Akihiro
-go-o------------------------------------------------ JAIST,Hokuriku
	Graduate School of Information Science
			Department of Information Systems
Akihiro MATSUSHIMA (http://www.jaist.ac.jp/~amatsus/) ---------go-o-

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
