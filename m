Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267806AbUJONki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267806AbUJONki (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUJONjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:39:53 -0400
Received: from mail-gateway-0-1.landonet.net ([196.25.111.196]:49099 "EHLO
	mail-gateway-0-1.landonet.net") by vger.kernel.org with ESMTP
	id S267798AbUJONgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:36:25 -0400
Message-ID: <416FD24C.7020007@lbsd.net>
Date: Fri, 15 Oct 2004 13:36:12 +0000
From: Nigel Kukard <nkukard@lbsd.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040712
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc4-bk2 bug report
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While booting with 2.6.9rc4-bk2 I seem to get the below OOPS, I copied 
the modules & System.map file over to another box of mine where i used 
serial-console to grab the oops.

Anyone know what I can try to debug the below problem?

The box is a 2.8Ghz P4 with HT enabled (smp).

Kind Regards
Nigel Kukard



ksymoops 2.4.9 on i686 2.6.8-0.23.  Options used
      -V (default)
      -K (specified)
      -L (specified)
      -o /tmp/2.6.9-0.8 (specified)
      -m /tmp/System.map-2.6.9-0.8 (specified)

No modules in ksyms, skipping objects
kernel BUG at kernel/timer.c:414!
invalid operand: 0000 [#1]
EIP:    0060:[<c01279e0>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010007   (2.6.9-0.8)
eax: c1810a60   ebx: f7097d6c   ecx: 0000000f   edx: f7097d6c
esi: c18112e4   edi: c1810a60   ebp: 0000000f   esp: c064afb0
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 c05f9f88 c1810a60 c064afc8 c0127f86 c064afc8 c064afc8 
c064afc8
        c01247c0 00000001 c05f9f88 c0643bc0 00000000 c01244a4 0000000a 
c05fbf90
        00000046 c0641484 006c8007 c01097f4
Call Trace:
  [<c0127f86>] run_timer_softirq+0xe6/0x160
  [<c01247c0>] tasklet_action+0x50/0xc0
  [<c01244a4>] __do_softirq+0x64/0xe0
  [<c01097f4>] do_softirq+0x44/0x4b
  [<c01161ed>] smp_apic_timer_interrupt+0xfd/0x100
  [<c0106fda>] apic_timer_interrupt+0x1a/0x20
  [<c010405a>] default_idle+0x2a/0x40
  [<c01040d4>] cpu_idle+0x24/0x60
  [<c05fc86d>] start_kernel+0x18d/0x1c0
Code: ca 53 89 c7 89 cd 8b 1e eb 11 90 89 da 39 7b 1c 75 19 89 f8 8b 1b 
e8 80 fb ff ff 39 f3 75 ec 89 36 89 76 04 89 e8 5b 5e 5f 5d c3 <0f> 0b 
9e 01 ff 23 4d c0 eb dd 8d b6 00 00 00 00 0f bf 05 7a dc


 >>EIP; c01279e0 <cascade+30/40>   <=====

 >>eax; c1810a60 <pg0+116aa60/3f958400>
 >>ebx; f7097d6c <pg0+369f1d6c/3f958400>
 >>edx; f7097d6c <pg0+369f1d6c/3f958400>
 >>esi; c18112e4 <pg0+116b2e4/3f958400>
 >>edi; c1810a60 <pg0+116aa60/3f958400>
 >>esp; c064afb0 <softirq_stack+fb0/8000>

Trace; c0127f86 <run_timer_softirq+e6/160>
Trace; c01247c0 <tasklet_action+50/c0>
Trace; c01244a4 <__do_softirq+64/e0>
Trace; c01097f4 <do_softirq+44/4b>
Trace; c01161ed <smp_apic_timer_interrupt+fd/100>
Trace; c0106fda <apic_timer_interrupt+1a/20>
Trace; c010405a <default_idle+2a/40>
Trace; c01040d4 <cpu_idle+24/60>
Trace; c05fc86d <start_kernel+18d/1c0>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c01279b5 <cascade+5/40>
00000000 <_EIP>:
Code;  c01279b5 <cascade+5/40>
    0:   ca 53 89                  lret   $0x8953
Code;  c01279b8 <cascade+8/40>
    3:   c7 89 cd 8b 1e eb 11      movl   $0xda899011,0xeb1e8bcd(%ecx)
Code;  c01279bf <cascade+f/40>
    a:   90 89 da
Code;  c01279c2 <cascade+12/40>
    d:   39 7b 1c                  cmp    %edi,0x1c(%ebx)
Code;  c01279c5 <cascade+15/40>
   10:   75 19                     jne    2b <_EIP+0x2b>
Code;  c01279c7 <cascade+17/40>
   12:   89 f8                     mov    %edi,%eax
Code;  c01279c9 <cascade+19/40>
   14:   8b 1b                     mov    (%ebx),%ebx
Code;  c01279cb <cascade+1b/40>
   16:   e8 80 fb ff ff            call   fffffb9b <_EIP+0xfffffb9b>
Code;  c01279d0 <cascade+20/40>
   1b:   39 f3                     cmp    %esi,%ebx
Code;  c01279d2 <cascade+22/40>
   1d:   75 ec                     jne    b <_EIP+0xb>
Code;  c01279d4 <cascade+24/40>
   1f:   89 36                     mov    %esi,(%esi)
Code;  c01279d6 <cascade+26/40>
   21:   89 76 04                  mov    %esi,0x4(%esi)
Code;  c01279d9 <cascade+29/40>
   24:   89 e8                     mov    %ebp,%eax
Code;  c01279db <cascade+2b/40>
   26:   5b                        pop    %ebx
Code;  c01279dc <cascade+2c/40>
   27:   5e                        pop    %esi
Code;  c01279dd <cascade+2d/40>
   28:   5f                        pop    %edi
Code;  c01279de <cascade+2e/40>
   29:   5d                        pop    %ebp
Code;  c01279df <cascade+2f/40>
   2a:   c3                        ret

This decode from eip onwards should be reliable

Code;  c01279e0 <cascade+30/40>
00000000 <_EIP>:
Code;  c01279e0 <cascade+30/40>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c01279e2 <cascade+32/40>
    2:   9e                        sahf
Code;  c01279e3 <cascade+33/40>
    3:   01 ff                     add    %edi,%edi
Code;  c01279e5 <cascade+35/40>
    5:   23 4d c0                  and    0xffffffc0(%ebp),%ecx
Code;  c01279e8 <cascade+38/40>
    8:   eb dd                     jmp    ffffffe7 <_EIP+0xffffffe7>
Code;  c01279ea <cascade+3a/40>
    a:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c01279f0 <second_overflow+0/260>
   10:   0f                        .byte 0xf
Code;  c01279f1 <second_overflow+1/260>
   11:   bf                        .byte 0xbf
Code;  c01279f2 <second_overflow+2/260>
   12:   05                        .byte 0x5
Code;  c01279f3 <second_overflow+3/260>
   13:   7a dc                     jp     fffffff1 <_EIP+0xfffffff1>
