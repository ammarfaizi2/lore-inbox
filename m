Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265711AbUAKC4O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 21:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265729AbUAKC4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 21:56:14 -0500
Received: from potato.cts.ucla.edu ([149.142.36.49]:5254 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S265711AbUAKC4J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 21:56:09 -0500
Date: Sat, 10 Jan 2004 18:56:08 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23 SMP: kernel BUG at mmap.c
Message-ID: <Pine.LNX.4.58.0401101731430.11363@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday I had a kernel oops twice within half an hour.  Both are decoded
below.  The system is an SMP P3 with 4Gb of RAM.


-Chris

ver_linux:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux iris 2.4.23 #1 SMP Sun Nov 30 06:32:09 PST 2003 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
jfsutils               1.1.4
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         eepro100 mii




ksymoops 2.4.5 on i686 2.4.23.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23/ (default)
     -m /boot/System.map-2.4.23 (specified)

Jan  9 19:35:11 iris kernel: kernel BUG at mmap.c:1166!
Jan  9 19:35:11 iris kernel: invalid operand: 0000
Jan  9 19:35:11 iris kernel: CPU:    0
Jan  9 19:35:11 iris kernel: EIP:    0010:[exit_mmap+249/288]    Not tainted
Jan  9 19:35:11 iris kernel: EFLAGS: 00010286
Jan  9 19:35:11 iris kernel: eax: 00000060   ebx: 00000000   ecx: c281ece4   edx: 00000060
Jan  9 19:35:11 iris kernel: esi: d86b4f20   edi: bfffb000   ebp: d3e9ff88   esp: d3e9ff74
Jan  9 19:35:11 iris kernel: ds: 0018   es: 0018   ss: 0018
Jan  9 19:35:11 iris kernel: Process gather (pid: 4348, stackpage=d3e9f000)
Jan  9 19:35:11 iris kernel: Stack: d86b4f20 40153344 d3e9e000 00005000 00000000 d3e9ff98 c0115a6a d86b4f20
Jan  9 19:35:11 iris kernel:        d86b4f20 d3e9ffb0 c011a6b6 d86b4f20 d3e9e000 40153344 00000000 d3e9ffbc
Jan  9 19:35:11 iris kernel:        c011a904 00000000 bffffdec c0106fa3 00000000 080480f4 40154e48 40153344
Jan  9 19:35:11 iris kernel: Call Trace:    [mmput+94/124] [do_exit+190/740] [sys_wait4+0/952] [system_call+51/56]
Jan  9 19:35:11 iris kernel: Code: 0f 0b 8e 04 21 14 28 c0 68 00 03 00 00 6a 00 56 e8 a6 d1 ff
Using defaults from ksymoops -t elf32-i386 -a i386


>>ecx; c281ece4 <_end+24875f0/388f590c>
>>esi; d86b4f20 <_end+1831d82c/388f590c>
>>edi; bfffb000 Before first symbol
>>ebp; d3e9ff88 <_end+13b08894/388f590c>
>>esp; d3e9ff74 <_end+13b08880/388f590c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   8e 04 21                  movl   (%ecx,1),%es
Code;  00000005 Before first symbol
   5:   14 28                     adc    $0x28,%al
Code;  00000007 Before first symbol
   7:   c0 68 00 03               shrb   $0x3,0x0(%eax)
Code;  0000000b Before first symbol
   b:   00 00                     add    %al,(%eax)
Code;  0000000d Before first symbol
   d:   6a 00                     push   $0x0
Code;  0000000f Before first symbol
   f:   56                        push   %esi
Code;  00000010 Before first symbol
  10:   e8 a6 d1 ff 00            call   ffd1bb <_EIP+0xffd1bb> 00ffd1bb Before first symbol



ksymoops 2.4.5 on i686 2.4.23.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23/ (default)
     -m /boot/System.map-2.4.23 (specified)

Jan  9 19:56:32 iris kernel:  kernel BUG at mmap.c:1166!
Jan  9 19:56:32 iris kernel: invalid operand: 0000
Jan  9 19:56:32 iris kernel: CPU:    0
Jan  9 19:56:32 iris kernel: EIP:    0010:[exit_mmap+249/288]    Not tainted
Jan  9 19:56:32 iris kernel: EFLAGS: 00010286
Jan  9 19:56:32 iris kernel: eax: 000000b2   ebx: 00000000   ecx: c281ece4   edx: 000000b2
Jan  9 19:56:32 iris kernel: esi: d86b4e80   edi: bfffb000   ebp: c55f3f88   esp: c55f3f74
Jan  9 19:56:32 iris kernel: ds: 0018   es: 0018   ss: 0018
Jan  9 19:56:32 iris kernel: Process gather (pid: 32212, stackpage=c55f3000)
Jan  9 19:56:32 iris kernel: Stack: d86b4e80 40153344 c55f2000 00005000 00000000 c55f3f98 c0115a6a d86b4e80
Jan  9 19:56:32 iris kernel:        d86b4e80 c55f3fb0 c011a6b6 d86b4e80 c55f2000 40153344 00000000 c55f3fbc
Jan  9 19:56:32 iris kernel:        c011a904 00000000 bffffdec c0106fa3 00000000 080480f4 40154e48 40153344
Jan  9 19:56:32 iris kernel: Call Trace:    [mmput+94/124] [do_exit+190/740] [sys_wait4+0/952] [system_call+51/56]
Jan  9 19:56:32 iris kernel: Code: 0f 0b 8e 04 21 14 28 c0 68 00 03 00 00 6a 00 56 e8 a6 d1 ff
Using defaults from ksymoops -t elf32-i386 -a i386


>>ecx; c281ece4 <_end+24875f0/388f590c>
>>esi; d86b4e80 <_end+1831d78c/388f590c>
>>edi; bfffb000 Before first symbol
>>ebp; c55f3f88 <_end+525c894/388f590c>
>>esp; c55f3f74 <_end+525c880/388f590c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   8e 04 21                  movl   (%ecx,1),%es
Code;  00000005 Before first symbol
   5:   14 28                     adc    $0x28,%al
Code;  00000007 Before first symbol
   7:   c0 68 00 03               shrb   $0x3,0x0(%eax)
Code;  0000000b Before first symbol
   b:   00 00                     add    %al,(%eax)
Code;  0000000d Before first symbol
   d:   6a 00                     push   $0x0
Code;  0000000f Before first symbol
   f:   56                        push   %esi
Code;  00000010 Before first symbol
  10:   e8 a6 d1 ff 00            call   ffd1bb <_EIP+0xffd1bb> 00ffd1bb Before first symbol


