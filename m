Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265767AbSLHM1v>; Sun, 8 Dec 2002 07:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbSLHM1v>; Sun, 8 Dec 2002 07:27:51 -0500
Received: from m1.cs.man.ac.uk ([130.88.192.2]:265 "EHLO m1.cs.man.ac.uk")
	by vger.kernel.org with ESMTP id <S265767AbSLHM1p>;
	Sun, 8 Dec 2002 07:27:45 -0500
Date: Sun, 8 Dec 2002 12:35:23 +0000 (GMT)
From: Simon Ward <simon.ward@cs.man.ac.uk>
X-X-Sender: wards0@tl009.cs.man.ac.uk
To: linux-kernel@vger.kernel.org
cc: andre@linux-ide.org
Subject: PROBLEM: Oops.. NULL pointer reference in 2.4.20-ac1
Message-ID: <Pine.LNX.4.44.0212081222370.22353-100000@tl009.cs.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The kernel 2.4.20 with the -ac1 patch results in a kernel panic. I have
tried kernel 2.4.19 and a vanilla 2.4.20 and these both worked fine.

The problem appears to be after (or while) the IDE interfaces are
probed. The IDE chipset is (I think) ALI M1543. It's part of the ALI
Aladdin V chipset on an Asus P5A-B motherboard anyway, if that means
anything to you.


Output Of Oops Message:

hda: ST313021A, ATA DISK drive
hdb: CREATIVECD3621E, ATAPI CD/DVD-ROM drive
blk: queue c0294c20, I/O limit 4095Mb (mask 0xffffffff)
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:
c0108404
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0108404>]   Not tainted
EFLAGS: 00010002
eax: 00000000   ebx: 00001fe0   ecx: 000000ff   edx: c02728e0
esi: 00000212   edi: c0105000   ebp: 000000ff   esp: c11a7f5c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c11a7000)
Stack: 000000ff 00000001 c0294fac c01a2eab 000000ff 00000001 00000001 c0294fac
       c0105000 0008e000 c01a38c6 c0294fac 00000001 00000001 00000001 00000001
       00000001 00000001 00000001 00000001 00000001 00000001 c0231060 c0294b60
Call Trace:    [<c01a2eab>] [<c0105000>] [<c01a38c6>] [<c0105033>] [<c0105000>]
  [<c0105686>] [<c0105020>]

Code: ff 50 10 58 eb d4 90 90 90 90 90 90 90 90 90 90 90 90 90 90
 <0>Kernel panic: Attempted to kill init!


Output From ksymoops:

>>EIP; c0108404 <disable_irq+44/60>   <=====

>>edx; c02728e0 <pidhash+620/1000>
>>edi; c0105000 <_stext+0/0>

Trace; c01a2eab <probe_hwif+24b/280>
Trace; c0105000 <_stext+0/0>
Trace; c01a38c6 <ideprobe_init+a6/c0>
Trace; c0105033 <init+13/140>
Trace; c0105000 <_stext+0/0>
Trace; c0105686 <kernel_thread+26/40>
Trace; c0105020 <init+0/140>

Code;  c0108404 <disable_irq+44/60>
00000000 <_EIP>:
Code;  c0108404 <disable_irq+44/60>   <=====
   0:   ff 50 10                  call   *0x10(%eax)   <=====
Code;  c0108407 <disable_irq+47/60>
   3:   58                        pop    %eax
Code;  c0108408 <disable_irq+48/60>
   4:   eb d4                     jmp    ffffffda <_EIP+0xffffffda>
Code;  c010840a <disable_irq+4a/60>
   6:   90                        nop    
Code;  c010840b <disable_irq+4b/60>
   7:   90                        nop    
Code;  c010840c <disable_irq+4c/60>
   8:   90                        nop    
Code;  c010840d <disable_irq+4d/60>
   9:   90                        nop    
Code;  c010840e <disable_irq+4e/60>
   a:   90                        nop    
Code;  c010840f <disable_irq+4f/60>
   b:   90                        nop    
Code;  c0108410 <disable_irq+50/60>
   c:   90                        nop    
Code;  c0108411 <disable_irq+51/60>
   d:   90                        nop    
