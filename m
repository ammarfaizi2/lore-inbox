Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132367AbRBDXmV>; Sun, 4 Feb 2001 18:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132382AbRBDXmB>; Sun, 4 Feb 2001 18:42:01 -0500
Received: from chaos.ao.net ([205.244.242.21]:20749 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id <S132367AbRBDXlw>;
	Sun, 4 Feb 2001 18:41:52 -0500
Message-Id: <200102042341.f14Nfi514381@chaos.ao.net>
To: linux-kernel@vger.kernel.org
Subject: 3 more traces, 2.4.1 this time.
Date: Sun, 04 Feb 2001 18:41:43 -0500
From: Dan Merillat <harik@chaos.ao.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Managed to get 2.4.1 to Oops without locking up entirely:

I have no idea what's causing this... I just mkfs'ed all the drives fresh, so there
shouldn't be any filesystem corruption.

Ideas?

Unable to handle kernel paging request at virtual address d8958100
c0130704
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[__block_prepare_write+224/584]
EFLAGS: 00010283
eax: 000004f0   ebx: 00000322   ecx: 00000000   edx: d89580e8
esi: 00000800   edi: ce01a322   ebp: c25c5ef8   esp: c25c5ec8
ds: 0018   es: 0018   ss: 0018
Process innd (pid: 585, stackpage=c25c5000)
Stack: 00000322 c13b86f8 c331c360 000004f0 00000400 00000f3b c25c5ef8 ce044980 
       ce01a000 00000400 00035221 d89580e8 000fc340 c013e3b0 c0130ea2 c39fc2c0 
       c13b86f8 00000322 000004f0 c014ccbc c13b86f8 fffffff4 c014d425 c13b86f8 
Call Trace: [<d89580e8>] [posix_lock_file+1344/1360] [block_prepare_write+34/60] [ext2_get_block+0/1332] [ext2_prepare_write+25/32] [ext2_get_block+0/1332] [generic_file_write+812/1204] 
Code: f6 42 18 10 0f 85 b2 00 00 00 6a 01 52 8b 5c 24 30 53 8b 44 
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; d89580e8 <END_OF_CODE+18675b5c/????>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f6 42 18 10               testb  $0x10,0x18(%edx)
Code;  00000004 Before first symbol
   4:   0f 85 b2 00 00 00         jne    bc <_EIP+0xbc> 000000bc Before first symbol
Code;  0000000a Before first symbol
   a:   6a 01                     push   $0x1
Code;  0000000c Before first symbol
   c:   52                        push   %edx
Code;  0000000d Before first symbol
   d:   8b 5c 24 30               mov    0x30(%esp,1),%ebx
Code;  00000011 Before first symbol
  11:   53                        push   %ebx
Code;  00000012 Before first symbol
  12:   8b 44 00 00               mov    0x0(%eax,%eax,1),%eax

Unable to handle kernel paging request at virtual address d89580ec
c012fd64
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[getblk+128/296]
EFLAGS: 00010286
eax: c1450000   ebx: 00000002   ecx: 0004c11a   edx: d89580e8
esi: 00000008   edi: 00000801   ebp: 00000026   esp: c1bd1e1c
ds: 0018   es: 0018   ss: 0018
Process innfeed (pid: 588, stackpage=c1bd1000)
Stack: c1bd1f00 c3a64de0 c3a64de0 c3a64e50 00000801 00001f6e c014d253 00000801 
       0004c11a 00000400 cfb5cd40 00000001 c3a64de0 c33293a0 0004c11a c354a3c0 
       c3320801 c354a3c0 00030002 00000010 c1bd1e94 c1bd1e78 c1bd1e7c c198a2a0 
Call Trace: [ext2_getblk+99/204] [ext2_find_entry+177/944] [error_code+52/64] [file_read_actor+51/104] [ext2_unlink+39/204] [vfs_unlink+231/300] [sys_unlink+165/284] 
Code: 39 4a 04 75 12 31 c0 66 8b 42 08 3b 44 24 24 75 06 66 39 7a 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 4a 04                  cmp    %ecx,0x4(%edx)
Code;  00000003 Before first symbol
   3:   75 12                     jne    17 <_EIP+0x17> 00000017 Before first symbol
Code;  00000005 Before first symbol
   5:   31 c0                     xor    %eax,%eax
Code;  00000007 Before first symbol
   7:   66 8b 42 08               mov    0x8(%edx),%ax
Code;  0000000b Before first symbol
   b:   3b 44 24 24               cmp    0x24(%esp,1),%eax
Code;  0000000f Before first symbol
   f:   75 06                     jne    17 <_EIP+0x17> 00000017 Before first symbol
Code;  00000011 Before first symbol
  11:   66 39 7a 00               cmp    %di,0x0(%edx)

Unable to handle kernel paging request at virtual address d89580ec
c012fd64
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[getblk+128/296]
EFLAGS: 00010286
eax: c1450000   ebx: 00000002   ecx: 0004a014   edx: d89580e8
esi: 00000008   edi: 00000801   ebp: 00000025   esp: c15e9f38
ds: 0018   es: 0018   ss: 0018
Process kupdate (pid: 6, stackpage=c15e9000)
Stack: 0004a014 000000a0 00002280 c1b25c20 00000801 00001555 c012fffe 00000801 
       0004a014 00000400 00000801 c014e1f6 00000801 0004a014 00000400 00000001 
       c1b25c20 cff68238 cff68200 c7707ab4 00000286 00000001 cff68200 00000801 
Call Trace: [bread+26/112] [ext2_update_inode+302/952] [ext2_write_inode+15/20] [sync_inodes+296/388] [sync_old_buffers+14/56] [kupdate+222/232] [kernel_thread+35/48] 
Code: 39 4a 04 75 12 31 c0 66 8b 42 08 3b 44 24 24 75 06 66 39 7a 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 4a 04                  cmp    %ecx,0x4(%edx)
Code;  00000003 Before first symbol
   3:   75 12                     jne    17 <_EIP+0x17> 00000017 Before first symbol
Code;  00000005 Before first symbol
   5:   31 c0                     xor    %eax,%eax
Code;  00000007 Before first symbol
   7:   66 8b 42 08               mov    0x8(%edx),%ax
Code;  0000000b Before first symbol
   b:   3b 44 24 24               cmp    0x24(%esp,1),%eax
Code;  0000000f Before first symbol
   f:   75 06                     jne    17 <_EIP+0x17> 00000017 Before first symbol
Code;  00000011 Before first symbol
  11:   66 39 7a 00               cmp    %di,0x0(%edx)


1 warning issued.  Results may not be reliable.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
