Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbSKODFI>; Thu, 14 Nov 2002 22:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbSKODFI>; Thu, 14 Nov 2002 22:05:08 -0500
Received: from 8.suaa.bstn.bstnmaco.dsl.att.net ([12.98.8.8]:41344 "EHLO OMEGA")
	by vger.kernel.org with ESMTP id <S265661AbSKODFF>;
	Thu, 14 Nov 2002 22:05:05 -0500
Message-Id: <5.0.2.1.2.20021114210912.020b8b98@jhsph.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Thu, 14 Nov 2002 22:14:05 -0500
To: linux-kernel@vger.kernel.org
From: Hal Skinner <hskinner@fells.net>
Subject: kernel BUG at vmscan.c:355! in 2.4.19
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-OriginalArrivalTime: 15 Nov 2002 03:14:06.0437 (UTC) FILETIME=[0E924150:01C28C55]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Any help on diagnosing and fixing this bug that cropped up on my machine 
after installing an unpatched 2.4.19 kernel would be greatly 
appreciated.  I haven't seen this particular VM bug addressed previously.
-Hal

[1.] One line summary of the problem:

System crash with kernel BUG at vmscan.c:355 after upgrade to kernel 2.4.19

[2.] Full description of the problem/report:

Almost three days after upgrading an older machine from 2.2.16 to 2.4.19 
the machine crashed with the following error in the log:

Nov 12 06:37:47 ns kernel: kernel BUG at vmscan.c:355!
Nov 12 06:37:47 ns kernel: invalid operand: 0000
Nov 12 06:37:47 ns kernel: CPU:    0

The entries in the log indicate the BUG was recorded 1 minute after some 
inetd entries (autorpm updates and an SMTP connection from crond).  All 
inetd entries after the kernel BUG message were signal 11's.  After reboot 
the machine went almost 2 days and then crashed with the same message:

Nov 14 04:06:19 ns kernel: kernel BUG at vmscan.c:355!
Nov 14 04:06:19 ns kernel: invalid operand: 0000
Nov 14 04:06:19 ns kernel: CPU:    0

No further logging after this until reboot.

[3.] Keywords (i.e., modules, networking, kernel):

kernel
bug
vmscan.c

[4.] Kernel version (from /proc/version):

Linux version 2.4.19 (gcc version 2.95.3 20010315 (release))
  #2 Sat Nov 9 09:15:49 EST 2002

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

No oops available.

[6.] A small shell script or example program which triggers the
      problem (if possible)

Although it has happened twice, I have not found a way to trigger the BUG 
reproducibly.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux 2.4.19 #2 Sat Nov 9 09:15:49 EST 2002 i686 unknown

Gnu C                  2.95.3
Gnu make               3.78.1
util-linux             2.11l
mount                  2.11l
modutils               2.4.10
e2fsprogs              1.25
pcmcia-cs              3.1.8
PPP                    2.3.10
isdn4k-utils           3.1beta7
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 1.01
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0


[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 7
cpu MHz         : 199.435
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
bogomips        : 398.13

[7.3.] Module information (from /proc/modules):

capcheck                1136   0 (unused)

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
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
f800-f8ff : Lite-On Communications Inc LNE100TX
   f800-f8ff : tulip
fc00-fcff : Adaptec AHA-2940U/UW/D / AIC-7881U
ffa0-ffaf : Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]

00000000-0009fbff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cc7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
   00100000-002700f6 : Kernel code
   002700f7-00304b9f : Kernel data
ff000000-ff7fffff : Matrox Graphics, Inc. MGA 2064W [Millennium]
ffbeac00-ffbeacff : Lite-On Communications Inc LNE100TX
   ffbeac00-ffbeacff : tulip
ffbeb000-ffbebfff : Adaptec AHA-2940U/UW/D / AIC-7881U
   ffbeb000-ffbebfff : aic7xxx
ffbec000-ffbeffff : Matrox Graphics, Inc. MGA 2064W [Millennium]
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort+ >SERR- <PERR-
         Latency: 32 set

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev
01)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
         Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton 
II] (p
rog-if 80 [Master])
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
         Region 4: I/O ports at ffa0 [size=16]

00:0b.0 SCSI storage controller: Adaptec AIC-7881U
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Step
ping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
         Latency: 8 min, 8 max, 72 set, cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at fc00 [disabled] [size=256]
         Region 1: Memory at ffbeb000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at <unassigned> [disabled] [size=64K]

00:0f.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium]
(rev 01) (prog-if 00 [VGA])
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping+ SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at ffbec000 (32-bit, non-prefetchable) [size=16K]
         Region 1: Memory at ff000000 (32-bit, prefetchable) [size=8M]
         Expansion ROM at <unassigned> [disabled] [size=64K]

00:13.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
         Subsystem: Netgear FA310TX
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
         Latency: 32 set
         Interrupt: pin A routed to IRQ 9
         Region 0: I/O ports at f800 [size=256]
         Region 1: Memory at ffbeac00 (32-bit, non-prefetchable) [size=256]
         Expansion ROM at <unassigned> [disabled] [size=256K]


[7.6.] SCSI information (from /proc/scsi/scsi)

Host: scsi0 Channel: 00 Id: 04 Lun: 00
   Vendor: Seagate  Model: STT8000N         Rev: 3.22
   Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
   Vendor: TOSHIBA  Model: CD-ROM XM-5401TA Rev: 3605
   Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
   Vendor: IBM      Model: DDRS-39130W      Rev: S97B
   Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):


[X.] Other notes, patches, fixes, workarounds:

Modules Loaded         capcheck

