Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbSKIWy7>; Sat, 9 Nov 2002 17:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbSKIWy7>; Sat, 9 Nov 2002 17:54:59 -0500
Received: from 12-224-175-196.client.attbi.com ([12.224.175.196]:16256 "EHLO
	mcgruff.krimedawg.org") by vger.kernel.org with ESMTP
	id <S262807AbSKIWy6>; Sat, 9 Nov 2002 17:54:58 -0500
Date: Sat, 9 Nov 2002 15:01:40 -0800 (PST)
From: no one in particular <lkml@krimedawg.org>
X-X-Sender: plumpy@mcgruff.krimedawg.org
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.5.46 (scheduler?)
Message-ID: <Pine.LNX.4.44.0211091458160.484-100000@mcgruff.krimedawg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies if I did this wrong, but I get an oops on startup now.  Oddly,
2.5.46 used to work for me, ...

Here's what happened when I ran it through ksymoops (let me know if I did
anything wrong or you need more info?)

ksymoops 2.4.6 on i686 2.4.19.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.5.46 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0114323
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0114323>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: c1e9c440   ebx: f79e0000   ecx: 00000001   edx: 00000000
esi: 00000001   edi: 00000046   ebp: f79e1f3c   esp: f79e1f30
ds: 0068   es: 0068   ss: 0068
Stack: f79e0000 00000282 00000046 f79e1f5c c0114380 c1e9c440 00000001 00000001
       00000000 00000046 f7a10d40 00000000 c0147b36 00000000 00000000 c1e73ec0
       c1e73ee0 f7a10d9c 00000001 00000046 c013e131 c1e73ec0 40012046 00000046
Call Trace: [<c0114380>] [<c0147b36>] [<c013e131>] [<c013e3ea>]
[<c010897b>]
Code: 8b 3a 8b 45 08 83 c0 04 39 c2 74 23 8b 5a f4 8b 4d 14 51 8b


>>EIP; c0114323 <__wake_up_common+13/50>   <=====

Trace; c0114380 <__wake_up+20/40>
Trace; c0147b36 <pipe_write+1f6/240>
Trace; c013e131 <vfs_write+c1/160>
Trace; c013e3ea <sys_write+2a/40>
Trace; c010897b <syscall_call+7/b>

Code;  c0114323 <__wake_up_common+13/50>
00000000 <_EIP>:
Code;  c0114323 <__wake_up_common+13/50>   <=====
   0:   8b 3a                     mov    (%edx),%edi   <=====
Code;  c0114325 <__wake_up_common+15/50>
   2:   8b 45 08                  mov    0x8(%ebp),%eax
Code;  c0114328 <__wake_up_common+18/50>
   5:   83 c0 04                  add    $0x4,%eax
Code;  c011432b <__wake_up_common+1b/50>
   8:   39 c2                     cmp    %eax,%edx
Code;  c011432d <__wake_up_common+1d/50>
   a:   74 23                     je     2f <_EIP+0x2f>
Code;  c011432f <__wake_up_common+1f/50>
   c:   8b 5a f4                  mov    0xfffffff4(%edx),%ebx
Code;  c0114332 <__wake_up_common+22/50>
   f:   8b 4d 14                  mov    0x14(%ebp),%ecx
Code;  c0114335 <__wake_up_common+25/50>
  12:   51                        push   %ecx
Code;  c0114336 <__wake_up_common+26/50>
  13:   8b 00                     mov    (%eax),%eax

