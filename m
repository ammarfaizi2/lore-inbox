Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTFZT15 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 15:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbTFZT15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 15:27:57 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:35846 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S263025AbTFZT1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 15:27:53 -0400
To: rth@twiddle.net
Cc: linux-kernel@vger.kernel.org
Subject: [ALPHA][2.5.7x] Problems with execve assembly rewriting
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Thu, 26 Jun 2003 21:40:57 +0200
Message-ID: <wrp4r2cpqye.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

A few releases ago, Alpha's implementation of execve was rewritten
entirely in assembly.  Since then, the Jensen is unable to boot
(crashes as soon as it reaches userland).

This is the latest BK :

<quote>
Unable to handle kernel paging request at virtual address 5345432039323a38
swapper(1): Oops 0
pc = [<fffffc0000496080>]  ra = [<fffffc0000499e60>]  ps = 0000    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = fffffc0003fbbdd8  t0 = 00000000616d2820  t1 = 0000000033372e35
t2 = 000000006920676e  t3 = 5345432039323a34  t4 = fffffc0003fbbec0
t5 = fffffc0003fbbec0  t6 = 0000000000000003  t7 = fffffc0003fb8000
s0 = ffffffffde11f2c7  s1 = 000000003f7f1ae7  s2 = ffffffffd1ca0615
s3 = fffffffff3b8134e  s4 = fffffc0000581b60  s5 = 0000000000000000
s6 = fffffc00005229e9
a0 = fffffc00005229e9  a1 = fffffffff3b8134e  a2 = 000000003f7f1ae7
a3 = 0000000000000000  a4 = 000000000001c200  a5 = 0000000000000000
t8 = 0000000000000000  t9 = fffffc0003fc3700  t10= 0000000000002800
t11= 0000000000002580  pv = fffffc0000495fe0  at = 0000000000000001
gp = fffffc00005ad198  sp = fffffc0003fbbad8
Trace:fffffc0000499e60 fffffc0000376468 fffffc00003776ec fffffc0000323b0c fffffc00003134fc fffffc0000348dd0 fffffc0000349124 fffffc00003490a0 fffffc0000318558 fffffc0000318790 fffffc0000442c50 fffffc0000443b68 fffffc000033200c fffffc000032cf38 fffffc0000318244 fffffc0000318ca8 fffffc0000319260 fffffc00003101e8 fffffc0000313448 
Code: 401f000e  e5400098  4189000c  b53e0048  a48f00d8  b7fe0040 <a0240004> e4200058 


>>RA;  fffffc0000499e60 <skb_checksum_help+50/120>

>>PC;  fffffc0000496080 <skb_checksum+a0/360>   <=====

Trace; fffffc0000499e60 <skb_checksum_help+50/120>
Trace; fffffc0000376468 <open_exec+28/150>
Trace; fffffc00003776ec <do_execve+3c/280>
Trace; fffffc0000323b0c <schedule+2cc/4f0>
Trace; fffffc00003134fc <execve+4c/80>
Trace; fffffc0000348dd0 <rmqueue_bulk+a0/d0>
Trace; fffffc0000349124 <buffered_rmqueue+184/1a0>
Trace; fffffc00003490a0 <buffered_rmqueue+100/1a0>
Trace; fffffc0000318558 <setup_irq+f8/120>
Trace; fffffc0000318790 <request_irq+c0/130>
Trace; fffffc0000442c50 <serial8250_interrupt+0/140>
Trace; fffffc0000443b68 <serial8250_set_termios+348/450>
Trace; fffffc000033200c <update_process_times+5c/80>
Trace; fffffc000032cf38 <do_softirq+138/150>
Trace; fffffc0000318244 <handle_IRQ_event+74/f0>
Trace; fffffc0000318ca8 <handle_irq+188/1d0>
Trace; fffffc0000319260 <do_entInt+c0/150>
Trace; fffffc00003101e8 <init+108/1b0>
Trace; fffffc0000313448 <kernel_thread+28/90>

Code;  fffffc0000496068 <skb_checksum+88/360>
0000000000000000 <_PC>:
Code;  fffffc0000496068 <skb_checksum+88/360>
   0:   0e 00 1f 40       addl v0,zero,s5
Code;  fffffc000049606c <skb_checksum+8c/360>
   4:   98 00 40 e5       beq  s1,268 <_PC+0x268>
Code;  fffffc0000496070 <skb_checksum+90/360>
   8:   0c 00 89 41       addl s3,s0,s3
Code;  fffffc0000496074 <skb_checksum+94/360>
   c:   48 00 3e b5       stq  s0,72(sp)
Code;  fffffc0000496078 <skb_checksum+98/360>
  10:   d8 00 8f a4       ldq  t3,216(fp)
Code;  fffffc000049607c <skb_checksum+9c/360>
  14:   40 00 fe b7       stq  zero,64(sp)
Code;  fffffc0000496080 <skb_checksum+a0/360>   <=====
  18:   04 00 24 a0       ldl  t0,4(t3)   <=====
Code;  fffffc0000496084 <skb_checksum+a4/360>
  1c:   58 00 20 e4       beq  t0,180 <_PC+0x180>
</quote>

The stack looks quite messy (what is skb_checksum doing here ?), but
execve caught my eyes... Excluding the whole execve rewriting
change-set let the system boot without any problem.

Let me know if I can do something to help debugging the thing.

Regards,

        M.
-- 
Places change, faces change. Life is so very strange.
