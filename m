Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272015AbRHVOmc>; Wed, 22 Aug 2001 10:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272016AbRHVOmW>; Wed, 22 Aug 2001 10:42:22 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:43662 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S272015AbRHVOmK>; Wed, 22 Aug 2001 10:42:10 -0400
Date: Wed, 22 Aug 2001 10:57:22 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Oops after mounting ext3 on 2.4.8-ac9
Message-ID: <Pine.LNX.4.31.0108221042430.3959-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upon issuing "mount -avt nonfs" at boot, my machine oopsed while mounting
the last partition in the fstab.  mount seg faulted, but all the file
systems did end up mounted.  The machine kept running after that, but I'm
taking it back to the previous kernel (2.4.7-ac8), just to be safe.  It is
reproducable.  I rebooted just to check, and got the same oops.


EXT3 FS 2.4-0.9.6, 11 Aug 2001 on dac960(48,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.6, 11 Aug 2001 on dac960(48,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.6, 11 Aug 2001 on dac960(48,17), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.6, 11 Aug 2001 on dac960(48,25), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.6, 11 Aug 2001 on dac960(48,33), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Unable to handle kernel paging request at virtual address 00003001
c01a6a64
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01a6a64>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00003001   ebx: d7f69e00   ecx: d794ef60   edx: d7f69e18
esi: c179ec00   edi: 00000018   ebp: d7974400   esp: d7a4be84
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 22, stackpage=d7a4b000)
Stack: d7f69e00 c179ec00 d79744f0 d7974400 c01a6b63 c179ec00 d7974400
d7f69e00
       d7974400 d79744f0 c022059c c01a7977 c179ec00 d7974400 d7f69de0
d7974400
       d7974400 d7974444 d797447c c0220740 00000002 c012f87d d7974400
d7931000
Call Trace: [<c01a6b63>] [<c01a7977>] [<c012f87d>] [<c012fc08>]
[<c013e825>]
   [<c013eabb>] [<c013e91d>] [<c013eb58>] [<c0106aeb>]
Code: 8b 30 8d 47 ff 83 f8 7e 0f 87 d5 00 00 00 81 fe ff 00 00 00

>>EIP; c01a6a64 <new_dev_inode+14/fc>   <=====
Trace; c01a6b63 <recurse_new_dev_inode+17/4c>
Trace; c01a7977 <usbdevfs_read_super+177/1a4>
Trace; c012f87d <get_sb_single+ed/16c>
Trace; c012fc08 <do_kern_mount+fc/188>
Trace; c013e825 <do_add_mount+21/cc>
Trace; c013eabb <do_mount+14f/168>
Trace; c013e91d <copy_mount_options+4d/9c>
Trace; c013eb58 <sys_mount+84/c4>
Trace; c0106aeb <system_call+33/38>
Code;  c01a6a64 <new_dev_inode+14/fc>
00000000 <_EIP>:
Code;  c01a6a64 <new_dev_inode+14/fc>   <=====
   0:   8b 30                     mov    (%eax),%esi   <=====
Code;  c01a6a66 <new_dev_inode+16/fc>
   2:   8d 47 ff                  lea    0xffffffff(%edi),%eax
Code;  c01a6a69 <new_dev_inode+19/fc>
   5:   83 f8 7e                  cmp    $0x7e,%eax
Code;  c01a6a6c <new_dev_inode+1c/fc>
   8:   0f 87 d5 00 00 00         ja     e3 <_EIP+0xe3> c01a6b47
<new_dev_inode+f7/fc>
Code;  c01a6a72 <new_dev_inode+22/fc>
   e:   81 fe ff 00 00 00         cmp    $0xff,%esi


-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

