Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285272AbRLFWrO>; Thu, 6 Dec 2001 17:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285274AbRLFWrC>; Thu, 6 Dec 2001 17:47:02 -0500
Received: from pieck.student.uva.nl ([146.50.96.22]:5031 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S285268AbRLFWpe>; Thu, 6 Dec 2001 17:45:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: rudmer@linuxmail.org
Reply-To: rudmer@linuxmail.org
To: linux-kernel@vger.kernel.org
Subject: 2.4.17-pre1 stops after Oops during compile
Date: Thu, 6 Dec 2001 23:46:30 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01120623463000.00315@gandalf>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

for the last two days I have a problem with compiling: my system is unusable 
after some time. It seems that after a signal 11 to cc1 the kernel gets an 
Oops and then my harddisk stops responding due to a lost interrupt:

ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hda: lost interrupt

-- ksymoops -V -o /lib/modules/2.4.16/ -m /boot/System.map-2.4.16 -K
ksymoops 2.4.3 on i686 2.4.17-pre4.  Options used
     -V (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16/ (specified)
     -m /boot/System.map-2.4.16 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 0000000e 
printing eip:
0000000e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<0000000e>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010016
eax: 00000066   ebx: 00000018   ecx: 0000000e   edx: 00000018
esi: 00000380   edi: 00000000   ebp: c0287c80   esp: cc3abfa0
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid9847, stackpage=cc3ab000)
Stack: c010849a 0000000e 00000000 00000000 0869b9f8 bfffc8ec cc3abfc4 c1404780
       c010a628 00000000 40134e80 0869d990 00000000 0869b9f8 bfffc8ec 40134ed8
       0000002b 0000002b ffffff0e 0815d5d2 00000023 00000246 bfffc8d4 0000002b
Call Trace: [<c010849a>] [<c010a628>]
Code:  Bad EIP value.

>>EIP; 0000000e Before first symbol   <=====
Trace; c010849a <do_IRQ+2a/f0>
Trace; c010a628 <call_do_IRQ+6/e>

Unable to handle kernel NULL pointer dereference at virtual address 0000000e


Some system information:

gcc --version
2.95.3

cat /proc/interrupts 
           CPU0
  0:     109947          XT-PIC  timer
  1:       3091          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
 10:         53          XT-PIC  eth0
 11:        731          XT-PIC  PCnet/PCI II 79C970A
 12:      27291          XT-PIC  PS/2 Mouse
 14:      19270          XT-PIC  ide0
 15:          2          XT-PIC  ide1
NMI:          0
ERR:          0

cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 999.535
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1992.29

lspci -v 
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
        Flags: bus master, medium devsel, latency 0
        Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 
[Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: d4000000-d7ffffff
        Prefetchable memory behind bridge: d8000000-d8ffffff
        Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) 
(prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at d000 [size=16]
        Capabilities: [c0] Power Management version 2

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
30)
        Flags: medium devsel, IRQ 4
        Capabilities: [68] Power Management version 2

00:09.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
        Flags: bus master, slow devsel, latency 32, IRQ 3
        I/O ports at dc00 [size=64]
        Capabilities: [dc] Power Management version 1

00:0a.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet 
LANCE] (rev 16)
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at e000 [size=32]
        Memory at da000000 (32-bit, non-prefetchable) [size=32]
        Expansion ROM at <unassigned> [disabled] [size=64K]
 
00:0c.0 Ethernet controller: Winbond Electronics Corp W89C940
        Flags: medium devsel, IRQ 10
        I/O ports at e400 [size=32]
 
00:0e.0 Communication controller: Analog Devices: Unknown device 1805
        Subsystem: Analog Devices: Unknown device 1805
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at da001000 (32-bit, prefetchable) [size=256]
        Capabilities: [dc] Power Management version 2
 
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 
01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G200 AGP
        Flags: bus master, medium devsel, latency 32, IRQ 5
        Memory at d8000000 (32-bit, prefetchable) [size=16M]
        Memory at d4000000 (32-bit, non-prefetchable) [size=16K]
        Memory at d5000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
        Capabilities: [f0] AGP version 1.0


I never had any problem with this compiler, until 2.4.17-pre1
if you need more information, please ask!

I'm currently not on the list, so please include me in the cc list

rvd
