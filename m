Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262405AbSJLIsv>; Sat, 12 Oct 2002 04:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262412AbSJLIsv>; Sat, 12 Oct 2002 04:48:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28104 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262405AbSJLIsq>; Sat, 12 Oct 2002 04:48:46 -0400
Date: Sat, 12 Oct 2002 10:54:32 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: linux-kernel@vger.kernel.org
Subject: kswapd Oops in 2.4.20-pre10
Message-ID: <Pine.NEB.4.44.0210121026550.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My computer wasn't under high load when this happened.
It has 128 MB RAM and 1 GB of swap and the amount of used RAM+swap is
usually far below 128 MB.


<--  snip  -->

$ ps aux|grep kswapd
root         5  0.1  0.0     0    0 ?        Z    07:12   0:16 [kswapd <defunct>]

<--  snip  -->

Oct 12 09:30:31 r063144 kernel: c012fd77
Oct 12 09:30:31 r063144 kernel: Oops: 0002
Oct 12 09:30:31 r063144 kernel: CPU:    0
Oct 12 09:30:31 r063144 kernel: EIP:    0010:[__remove_inode_queue+23/48]    Not tainted
Oct 12 09:30:31 r063144 kernel: EFLAGS: 00010206
Oct 12 09:30:31 r063144 kernel: eax: 00000000   ebx: c1ec8a18   ecx: 00000000   edx: c1ec89c0
Oct 12 09:30:31 r063144 kernel: esi: c1ec8600   edi: c1ec8600   ebp: c11c1f00   esp: c11c1efc
Oct 12 09:30:31 r063144 kernel: ds: 0018   es: 0018   ss: 0018
Oct 12 09:30:31 r063144 kernel: Process kswapd (pid: 5, stackpage=c11c1000)
Oct 12 09:30:31 r063144 kernel: Stack: c1ec89c0 c11c1f1c c01320e6 c1ec89c0 c10f4b98 000001d0 00000016 c10f4b98
Oct 12 09:30:31 r063144 kernel:        c11c1f2c c013075d c1ec8600 c10f4b98 c11c1f60 c01293b1 c10f4b98 000001d0
Oct 12 09:30:31 r063144 kernel:        00000020 000001d0 00000020 c0290f34 c11c0000 000000c4 0000079f 000001d0
Oct 12 09:30:31 r063144 kernel: Call Trace:    [try_to_free_buffers+94/240] [try_to_release_page+69/76] [shrink_cache+485/756] [shrink_caches+86/132] [try_to_free_pages_zone+56/92]
Oct 12 09:30:31 r063144 kernel: Code: 89 48 04 89 01 c7 42 58 00 00 00 00 c7 43 04 00 00 00 00 5b
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  00000003 Before first symbol
   3:   89 01                     mov    %eax,(%ecx)
Code;  00000005 Before first symbol
   5:   c7 42 58 00 00 00 00      movl   $0x0,0x58(%edx)
Code;  0000000c Before first symbol
   c:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  00000013 Before first symbol
  13:   5b                        pop    %ebx

<--  snip  -->

cu
Adrian

-- 

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed





