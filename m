Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282799AbRLKTwB>; Tue, 11 Dec 2001 14:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282801AbRLKTvz>; Tue, 11 Dec 2001 14:51:55 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:47508 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S282799AbRLKTvs>; Tue, 11 Dec 2001 14:51:48 -0500
Date: Tue, 11 Dec 2001 11:51:41 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.17-pre8 OOPS with RedHat gcc 3.1-0.10
In-Reply-To: <Pine.LNX.4.33.0112102048390.17524-100000@mf1.private>
Message-ID: <Pine.LNX.4.33.0112111139460.18171-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001, Wayne Whitney wrote:

> I recently upgraded to "gcc version 3.1 20011127 (Red Hat Linux
> Rawhide 3.1-0.10)".  It compiles the recent 2.4.17-preX kernels

Well, it compiles them, but I get an oops on booting 2.4.17-pre8, for
example, almost immediately after init is launched.  "gcc version 2.96
20000731 (Red Hat Linux 7.2 2.96-101.9)" works fine.

The output of ksymoops is below, there were two oopses actually.  Since
the oopses occurred just after init started, and I don't have an initrd, I
believe there were no modules loaded.  I captured the oopses via the line
printer console and had to type them back in.  Too bad there is no floppy
disk console.  I did double check my typing, but the standard disclaimers
apply.

Cheers,
Wayne


ksymoops 2.4.3 on i686 2.4.17-pre8.  Options used
     -v /usr/local/src/linux-2.4.17-pre8-gcc-3.1/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.17-pre8-gcc-3.1 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 0000002f printing eip:
c0106e56
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c0106e56>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: cfda5fc4 ebx: cfda4000 ecx: cfc7d2e8 edx: 00000001
esi: 00000080 edi: bffff860 ebp: 00000003 esp: cfda5f1c
ds: 0018 es: 0018 ss: 0018
Process rc.sysinit (pid: 10, stackpage=cfda50000)
Stack: 00000000 c0283100 cfc7d2e8 cfda4000 00000296 cfc7d2e8 c0142e54 00000000
       cfda4000 00000000 00000000 00000000 cfda4000 cff28a40 cff28a40 fffffe00
       cfc7d280 cfda4000 00000080 c0142fb4 cfc7d280 00000014 080708b0 cfc7d2e8
Call Trace: [<c0142e54>] [<c0142fb4>] [<c0139b87>] [<c0107e24>]
Code: 8b 45 2c 83 e0 03 83 f8 03 74 0d 81 c4 94 00 00 00 89 d0 5b

>>EIP; c0106e56 <do_signal+16/2d0>   <=====
Trace; c0142e54 <pipe_wait+94/c0>
Trace; c0142fb4 <pipe_read+134/220>
Trace; c0139b86 <sys_read+86/110>
Trace; c0107e24 <io_check_error+34/50>
Code;  c0106e56 <do_signal+16/2d0>
00000000 <_EIP>:
Code;  c0106e56 <do_signal+16/2d0>   <=====
   0:   8b 45 2c                  mov    0x2c(%ebp),%eax   <=====
Code;  c0106e58 <do_signal+18/2d0>
   3:   83 e0 03                  and    $0x3,%eax
Code;  c0106e5c <do_signal+1c/2d0>
   6:   83 f8 03                  cmp    $0x3,%eax
Code;  c0106e5e <do_signal+1e/2d0>
   9:   74 0d                     je     18 <_EIP+0x18> c0106e6e <do_signal+2e/2d0>
Code;  c0106e60 <do_signal+20/2d0>
   b:   81 c4 94 00 00 00         add    $0x94,%esp
Code;  c0106e66 <do_signal+26/2d0>
  11:   89 d0                     mov    %edx,%eax
Code;  c0106e68 <do_signal+28/2d0>
  13:   5b                        pop    %ebx

Unable to handle kernel NULL pointer dereference at virtual address 00000037 printing eip:
c0106e56
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c0106e56>]
EFLAGS: 00010292
eax: c13cdfc4 ebx: c13cc000 ecx: 00000000 edx: 00000001
esi: 00000000 edi: bffff878 ebP; 0000000b esp: c13cdf1c
ds: 0018 es: 0018 ss: 0018
Process init (pid: 1, stackpage=c13cd000)
Stack: fffffdfe c014905c cff03140 00000004 c13cdf8c 000001da 00000001 00000004
       00000060 00002107 00000000 00000000 0000002a 00001180 00000001 00000000
       00000000 00000000 cff03148 00000000 00000000 cff03144 00001000 00000000
Call Trace: [<c014905c>] [<c0107324>]
Code: 8b 45 2c 83 e0 03 83 f8 03 74 0d 81 c4 94 00 00 00 89 d0 5b

>>EIP; c0106e56 <do_signal+16/2d0>   <=====
Trace; c014905c <sys_select+1dc/580>
Trace; c0107324 <signal_return+14/18>
Code;  c0106e56 <do_signal+16/2d0>
00000000 <_EIP>:
Code;  c0106e56 <do_signal+16/2d0>   <=====
   0:   8b 45 2c                  mov    0x2c(%ebp),%eax   <=====
Code;  c0106e58 <do_signal+18/2d0>
   3:   83 e0 03                  and    $0x3,%eax
Code;  c0106e5c <do_signal+1c/2d0>
   6:   83 f8 03                  cmp    $0x3,%eax
Code;  c0106e5e <do_signal+1e/2d0>
   9:   74 0d                     je     18 <_EIP+0x18> c0106e6e <do_signal+2e/2d0>
Code;  c0106e60 <do_signal+20/2d0>
   b:   81 c4 94 00 00 00         add    $0x94,%esp
Code;  c0106e66 <do_signal+26/2d0>
  11:   89 d0                     mov    %edx,%eax
Code;  c0106e68 <do_signal+28/2d0>
  13:   5b                        pop    %ebx


