Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263646AbUESPYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUESPYM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbUESPYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:24:12 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:14842 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S263646AbUESPYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:24:07 -0400
Date: Wed, 19 May 2004 11:19:15 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: overlaping printk
Message-ID: <Pine.GSO.4.33.0405191110380.14297-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone explain why the kernel does this on a serial console:

C<PU0 >C2P:U M 3a:ch Mianech iCnhee cCk heExckc epEtxcieopnt: i0o0n0: 0000000000
0000000000000040
00C4P
U 2C:P UE 3IP:: E cI0P:1 0c10fa108 1fEFa8L AEGSF:L AG00S0:0 00200460
0246    e
ax:     e 0ax00: 0000000000 0eb00x:  ebfx7f: a6f070f0a4 0ec00x:  e0c2x:a7 a02bea
7e aebedxe : efdx7f: a6f700f0a4
000     e
si      e: sif7: faf76f0a0040 e0d0i e:d ci0: 10c01f107e1f e7be p:eb 0p:00 000000
00000 e00sp e:s fp:7 faf77ffab45
fb4*
** **Ba*n kBa 0nk:  00:00 0000000000000000000000000000[00[0000000000000000000000
0000000]00] a at t 00000000000000000000000000000000

***** * BaBankn k1 1: :0 000000000000000000000000000000g0eneral protection fault
: 0000 [#1]
...

That's two MCE's being printed at the exact same time. (CPU2 & 3 are a single
P4 Xeon.)  It makes it real damn hard to debug when the errors are printed
like that.

The GPF was printed correctly:
CPU:    3
EIP:    0060:[<c010c0a7>]    Not tainted
EFLAGS: 00010282   (2.6.6-SMP-rc3+BK@1.1386)
EIP is at intel_machine_check+0x12b/0x364
eax: 0000001f   ebx: 00000004   ecx: 00000407   edx: 00006f52
esi: 00000407   edi: 00000000   ebp: 00000000   esp: f7fa5f04
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=f7fa4000 task=f7fa85c0)
Stack: c0304002 00000001 00000000 00000000 f7fa5fb4 0000000f c0120adc 00000003
       00000001 00000000 00000004 00000001 00000000 f7fa4000 02a7abee f7fa4000
       f7fa4000 c0101f7e 00000000 f7fa5fb4 00000246 c0101fa8 00000046 c03cf108
Call Trace:
 [<c0120adc>] run_timer_softirq+0x110/0x180
 [<c0101f7e>] default_idle+0x0/0x2d
 [<c0101fa8>] default_idle+0x2a/0x2d
 [<c010bf7c>] intel_machine_check+0x0/0x364
 [<c01049b5>] error_code+0x2d/0x38
 [<c0101f7e>] default_idle+0x0/0x2d
 [<c0101fa8>] default_idle+0x2a/0x2d
 [<c010201c>] cpu_idle+0x37/0x40
 [<c0119558>] printk+0x172/0x1a8
 [<c03b2981>] print_cpu_info+0x86/0xd2

Code: 0f 32 81 c3 02 04 00 00 89 44 24 08 89 54 24 04 c7 04 24 f7

I wouldn't trust it as it was on the MCE'ing processor.

Note: The answer to "which kernel" is ALL of them. (even the bastard stepchild
redhat 2.4 kernel will do it.)

It goes on to have a fit unblanking a never blanked VT.  Stupid kernel!

--Ricky


