Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263323AbSJIAUn>; Tue, 8 Oct 2002 20:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263331AbSJIAUn>; Tue, 8 Oct 2002 20:20:43 -0400
Received: from n1x6.imsa.edu ([143.195.1.6]:58294 "EHLO mail.imsa.edu")
	by vger.kernel.org with ESMTP id <S263323AbSJIAUl>;
	Tue, 8 Oct 2002 20:20:41 -0400
Date: Tue, 8 Oct 2002 19:26:23 -0500
From: Maciej Babinski <maciej@imsa.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.5.41 oops on reboot
Message-ID: <20021008192623.A1314@imsa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this oops when rebooting my fresh 2.5.41 build. reboot failed, and
there were no other processes running, so this is hand copied.


ksymoops 2.4.6 on i586 2.4.19.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.41/ (specified)
     -m /kernel/System.map-2.5.41 (specified)

No modules in ksyms, skipping objects
CPU:    0
EIP:    0060:[<c015d448>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c0205fb7   ebx: 0000005c     ecx: 0000005c       edx: 00000077
esi: 00000000   edi: c110ece8     ebp: c110ec00       esp: c5475e18
ds: 0068 es: 0068 ss: 0068
Stack: c110ec4c c022cc7c c13c3528 c0181523 c110ece8 c0205e7c c110ec4c c110ec4c
       00000000 c015b863 c110ec4c c022cc7c c110ec00 c110ec00 c02b7654 00000000
       c015c22b c110ec00 c02b7700 c01b025b c110ec00 c02b7700 00000001 c01ad155
Call Trace: [<c0181423>] [<c015b863>] [<c015c22b>] [<c01b025b>] [<c01ad155>] [c011ed6c>] [<c011f1b8>] [<c01c64e8>] [<c01c1b6c>] [<c01f05b0>] [<c01f0585>] [<c012b323>] [<c01b9964>] [<c012b323>] [<c014a2ec>] [<c0138bf5>] [<c0137097>] [<c0137105>] [<c0107357>]
Code: ff 4e 5c 0f 88 5f 02 00 00 8b 5c 24 14 53 8b 4f 04 51 e8 61


>>EIP; c015d448 <driverfs_remove_file+28/90>   <=====

>>eax; c0205fb7 <__func__.0+1e75/2388>

Trace; c0181423 <device_remove_file+23/40>
Trace; c015b863 <driverfs_remove_partitions+53/a0>
Trace; c015c22b <del_gendisk+b/40>
Trace; c01b025b <idedisk_cleanup+4b/70>
Trace; c01ad155 <ide_notify_reboot+a5/b0>

Code;  c015d448 <driverfs_remove_file+28/90>
00000000 <_EIP>:
Code;  c015d448 <driverfs_remove_file+28/90>   <=====
   0:   ff 4e 5c                  decl   0x5c(%esi)   <=====
Code;  c015d44b <driverfs_remove_file+2b/90>
   3:   0f 88 5f 02 00 00         js     268 <_EIP+0x268> c015d6b0 <.text.lock.inode+64/a4>
Code;  c015d451 <driverfs_remove_file+31/90>
   9:   8b 5c 24 14               mov    0x14(%esp,1),%ebx
Code;  c015d455 <driverfs_remove_file+35/90>
   d:   53                        push   %ebx
Code;  c015d456 <driverfs_remove_file+36/90>
   e:   8b 4f 04                  mov    0x4(%edi),%ecx
Code;  c015d459 <driverfs_remove_file+39/90>
  11:   51                        push   %ecx
Code;  c015d45a <driverfs_remove_file+3a/90>
  12:   e8 61 00 00 00            call   78 <_EIP+0x78> c015d4c0 <driverfs_remove_dir+10/110>

