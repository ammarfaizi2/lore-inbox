Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275097AbRJUBsS>; Sat, 20 Oct 2001 21:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275098AbRJUBsI>; Sat, 20 Oct 2001 21:48:08 -0400
Received: from ns-3.dglnet.com.br ([200.246.42.67]:38528 "HELO
	ns-3.dglnet.com.br") by vger.kernel.org with SMTP
	id <S275097AbRJUBr4>; Sat, 20 Oct 2001 21:47:56 -0400
Date: Sat, 20 Oct 2001 23:48:29 -0200
To: linux-kernel@vger.kernel.org
Subject: kernel-2.4.12-ac3 sparc4m SMP oops
Message-ID: <20011020234829.A585@dglnet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
From: edson@dglnet.com.br (Edson Y. Fugio)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was instaling squid on my sparc20, SMP debian box, and hit this:

ksymoops 2.4.1 on sparc 2.4.12-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12-ac3/ (default)
     -m /boot/System.map-2.4.12-ac3 (specified)

Oct 20 18:54:58 nx01 kernel: kernel BUG at /usr/src/linux/include/asm/highmem.h:124!
Oct 20 18:54:58 nx01 kernel: Unable to handle kernel NULL pointer dereference<1>tsk->{mm,active_mm}->context = 00000a29
Oct 20 18:54:58 nx01 kernel: tsk->{mm,active_mm}->pgd = fc01a800
Oct 20 18:54:58 nx01 kernel:               \|/ ____ \|/
Oct 20 18:54:58 nx01 kernel:               "@'/ ,. \`@"
Oct 20 18:54:58 nx01 kernel:               /_| \__/ |_\
Oct 20 18:54:58 nx01 kernel:                  \__U_/
Oct 20 18:54:58 nx01 kernel: dpkg-preconfigu(2613): Oops
Oct 20 18:54:58 nx01 kernel: PSR: 408010c0 PC: f003f128 NPC: f003f12c Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
Oct 20 18:54:58 nx01 kernel: g0: f01c9c00 g1: 40001fe6 g2: 00000001 g3: 00000000 g4: f3f4a000 g5: f01c9b14 g6: f337e000 g7: 00000100
Oct 20 18:54:58 nx01 kernel: o0: 00000038 o1: 404010e0 o2: f01c9c00 o3: f01c9c00 o4: f01c9f4c o5: f018d3a0 sp: f337fd48 o7: f003f120
Oct 20 18:54:58 nx01 kernel: l0: f3230000 l1: f337e3b8 l2: f0204800 l3: efffefff l4: 000000f8 l5: 69636520 l6: f337e000 l7: 50130f54
Oct 20 18:54:58 nx01 kernel: i0: 0000000a i1: f0d451a0 i2: fc01c8e0 i3: f053d4c8 i4: 002b8000 i5: 00285754 fp: f337fdb0 i7: f003f1d0
Oct 20 18:54:58 nx01 kernel: Caller[f003f1d0]
Oct 20 18:54:58 nx01 kernel: Caller[f003f424]
Oct 20 18:54:58 nx01 kernel: Caller[f0022504]
Oct 20 18:54:58 nx01 kernel: Caller[f001505c]
Oct 20 18:54:58 nx01 kernel: Caller[5025cb14]
Oct 20 18:54:58 nx01 kernel: Instruction DUMP: 92126090  7fffb1d7  9410207c <c0202000> 7fff9c48  01000000  d204a28c  912e2002  90024008 

>>PC;  f003f128 <do_anonymous_page+1c4/238>   <=====
>>O7;  f003f120 <do_anonymous_page+1bc/238>
>>I7;  f003f1d0 <do_no_page+34/1c8>
Trace; f003f1d0 <do_no_page+34/1c8>
Trace; f003f424 <handle_mm_fault+c0/184>
Trace; f0022504 <do_sparc_fault+200/450>
Trace; f001505c <srmmu_fault+58/68>
Trace; 5025cb14 Before first symbol
Code;  f003f11c <do_anonymous_page+1b8/238>
00000000 <_PC>:
Code;  f003f11c <do_anonymous_page+1b8/238>
   0:   92 12 60 90       or  %o1, 0x90, %o1
Code;  f003f120 <do_anonymous_page+1bc/238>
   4:   7f ff b1 d7       call  fffec760 <_PC+0xfffec760> f002b87c <printk+0/1e4>
Code;  f003f124 <do_anonymous_page+1c0/238>
   8:   94 10 20 7c       mov  0x7c, %o2
Code;  f003f128 <do_anonymous_page+1c4/238>   <=====
   c:   c0 20 20 00       clr  [ %g0 ]   <=====
Code;  f003f12c <do_anonymous_page+1c8/238>
  10:   7f ff 9c 48       call  fffe7130 <_PC+0xfffe7130> f002624c <viking_flush_cache_all+0/0>
Code;  f003f130 <do_anonymous_page+1cc/238>
  14:   01 00 00 00       nop 
Code;  f003f134 <do_anonymous_page+1d0/238>
  18:   d2 04 a2 8c       ld  [ %l2 + 0x28c ], %o1
Code;  f003f138 <do_anonymous_page+1d4/238>
  1c:   91 2e 20 02       sll  %i0, 2, %o0
Code;  f003f13c <do_anonymous_page+1d8/238>
  20:   90 02 40 08       add  %o1, %o0, %o0

Oct 20 18:55:06 nx01 kernel: spin_lock(f2430830) CPU#1 stuck at f0040c68, owner PC(f003efdc):CPU(1)
Warning (Oops_read): Code line not seen, dumping what data is available

>>PC;  f0040c68 <exit_mmap+10/17c>   <=====
>>PC;  f003efdc <do_anonymous_page+78/238>   <=====
Trace; f2430830 <end+21da868/e169038>


1 warning issued.  Results may not be reliable.
