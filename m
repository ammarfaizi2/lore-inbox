Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbTH1LIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 07:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbTH1LIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 07:08:24 -0400
Received: from dark.pcgames.pl ([195.205.62.2]:40068 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id S263891AbTH1LIV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 07:08:21 -0400
Date: Thu, 28 Aug 2003 13:08:03 +0200 (CEST)
From: =?ISO-8859-2?Q?Krzysztof_Ol=EAdzki?= <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: <linux-kernel@vger.kernel.org>
cc: Atul Mukker <atul.mukker@lsil.com>
Subject: Megaraid does not work with 2.4.22 
Message-ID: <Pine.LNX.4.33.0308281202570.9443-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It seems that Megaraid does not work with 2.4.22 at least on
my machine. I don't know when it stopped working because I have never used
this SCSI adapter before. During kernel boot magararid's driver generates
nasty opps. This is the output from oops parsed by ksymoops:

ksymoops 2.4.9 on i686 2.4.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22 (specified)
     -m /boot/System.map-2.4.22 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
cpu: 0, clocks: 1333384, slice: 666692
PI_DEBUG for details.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Unable to handle kernel NULL pointer dereference at virtual address 0000000f
c0262330
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0262330>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: cfeb0078   ebx: 00000000   ecx: 00000005   edx: 00000018
esi: 00000000   edi: 00000000   ebp: cfeb0078   esp: c12ddd44
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c12dd000)
Stack: c12dc000 cfee9860 04000001 c026207b cfeb0078 00000000 00000001 00000000
       c12dddcc c12ddd68 c12ddd68 00000000 c0426b60 fffffffe 00000046 c011bf02
       c011be16 00000000 00000001 00000046 c0426b60 c0426900 00000000 00000001
Call Trace:    [<c026207b>] [<c011bf02>] [<c011be16>] [<c0108b8e>] [<c010b2ad>]
  [<c01089d5>] [<c0108b54>] [<c010b1f8>] [<c0108fa1>] [<c0262030>] [<c0108c35>]
  [<c02630c9>] [<c0262030>] [<c01172ff>] [<c01173f5>] [<c0105000>] [<c0263669>]
  [<c02303e6>] [<c023a4c3>] [<c015cac2>] [<c0105000>] [<c0230235>] [<c0105000>]
  [<c015c927>] [<c015cd33>] [<c0105000>] [<c0105053>] [<c0105000>] [<c010579e>]
  [<c0105040>]
Code: 80 7e 0f 00 74 1e c7 04 24 58 8d 06 00 43 e8 cd b8 0d 00 81


>>EIP; c0262330 <mega_busyWaitMbox+20/50>   <=====

Trace; c026207b <megaraid_isr+4b/2e0>
Trace; c011bf02 <bh_action+22/40>
Trace; c011be16 <tasklet_hi_action+46/70>
Trace; c0108b8e <do_IRQ+9e/a0>
Trace; c010b2ad <call_apic_timer_interrupt+5/10>
Trace; c01089d5 <handle_IRQ_event+45/70>
Trace; c0108b54 <do_IRQ+64/a0>
Trace; c010b1f8 <call_do_IRQ+5/d>
Trace; c0108fa1 <setup_irq+71/a0>
Trace; c0262030 <megaraid_isr+0/2e0>
Trace; c0108c35 <request_irq+a5/e0>
Trace; c02630c9 <mega_findCard+3b9/7d0>
Trace; c0262030 <megaraid_isr+0/2e0>
Trace; c01172ff <__call_console_drivers+5f/70>
Trace; c01173f5 <call_console_drivers+65/120>
Trace; c0105000 <_stext+0/0>
Trace; c0263669 <megaraid_detect+189/2b0>
Trace; c02303e6 <scsi_unregister_host+1a6/480>
Trace; c023a4c3 <ahc_linux_detect+23/60>
Trace; c015cac2 <proc_create+b2/100>
Trace; c0105000 <_stext+0/0>
Trace; c0230235 <scsi_register_host+2e5/2f0>
Trace; c0105000 <_stext+0/0>
Trace; c015c927 <proc_register+17/a0>
Trace; c015cd33 <create_proc_entry+83/d0>
Trace; c0105000 <_stext+0/0>
Trace; c0105053 <init+13/130>
Trace; c0105000 <_stext+0/0>
Trace; c010579e <arch_kernel_thread+2e/40>
Trace; c0105040 <init+0/130>

Code;  c0262330 <mega_busyWaitMbox+20/50>
00000000 <_EIP>:
Code;  c0262330 <mega_busyWaitMbox+20/50>   <=====
   0:   80 7e 0f 00               cmpb   $0x0,0xf(%esi)   <=====
Code;  c0262334 <mega_busyWaitMbox+24/50>
   4:   74 1e                     je     24 <_EIP+0x24>
Code;  c0262336 <mega_busyWaitMbox+26/50>
   6:   c7 04 24 58 8d 06 00      movl   $0x68d58,(%esp,1)
Code;  c026233d <mega_busyWaitMbox+2d/50>
   d:   43                        inc    %ebx
Code;  c026233e <mega_busyWaitMbox+2e/50>
   e:   e8 cd b8 0d 00            call   db8e0 <_EIP+0xdb8e0>
Code;  c0262343 <mega_busyWaitMbox+33/50>
  13:   81 00 00 00 00 00         addl   $0x0,(%eax)

 <0>Kernel panic: Aiee, killing interrupt handler!

1 error issued.  Results may not be reliable.


Best Ragards,

				Krzysztof Olêdzki

