Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285369AbSA2WhN>; Tue, 29 Jan 2002 17:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285482AbSA2Wg5>; Tue, 29 Jan 2002 17:36:57 -0500
Received: from donna.siteprotect.com ([64.41.120.44]:61195 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S285226AbSA2Wgh>; Tue, 29 Jan 2002 17:36:37 -0500
Date: Tue, 29 Jan 2002 17:36:37 -0500 (EST)
From: Vince Weaver <vince@deater.net>
X-X-Sender: <vince@hal.deaternet.vmw>
To: <linux-kernel@vger.kernel.org>
Subject: Oops on 2.4.17 possibly UMS-DOS related
Message-ID: <Pine.LNX.4.31.0201291728480.15872-100000@hal.deaternet.vmw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


X oopsed once on me after about a week of uptime, and now whenever I try
to run "startx" I get the message

umsdos_lookup_x: tmp/..LINK256 negative after link

followed by the below oops.

System is slackware 8.0 with a hand-compiled stock 2.4.17 kernel,
64MB RAM, Pentium II 300Mhz, Matrox Millenium II graphics card.
Filesystem is a 4GB vfat drive with umsdos running on top.  It worked fine
until this happened... rebooting doesn't help, nor does "umssync" and I
can't figure out which file is causing the problem (assuming it really is
a UMS DOS problem, the decoded oops seems a bit odd, but I have made sure
the system map file is the proper one).


ksymoops 2.4.3 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /usr/src/linux/System.map (default)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Unable to handle kernel NULL pointer dereference at virtual address 00000008
c012d4d4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012d4d4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c2e803a0   ebx: c2e803a0   ecx: 00000000   edx: c2e803a0
esi: fffffff7   edi: c2e801a0   ebp: 00000000   esp: c3addf9c
ds: 0018   es: 0018   ss: 0018
Process X (pid: 420, stackpage=c3add000)
Stack: c2e803a0 fffffff7 bffffb7b 0000000b c012cb38 c3adc000 00000001 bffffb7b
       bfffe99c c0106b0b 00000000 bfffd990 0000000b 00000001 bffffb7b bfffe99c
       00000004 0000002b 0000002b 00000004 40100f54 00000023 00000297 bfffd93c
Call Trace: [<c012cb38>] [<c0106b0b>]
Code: 8b 75 08 ff 4b 14 0f 94 c0 84 c0 0f 84 ac 00 00 00 53 e8 8d

>>EIP; c012d4d4 <fput+c/d0>   <=====
Trace; c012cb38 <sys_write+bc/c4>
Trace; c0106b0a <system_call+32/38>
Code;  c012d4d4 <fput+c/d0>
0000000000000000 <_EIP>:
Code;  c012d4d4 <fput+c/d0>   <=====
   0:   8b 75 08                  mov    0x8(%ebp),%esi   <=====
Code;  c012d4d6 <fput+e/d0>
   3:   ff 4b 14                  decl   0x14(%ebx)
Code;  c012d4da <fput+12/d0>
   6:   0f 94 c0                  sete   %al
Code;  c012d4dc <fput+14/d0>
   9:   84 c0                     test   %al,%al
Code;  c012d4de <fput+16/d0>
   b:   0f 84 ac 00 00 00         je     bd <_EIP+0xbd> c012d590 <fput+c8/d0>
Code;  c012d4e4 <fput+1c/d0>
  11:   53                        push   %ebx
Code;  c012d4e6 <fput+1e/d0>
  12:   e8 8d 00 00 00            call   a4 <_EIP+0xa4> c012d578 <fput+b0/d0>

 <1>Unable to handle kernel paging request at virtual address aaebd499
aaebd499
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<aaebd499>]    Not tainted
EFLAGS: 00010282
eax: c2e803d0   ebx: c2e803a0   ecx: c3adc264   edx: c2e803a0
esi: 00000000   edi: c06ae260   ebp: 00000001   esp: c3adde5c
ds: 0018   es: 0018   ss: 0018
Process X (pid: 420, stackpage=c3add000)
Stack: c2e803d7 c012c665 c2e803a0 00000005 00000000 c0115908 c2e803a0 c06ae260
       c1188d00 c3adc000 0000000b 00000008 c06ae380 c0115e8f c06ae260 00000000
       c1188d1c c0cfe840 c010704b 0000000b 00000000 c01109a7 c0248f9e c3addf68
Call Trace: [<c012c665>] [<c0115908>] [<c0115e8f>] [<c010704b>] [<c01109a7>]
   [<c0110658>] [<c011f62a>] [<c01107b8>] [<c0110658>] [<c0134765>] [<c01358b4>]
   [<c0106bfc>] [<c012d4d4>] [<c012cb38>] [<c0106b0b>]
Code:  Bad EIP value.

>>EIP; aaebd498 Before first symbol   <=====
Trace; c012c664 <filp_close+34/64>
Trace; c0115908 <put_files_struct+54/bc>
Trace; c0115e8e <do_exit+a6/1cc>
Trace; c010704a <die+4e/50>
Trace; c01109a6 <do_page_fault+34e/498>
Trace; c0110658 <do_page_fault+0/498>
Trace; c011f62a <handle_mm_fault+52/b4>
Trace; c01107b8 <do_page_fault+160/498>
Trace; c0110658 <do_page_fault+0/498>
Trace; c0134764 <path_release+c/2c>
Trace; c01358b4 <open_namei+430/524>
Trace; c0106bfc <error_code+34/3c>
Trace; c012d4d4 <fput+c/d0>
Trace; c012cb38 <sys_write+bc/c4>
Trace; c0106b0a <system_call+32/38>



