Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbUC3JAx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbUC3JAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:00:53 -0500
Received: from solarsystems.de ([217.160.216.16]:45737 "EHLO solarsystems.de")
	by vger.kernel.org with ESMTP id S263531AbUC3JAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:00:49 -0500
Date: Tue, 30 Mar 2004 11:00:48 +0200
To: linux-kernel@vger.kernel.org
Subject: Alpha/2.6.4: Kernel bug at mm/page_alloc.c:752
Message-ID: <20040330090048.GA8022@solarsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: Christian Vogel <chris@solarsystems.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to get 2.6.4 running on a AlphaStation 250 4/266.
I get a BUG right after mounting the root filesystem,
Compiled using gcc-3.3.3, binutils from cvs[1]. 

Any ideas? You can get .config, system.map, serial console log here:
        http://www.hedonism.cx/~chris/bug_alpha/

        Chris

[1]: binutins from cvs, because older binutils segfault on linking.
        The bug also happened when using gcc-3.3.2 and latest release
        plus a simple patch against that segfault on linking

Kernel bug at mm/page_alloc.c:752
        ---> this is BUG_ON(!virt_addr_valid(addr));
swapper(1): Kernel Bug 1
pc = [<fffffc000034cfc4>]  ra = [<fffffc0000320bcc>]  ps = 0000    Not
tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 0000000000000000  t0 = 0000000000000000  t1 = fffffc00005d01d0
t2 = 0000000000000001  t3 = 0000000000000001  t4 = 0000000000000000
t5 = fffffc0007fe2ec0  t6 = 0000000000000001  t7 = fffffc0007f80000
a0 = fffffc000052c000  a1 = 0000000000000000  a2 = fffffc0007e37cc0
a3 = 0000000000000000  a4 = 0000000000000000  a5 = 000000000000001f
t8 = 0000000000000004  t9 = fffffc00003b37dc  t10= 0000000000000080
t11= 0000000000000020  pv = 0000000000000000  at = fffffc0000392d98
gp = fffffc00005cff80  sp = fffffc0007f83e28
Trace:fffffc0000320bcc fffffc0000320d2c fffffc0000310164
fffffc0000313018 
Code: 40200561  40200441  23bd2fe8  402b064c  c3ffffd0  00000081
<000002f0> 004e0745 


>>RA;  fffffc0000320bcc <free_reserved_mem+10c/240>

>>PC;  fffffc000034cfc4 <free_pages+144/1f0>   <=====

Trace; fffffc0000320bcc <free_reserved_mem+10c/240>
Trace; fffffc0000320d2c <free_initmem+2c/70>
Trace; fffffc0000310164 <init+44/130>
Trace; fffffc0000313018 <kernel_thread+28/90>

Code;  fffffc000034cfac <free_pages+12c/1f0>
0000000000000000 <_PC>:
Code;  fffffc000034cfac <free_pages+12c/1f0>
   0:   61 05 20 40       s4subq       t0,v0,t0
Code;  fffffc000034cfb0 <free_pages+130/1f0>
   4:   41 04 20 40       s4addq       t0,v0,t0
Code;  fffffc000034cfb4 <free_pages+134/1f0>
   8:   e8 2f bd 23       lda  gp,12264(gp)
Code;  fffffc000034cfb8 <free_pages+138/1f0>
   c:   4c 06 2b 40       s8addq       t0,s2,s3
Code;  fffffc000034cfbc <free_pages+13c/1f0>
  10:   d0 ff ff c3       br   ffffffffffffff54 <_PC+0xffffffffffffff54>
fffffc000034cf00 <free_pages+80/1f0>
Code;  fffffc000034cfc0 <free_pages+140/1f0>
  14:   81 00 00 00       call_pal     0x81
Code;  fffffc000034cfc4 <free_pages+144/1f0>   <=====
  18:   f0 02 00 00       call_pal     0x2f0   <=====
Code;  fffffc000034cfc8 <free_pages+148/1f0>
  1c:   45 07 4e 00       call_pal     0x4e0745

-- 
Christian Vogel -- chris@solarsystems.de
