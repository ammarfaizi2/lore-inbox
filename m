Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129300AbRBVPfm>; Thu, 22 Feb 2001 10:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130133AbRBVPfc>; Thu, 22 Feb 2001 10:35:32 -0500
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:62915 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S129300AbRBVPfW>; Thu, 22 Feb 2001 10:35:22 -0500
Posted-Date: Thu, 22 Feb 2001 16:35:11 +0100 (MET)
Date: Thu, 22 Feb 2001 16:34:43 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200102221534.QAA00658@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: [Oops] 2.4.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2.4.2 oopsed after several seconds. Just after launching ax25 related stuff.

Here is the raw Oops :
----------------------
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0113cf3
*pde = 00001063
*pde = 00000000
OOps = 0
EIP: 0010:[<c0113cf3>]
EFLAGS: 00010017
eax: c67c15a0 abx: 00000000 acx: 00000001 edx: c67c15a4
esi: c6a15680 edi: fffffff8 ebp: c123bedc esp: c123bec0
ds: 0018 es: 0018 sss: 0018
Process kapm-idled (pid:3, stackpage = c123b000)
Stack: c67c1(a0 c6a15680 c02376fc c67c15a4 00000001 00000286 00000001 c123bf44
       c0191bcf c6a15680 c63ee3c0 c01914cf c6A15680 00000000 c0192042 c63ee3c0
       00000000 c02376fc c0193b73 c63ee3c0 00000001 c02375c8 0000000d c0119540
Call Trace: [<c0191bcf>] [<c01914cf>] [<c0192042>] [<c0193b73>] [<c0119540>] [<c010a1d2>] [<c0108e00>]
            [<c0110bba>] [<c0110018>] [<c0110c88>] [<c011138b>] [<c0111cc5>] [<c010740f>] [<c0107418>]

Code: 8b 4f 04 8b 1b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00

Kernel panic. Aiie, killing the interrupt handler!
In interrupt handler - not syscing

Here is the ksymoops processed Oops :
-------------------------------------

ksymoops 2.3.7 on i586 2.4.2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2/ (default)
     -m /boot/System.map-2.4.2 (specified)

Unable to handle kernel paging request at virtual address fffffffc
c0113cf3
*pde = 00001063
*pde = 00000000
EIP: 0010:[<c0113cf3>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010017
eax: c67c15a0 abx: 00000000 acx: 00000001 edx: c67c15a4
esi: c6a15680 edi: fffffff8 ebp: c123bedc esp: c123bec0
ds: 0018 es: 0018 sss: 0018
Stack: c67c1(a0 c6a15680 c02376fc c67c15a4 00000001 00000286 00000001 c123bf44
       c0191bcf c6a15680 c63ee3c0 c01914cf c6A15680 00000000 c0192042 c63ee3c0
       00000000 c02376fc c0193b73 c63ee3c0 00000001 c02375c8 0000000d c0119540
Call Trace: [<c0191bcf>] [<c01914cf>] [<c0192042>] [<c0193b73>] [<c0119540>] [<c010a1d2>] [<c0108e00>]
            [<c0110bba>] [<c0110018>] [<c0110c88>] [<c011138b>] [<c0111cc5>] [<c010740f>] [<c0107418>]
Code: 8b 4f 04 8b 1b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00

>>EIP; c0113cf3 <__wake_up+33/a8>   <=====
Trace; c0191bcf <sock_def_write_space+33/78>
Trace; c01914cf <sock_wfree+17/30>
Trace; c0192042 <__kfree_skb+7e/f4>
Trace; c0193b73 <net_tx_action+4f/a8>
Trace; c0119540 <do_softirq+40/64>
Trace; c010a1d2 <do_IRQ+a2/b0>
Trace; c0108e00 <ret_from_intr+0/20>
Trace; c0110bba <apm_bios_call_simple+4e/58>
Trace; c0110018 <mtrr_read+24/7c>
Trace; c0110c88 <apm_do_idle+14/30>
Trace; c011138b <apm_mainloop+97/100>
Trace; c0111cc5 <apm+275/290>
Trace; c010740f <kernel_thread+1f/38>
Trace; c0107418 <kernel_thread+28/38>
Code;  c0113cf3 <__wake_up+33/a8>
00000000 <_EIP>:
Code;  c0113cf3 <__wake_up+33/a8>   <=====
   0:   8b 4f 04                  mov    0x4(%edi),%ecx   <=====
Code;  c0113cf6 <__wake_up+36/a8>
   3:   8b 1b                     mov    (%ebx),%ebx
Code;  c0113cf8 <__wake_up+38/a8>
   5:   01 85 45 fc 74 51         add    %eax,0x5174fc45(%ebp)
Code;  c0113cfe <__wake_up+3e/a8>
   b:   31 c0                     xor    %eax,%eax
Code;  c0113d00 <__wake_up+40/a8>
   d:   9c                        pushf  
Code;  c0113d01 <__wake_up+41/a8>
   e:   5e                        pop    %esi
Code;  c0113d02 <__wake_up+42/a8>
   f:   fa                        cli    
Code;  c0113d03 <__wake_up+43/a8>
  10:   c7 01 00 00 00 00         movl   $0x0,(%ecx)

Kernel panic. Aiie, killing the interrupt handler!

My configuration :
------------------

ASUS P5A motherboard, K6-2 500 processor, 128Mb SDRAM
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux debian-f5ibh 2.2.19pre13 #1 mar fév 20 20:41:12 CET 2001 i586 unknown
Kernel modules         2.4.2
Gnu C                  2.95.2
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         af_packet scc ax25 parport_probe parport_pc lp parport mousedev usb-ohci hid input autofs lockd sunrpc usbcore serial unix


--------------
Regard
	Jean-Luc