Code;  c0108412 <disable_irq+52/60>
   e:   90                        nop    
Code;  c0108413 <disable_irq+53/60>
   f:   90                        nop    
Code;  c0108414 <disable_irq+54/60>
  10:   90                        nop    
Code;  c0108415 <disable_irq+55/60>
  11:   90                        nop    
Code;  c0108416 <disable_irq+56/60>
  12:   90                        nop
Code;  c0108417 <disable_irq+57/60>
  13:   90                        nop


Environment

I've included the information as specified in REPORTING-BUGS although
I'm not sure if all of it is relevant because it is not the running
kernel that has the problem.

Software

$ sh scripts/ver_linux
Linux masala 2.4.20k6 #1 Wed Dec 4 19:34:39 GMT 2002 i586 unknown unknown GNU/Linux
 
Gnu C                  3.2.1
Gnu make               3.80
util-linux             2.11x
mount                  2.11x
modutils               2.4.21
e2fsprogs              1.32
reiserfsprogs          3.6.4
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.0
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.3
Modules Loaded         apm ne2k-pci 8390 rtc unix


Processor Information

$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 400.897
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips        : 799.53


Module Information

$ /sbin/lsmod 
Module                  Size  Used by    Not tainted
apm                     9504   1 (autoclean)
ne2k-pci                5376   1 (autoclean)
8390                    6016   0 (autoclean) [ne2k-pci]
rtc                     6492   0 (autoclean)
unix                   14632   8 (autoclean)


Loaded Driver and Hardware Information

$ cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
5c20-5c3f : Acer Laboratories Inc. [ALi] M7101 PMU
b400-b40f : Acer Laboratories Inc. [ALi] M5229 IDE
  b400-b407 : ide0
b800-b81f : NetVin NV5000SC
  b800-b81f : ne2k-pci
d000-dfff : PCI Bus #01
  d800-d8ff : 3Dfx Interactive, Inc. Voodoo 3

$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffbfff : System RAM
  00100000-001f322c : Kernel code
  001f322d-00250ddf : Kernel data
07ffc000-07ffefff : ACPI Tables
07fff000-07ffffff : ACPI Non-volatile Storage
de000000-dfffffff : PCI Bus #01
  de000000-dfffffff : 3Dfx Interactive, Inc. Voodoo 3
e0000000-e3ffffff : Acer Laboratories Inc. [ALi] M1541
e5f00000-e7ffffff : PCI Bus #01
  e6000000-e7ffffff : 3Dfx Interactive, Inc. Voodoo 3
ffff0000-ffffffff : reserved


PCI Information

# lspci -vvv
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
        Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP Syste
m Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [b0] AGP version 1.0
                Status: RQ=28 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M1541 PCI to AGP Controller (re
v 04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: de000000-dfffffff
        Prefetchable memory behind bridge: e5f00000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
        Subsystem: Acer Laboratories Inc. [ALi] ALI M7101 Power Management Contr
oller
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdi
n IV] (rev c3)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
+ <MAbort+ >SERR- <PERR-
        Latency: 0

00:0a.0 Ethernet controller: NetVin NV5000SC
        Subsystem: NetVin RT8029-Based Ethernet Adapter
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at b800 [size=32]

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1) (prog-if 
8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at b400 [size=16]

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (pro
g-if 00 [VGA])
        Subsystem: 3Dfx Interactive, Inc. Voodoo3 AGP
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=32M]
        Region 1: Memory at e6000000 (32-bit, prefetchable) [size=32M]
        Region 2: I/O ports at d800 [size=256]
        Expansion ROM at e5ff0000 [disabled] [size=64K]
        Capabilities: [54] AGP version 1.0
                Status: RQ=7 SBA+ 64bit+ FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


I think that's everything. I hope it helps in tracking down the oops. If
I can help in any other way please do not hesitate to ask.

Regards

Simon Ward (please CC to <simon.ward@cs.man.ac.uk>)
-- 
Email: simon.ward@cs.man.ac.uk -- ICQ UIN: 63202593
Your analyst has you mixed up with another patient.  Don't believe a
thing he tells you.

