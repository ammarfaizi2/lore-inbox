Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317864AbSFSMU2>; Wed, 19 Jun 2002 08:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317867AbSFSMU1>; Wed, 19 Jun 2002 08:20:27 -0400
Received: from BSN-250-62-68.dsl.siol.net ([213.250.62.68]:17033 "EHLO
	gekko.velenje.cx") by vger.kernel.org with ESMTP id <S317864AbSFSMUZ>;
	Wed, 19 Jun 2002 08:20:25 -0400
Subject: High mem support, oops on 2.4.18
From: Samo Gabrovec <samo.gabrovec@siol.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Jun 2002 14:20:12 +0200
Message-Id: <1024489212.15738.63.camel@gekko>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Yesterday i sticked in another 256MB of ram [now it has 4x 256] and
noticed that only ~900MB was availeble.. so i recompiled with the hi mem
option [ i selected 4GB ]. But when it all loaded in the new build
kernel it was all but normal. 

when i tried running lilo it seg faulted leaving oops in the log, Load
was going off like crazy [idle server with +15 load]...

I tried appending mem size to the lilo, but it made no diffrence.

if i use 2.4.18 without the Hi mem option it works without any oopses or
problems what so ever, but with less availeble ram ofcourse :( 

all oops`s start with "Unable to handle kernel NULL pointer dereference
at virtual address 00000000"


The computer is :one Pentium III , 700mhz with 1G ram, running 2.4.18
kernel [RH 6.2]




i feed the ksymoops with oops that were in logs and got this out...

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
Jun 18 11:25:38 ena kernel: Code: f3 a5 f6 c3 02 74 02 66 a5 f6 c3 01 74
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


-----------------when i ran rsync ------------------------

Jun 18 09:22:16 ena kernel: ds: no socket drivers loaded!
Jun 18 09:22:39 ena kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Jun 18 09:22:39 ena kernel: f88b920f
Jun 18 09:22:39 ena kernel: *pde = 00000000
Jun 18 09:22:39 ena kernel: Oops: 0002
Jun 18 09:22:39 ena kernel: CPU:    0
Jun 18 09:22:39 ena kernel: EIP:    0010:[<f88b920f>]    Not tainted
Jun 18 09:22:39 ena kernel: EFLAGS: 00010206
Jun 18 09:22:39 ena kernel: eax: f6fe8400   ebx: 00000400   ecx:
00000100   edx: 00000000
Jun 18 09:22:39 ena kernel: esi: f6fe8400   edi: 00000000   ebp:
c1dbfa00   esp: f7815dac
Jun 18 09:22:39 ena kernel: ds: 0018   es: 0018   ss: 0018
Jun 18 09:22:39 ena kernel: Process rsync (pid: 1132,
stackpage=f7815000)
Jun 18 09:22:39 ena kernel: Stack: 00000001 f787a780 c02e4d64 000001ca
00000000 00000000 00000000 0000003a
Jun 18 09:22:39 ena kernel:        f7018150 f88b9295 00000000 f787a780
00000001 00000101 f787a780 c01a69ac
Jun 18 09:22:39 ena kernel:        c02e4d64 00000000 f787a780 00000002
00000000 fe3af000 f7815e64 c01a6a6f
Jun 18 09:22:39 ena kernel: Call Trace: [<f88b9295>]
[disk_change+364/604] [disk_change+559/604] [brw_page+31/164]
[show_swap_cache_info+51
/52]
Jun 18 09:22:39 ena kernel: Code: f3 a5 f6 c3 02 74 02 66 a5 f6 c3 01 74
01 a4 83 7c 24 28 00


>>EIP; f88b920f <[rd]rd_blkdev_pagecache_IO+ff/148>   <=====

>>eax; f6fe8400 <_end+36ce98e0/385a64e0>
>>esi; f6fe8400 <_end+36ce98e0/385a64e0>
>>ebp; c1dbfa00 <_end+1ac0ee0/385a64e0>
>>esp; f7815dac <_end+3751728c/385a64e0>

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
---------------------------end rsync------------------------------------


if someone here know`s what could be my problem please let me know.


Thanks

Samo Gabrovec.


