Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281797AbRKVWLH>; Thu, 22 Nov 2001 17:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281799AbRKVWK6>; Thu, 22 Nov 2001 17:10:58 -0500
Received: from daytona.gci.com ([205.140.80.57]:60177 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S281797AbRKVWKm>;
	Thu, 22 Nov 2001 17:10:42 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA31506DB3B73@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: leif@denali.net
Subject: RE: Linux-2.4.15-pre9
Date: Thu, 22 Nov 2001 13:10:36 -0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> Quite frankly, right now I'm in "handle only bugs that can crash the
> system mode". [...] My highest priority, in fact, is to get 2.4.15 
> out without any embarrassment.
> 

Well, here's an oops, caused on my Thinkpad 760ED, 80Mb ram.

I can boot into 2.4.15-pre9 without problems, however I get the message
to "Try pci=biosirq"
This option works in 2.4.14 and prior.  [ As a side note, it still does not
fix the problem of my 3ccFE575CT pcmcia card being recognized as anything
but
IRQ0.  2.4.8mdk26 (yea, yeah) does see the card with IRQ=9. ]

adding the 'pci=biosirq' to my kernel boot command line causes an oops:

ksymoops 2.4.3 on i586 2.4.14.  Options used
     -V (default)
     -k /dev/null (specified)
     -l /dev/null (specified)
     -o /lib/modules/2.4.15-pre9 (specified)
     -m /usr/src/linux/System.map (specified)

Error (regular_file): read_ksyms /dev/null is not a regular file, ignored
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
CPU:    0
EIP:    0010:[<c00fdbad>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 0000c026   ebx: 00000000     ecx: 00000030       edx: 00001144
esi: c1144000   edi: c114dfa0     ebp: c114df88       esp: c114df6c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c114d000)
Stack: b10e0246 00000018 c114dfa0 c0251130 00001144 c0252ce4 c00fd9ad
00000000
       00000286 c010ddaa 00000010 00000018 c1144000 40000030 c026c114
00010f00
       c026bfd8 c0105000 0008e000 c027048e c02701d1 00000000 c02510f8
00000000
Call Trace: [<c010ddaa>] [<c010f000>] [<c01a53d6>] [<c0105259>] [<c0105000>]
   [<c0105706>] [<c0105250>]
Code: 66 8e c0 87 f7 e8 dc 00 00 00 e8 68 00 00 00 e8 1f 00 00 00

>>EIP; c00fdbac Before first symbol   <=====
Trace; c010ddaa <pcibios_get_irq_routing_table+4a/100>
Trace; c010f000 <set_mtrr_done+40/70>
Trace; c01a53d6 <pci_init+6/40>
Trace; c0105258 <init+8/140>
Trace; c0105000 <_stext+0/0>
Trace; c0105706 <kernel_thread+26/30>
Trace; c0105250 <init+0/140>
Code;  c00fdbac Before first symbol
00000000 <_EIP>:
Code;  c00fdbac Before first symbol   <=====
   0:   66 8e c0                  mov    %ax,%es   <=====
Code;  c00fdbae Before first symbol
   3:   87 f7                     xchg   %esi,%edi
Code;  c00fdbb0 Before first symbol
   5:   e8 dc 00 00 00            call   e6 <_EIP+0xe6> c00fdc92 Before
first symbol
Code;  c00fdbb6 Before first symbol
   a:   e8 68 00 00 00            call   77 <_EIP+0x77> c00fdc22 Before
first symbol
Code;  c00fdbba Before first symbol
   f:   e8 1f 00 00 00            call   33 <_EIP+0x33> c00fdbde Before
first symbol

 <0>Kernel panic: Attempted to kill init!

1 error issued.  Results may not be reliable.

--

I'd say that this crashes the system.. :-)

Happy Day of thanks to everybody on the list. Without all of us, the world
would not be as fun a place to be.

Leif

