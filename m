Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbUKXTYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbUKXTYx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 14:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbUKXTYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 14:24:53 -0500
Received: from ns.theshore.net ([67.18.92.50]:38805 "EHLO www.theshore.net")
	by vger.kernel.org with ESMTP id S262775AbUKXTYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 14:24:47 -0500
Message-ID: <002c01c4d25b$3e8b9b10$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.10-rc2-bk7 - kernel BUG at fs/sysfs/file.c:87! 
Date: Wed, 24 Nov 2004 13:24:39 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doing "cat /sys/block/sda/queue/iosched/show_status" produces the following BUG:

------------[ cut here ]------------
kernel BUG at fs/sysfs/file.c:87!
invalid operand: 0000 [#1]
SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c018455b>]    Not tainted VLI
EFLAGS: 00010206   (2.6.10-rc2-bk7-1-bigmem)
EIP is at fill_read_buffer+0x93/0x9d
eax: 000019bb   ebx: f4004fc0   ecx: f7eb8800   edx: c03c49a3
esi: f7eb6188   edi: c04173b0   ebp: c0417348   esp: c0883f34
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 14936, threadinfo=c0882000 task=f1b1ea20)
Stack: f7eb6188 c0417348 ddff0000 00000000 f4004fc0 c06a0380 c0883fac 00001000
       c0184657 f6a19654 f4004fc0 00000000 00001000 00000000 c0150ffc c06a0380
       0804d888 00001000 c0883fac e0026148 e0026140 c06a0380 fffffff7 0804d888
Call Trace:
 [<c0184657>] sysfs_read_file+0x31/0x6d
 [<c0150ffc>] vfs_read+0xb0/0x119
 [<c01512ba>] sys_read+0x51/0x80
 [<c01023e9>] sysenter_past_esp+0x52/0x71
Code: 10 00 00 7f 26 85 c0 78 1c 89 03 8b 54 24 0c 89 d0 8b 5c 24 10 8b 74 24 14 8b
7c 24 18 8b 6c 24 1c 83 c4 20 c3 89 44 24 0c eb e0 <0f> 0b 57 00 17 3a 3b c0 eb d0 83
ec 24 89 5c 24 14 89 74 24 18

ksymoops output:

>>EIP; c018455b <fill_read_buffer+93/9d>   <=====

>>ebx; f4004fc0 <pg0+33af2fc0/3faec400>
>>ecx; f7eb8800 <pg0+379a6800/3faec400>
>>edx; c03c49a3 <__func__.4+1a7a0/41bc1>
>>esi; f7eb6188 <pg0+379a4188/3faec400>
>>edi; c04173b0 <cfq_sysfs_ops+0/8>
>>ebp; c0417348 <cfq_misc_entry+0/14>
>>esp; c0883f34 <pg0+371f34/3faec400>

Trace; c0184657 <sysfs_read_file+31/6d>
Trace; c0150ffc <vfs_read+b0/119>
Trace; c01512ba <sys_read+51/80>
Trace; c01023e9 <sysenter_past_esp+52/71>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c0184530 <fill_read_buffer+68/9d>
00000000 <_EIP>:
Code;  c0184530 <fill_read_buffer+68/9d>
   0:   10 00                     adc    %al,(%eax)
Code;  c0184532 <fill_read_buffer+6a/9d>
   2:   00 7f 26                  add    %bh,0x26(%edi)
Code;  c0184535 <fill_read_buffer+6d/9d>
   5:   85 c0                     test   %eax,%eax
Code;  c0184537 <fill_read_buffer+6f/9d>
   7:   78 1c                     js     25 <_EIP+0x25>
Code;  c0184539 <fill_read_buffer+71/9d>
   9:   89 03                     mov    %eax,(%ebx)
Code;  c018453b <fill_read_buffer+73/9d>
   b:   8b 54 24 0c               mov    0xc(%esp,1),%edx
Code;  c018453f <fill_read_buffer+77/9d>
   f:   89 d0                     mov    %edx,%eax
Code;  c0184541 <fill_read_buffer+79/9d>
  11:   8b 5c 24 10               mov    0x10(%esp,1),%ebx
Code;  c0184545 <fill_read_buffer+7d/9d>
  15:   8b 74 24 14               mov    0x14(%esp,1),%esi
Code;  c0184549 <fill_read_buffer+81/9d>
  19:   8b 7c 24 18               mov    0x18(%esp,1),%edi
Code;  c018454d <fill_read_buffer+85/9d>
  1d:   8b 6c 24 1c               mov    0x1c(%esp,1),%ebp
Code;  c0184551 <fill_read_buffer+89/9d>
  21:   83 c4 20                  add    $0x20,%esp
Code;  c0184554 <fill_read_buffer+8c/9d>
  24:   c3                        ret
Code;  c0184555 <fill_read_buffer+8d/9d>
  25:   89 44 24 0c               mov    %eax,0xc(%esp,1)
Code;  c0184559 <fill_read_buffer+91/9d>
  29:   eb e0                     jmp    b <_EIP+0xb>

This decode from eip onwards should be reliable

Code;  c018455b <fill_read_buffer+93/9d>
00000000 <_EIP>:
Code;  c018455b <fill_read_buffer+93/9d>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c018455d <fill_read_buffer+95/9d>
   2:   57                        push   %edi
Code;  c018455e <fill_read_buffer+96/9d>
   3:   00 17                     add    %dl,(%edi)
Code;  c0184560 <fill_read_buffer+98/9d>
   5:   3a 3b                     cmp    (%ebx),%bh
Code;  c0184562 <fill_read_buffer+9a/9d>
   7:   c0 eb d0                  shr    $0xd0,%bl
Code;  c0184565 <flush_read_buffer+0/c1>
   a:   83 ec 24                  sub    $0x24,%esp
Code;  c0184568 <flush_read_buffer+3/c1>
   d:   89 5c 24 14               mov    %ebx,0x14(%esp,1)
Code;  c018456c <flush_read_buffer+7/c1>
  11:   89 74 24 18               mov    %esi,0x18(%esp,1)

-Chris

