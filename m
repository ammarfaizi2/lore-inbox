Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281696AbRKUK0q>; Wed, 21 Nov 2001 05:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281563AbRKUK0m>; Wed, 21 Nov 2001 05:26:42 -0500
Received: from vti01.vertis.nl ([145.66.4.26]:10757 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S281599AbRKUK00>;
	Wed, 21 Nov 2001 05:26:26 -0500
Date: Wed, 21 Nov 2001 11:26:05 +0100
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
Message-Id: <200111211026.LAA24599@linux06.vertis.nl>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.14 oopses
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Included two kernel oopses. The kernel freezes, so I had to write down 
everything from console, there may be errors. Further more the kernel has 
some patches, listed below.

The crashing kernel is 2.4.14, it seems to crash quite reproducably. The 
previous kernel on this machine was 2.4.8 which ran without any problems. I 
had to reboot to 2.4.8 to get the machine running again.

Of course this is not the most straightforward kernel (with all the patches),
so this problem report may not be of use. One specific patch is the one that 
removes the deactivate_page calls from loop.c.

Rolf

Linux kernel 2.4.14
* FreeS/WAN 1.91
* X.509 Certificate Support 0.8.5
* 3Dfx module
* Alsa 0.5.12
* QLogic Fibre Channel Driver for QLA2x00 4.25
* VLAN packet size support for 3c59x NICs
* HZ is 2048 instead of 100
* netfilter 1.2.4
* LVM 1.0.1-rc4
* lm_sensors 2.6.1
* Intel e1000 3.1.23

Module                  Size  Used by
nfs                    87776   1 (autoclean)
nfsd                   74288   0 (autoclean)
lockd                  52448   1 (autoclean) [nfs nfsd]
sunrpc                 70112   1 (autoclean) [nfs nfsd lockd]
ipt_REDIRECT            1344   4 (autoclean)
iptable_nat            25872   0 (autoclean) [ipt_REDIRECT]
ip_conntrack           29152   1 (autoclean) [ipt_REDIRECT iptable_nat]
ip_tables              14400   4 [ipt_REDIRECT iptable_nat]
eepro100               17216   1 (autoclean)
st                     28496   0 (unused)
unix                   18112  13 (autoclean)
cpqarray               17040   8
aic7xxx               111984   0 (unused)

ksymoops 0.7c on i686 2.4.8-clk.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14-fks/ (specified)
     -m /boot/System.map-2.4.14-fks (specified)

ksymoops 0.7c on i686 2.4.8-clk.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.14-fks/ (specified)
     -m /boot/System.map-2.4.14-fks (specified)

No modules in ksyms, skipping objects
Invalid operand: 0000
CPU: 0
EIP: 0010:[<c012f486>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 0000001d ebx: c1b972b0 ecx: c029be0c edx: 000018f4
esi: c029d9e4 edi: 00000001 ebp: c1b972b0 esp: f05d1e50
ds: 0018 es:0 018 ss: 0010
Process fsck.ext2 (pid 106, stackpage=f05d10000)
Stack: c0248532 00000310 eba2e568 c029d9e4 c01448f1 00000000 f74b0134 00000001
       f77ff400 f8821ae7 eba2ef68 00000001 c232c4ec 24000001 00000000 0000000a
       00000001 00000002 c0100d76 0000000a f77ff400 f05d1ee8 c02f5940 c02f5950
Call Trace: [<c01448f1>] [<f8821ae7>] [<c0108d76>] [<c010908d>] [<c013029b>]
            [<c012ff4d>] [<c0130385>] [<c0130210>] [<c01423aa>] [<c01076a3>]
Code: 0f 0b 83 c4 08 90 8d 74 26 00 8d 73 24 8d 73 24 8d 43 2c 39 43 2c 74

>>EIP; c012f486 <unlock_page+2a/54>   <=====
Trace; c01448f1 <end_buffer_io_async+fd/14c>
Trace; f8821ae7 <END_OF_CODE+384cdcfb/????>
Trace; c0108d76 <handle_IRQ_event+4e/78>
Trace; c010908d <do_IRQ+105/1c0>
Trace; c013029b <file_read_actor+8b/100>
Trace; c012ff4d <do_generic_file_read+299/55c>
Trace; c0130385 <generic_file_read+75/90>
Trace; c0130210 <file_read_actor+0/100>
Trace; c01423aa <sys_read+8e/c4>
Trace; c01076a3 <system_call+2f/34>

Code;  c012f486 <unlock_page+2a/54>
00000000 <_EIP>:
Code;  c012f486 <unlock_page+2a/54>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012f488 <unlock_page+2c/54>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c012f48b <unlock_page+2f/54>
   5:   90                        nop    
Code;  c012f48c <unlock_page+30/54>
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c012f490 <unlock_page+34/54>
   a:   8d 73 24                  lea    0x24(%ebx),%esi
Code;  c012f493 <unlock_page+37/54>
   d:   8d 73 24                  lea    0x24(%ebx),%esi
Code;  c012f496 <unlock_page+3a/54>
  10:   8d 43 2c                  lea    0x2c(%ebx),%eax
Code;  c012f499 <unlock_page+3d/54>
  13:   39 43 2c                  cmp    %eax,0x2c(%ebx)
Code;  c012f49c <unlock_page+40/54>
  16:   74 00                     je     18 <_EIP+0x18> c012f49e <unlock_page+42/54>

Kernel Panic: Aiee, killing interrupt handler


ksymoops 0.7c on i686 2.4.8-clk.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.14-fks/ (specified)
     -m /boot/System.map-2.4.14-fks (specified)

No modules in ksyms, skipping objects
Invalid operand: 0000
CPU: 0
EIP: 0010:[<c012f486>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 0000001d ebx: c22928ac ecx: c029be0c edx: 00001ca3
esi: c029d9e4 edi: 00000002 ebp: c22928ac esp: f769de18
ds: 0018 es:0 018 ss: 0010
Process egrep (pid 505, stackpage=f769d000)
Stack: c0248532 00000310 f7373c94 c01448f1 00000000 ffff5000 00000001
       f769c000 c013fd17 f7373c94 00000001 00000000 f74b0134 00000001 f77ff400
       00000000 00000002 f7373c94 f8821ae7 f7373d00 00000001 c232c4ec 24000001
Call Trace: [<c01448f1>] [<c013fd17>] [<f8821ae7>] [<c0108d76>] [<c010908d>]
            [<c0110018>] [<c011428c>] [<c0114268>] [<c012d9f6>] [<c01595a9>]
            [<c0141d73>] [<c0141dff>] [<c010778c>]
Code: 0f 0b 83 c4 08 90 8d 74 26 00 8d 73 24 8d 73 24 8d 43 2c 39 43 2c 74

>>EIP; c012f486 <unlock_page+2a/54>   <=====
Trace; c01448f1 <end_buffer_io_async+fd/14c>
Trace; c013fd17 <bounce_end_io_read+147/284>
Trace; f8821ae7 <END_OF_CODE+384cdcfb/????>
Trace; c0108d76 <handle_IRQ_event+4e/78>
Trace; c010908d <do_IRQ+105/1c0>
Trace; c0110018 <amd_set_mtrr_up+50/a8>
Trace; c011428c <do_page_fault+24/548>
Trace; c0114268 <do_page_fault+0/548>
Trace; c012d9f6 <do_brk+f6/248>
Trace; c01595a9 <dput+19/214>
Trace; c0141d73 <filp_close+133/140>
Trace; c0141dff <sys_close+7f/98>
Trace; c010778c <error_code+34/3c>

Code;  c012f486 <unlock_page+2a/54>
00000000 <_EIP>:
Code;  c012f486 <unlock_page+2a/54>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012f488 <unlock_page+2c/54>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c012f48b <unlock_page+2f/54>
   5:   90                        nop    
Code;  c012f48c <unlock_page+30/54>
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c012f490 <unlock_page+34/54>
   a:   8d 73 24                  lea    0x24(%ebx),%esi
Code;  c012f493 <unlock_page+37/54>
   d:   8d 73 24                  lea    0x24(%ebx),%esi
Code;  c012f496 <unlock_page+3a/54>
  10:   8d 43 2c                  lea    0x2c(%ebx),%eax
Code;  c012f499 <unlock_page+3d/54>
  13:   39 43 2c                  cmp    %eax,0x2c(%ebx)
Code;  c012f49c <unlock_page+40/54>
  16:   74 00                     je     18 <_EIP+0x18> c012f49e <unlock_page+42/54>

Kernel Panic: Aiee, killing interrupt handler
