Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130214AbRAHD5Q>; Sun, 7 Jan 2001 22:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130797AbRAHD5H>; Sun, 7 Jan 2001 22:57:07 -0500
Received: from adsl-63-204-197-52.dsl.snfc21.pacbell.net ([63.204.197.52]:64004
	"EHLO mail.topdollargeek.com") by vger.kernel.org with ESMTP
	id <S130214AbRAHD4r>; Sun, 7 Jan 2001 22:56:47 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Ooops on 2.4.0 SMP Sparc32...
Message-ID: <978926205.3a593a7d917cf@www.sunshinecomputing.com>
Date: Sun, 07 Jan 2001 19:56:45 -0800 (PST)
From: Brian Macy <bmacy@macykids.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 63.204.197.51
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is very easily repeated... happens a few minutes after boot. After it
happens one CPU gets stuck on a spin lock owned by the other.

This kernel was built from code pulled down from cvs@vger.samba.org:/vger on Jan
5th. Looked like the first merge of the 2.4.0 released code... but the Ooops
happened on the CVS 2.4.0-prerelease also.

Brian Macy

job:~# cat ~bmacy/sparc.oops | ksymoops -K -m /boot/System.map-2.4.0
ksymoops 2.3.4 on sparc 2.2.18.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18/ (default)
     -m /boot/System.map-2.4.0 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer
dereference<1>tsk->{mm,active_mm}->context
= 00000185
tsk->{mm,active_mm}->pgd = fc074400
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
apache(408): Oops
PSR: 1e101fc5 PC: f004804c NPC: f0048050 Y: 00000000
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: f01adc00 g1: 1e401fe7 g2: 00000000 g3: 1e4010e1 g4: f0063848 g5: f015f944
g6: f07e6000 g7: 00000000
o0: 00000400 o1: f4860040 o2: f48604c0 o3: 00000006 o4: 00000018 o5: fd004000
sp: f07e7bf0 o7: f0048018
l0: f4860020 l1: 0000007d l2: 00000000 l3: 00000020 l4: 1e401fc6 l5: f01a6dc4
l6: 00000000 l7: f018e0e0
i0: f053e278 i1: 00000007 i2: f056c400 i3: f0138c00 i4: f0138c00 i5: 1e4010e6
fp: f07e7c58 i7: f0048270
Caller[f0048270]
Caller[f006f9f0]
Caller[f0063904]
Caller[f006467c]
Caller[f0065594]
Caller[f005380c]
Caller[f0053ca4]
Caller[f0015360]
Caller[501a3914]
Instruction DUMP: d6242014  d0040000  d0262008 <d2048000> a2047fff
912a6002
90020012  d4222008  92026001

>>PC;  f004804c <kmem_cache_alloc_batch+7c/ec> <=====
>>O7;  f0048018 <kmem_cache_alloc_batch+48/ec> >>I7;  f0048270
<kmem_cache_alloc+78/150> Trace; f0048270 <kmem_cache_alloc+78/150> Trace;
f006f9f0 <d_alloc+10/1cc> Trace; f0063904 <real_lookup+4c/178> Trace; f006467c
<path_walk+9dc/d2c> Trace; f0065594 <open_namei+70/6d8> Trace; f005380c
<filp_open+2c/54> Trace; f0053ca4 <sys_open+48/20c> Trace; f0015360
<syscall_is_too_hard+34/40> Trace; 501a3914 Before first symbol
Code;  f0048040 <kmem_cache_alloc_batch+70/ec> 0000000000000000 <_PC>:
Code;  f0048040 <kmem_cache_alloc_batch+70/ec> 0:   d6 24 20 14       st  %o3, [
%l0 + 0x14 ]
Code;  f0048044 <kmem_cache_alloc_batch+74/ec> 4:   d0 04 00 00       ld  [ %l0
], %o0
Code;  f0048048 <kmem_cache_alloc_batch+78/ec> 8:   d0 26 20 08       st  %o0, [
%i0 + 8 ]
Code;  f004804c <kmem_cache_alloc_batch+7c/ec> <=====
   c:   d2 04 80 00       ld  [ %l2 ], %o1   <=====
Code;  f0048050 <kmem_cache_alloc_batch+80/ec> 10:   a2 04 7f ff       add  %l1,
-1, %l1
Code;  f0048054 <kmem_cache_alloc_batch+84/ec> 14:   91 2a 60 02       sll  %o1,
2, %o0
Code;  f0048058 <kmem_cache_alloc_batch+88/ec> 18:   90 02 00 12       add  %o0,
%l2, %o0
Code;  f004805c <kmem_cache_alloc_batch+8c/ec> 1c:   d4 22 20 08       st  %o2,
[ %o0 + 8 ]
Code;  f0048060 <kmem_cache_alloc_batch+90/ec> 20:   92 02 60 01       inc  %o1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
