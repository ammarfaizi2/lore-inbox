Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270724AbRHPDcb>; Wed, 15 Aug 2001 23:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270725AbRHPDcW>; Wed, 15 Aug 2001 23:32:22 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:27144 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S270724AbRHPDcQ>;
	Wed, 15 Aug 2001 23:32:16 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108160332.f7G3WLV229057@saturn.cs.uml.edu>
Subject: Re: Problems with sound in 2.4.x (.7 and .8 definitely) with CS4248
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 15 Aug 2001 23:32:21 -0400 (EDT)
Cc: vichu@digitalme.com (Trever Adams), linux-kernel@vger.kernel.org
In-Reply-To: <E15X719-0003ua-00@the-village.bc.nu> from "Alan Cox" at Aug 15, 2001 09:11:55 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> [somebody]

>> Whether it be MP3, OGG, or whatever, I cannot play sound
>> without getting the following message in 2.4.7 and 2.4.8 (I
>> don't believe I tried any other versions).  However, I
>> believe it works (unless hardware failure has happened in
>> the past 6 mos) in 2.2.x.
>>
>> Sound: DMA (output) timed out - IRQ/DRQ config error?
>
> This message occurs when the audio doesn't generate an
> interrupt for the completion of a block of sound. It might
> for example indicate that the irq setting passed when you
> configured it was wrong.

I just saw this for the first time, with a 2.4.8-pre4 kernel.
For perhaps 1/2 of a second, my MP3 went quiet and my mouse
got stuck. Then the above message pops up on my serial console
and everything goes back to normal.

The hardware is a genuine Sound Blaster 16. I'm sure of the
IRQ and DMA settings because I had to set them with jumpers.
It has been years since I changed the hardware.

Kernel command line:

aha152x=0x340,11,7,1 sb=0x220,7,1,5,0x330 opl3=0x388
nopnp console=ttyS0,38400n8 console=tty0

This system was stable until it met the 2.4 kernel. It's an
old Pentium system that has worked for years. It still passes
both memtest86 and cpuburn. I've had a few lockups, and one
oops captured on the serial console as well.

I might as well give you the oops. You can have it raw and with
ksymoops processing, plus you get a few bonus System.map lines.
Basic info: PentiumMMX, gcc version 2.96 20000731, no 3d video.

----------------------------------------------------------------
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01051c4>]
EFLAGS: 00000246
eax: 00000000   ebx: c02d0000   ecx: 00000000   edx: 00000019
esi: c01051a0   edi: c02d0000   ebp: ffffe000   esp: c02d1fdc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02d1000)
Stack: c0105232 00004000 0009b800 c0105000 0008e000 c02d2877 c03083a0 00000000
       c0100197
Call Trace: [<c0105232>] [<c0105000>]

Code: c3 fb c3 89 f6 8d bc 27 00 00 00 00 fb 83 c8 ff ba 00 e0 ff
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
--------------------------------------------------------------------------
ksymoops 2.3.4 on i586 2.4.8-pre4.  Options used
     -v /boot/vmlinux-2.4.8-pre4 (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.8-pre4 (specified)

invalid operand: 0000
CPU:    0
EIP:    0010:[<c01051c4>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000246
eax: 00000000   ebx: c02d0000   ecx: 00000000   edx: 00000019
esi: c01051a0   edi: c02d0000   ebp: ffffe000   esp: c02d1fdc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02d1000)
Stack: c0105232 00004000 0009b800 c0105000 0008e000 c02d2877 c03083a0 00000000
       c0100197
Call Trace: [<c0105232>] [<c0105000>]
Code: c3 fb c3 89 f6 8d bc 27 00 00 00 00 fb 83 c8 ff ba 00 e0 ff

>>EIP; c01051c4 <default_idle+24/30>   <=====
Trace; c0105232 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>
Code;  c01051c4 <default_idle+24/30>
00000000 <_EIP>:
Code;  c01051c4 <default_idle+24/30>   <=====
   0:   c3                        ret       <=====
Code;  c01051c5 <default_idle+25/30>
   1:   fb                        sti    
Code;  c01051c6 <default_idle+26/30>
   2:   c3                        ret    
Code;  c01051c7 <default_idle+27/30>
   3:   89 f6                     mov    %esi,%esi
Code;  c01051c9 <default_idle+29/30>
   5:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi
Code;  c01051d0 <poll_idle+0/20>
   c:   fb                        sti    
Code;  c01051d1 <poll_idle+1/20>
   d:   83 c8 ff                  or     $0xffffffff,%eax
Code;  c01051d4 <poll_idle+4/20>
  10:   ba 00 e0 ff 00            mov    $0xffe000,%edx

Kernel panic: Attempted to kill the idle task!
------------------------------------------------------------------
c0100148 t is386
c0100197 t L6
c0100199 t ready
c0104000 T empty_zero_page
c0105000 T _stext
c0105000 T stext
c0105000 t rest_init
c0105030 t prepare_namespace
c0105040 t init
c0105180 T disable_hlt
c0105190 T enable_hlt
c01051a0 t default_idle
c01051d0 t poll_idle
c01051f0 T cpu_idle
c0105250 T machine_real_restart
c01052f0 T machine_restart
c02d0000 D init_task_union
c02d2790 T start_kernel
c02d2880 t do_initcalls
c03083a0 b command_line
----------------------------------------------------------------
