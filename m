Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265961AbSKBMrb>; Sat, 2 Nov 2002 07:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265957AbSKBMqa>; Sat, 2 Nov 2002 07:46:30 -0500
Received: from zamok.crans.org ([138.231.136.6]:13978 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S265955AbSKBMp3>;
	Sat, 2 Nov 2002 07:45:29 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Mathieu Segaud <Mathieu.Segaud@crans.org>
Organization: ENS Cachan
To: linux-kernel@vger.kernel.org
Subject: [Oops] 2.5.45 raid0 initialization failure
Date: Sat, 2 Nov 2002 14:48:06 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211021448.06568.segaud@crans.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a raid0 partition (2*100Go) that is correctly mounted by 2.5.44 but 
2.5.45 compiled with the same configuration gives me that:

Unable to handle kernel NULL pointer dereference at virtual address 00000204
c0292091
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0292091>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c03fec14   ebx: 00000200   ecx: 00000000   edx: 00001000
esi: 0000001a   edi: cf8a0c00   ebp: 00002100   esp: cf5abedc
ds: 0068   es: 0068   ss: 0068
Stack: 00002100 00000001 00002100 00000000 cf8a0c00 cf587cf4 c0292ea5 00002100 
       bffffaa0 cf5abf08 00000060 00000301 00000000 00000000 00002329 000061b0 
       00000001 00000000 00000006 00002100 00000000 00000000 00000000 00000000 
Call Trace: [<c0292ea5>]  [<c020d473>]  [<c0155cda>]  [<c01075e3>] 
Code: 0f b7 43 04 c1 e0 08 66 0b 43 08 74 38 66 39 e8 74 33 0f b7 


>>EIP; c0292091 <autostart_array+91/120>   <=====

>>eax; c03fec14 <pending_raid_disks+0/8>

Trace; c0292ea5 <md_ioctl+505/5c0>
Trace; c020d473 <blkdev_ioctl+b3/441>
Trace; c0155cda <sys_ioctl+ea/250>
Trace; c01075e3 <syscall_call+7/b>

Code;  c0292091 <autostart_array+91/120>
00000000 <_EIP>:
Code;  c0292091 <autostart_array+91/120>   <=====
   0:   0f b7 43 04               movzwl 0x4(%ebx),%eax   <=====
Code;  c0292095 <autostart_array+95/120>
   4:   c1 e0 08                  shl    $0x8,%eax
Code;  c0292098 <autostart_array+98/120>
   7:   66 0b 43 08               or     0x8(%ebx),%ax
Code;  c029209c <autostart_array+9c/120>
   b:   74 38                     je     45 <_EIP+0x45>
Code;  c029209e <autostart_array+9e/120>
   d:   66 39 e8                  cmp    %bp,%ax
Code;  c02920a1 <autostart_array+a1/120>
  10:   74 33                     je     45 <_EIP+0x45>
Code;  c02920a3 <autostart_array+a3/120>
  12:   0f b7 00                  movzwl (%eax),%eax


3 warnings issued.  Results may not be reliable.

my raid partition is from two hard drives hde and hdg plugged with hpt370 chip 
(included in compilation)
I also patched arch/i386/Makefile to use gcc-3.2 -march=athlon-xp option.

Thanks in advance

Mathieu Segaud

