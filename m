Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSGGCct>; Sat, 6 Jul 2002 22:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSGGCcs>; Sat, 6 Jul 2002 22:32:48 -0400
Received: from h-66-134-25-243.NYCMNY83.covad.net ([66.134.25.243]:14467 "EHLO
	h-66-134-25-243.NYCMNY83.covad.net") by vger.kernel.org with ESMTP
	id <S314277AbSGGCcp>; Sat, 6 Jul 2002 22:32:45 -0400
Date: Sat, 6 Jul 2002 22:27:23 -0400 (EDT)
From: "Filip J. Bujanic" <fbujanic@fikus.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: floppy oops in 2.5.25
Message-ID: <Pine.LNX.4.44.0207062213180.3071-100000@lizard.fikus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
	accessing floppy drive oopses 2.5.25 kernel

[2.] Full description of the problem/report:
	formating or dd-ing a floppy raises an oops in 2.5.25 kernel

[3.] Keywords (i.e., modules, networking, kernel):
	floppy, 2.5.25

[4.] Kernel version (from /proc/version):
	Linux version 2.5.25 (root@lizard.fikus.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)) #7 SMP Sat Jul 6 11:26:56 EDT 2002

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
ksymoops 2.4.5 on i686 2.5.25.  Options used
     -v /boot/vmlinux-2.5.25 (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.25/ (default)
     -m /boot/System.map-2.5.25 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 000000a8
c0218b87
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0218b87>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 00000000   ebx: 00000000   ecx: c897be40   edx: c897be00
esi: c897be40   edi: c112b504   ebp: d7d0f0e4   esp: c897bdf8
ds: 0018   es: 0018   ss: 0018
Stack: c897be10 c897be40 c02223f7 00000000 00000000 c897be40 00000001 00000001 
       dead4ead c897be1c c897be1c 00000000 c032dd96 00000000 c112b504 00000400 
       00000000 00000000 00000000 00000000 d7d0f0e4 00000000 00000000 00000001 
Call Trace: [<c02223f7>] [<c014b535>] [<c0222320>] [<c022245d>] [<c014bb39>] 
   [<c02221b7>] [<c014bcf6>] [<c015b2cb>] [<c014b473>] [<c014bf85>] [<c0143ae6>]
   [<c01439ed>] [<c0143e15>] [<c010742b>] 
Code: 8b b3 a8 00 00 00 81 7e 04 ad 4e ad de 74 1a 68 80 8b 21 c0 


>>EIP; c0218b87 <generic_unplug_device+7/120>   <=====

>>ecx; c897be40 <_end+8517804/1a5ed9c4>
>>edx; c897be00 <_end+85177c4/1a5ed9c4>
>>esi; c897be40 <_end+8517804/1a5ed9c4>
>>edi; c112b504 <_end+cc6ec8/1a5ed9c4>
>>ebp; d7d0f0e4 <_end+178aaaa8/1a5ed9c4>
>>esp; c897bdf8 <_end+85177bc/1a5ed9c4>

Trace; c02223f7 <__floppy_read_block_0+c7/f0>
Trace; c014b535 <bdput+15/e0>
Trace; c0222320 <floppy_rb0_complete+0/10>
Trace; c022245d <floppy_read_block_0+3d/50>
Trace; c014bb39 <check_disk_change+79/90>
Trace; c02221b7 <floppy_open+347/3b0>
Trace; c014bcf6 <do_open+156/350>
Trace; c015b2cb <new_inode+b/c0>
Trace; c014b473 <bdget+163/210>
Trace; c014bf85 <blkdev_open+25/30>
Trace; c0143ae6 <dentry_open+e6/1b0>
Trace; c01439ed <filp_open+4d/60>
Trace; c0143e15 <sys_open+35/70>
Trace; c010742b <syscall_call+7/b>

Code;  c0218b87 <generic_unplug_device+7/120>
00000000 <_EIP>:
Code;  c0218b87 <generic_unplug_device+7/120>   <=====
   0:   8b b3 a8 00 00 00         mov    0xa8(%ebx),%esi   <=====
Code;  c0218b8d <generic_unplug_device+d/120>
   6:   81 7e 04 ad 4e ad de      cmpl   $0xdead4ead,0x4(%esi)
Code;  c0218b94 <generic_unplug_device+14/120>
   d:   74 1a                     je     29 <_EIP+0x29> c0218bb0 <generic_unplug_device+30/120>
Code;  c0218b96 <generic_unplug_device+16/120>
   f:   68 80 8b 21 c0            push   $0xc0218b80

[6.] A small shell script or example program which triggers the
     problem (if possible)
	mformat a:
	or 
	dd if=out.txt of=/dev/fd0

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux lizard.fikus.com 2.5.25 #7 SMP Sat Jul 6 11:26:56 EDT 2002 i686 
unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11f
mount                  2.11b
modutils               2.4.13
e2fsprogs              1.26
reiserfsprogs          3.x.0f
pcmcia-cs              3.1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         parport_pc lp parport

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : 00/05
stepping        : 2
cpu MHz         : 451.059
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 888.83

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : 00/05
stepping        : 2
cpu MHz         : 451.059
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 901.12

[7.3.] Module information (from /proc/modules):
parport_pc             23656   1 (autoclean)
lp                      7136   0 (autoclean)
parport                30208   1 (autoclean) [parport_pc lp]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
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
0213-0213 : isapnp read
0290-0297 : PnPBIOS PNP0c02
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
  03c0-03df : matrox
03f2-03f5 : floppy
03f6-03f6 : ide0
03f7-03f7 : floppy DIR
03f8-03ff : serial(auto)
0400-043f : PnPBIOS PNP0c02
0440-044f : PnPBIOS PNP0c02
04d0-04d1 : PnPBIOS PNP0c02
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
d000-dfff : PCI Bus #01
e400-e4ff : Lite-On Communications Inc LNE100TX
  e400-e4ff : tulip
e800-e8ff : Adaptec AIC-7881U
  e800-e8ff : aic7xxx
ef80-ef9f : Intel Corp. 82371AB PIIX4 USB
ffa0-ffaf : Intel Corp. 82371AB PIIX4 IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cdfff : Extension ROM
000f0000-000fffff : System ROM
00100000-17feffff : System RAM
  00100000-002ef893 : Kernel code
  002ef894-0039fdf3 : Kernel data
17ff0000-17ff7fff : ACPI Tables
17ff8000-17ffffff : ACPI Non-volatile Storage
f1800000-f58fffff : PCI Bus #01
  f2000000-f3ffffff : Matrox Graphics, Inc. MGA G400 AGP
    f2000000-f3ffffff : matroxfb FB
f8000000-fbffffff : Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge
fda00000-feafffff : PCI Bus #01
  fe000000-fe7fffff : Matrox Graphics, Inc. MGA G400 AGP
  feafc000-feafffff : Matrox Graphics, Inc. MGA G400 AGP
    feafc000-feafffff : matroxfb MMIO
febfef00-febfefff : Lite-On Communications Inc LNE100TX
  febfef00-febfefff : tulip
febff000-febfffff : Adaptec AIC-7881U
  febff000-febfffff : aic7xxx
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fffc0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge 
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge 
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fda00000-feafffff
        Prefetchable memory behind bridge: f1800000-f58fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at ef80 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:12.0 SCSI storage controller: Adaptec AIC-7881U (rev 01)
        Subsystem: Adaptec AHA-2940UW SCSI Host Adapter
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at e800 [disabled] [size=256]
        Region 1: Memory at febff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at febe0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 21)
        Subsystem: Netgear FA310TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at e400 [size=256]
        Region 1: Memory at febfef00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at feb80000 [disabled] [size=256K]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 
04) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 
32Mb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f2000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at feafc000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at feae0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: WDIGTL   Model: WDE9100AV        Rev: 1.50
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: WDIGTL   Model: WD183 ULTRA2     Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST19171N         Rev: F224
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: SEAGATE  Model: ST39173N         Rev: 5698
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: HP       Model: T20              Rev: 3.01
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: RICOH    Model: MP6200S          Rev: 2.20
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: SEAGATE  Model: ST336737LW       Rev: 0105
  Type:   Direct-Access                    ANSI SCSI revision: 03

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:
	This is a dual PII tyan motherboard worked flawlessly under all 
kernels up to 2.4.19. Since than I have many problems especialy if I 
attempt to use ACPI, oppses during floppy access, md raid0 failiures under 
heavy load and random ADAPTEC lockups....

thanks
fil 

