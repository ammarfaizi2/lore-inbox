Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314556AbSD3CHw>; Mon, 29 Apr 2002 22:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315115AbSD3CHv>; Mon, 29 Apr 2002 22:07:51 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:55698 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S314556AbSD3CHu>; Mon, 29 Apr 2002 22:07:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.11 ide kernel panic
Date: Mon, 29 Apr 2002 20:01:15 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02042920011502.00813@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's my next attempt to get the kernel working.
This is 2.5.11 + framebuffer patch for compilation + framebuffer patch for 
kernel panic (both from James Simmons).

Oops portion below was copied from the screen. 
It's a portion since the rest scrolled off the screen.
Inaccuracies are possible but unlikely ( I double-checked). 

 ksymoops 2.4.0 on i686 2.4.19-pre3.  Options used
     -v /usr/src/linux-2.5.11/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.11 (specified)
     -m /boot/System.map-2.5.11 (specified)

No modules in ksyms, skipping objects
EIP: 0010: [<c01db5d5>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 0001006
eax: c0332cfc ebx: d3de75c0 ecx: 000000f
esi: 20000001 edi: 00000000 ebp: d3eee000
ds: 0018 es: 0018 ss: 0018
Stack: d3eee000 00000092 c0332cfc d3de75c0
       20000001 0000000f d3eefe2c c0108559
       0000000f c0332cfc d3eefe2c d3eee000
       0000000f d3eee000 c0308cc0 c0108730
       0000000f d3eefe2c d3de75c0 d3de75c0
       d3eee000 00000575 c0332de8 00000000
Call Trace: [<c0108559>] [<c0108730>] [<c010718e>]
            [<c0186834>] [<c01dcbeb>] [<c01dd964>] [<c01ddcd0>]
            [<c01dde1e>] [<c01de0bd>] [<c01deddc>] [<c01dba65>]
            [<c01dc45b>] [<c0116c61>] [<c0105000>] [<c0105070>]
            [<c0105000>] [<c0105646>] [<c0105050>]
Code: 8b 07 85 c0 89 04 24 74 0a 8b 9f 88 00 00 00 85 db 74 0f ff

>>EIP; c01db5d5 <ata_irq_request+25/130>   <=====
Trace; c0108559 <handle_IRQ_event+39/60>
Trace; c0108730 <do_IRQ+90/f0>
Trace; c010718e <common_interrupt+22/28>
Trace; c0186834 <__rdtsc_delay+14/20>
Trace; c01dcbeb <ide_delay_50ms+1b/30>
Trace; c01dd964 <actual_try_to_identify+d4/3f0>
Trace; c01ddcd0 <try_to_identify+50/c0>
Trace; c01dde1e <do_probe+de/220>
Trace; c01de0bd <probe_hwif+6d/4b0>
Trace; c01deddc <ideprobe_init+5c/b0>
Trace; c01dba65 <ide_probe_module+5/10>
Trace; c01dc45b <ide_register_hw+15b/1a0>
Trace; c0116c61 <printk+131/160>
Trace; c0105000 <_stext+0/0>
Trace; c0105070 <init+20/180>
Trace; c0105000 <_stext+0/0>
Trace; c0105646 <kernel_thread+26/30>
Trace; c0105050 <init+0/180>
Code;  c01db5d5 <ata_irq_request+25/130>
00000000 <_EIP>:
Code;  c01db5d5 <ata_irq_request+25/130>   <=====
   0:   8b 07                     mov    (%edi),%eax   <=====
Code;  c01db5d7 <ata_irq_request+27/130>
   2:   85 c0                     test   %eax,%eax
Code;  c01db5d9 <ata_irq_request+29/130>
   4:   89 04 24                  mov    %eax,(%esp,1)
Code;  c01db5dc <ata_irq_request+2c/130>
   7:   74 0a                     je     13 <_EIP+0x13> c01db5e8 
<ata_irq_reques
t+38/130>
Code;  c01db5de <ata_irq_request+2e/130>
   9:   8b 9f 88 00 00 00         mov    0x88(%edi),%ebx
Code;  c01db5e4 <ata_irq_request+34/130>
   f:   85 db                     test   %ebx,%ebx
Code;  c01db5e6 <ata_irq_request+36/130>
  11:   74 0f                     je     22 <_EIP+0x22> c01db5f7 
<ata_irq_reques
t+47/130>
Code;  c01db5e8 <ata_irq_request+38/130>
  13:   ff 00                     incl   (%eax)

<0> Kernel Panic: Aiee, killing interrupt handler!
	
-> Then in the original oops message:   "In interrupt handler - not syncing."
