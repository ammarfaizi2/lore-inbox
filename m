Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279588AbRKOBMN>; Wed, 14 Nov 2001 20:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279548AbRKOBME>; Wed, 14 Nov 2001 20:12:04 -0500
Received: from news.heim1.tu-clausthal.de ([139.174.234.200]:47529 "EHLO
	neuemuenze.heim1.tu-clausthal.de") by vger.kernel.org with ESMTP
	id <S279156AbRKOBLo>; Wed, 14 Nov 2001 20:11:44 -0500
Date: Thu, 15 Nov 2001 02:11:42 +0100
From: Sven.Riedel@tu-clausthal.de
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 Oops during boot (KT133A Problem?)
Message-ID: <20011115021142.A12923@moog.heim1.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: I already sent this Oops-Report to the list a few days ago, but I
didn't see it arrive. I apologize in case this mail reaches the list
twice...]

Hi,
I get the following kernel oops when booting 2.4.14 vanilla on an Athlon
1200, KT133A Chipset Motherboard, 768MB RAM. Kernel has been compiled
for Athlon CPUs, non-SMP. The next thing the kernel would have done
after the oops would have been to start kswapd. 
Sidenote: booting the exact same kernel from floppy (debian rescue with
kernels exchanged and booting with 'linux root=/dev/hda6') gives me a rather
unstable system for a short while (uptime usually < 6 hours before oopsing).

Linux NET 4.0 for Linux 2.4
Based upon Swansea University Computer Society Net 3.039
Unable to handle kernel NULL pointer dereference at virtual address
00000003 printing eip:
c0112073
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0112073>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: f7efe000   ebx: f7efe000     ecx: 00000000 edx: ffffffff
esi: c1e1a5a0 edi: fffffff5     ebp: 00000700       esp: c1e1bf50
ds: 0018        es: 0018       ss:0018
Process swapper (pid: 1, stackpage=c1e1b000)
Stack: c1e1a000 c1e1bfc4 c023d3c0 c1e1bf88 00000000 00000000 c0228f80 00000004
        c0228f80 c01058be 00000700 00000078 c1e1bf90 00000000 0008e000 c0106c4b
        00000700 00000078 c011ded0 c1e1bfc4 c023d3c0 0008e000 00000078 00000018
Call Trace: [<c01058be>] [<c0106c4b>] [<c011ded0>] [<c01054df>] [<c011e124>]
        [<c011ded0>] [<c0105047>] [<c01054e8>]
Code: 8b 42 04 3b 83 18 02 00 00 0f 83 a7 05 00 00 ff 02 8b 83 e4

>>EIP; c0112072 <do_fork+62/640>   <=====
Trace; c01058be <sys_clone+1e/30>
Trace; c0106c4a <system_call+32/38>
Trace; c011ded0 <context_thread+0/1a0>
Trace; c01054de <kernel_thread+1e/40>
Trace; c011e124 <start_context_thread+14/30>
Trace; c011ded0 <context_thread+0/1a0>
Trace; c0105046 <init+6/110>
Trace; c01054e8 <kernel_thread+28/40>
Code;  c0112072 <do_fork+62/640>
00000000 <_EIP>:
Code;  c0112072 <do_fork+62/640>   <=====
   0:   8b 42 04                  mov    0x4(%edx),%eax   <=====
Code;  c0112074 <do_fork+64/640>
   3:   3b 83 18 02 00 00         cmp    0x218(%ebx),%eax
Code;  c011207a <do_fork+6a/640>
  9:   0f 83 a7 05 00 00         jae    5b6 <_EIP+0x5b6> c0112628
<do_fork+618/640>
Code;  c0112080 <do_fork+70/640>
   f:   ff 02                     incl   (%edx)
Code;  c0112082 <do_fork+72/640>
  11:   8b 83 e4 00 00 00         mov    0xe4(%ebx),%eax

 <0>Kernel panic: Attempted to kill init!

Regs,
Sven
-- 
Sven Riedel                      sr@gimp.org
Osteroeder Str. 6 / App. 13      sven.riedel@tu-clausthal.de
38678 Clausthal                  "Call me bored, but don't call me boring."
                                 - Larry Wall 
