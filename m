Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbRBWHqe>; Fri, 23 Feb 2001 02:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbRBWHqZ>; Fri, 23 Feb 2001 02:46:25 -0500
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:8325
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S129231AbRBWHqU>; Fri, 23 Feb 2001 02:46:20 -0500
Message-ID: <3A96154F.8A791FF6@debian.org>
Date: Fri, 23 Feb 2001 08:46:23 +0100
From: Giacomo Catenazzi <cate@debian.org>
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.2 OOPS on parport loading [pci_register_driver] // parport slow
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I was writing a bug report (parport slow, resources
problems?),
when I tried something strange and OOPS.
The original report is included in the last part of this
email.
After writing the report, I disabled parport resources in BIOS
and I maked:

cate3:~# modprobe parport_pc
Unable to handle kernel paging request at virtual address
c3a5f640
 printing eip:
.....
Segmentation fault
cate3:~#

OOPS via ksymoops:

ksymoops 2.3.7 on i686 2.4.2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2/ (default)
     -m /boot/System.map-2.4.2 (default)

Warning: You did not tell me where to find symbol
information.  I will
assume that the log matches the kernel and modules that are
running
right now and I'll use the default options above for symbol
resolution.
If the current kernel and/or modules do not match the log, you
can get
more accurate output by telling me the kernel version and
where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address
c3a5f640
c0177907
*pde = 011e6063
Oops: 0002
CPU:    0
EIP:    0010:[<c0177907>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c3a5f640   ebx: 00000000   ecx: c2f41000   edx: 00000000
esi: c3a23640   edi: 00000000   ebp: c3a23700   esp: c127dec8
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 486, stackpage=c127d000)
Stack: 00000000 fffffffd 00000000 c3a217a2 c3a23640 fffffffd
fffffffe c3a23660
       c3a236a0 c3a236e0 c3a2185c fffffffd fffffffe 00000000
00000001 00000001
       00004860 00000000 00000000 c3a21951 c3a23660 c3a236a0
c3a23700 c3a236e0
Call Trace: [<c3a217a2>] [<c3a23640>] [<c3a23660>]
[<c3a236a0>] [<c3a236e0>] [<c3a2185c>] [<c3a21951>]
       [<c3a23660>] [<c3a236a0>] [<c3a23700>] [<c3a236e0>]
[<c3a1f000>] [<c012a264>] [<c011576d>] [<c3a17000>]
       [<c3a1f060>] [<c0108d5f>]
Code: 89 30 8b 1d 48 8c 1f c0 31 ff 81 fb 48 8c 1f c0 74 2a 8d
b4

>>EIP; c0177907 <pci_register_driver+1b/60>   <=====
Trace; c3a217a2 <[parport_pc]parport_pc_find_ports+26/3c>
Trace; c3a23640 <[parport_pc]parport_pc_pci_driver+0/20>
Trace; c3a23660 <[parport_pc]io+0/40>
Trace; c3a236a0 <[parport_pc]io_hi+0/40>
Trace; c3a236e0 <[parport_pc]dmaval+0/20>
Trace; c3a2185c <[parport_pc]parport_pc_init+a4/b8>
Trace; c3a21951 <[parport_pc]init_module+e1/f0>
Trace; c3a23660 <[parport_pc]io+0/40>
Trace; c3a236a0 <[parport_pc]io_hi+0/40>
Trace; c3a23700 <[parport_pc]irqval+0/20>
Trace; c3a236e0 <[parport_pc]dmaval+0/20>
Trace; c3a1f000 <[parport_pc]__module_kernel_version+0/20>
Trace; c012a264 <free_pages+24/28>
Trace; c011576d <sys_init_module+4f5/598>
Trace; c3a17000 <_end+37b6eb0/37b6f10>
Trace; c3a1f060 <[parport_pc]__module_description+0/0>
Trace; c0108d5f <system_call+33/38>
Code;  c0177907 <pci_register_driver+1b/60>
00000000 <_EIP>:
Code;  c0177907 <pci_register_driver+1b/60>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c0177909 <pci_register_driver+1d/60>
   2:   8b 1d 48 8c 1f c0         mov    0xc01f8c48,%ebx
