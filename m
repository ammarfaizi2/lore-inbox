Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269464AbRHGVda>; Tue, 7 Aug 2001 17:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269466AbRHGVdV>; Tue, 7 Aug 2001 17:33:21 -0400
Received: from fep04.swip.net ([130.244.199.132]:37252 "EHLO
	fep04-svc.swip.net") by vger.kernel.org with ESMTP
	id <S269464AbRHGVdF>; Tue, 7 Aug 2001 17:33:05 -0400
Date: Tue, 7 Aug 2001 23:31:54 +0200 (CEST)
From: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
X-X-Sender: <petero@ppro.localdomain>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: kupdated oops in 2.4.8-pre5
Message-ID: <Pine.LNX.4.33.0108072325230.1930-100000@ppro.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following oops with kernel 2.4.8-pre5. bh becomes NULL in
sync_old_buffers() but the code tries to dereference it anyway.

Unable to handle kernel NULL pointer dereference at virtual address 0000001c
c0132ed7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0132ed7>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00016975   ebx: c5fec550   ecx: 00000000   edx: 00000000
esi: ffffffff   edi: fff9ffff   ebp: c5fec000   esp: c5fedfc4
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 7, stackpage=c5fed000)
Stack: c5fec550 c5fec550 ffffffff c5fec000 c013317c 0008e000 c5fec000 00010f00
       c11e1fb0 c0105000 0008e000 c01054f6 c0231cf0 c0133090 c0223fd8
Call Trace: [<c013317c>] [<c0105000>] [<c01054f6>] [<c0133090>]
Code: 3b 42 1c 0f 89 e0 ff ff ff 81 3d a0 b3 21 c0 a0 b3 21 c0 74

>>EIP; c0132ed7 <sync_old_buffers+27/50>   <=====
Trace; c013317c <kupdate+ec/f0>
Trace; c0105000 <_stext+0/0>
Trace; c01054f6 <kernel_thread+26/30>
Trace; c0133090 <kupdate+0/f0>
Code;  c0132ed7 <sync_old_buffers+27/50>
00000000 <_EIP>:
Code;  c0132ed7 <sync_old_buffers+27/50>   <=====
   0:   3b 42 1c                  cmp    0x1c(%edx),%eax   <=====
Code;  c0132eda <sync_old_buffers+2a/50>
   3:   0f 89 e0 ff ff ff         jns    ffffffe9 <_EIP+0xffffffe9> c0132ec0 <sync_old_buffers+10/50>
Code;  c0132ee0 <sync_old_buffers+30/50>
   9:   81 3d a0 b3 21 c0 a0      cmpl   $0xc021b3a0,0xc021b3a0
Code;  c0132ee7 <sync_old_buffers+37/50>
  10:   b3 21 c0
Code;  c0132eea <sync_old_buffers+3a/50>
  13:   74 00                     je     15 <_EIP+0x15> c0132eec <sync_old_buffers+3c/50>

-- 
Peter Österlund             peter.osterlund@mailbox.swipnet.se
Sköndalsvägen 35            http://home1.swipnet.se/~w-15919
S-128 66 Sköndal            +46 8 942647
Sweden


