Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131521AbRCNTl1>; Wed, 14 Mar 2001 14:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131523AbRCNTlR>; Wed, 14 Mar 2001 14:41:17 -0500
Received: from isc4.tn.cornell.edu ([128.84.242.21]:29860 "EHLO
	isc4.tn.cornell.edu") by vger.kernel.org with ESMTP
	id <S131521AbRCNTlG>; Wed, 14 Mar 2001 14:41:06 -0500
Date: Wed, 14 Mar 2001 14:39:53 -0500 (EST)
From: "Donald J. Barry" <don@astro.cornell.edu>
Message-Id: <200103141939.OAA05598@isc4.tn.cornell.edu>
To: linux-kernel@vger.kernel.org
Subject: kernel paging oops on massive vfs activity
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey kernel developers,

I'm getting repeated oopses and occasional freezes on a server I've
set up to host a giant (180G) reiserfs system atop lvm, served by nfs(v2).
(I've applied the reiserfs and nfs patches to the vanilla kernel,
which is otherwise pretty minimally compiled). They seem to be
correlated by massive disk activity.  Because this file system has
many huge directories (20000+ files in some) and also many long names
(some of those giant directories are filled with 40+ character
filenames) I'm beginning to wonder whether the vfs layer is at fault.
I got some of the same behavior with an earlier ext2 instance atop
lvm.  In this case I triggered the result by doing a find atop the 
tree.  Generally things that access many directory entries trigger it.

Of course, it could be a remaining hardware glitch on this new tbird
1100 system on GA59X motherboard (latest firmware, but it has the 
troublesome VIA kt133 chipset).

What use is a server when it oopses when trying to serve?

Any thoughts?

Don Barry
Cornell Astronomy


ksymoops 2.3.4 on i686 2.4.2.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2/ (default)
     -m /usr/src/linux/System.map (default)

Unable to handle kernel paging request at virtual address 00acaca0
c0141adb
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0141adb>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010217
eax: cffc9f58   ebx: 00acac80   ecx: 0000000e   edx: 0001be9b
esi: 00acac80   edi: 00000000   ebp: cffc9f58   esp: c96c9e1c
ds: 0018   es: 0018   ss: 0018
Process find (pid: 929, stackpage=c96c9000)
Stack: c96c9e94 00000000 0001be9b cf921400 c0141ef7 cf921400 0001be9b cffc9f58 
       00000000 c96c9e74 c96c9e94 c96c9ef8 c96c9ed4 c2545bc0 cffc9f58 c0180e04 
       cf921400 0001be9b 00000000 c96c9e74 c96c9e94 00000001 0001bdb0 c017c7de 
Call Trace: [<c0141ef7>] [<c0180e04>] [<c017c7de>] [<c01385a3>] [<c0138d27>] [<c013830b>] [<c013935c>] 
       [<c0136206>] [<c0108f47>] 
Code: 39 53 20 75 24 8b 54 24 14 39 93 8c 00 00 00 75 18 85 ff 74 

>>EIP; c0141adb <find_inode+1b/60>   <=====
Trace; c0141ef7 <iget4+47/e0>
Trace; c0180e04 <reiserfs_iget+24/60>
Trace; c017c7de <reiserfs_lookup+8e/d0>
Trace; c01385a3 <real_lookup+53/c0>
Trace; c0138d27 <path_walk+5b7/820>
Trace; c013830b <getname+5b/a0>
Trace; c013935c <__user_walk+3c/60>
Trace; c0136206 <sys_lstat64+16/70>
Trace; c0108f47 <system_call+33/38>
Code;  c0141adb <find_inode+1b/60>
00000000 <_EIP>:
Code;  c0141adb <find_inode+1b/60>   <=====
   0:   39 53 20                  cmp    %edx,0x20(%ebx)   <=====
Code;  c0141ade <find_inode+1e/60>
   3:   75 24                     jne    29 <_EIP+0x29> c0141b04 <find_inode+44/60>
Code;  c0141ae0 <find_inode+20/60>
   5:   8b 54 24 14               mov    0x14(%esp,1),%edx
Code;  c0141ae4 <find_inode+24/60>
   9:   39 93 8c 00 00 00         cmp    %edx,0x8c(%ebx)
Code;  c0141aea <find_inode+2a/60>
   f:   75 18                     jne    29 <_EIP+0x29> c0141b04 <find_inode+44/60>
Code;  c0141aec <find_inode+2c/60>
  11:   85 ff                     test   %edi,%edi
Code;  c0141aee <find_inode+2e/60>
  13:   74 00                     je     15 <_EIP+0x15> c0141af0 <find_inode+30/60>

