Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbRBDVtk>; Sun, 4 Feb 2001 16:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129499AbRBDVta>; Sun, 4 Feb 2001 16:49:30 -0500
Received: from chaos.ao.net ([205.244.242.21]:6665 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id <S129352AbRBDVtM>;
	Sun, 4 Feb 2001 16:49:12 -0500
Message-Id: <200102042149.f14Ln4508774@chaos.ao.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0/2.4.1 crashes in ext2
Date: Sun, 04 Feb 2001 16:49:03 -0500
From: Dan Merillat <harik@chaos.ao.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ok, here's the crash I'm getting in 2.4.0.  Same thing is happening in 2.4.1,
but It's dying harder so getting syslog info out is tougher.

Looks like it's trying to write WAY past the end of a drive (from some messages
that unfortunatly did not get logged, but were scrolling on the screen) but I'm
not sure if that's the cause or result of the oops.

The only thing different on this machine from my others running 2.4.1 is that
this one is actually using large files.  lots of them, all the time.  So that'd
be my first guess.

I made sure to compile 2.4.1 with 2.91.2, no change.

I get about 5-10 minutes of runtime on a full-feed newsserver before it
crashes.   Need to figure this out quickly, please.

--Dan


Unable to handle kernel paging request at virtual address d8958100
c012e253
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[__block_write_full_page+123/372]
EFLAGS: 00010206
eax: 00000000   ebx: d89580e8   ecx: 00003057   edx: 00000000
esi: 00000000   edi: 00000c4c   ebp: c3886f60   esp: c15ebf5c
ds: 0018   es: 0018   ss: 0018
Process kupdate (pid: 6, stackpage=c15eb000)
Stack: c10f2388 c4ff6620 c4ff66c4 c4ff6620 00000000 c012eda1 c4ff6620 c10f2388 
       c0148e78 c10f2388 c4ff6620 c4ff66c4 c01494ec c4bd2d60 c01494fa c10f2388 
       c0148e78 c011fe6a c10f2388 00000004 c4ff6620 cffca638 cffca600 c013db9b 
Call Trace: [block_write_full_page+49/328] [ext2_get_block+0/1168] [ext2_writepage+0/20] [ext2_writepage+14/20] [ext2_get_block+0/1168] [filemap_fdatasync+90/188] [sync_inodes+239/364] 
Code: 8b 73 18 83 e6 10 75 29 6a 01 53 57 8b 54 24 24 52 8b 54 24 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 73 18                  mov    0x18(%ebx),%esi
Code;  00000003 Before first symbol
   3:   83 e6 10                  and    $0x10,%esi
Code;  00000006 Before first symbol
   6:   75 29                     jne    31 <_EIP+0x31> 00000031 Before first symbol
Code;  00000008 Before first symbol
   8:   6a 01                     push   $0x1
Code;  0000000a Before first symbol
   a:   53                        push   %ebx
Code;  0000000b Before first symbol
   b:   57                        push   %edi
Code;  0000000c Before first symbol
   c:   8b 54 24 24               mov    0x24(%esp,1),%edx
Code;  00000010 Before first symbol
  10:   52                        push   %edx
Code;  00000011 Before first symbol
  11:   8b 54 24 00               mov    0x0(%esp,1),%edx


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
