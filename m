Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319608AbSH3Qip>; Fri, 30 Aug 2002 12:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319609AbSH3Qip>; Fri, 30 Aug 2002 12:38:45 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:30937 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319608AbSH3Qio>;
	Fri, 30 Aug 2002 12:38:44 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200208301642.g7UGgVP20912@eng2.beaverton.ibm.com>
Subject: 2.5.32 oops on unmount of ext2 filesystems
To: linux-kernel@vger.kernel.org
Date: Fri, 30 Aug 2002 09:42:31 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get following oops while unmounting ext2 filesystems. I have not seen
this on 2.5.31.  Is this a known problem ?

(I have 200 ext2 filesystems on 40 disks, I got one oops per filesystem 
- all looks same).


Thanks,
Badari

 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000001c
c01e1e34
*pde = 00000000
Oops: 0000
CPU:    4
EIP:    0060:[<c01e1e34>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: c872c800   ecx: c12bf860   edx: 00000000
esi: 00000001   edi: 00000000   ebp: f6e5c5e8   esp: efef5ea0
ds: 0068   es: 0068   ss: 0068
Stack: c01e1a27 00000000 00000296 cdc4da80 00000000 efef5ecc c872c800 f6e5c5c0 
       c0349180 c872c800 c017d685 00000001 00000001 f6e5c5e8 c01501a2 cdc4daf0 
       cdc4daf0 c0150458 00000000 c017c609 c872c800 cffd3400 c01505ac efef5f00 
Call Trace: [<c01e1a27>] [<c017d685>] [<c01501a2>] [<c0150458>] [<c017c609>] 
   [<c01505ac>] [<c0140d8f>] [<c01415b2>] [<c0140bf6>] [<c0152858>] [<c0146119>] 
   [<c0152fe0>] [<c0128dc5>] [<c0152ffc>] [<c0107643>] 
Code: 8b 40 1c c3 90 8d b4 26 00 00 00 00 53 8b 5c 24 08 8d 8b 98 

>>EIP; c01e1e34 <bdev_get_queue+4/10>   <=====
Trace; c01e1a27 <ll_rw_block+27/1a0>
Trace; c017d685 <ext2_sync_super+35/60>
Trace; c01501a2 <destroy_inode+32/50>
Trace; c0150458 <dispose_list+48/60>
Trace; c017c609 <ext2_put_super+29/90>
Trace; c01505ac <invalidate_inodes+7c/90>
Trace; c0140d8f <generic_shutdown_super+9f/150>
Trace; c01415b2 <kill_block_super+12/30>
Trace; c0140bf6 <deactivate_super+46/90>
Trace; c0152858 <__mntput+18/30>
Trace; c0146119 <path_release+29/30>
Trace; c0152fe0 <sys_umount+60/70>
Trace; c0128dc5 <sys_munmap+35/60>
Trace; c0152ffc <sys_oldumount+c/10>
Trace; c0107643 <syscall_call+7/b>
Code;  c01e1e34 <bdev_get_queue+4/10>
00000000 <_EIP>:
Code;  c01e1e34 <bdev_get_queue+4/10>   <=====
   0:   8b 40 1c                  mov    0x1c(%eax),%eax   <=====
Code;  c01e1e37 <bdev_get_queue+7/10>
   3:   c3                        ret    
Code;  c01e1e38 <bdev_get_queue+8/10>
   4:   90                        nop    
Code;  c01e1e39 <bdev_get_queue+9/10>
   5:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c01e1e40 <blk_remove_plug+0/50>
   c:   53                        push   %ebx
Code;  c01e1e41 <blk_remove_plug+1/50>
   d:   8b 5c 24 08               mov    0x8(%esp,1),%ebx
Code;  c01e1e45 <blk_remove_plug+5/50>
  11:   8d 8b 98 00 00 00         lea    0x98(%ebx),%ecx



