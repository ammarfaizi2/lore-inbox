Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276046AbRI1NdN>; Fri, 28 Sep 2001 09:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275996AbRI1NdC>; Fri, 28 Sep 2001 09:33:02 -0400
Received: from ns.muni.cz ([147.251.4.33]:967 "EHLO aragorn.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S276046AbRI1Ncw>;
	Fri, 28 Sep 2001 09:32:52 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.10: oops and panic in usb-uhci
X-URL: http://www.fi.muni.cz/~pekon/
From: Petr Konecny <pekon@informatics.muni.cz>
Date: 28 Sep 2001 15:33:01 +0200
Message-ID: <qwwpu8bigoi.fsf@decibel.fi.muni.cz>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.5 (anise)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried to play a wav on my USB audio speakers (Yamaha YSTMS35D) and got
panic. The oops (processed by ksymoops) is appended. uhci works OK.

                                                Regards, Petr

ksymoops 2.4.3 on i686 2.4.10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10/ (default)
     -m /boot/System.map-2.4.10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

chazelle login: Unable to handle kernel paging request at virtual address ffffffdc
cc902471
*pde = 00001063
Oops: 0000
CPU:    0
EIP:    0010:[<cc902471>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010203
eax: 00000000   ebx: c7dd746c   ecx: 00000000   edx: c02e9400
esi: 00000000   edi: c7dd73c0   ebp: c7df3000   esp: c0281eec
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0281000)
Stack: c7dd746c c7dd73c0 c1322d60 00000000 00000010 c7dea120 00000000 00000001 
       cc9025f9 c1322d60 c7dd73c0 00000000 c7dd746c c1322d60 00000000 00000000 
       00000000 c011ad8f 00000000 cc90284d c1322d60 c7dd73c8 ca905360 04000001 
Call Trace: [<cc9025f9>] [<c011ad8f>] [<cc90284d>] [<c0107d0f>] [<c0107e6e>] 
   [<c0105150>] [<c0105150>] [<c0105150>] [<c0105150>] [<c0105173>] [<c01051d9>] 
   [<c0105000>] [<c0105027>] 
Code: 8b 46 dc 8d 6e d8 a9 00 00 80 00 74 39 25 ff ff 7f ff 89 46 

>>EIP; cc902470 <[usb-uhci]process_iso+64/184>   <=====
Trace; cc9025f8 <[usb-uhci]process_urb+68/1fc>
Trace; c011ad8e <timer_bh+22e/268>
Trace; cc90284c <[usb-uhci]uhci_interrupt+c0/120>
Trace; c0107d0e <handle_IRQ_event+2e/58>
Trace; c0107e6e <do_IRQ+6e/b0>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0105172 <default_idle+22/28>
Trace; c01051d8 <cpu_idle+40/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105026 <rest_init+26/28>
Code;  cc902470 <[usb-uhci]process_iso+64/184>
00000000 <_EIP>:
Code;  cc902470 <[usb-uhci]process_iso+64/184>   <=====
   0:   8b 46 dc                  mov    0xffffffdc(%esi),%eax   <=====
Code;  cc902472 <[usb-uhci]process_iso+66/184>
   3:   8d 6e d8                  lea    0xffffffd8(%esi),%ebp
Code;  cc902476 <[usb-uhci]process_iso+6a/184>
   6:   a9 00 00 80 00            test   $0x800000,%eax
Code;  cc90247a <[usb-uhci]process_iso+6e/184>
   b:   74 39                     je     46 <_EIP+0x46> cc9024b6 <[usb-uhci]process_iso+aa/184>
Code;  cc90247c <[usb-uhci]process_iso+70/184>
   d:   25 ff ff 7f ff            and    $0xff7fffff,%eax
Code;  cc902482 <[usb-uhci]process_iso+76/184>
  12:   89 46 00                  mov    %eax,0x0(%esi)

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

-- 
Life sucks, but death doesn't put out at all.
		-- Thomas J. Kopp
