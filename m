Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318229AbSG3LZ7>; Tue, 30 Jul 2002 07:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318228AbSG3LZ6>; Tue, 30 Jul 2002 07:25:58 -0400
Received: from mout1.freenet.de ([194.97.50.132]:3546 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S318229AbSG3LZ5>;
	Tue, 30 Jul 2002 07:25:57 -0400
Date: Tue, 30 Jul 2002 13:29:34 +0200
From: Axel Siebenwirth <axel@hh59.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.29: Oops in handle_scancode.
Message-ID: <20020730112934.GA372@prester.freenet.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I encountered following oops invoked from swapper. Unfortunately I do not
remember when it happened.. sorry.

ksymoops 2.4.6 on i686 2.5.29.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.29/ (default)
     -m /boot/System.map-2.5.29 (specified)

Unable to handle kernel paging request at virtual address 5a5a5a66
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01ffc12>]       Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 5a5a5a5a ebx: 0000000e ecx: 00000000 edx: 0000000e
esi: c923d000 edi: cbbfae00 ebp: c031e944 esp: c02c5ed4
ds: 0018 es: 0018 ss: 0018
Stack: 0000000e c02c5ef3 00000000 00000001 00000001 00000000 00000046
0e00006c
       0000000e 0000270f c02c5f6c 00000001 c02002ac 0000000e 00000001
00fffffe
       c02c4000 00000001 c02002ca cbc1b21c c0109495 00000001 00000000
c02c5f6c
Call Trace: [<c02002ac>] [<c02002ca>] [<c0109495>] [<c01096c7>] [<c0107fa4>]
[<c01e12ab>] [<c0105410>] [<c01e1130>] [<c0105410>] [<c01054ca>]
[<c0105000>]
Code: f6 40 0c 08 0f 84 ee 00 00 00 0f b6 5d 01 a1 f0 cc 2b c0 09


>>EIP; c01ffc12 <handle_scancode+122/2f0>   <=====

>>esi; c923d000 <_end+8f0abfc/c5e3bfc>
>>edi; cbbfae00 <_end+b8c89fc/c5e3bfc>
>>ebp; c031e944 <kbd_table+4/fc>
>>esp; c02c5ed4 <init_thread_union+1ed4/2000>

Trace; c02002ac <handle_kbd_event+bc/c0>
Trace; c02002ca <keyboard_interrupt+1a/30>
Trace; c0109495 <handle_IRQ_event+45/70>
Trace; c01096c7 <do_IRQ+97/120>
Trace; c0107fa4 <common_interrupt+18/20>
Trace; c01e12ab <acpi_processor_idle+17b/230>
Trace; c0105410 <default_idle+0/40>
Trace; c01e1130 <acpi_processor_idle+0/230>
Trace; c0105410 <default_idle+0/40>
Trace; c01054ca <cpu_idle+3a/50>
Trace; c0105000 <_stext+0/0>

Code;  c01ffc12 <handle_scancode+122/2f0>
00000000 <_EIP>:
Code;  c01ffc12 <handle_scancode+122/2f0>   <=====
   0:   f6 40 0c 08               testb  $0x8,0xc(%eax)   <=====
Code;  c01ffc16 <handle_scancode+126/2f0>
   4:   0f 84 ee 00 00 00         je     f8 <_EIP+0xf8> c01ffd0a
<handle_scancode+21a/2f0>
Code;  c01ffc1c <handle_scancode+12c/2f0>
   a:   0f b6 5d 01               movzbl 0x1(%ebp),%ebx
Code;  c01ffc20 <handle_scancode+130/2f0>
   e:   a1 f0 cc 2b c0            mov    0xc02bccf0,%eax
Code;  c01ffc25 <handle_scancode+135/2f0>
  13:   09 00                     or     %eax,(%eax)

<0>Kernel panic: Aiee, killing interrupt handler!


Best regards,
Axel Siebenwirth