Code;  c017790f <pci_register_driver+23/60>
   8:   31 ff                     xor    %edi,%edi
Code;  c0177911 <pci_register_driver+25/60>
   a:   81 fb 48 8c 1f c0         cmp    $0xc01f8c48,%ebx
Code;  c0177917 <pci_register_driver+2b/60>
  10:   74 2a                     je     3c <_EIP+0x3c>
c0177943 <pci_register_driver
+57/60>
Code;  c0177919 <pci_register_driver+2d/60>
  12:   8d b4 00 00 00 00 00      lea    0x0(%eax,%eax,1),%esi


1 warning issued.  Results may not be reliable.

cate3:~# lsmod
Module                  Size  Used by
parport_pc             18528   1  (initializing)
parport                26464   0  [parport_pc]
cate3:~#

+++++++++++++++++++++++++++++++++++++++++++++++

Was: 2.4.x: Slow parport. Parport resources bug?

Hello!

In 2.4.x (and also in 2.3.x) the parport is slow!
Now [2.4.2] I noticed that parport don't use some resources!

also:

/etc/modules.conf:
...
options parport 0x378,5,3
...

cate3:~# lsmod
Module                  Size  Used by
cate3:~# modprobe parport_pc
cate3:~# lsmod
Module                  Size  Used by
parport_pc             18528   0
parport                26464   0  [parport_pc]
cate3:~#

In syslog:

Feb 22 21:02:25 cate3 kernel: 0x378: FIFO is 16 bytes
Feb 22 21:02:25 cate3 kernel: 0x378: writeIntrThreshold is 8
Feb 22 21:02:25 cate3 kernel: 0x378: readIntrThreshold is 8
Feb 22 21:02:25 cate3 kernel: 0x378: PWord is 8 bits
Feb 22 21:02:25 cate3 kernel: 0x378: Interrupts are ISA-Pulses
Feb 22 21:02:25 cate3 kernel: 0x378: ECP port cfgA=0x14
cfgB=0x7b
Feb 22 21:02:25 cate3 kernel: 0x378: ECP settings irq=5 dma=3
Feb 22 21:02:25 cate3 kernel: parport0: PC-style at 0x378
(0x778) [PCSPP,TRISTATE,COM
PAT,ECP]
Feb 22 21:02:25 cate3 kernel: parport0: irq 5 detected
Feb 22 21:02:25 cate3 kernel: parport0: Found 1 daisy-chained
devices
Feb 22 21:02:25 cate3 kernel: parport0: No more nibble data (1
bytes)
Feb 22 21:02:25 cate3 kernel: parport0: device reported
incorrect length field (61, s
hould be 62)
Feb 22 21:02:25 cate3 kernel: parport0 (addr 0): SCSI adapter,
IMG VP1

You see that parport0 claims irq5, and above seem that ir5 and
dma=3 is ok!
But no irq 5, nor dma used, but only the ioports:

cate3:~# cat /proc/interrupts
           CPU0
  0:      56688          XT-PIC  timer
  1:       2561          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
 12:       7759          XT-PIC  PS/2 Mouse
 14:       3167          XT-PIC  ide0
 15:         32          XT-PIC  ide1
NMI:          0
ERR:          0
cate3:~# cat /proc/dma
 4: cascade
cate3:~# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
  03c0-03df : matrox
03f6-03f6 : ide0
0778-077a : parport0
0cf8-0cff : PCI conf1
1000-101f : Intel Corporation 82371SB PIIX3 USB [Natoma/Triton
II]
1020-102f : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton
II]
  1020-1027 : ide0
  1028-102f : ide1

Kernel 2.4.2, on a Compaq Computer, PentiumPro 200, Debian
Sid.
imm (iomega zip 250) attached to the parport.

What is wrong?

        giacomo

PS: please CC: to me [due ECN problems :-( ]
