Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316372AbSFUGfQ>; Fri, 21 Jun 2002 02:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSFUGfP>; Fri, 21 Jun 2002 02:35:15 -0400
Received: from BSN-250-62-68.dsl.siol.net ([213.250.62.68]:53725 "EHLO
	gekko.velenje.cx") by vger.kernel.org with ESMTP id <S316372AbSFUGfO>;
	Fri, 21 Jun 2002 02:35:14 -0400
Subject: Re: High mem support, oops on 2.4.18
From: Samo Gabrovec <root@velenje.cx>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 21 Jun 2002 08:34:59 +0200
Message-Id: <1024641299.12272.23.camel@gekko>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran the memtest86 for over 24h and did not show any errors in the ram.
The computer works with the same ram but without the Hi mem support. If
i use the same kernel but with hi mem enabled i get kernel oopses, load
rises ...etc.

The computer is :one Pentium III , 700mhz with 1G ram, running 2.4.18
kernel [RH 6.2]


one of the oops .. 
 -----------------When i ran lilo--------------------
 Jun 18 11:25:38 ena kernel:  <1>Unable to handle kernel NULL pointer
 dereference at virtual address 00000000
 Jun 18 11:25:38 ena kernel: f88b920f
 Jun 18 11:25:38 ena kernel: *pde = 00000000
 Jun 18 11:25:38 ena kernel: Oops: 0000
 Jun 18 11:25:38 ena kernel: CPU:    0
 Jun 18 11:25:38 ena kernel: EIP:    0010:[<f88b920f>]    Not tainted
 Jun 18 11:25:38 ena kernel: EFLAGS: 00010206
 Jun 18 11:25:38 ena kernel: eax: 00000000   ebx: 00000400   ecx:
 00000100   edx: f1bae000
 Jun 18 11:25:38 ena kernel: esi: 00000000   edi: f1bae000   ebp:
 c1c6eb80   esp: d6a35e64
 Jun 18 11:25:38 ena kernel: ds: 0018   es: 0018   ss: 0018
 Jun 18 11:25:38 ena kernel: Process lilo (pid: 12754,
 stackpage=d6a35000)
 Jun 18 11:25:38 ena kernel: Stack: 00000001 f2e788c0 c02e4d64 000044f8
 00000000 00000000 00000000 000008a0
 Jun 18 11:25:38 ena kernel:        f72cc690 f88b9295 00000001 f2e788c0
 00000001 00000101 f2e788c0 c01a69ac
 Jun 18 11:25:38 ena kernel:        c02e4d64 00000001 f2e788c0 00000002
 00000001 f3756c80 000030a9 c01a6a6f
 Jun 18 11:25:38 ena kernel: Call Trace: [<f88b9295>]
 [disk_change+364/604] [disk_change+559/604]
 [invalidate_inode_buffers+0/92] [getblk+41
 /60]
 Jun 18 11:25:38 ena kernel: Code: f3 a5 f6 c3 02 74 02 66 a5 f6 c3 01
74
 01 a4 83 7c 24 28 00
 
 
 >>EIP; f88b920f <[rd]rd_blkdev_pagecache_IO+ff/148>   <=====
 
 >>edx; f1bae000 <_end+318af4e0/385a64e0>
 >>edi; f1bae000 <_end+318af4e0/385a64e0>
 >>ebp; c1c6eb80 <_end+1970060/385a64e0>
 >>esp; d6a35e64 <_end+16737344/385a64e0>
 
 Trace; f88b9295 <[rd]rd_make_request+3d/68>
 
 Code;  f88b920f <[rd]rd_blkdev_pagecache_IO+ff/148>
 00000000 <_EIP>:
 Code;  f88b920f <[rd]rd_blkdev_pagecache_IO+ff/148>   <=====
    0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)  
 <=====
 Code;  f88b9211 <[rd]rd_blkdev_pagecache_IO+101/148>
    2:   f6 c3 02                  test   $0x2,%bl
 Code;  f88b9214 <[rd]rd_blkdev_pagecache_IO+104/148>
    5:   74 02                     je     9 <_EIP+0x9> f88b9218
 <[rd]rd_blkdev_pagecache_IO+108/148>
 Code;  f88b9216 <[rd]rd_blkdev_pagecache_IO+106/148>
    7:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
 Code;  f88b9218 <[rd]rd_blkdev_pagecache_IO+108/148>
    9:   f6 c3 01                  test   $0x1,%bl
 Code;  f88b921b <[rd]rd_blkdev_pagecache_IO+10b/148>
    c:   74 01                     je     f <_EIP+0xf> f88b921e
 <[rd]rd_blkdev_pagecache_IO+10e/148>
 Code;  f88b921d <[rd]rd_blkdev_pagecache_IO+10d/148>
    e:   a4                        movsb  %ds:(%esi),%es:(%edi)
 Code;  f88b921e <[rd]rd_blkdev_pagecache_IO+10e/148>
    f:   83 7c 24 28 00            cmpl   $0x0,0x28(%esp,1)
 
 -----------------end lilo exec---------------------------
