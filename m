Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264576AbSIQU20>; Tue, 17 Sep 2002 16:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264577AbSIQU20>; Tue, 17 Sep 2002 16:28:26 -0400
Received: from fastmail.fm ([209.61.183.86]:64464 "EHLO www.fastmail.fm")
	by vger.kernel.org with ESMTP id <S264576AbSIQU2Y>;
	Tue, 17 Sep 2002 16:28:24 -0400
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.2  (F2.6; T1.001; A1.48; B2.12; Q2.03)
Date: Tue, 17 Sep 2002 20:33:16 UT
From: "Aravind Ceyardass" <aravind1001@speedpost.net>
To: linux-kernel@vger.kernel.org
X-Epoch: 1032294796
X-Sasl-enc: RBc+Lre6mRaYT0y8tn7Ztw
Subject: Kernel Oops with spinlocks and modules in 2.5.30
Message-Id: <20020917203316.B3B3F93737@server2.fastmail.fm>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I get a kernel oops when using wake_up_interruptible in modules.
I traced it down to the spin_lock code

I also searched the kernel archive and found that many other 
people have also faced this problem. And it is supposed to do
with gcc and as. But I could not find any information on the
right version that I must use. 

But i might be totally wrong in my conclusion, so I have included
the oops file.

My environment.
Processor: Pentium II
Kernel: 2.5.30
Gcc package: 2.96-98
Binutils package: 2.11.93.0.2-11

thanks in advance

Aravind


----------oops file----------------------


No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address
00000003
c011424e
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011424e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: 00000003   ebx: 00000206   ecx: 00000000   edx: c4838090
esi: 00000003   edi: 00000000   ebp: c25fff70   esp: c25fff68
ds: 0018   es: 0018   ss: 0018
Stack: c4838000 c26cb000 c25fff90 c48380a7 c48383d4 00000001 00000001
c1028018
       c02d31c4 00000207 c26cb000 c0119b5e c4838000 c26cb000 00000000
       c0118f53
       c4838000 00000000 c25fe000 bffffc60 00000001 bfffeac8 c0107193
       bffffc60
Call Trace: [<c48380a7>] [<c48383d4>] [<c0119b5e>] [<c0118f53>]
[<c0107193>]
Code: f0 fe 0e 0f 88 35 18 00 00 6a 00 51 52 56 e8 7f ff ff ff 83

>>EIP; c011424e <__wake_up+e/40>   <=====
Trace; c48380a7 <END_OF_CODE+44979eb/???
Trace; c48383d4 <END_OF_CODE+4497d18/???
Trace; c0119b5e <free_module+1e/d0>
Trace; c0118f53 <sys_delete_module+123/250>
Trace; c0107193 <syscall_call+7/b>
Code;  c011424e <__wake_up+e/40>
00000000 <_EIP>:
Code;  c011424e <__wake_up+e/40>   <=====
   0:   f0 fe 0e                  lock decb (%esi)   <=====
Code;  c0114251 <__wake_up+11/40>
   3:   0f 88 35 18 00 00         js     183e <_EIP+0x183e> c0115a8c
   <.text.lock.sched+90/214>
Code;  c0114257 <__wake_up+17/40>
   9:   6a 00                     push   $0x0
Code;  c0114259 <__wake_up+19/40>
   b:   51                        push   %ecx
Code;  c011425a <__wake_up+1a/40>
   c:   52                        push   %edx
Code;  c011425b <__wake_up+1b/40>
   d:   56                        push   %esi
Code;  c011425c <__wake_up+1c/40>
   e:   e8 7f ff ff ff            call   ffffff92 <_EIP+0xffffff92>
   c01141e0 <__wake_up_common+0/60>
Code;  c0114261 <__wake_up+21/40>
  13:   83 00 00                  addl   $0x0,(%eax)

-------------------------------------------------------

-- 
http://fastmail.fm - The way an email service should be
