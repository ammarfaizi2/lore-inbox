Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUCaU3m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 15:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUCaU3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 15:29:42 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:2539 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262450AbUCaU3h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 15:29:37 -0500
To: linux-kernel@vger.kernel.org
Subject: "kernel BUG at usb-ohci.h:464!" and 8139too -- 2.4.25
Mail-Copies-To: never
X-Face: ,MPrV]g0IX5D7rgJol{*%.pQltD?!TFg(`c8(2pkt-F0SLh(g3mIFYU1GYf]C/GuUTbr;cZ5y;3ALK%.OL8A.^.PW14e/,X-B?Nv}2a9\u-j0sSa
From: Roland Mas <roland.mas@free.fr>
Date: Wed, 31 Mar 2004 22:29:32 +0200
Message-ID: <87lllg3glv.fsf@mirexpress.internal.placard.fr.eu.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is my ADSL gateway/firewall.  Old ISA card (module ne), which has
worked flawlessly for months.  USB modem based on the Eagle chipset by
Analog Devices Inc. (ADI), driver is not in mainline kernel, but it
also has worked for months (except when my ISP played silly buggers).
Kernel is vanilla 2.4.25, system is Debian Woody (plus backport of the
modem driver).

  I have recently (on Monday) bought a new PCI 10/100 Ethernet NIC,
based on the Realtek 8139 chipset.  Module is 8139too, seems to work
fine.  I left the old one in, just for kicks (my first multi-NIC box,
woo!).

  eth0 is the 8139too, eth1 is the ne, eth2 is a virtual interface
used by the ADSL modem, then there's lo and ppp0.

  My problem: after some time (a few hours), I get a kernel panic
speaking of a "kernel BUG at usb-ohci.h:464!".  The only USB
peripheral is the ADSL modem.  If I unload 8139too and alias eth0 ne,
but leave the Realtek NIC plugged in, I get no such panic.

  Here's the oops, snapshot with my camcorder then typed into an
editor and sent through ksymoops:
,----
| ksymoops 2.4.5 on i586 2.4.25.  Options used
|      -V (default)
|      -k /proc/ksyms (default)
|      -l /proc/modules (default)
|      -o /lib/modules/2.4.25/ (default)
|      -m /boot/System.map-2.4.25 (default)
| 
| Warning: You did not tell me where to find symbol information.  I will
| assume that the log matches the kernel and modules that are running
| right now and I'll use the default options above for symbol resolution.
| If the current kernel and/or modules do not match the log, you can get
| more accurate output by telling me the kernel version and where to find
| map, modules, ksyms etc.  ksymoops -h explains the options.
| 
| kernel BUG at usb-ohci.h:464!
| invalid operand: 0000
| CPU:    0
| EIP:    0010:[<c4862f47>]    Not tainted
| Using defaults from ksymoops -t elf32-i386 -a i386
| EFLAGS: 00010046
| eax: 00000000   ebx: c3d5d800     ecx: c3d5d800       edx: f000e2c8
| esi: c484a000   edi: 00000000     ebp: c0237fac       esp: c0237f30
| ds: 0018   es: 0018   ss: 0018
| Process swapper (pid: 0, stackpage=c0237000)
| Stack: c3d5d800 c484a000 0000000b c0237fac 00000246 00000000 c486412b c3d5d800
|        c3b0c9a0 04000001 0000000b c0237fac 00000002 c0107ecf 0000000b c3d5d800
|        c0237fac 00000160 c0246a60 0000000b c0237fa4 c010803e 0000000b c0237fac
| Call Trace:    [<c486412b>] [<c0107ecf>] [<c010803e>] [<c0105260>] [<c010a208>]
|   [<c0105260>] [<c0105283>] [<c01052e7>] [<c0105000>] [<c0105027>]
| Code: 0f 0b d0 01 aa 47 86 c4 8b 38 89 fd 8b 07 c1 e8 1c 74 50 8b
| 
| 
| >>EIP; c4862f47 <[usb-ohci]dl_reverse_done_list+63/f0>   <=====
| 
| >>ebx; c3d5d800 <_end+3aef4f4/4593cf4>
| >>ecx; c3d5d800 <_end+3aef4f4/4593cf4>
| >>edx; f000e2c8 <END_OF_CODE+2b6fb749/????>
| >>esi; c484a000 <[parport].bss.end+19c1/39c1>
| >>ebp; c0237fac <init_task_union+1fac/2000>
| >>esp; c0237f30 <init_task_union+1f30/2000>
| 
| Trace; c486412b <[usb-ohci]hc_interrupt+ab/160>
| Trace; c0107ecf <handle_IRQ_event+2f/58>
| Trace; c010803e <do_IRQ+72/b4>
| Trace; c0105260 <default_idle+0/28>
| Trace; c010a208 <call_do_IRQ+5/d>
| Trace; c0105260 <default_idle+0/28>
| Trace; c0105283 <default_idle+23/28>
| Trace; c01052e7 <cpu_idle+3f/54>
| Trace; c0105000 <_stext+0/0>
| Trace; c0105027 <rest_init+27/28>
| 
| Code;  c4862f47 <[usb-ohci]dl_reverse_done_list+63/f0>
| 00000000 <_EIP>:
| Code;  c4862f47 <[usb-ohci]dl_reverse_done_list+63/f0>   <=====
|    0:   0f 0b                     ud2a      <=====
| Code;  c4862f49 <[usb-ohci]dl_reverse_done_list+65/f0>
|    2:   d0 01                     rolb   (%ecx)
| Code;  c4862f4b <[usb-ohci]dl_reverse_done_list+67/f0>
|    4:   aa                        stos   %al,%es:(%edi)
| Code;  c4862f4c <[usb-ohci]dl_reverse_done_list+68/f0>
|    5:   47                        inc    %edi
| Code;  c4862f4d <[usb-ohci]dl_reverse_done_list+69/f0>
|    6:   86 c4                     xchg   %al,%ah
| Code;  c4862f4f <[usb-ohci]dl_reverse_done_list+6b/f0>
|    8:   8b 38                     mov    (%eax),%edi
| Code;  c4862f51 <[usb-ohci]dl_reverse_done_list+6d/f0>
|    a:   89 fd                     mov    %edi,%ebp
| Code;  c4862f53 <[usb-ohci]dl_reverse_done_list+6f/f0>
|    c:   8b 07                     mov    (%edi),%eax
| Code;  c4862f55 <[usb-ohci]dl_reverse_done_list+71/f0>
|    e:   c1 e8 1c                  shr    $0x1c,%eax
| Code;  c4862f58 <[usb-ohci]dl_reverse_done_list+74/f0>
|   11:   74 50                     je     63 <_EIP+0x63> c4862faa <[usb-ohci]dl_reverse_done_list+c6/f0>
| Code;  c4862f5a <[usb-ohci]dl_reverse_done_list+76/f0>
|   13:   8b 00                     mov    (%eax),%eax
| 
|  <0>Kernel panic: Aiee, killing interrupt handler!
| 
| 1 warning issued.  Results may not be reliable.
`----

  I have no idea where the bug is, should I bug the usb-ohci
maintainer, or is it likely to be triggered by 8139too, or the
adiusbadsl module?  Should I try a 2.4.26-rc1 kernel?

Thanks,

Roland.
-- 
Roland Mas

Bada, bada, ba-da-da-daaa, doudou, doudou, dou-dou-dou-dou-baaa.
  -- in Song without words #1 (Paul Leavitt)
