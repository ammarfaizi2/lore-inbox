Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130067AbQKWJFF>; Thu, 23 Nov 2000 04:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129845AbQKWJE4>; Thu, 23 Nov 2000 04:04:56 -0500
Received: from mailserver1.hrz.tu-darmstadt.de ([130.83.126.41]:38303 "EHLO
        mailserver1.hrz.tu-darmstadt.de") by vger.kernel.org with ESMTP
        id <S130337AbQKWJEm>; Thu, 23 Nov 2000 04:04:42 -0500
Date: Thu, 23 Nov 2000 09:34:36 +0100
From: Christian Haul <haul@dvs1.informatik.tu-darmstadt.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.0-test11 freezes when writing to FAT SCSI-MO-Drive
Message-ID: <20001123093436.A1132@bremen.dvs1.informatik.tu-darmstadt.de>
Reply-To: haul@informatik.tu-darmstadt.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Databases and Distributed Systems Group, Darmstadt University of Technology
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:  2.4.0-test11 freezes when writing to FAT SCSI-MO-Drive  

[2.] Full description of the problem/report:

When writing to a msdos fat formated 640 MB magneto-optical disc the
system freezes and neither ctrl-alt-del nor the reset button can wake
the machine again, only power-off helps. The MO was formated using the
linux utilities (mkfs.msdos), I currently have no other discs around
so I cannot confirm whether this occurs only on 640MB media or others
as well. Again, I cannot at this moment verify other filesystem types.

While the system freezes when writing to the media it is OK to move
files around on the media, to create directories, read or touch
files. It does not work to move files to the media or copy them onto
it.

The media is mounted through autofs with the following map entry:
mop             -fstype=vfat,umask=000  :/dev/sda

As 2.4.0-test11 is the first kernel from the new series that I have
tried, I cannot determine which version introduced the
behaviour. However, the 2.2 kernel series up to and including
2.2.18pre17 (haven't tried newer kernels than that) seem to work
correctly.

[3.] Keywords (i.e., modules, networking, kernel):

MO fat vfat msdos freeze scsi symbios 53x875

[4.] Kernel version (from /proc/version):

Linux version 2.4.0-test11 (root@bremen) (gcc version 2.95.2 19991024 (release)) #2 Wed Nov 22 14:00:58 CET 2000

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
     problem (if possible)

cp to media

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux bremen 2.4.0-test11 #2 Wed Nov 22 14:00:58 CET 2000 i686 unknown
Kernel modules         2.3.11
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.24
Linux C Library        x   1 root     root      4070534 Sep 20 18:07 /lib/libc.so.6
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10m
Net-tools              1.56
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         sd_mod nfs lockd sunrpc es1371 ac97_codec soundcore 8139too usbcore nls_iso8859-1 nls_cp437 vfat fat

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 449.000959
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 897.84


[7.3.] Module information (from /proc/modules):

sd_mod                 10192   1 (autoclean)
nfs                    75232   2 (autoclean)
lockd                  48816   1 (autoclean) [nfs]
sunrpc                 57528   1 (autoclean) [nfs lockd]
es1371                 24244   1
ac97_codec              7492   0 [es1371]
soundcore               3652   4 [es1371]
8139too                15008   1 (autoclean)
usbcore                45920   1 (autoclean)
nls_iso8859-1           2840   2 (autoclean)
nls_cp437               4352   2 (autoclean)
vfat                   10412   2 (autoclean)
fat                    30392   0 (autoclean) [vfat]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
  4000-4003 : acpi
  4004-4005 : acpi
  4008-400b : acpi
  400c-400f : acpi
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
d000-dfff : PCI Bus #01
e000-e01f : Intel Corporation 82371AB PIIX4 USB
e400-e43f : Ensoniq ES1371 [AudioPCI-97]
  e400-e43f : es1371
e800-e8ff : Symbios Logic Inc. (formerly NCR) 53c875
  e800-e87f : sym53c8xx
ec00-ecff : Realtek Semiconductor Co., Ltd. RTL-8139
  ec00-ecff : eth0
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cb3ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-00211967 : Kernel code
  00211968-00226f87 : Kernel data
07ff0000-07ff2fff : ACPI Non-volatile Storage
07ff3000-07ffffff : ACPI Tables
e0000000-e3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
e4000000-e5ffffff : PCI Bus #01
  e4000000-e4ffffff : nVidia Corporation Riva TnT 128 [NV04]
e6000000-e6ffffff : PCI Bus #01
  e6000000-e6ffffff : nVidia Corporation Riva TnT 128 [NV04]
    e6000000-e63fffff : vesafb
e8000000-e8000fff : Symbios Logic Inc. (formerly NCR) 53c875
e8001000-e80010ff : Symbios Logic Inc. (formerly NCR) 53c875
e8002000-e80020ff : Realtek Semiconductor Co., Ltd. RTL-8139
  e8002000-e80020ff : eth0
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: e6000000-e6ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at e000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at e400 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 26)
        Subsystem: Symbios Logic Inc. (formerly NCR): Unknown device 1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 134 (4250ns min, 16000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at e8001000 (32-bit, non-prefetchable) [size=256]
        Region 2: Memory at e8000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at e7000000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at ec00 [size=256]
        Region 1: Memory at e8002000 (32-bit, non-prefetchable) [size=256]

01:00.0 VGA compatible controller: nVidia Corporation Riva TnT 128 [NV04] (rev 04) (prog-if 00 [VGA])
        Subsystem: Creative Labs Graphics Blaster CT6710
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e6000000 (32-bit, prefetchable) [size=16M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 1.0
                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: TEAC     Model: CD-ROM CD-532S   Rev: 1.0A
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: SONY     Model: CD-ROM CDU-415   Rev: 1.1g
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: FUJITSU  Model: M2513E           Rev: 0060
  Type:   Optical Device                   ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: YAMAHA   Model: CRW4416S         Rev: 1.0g
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:

	Christian Haul

-- 
C h r i s t i a n       H a u l
haul@informatik.tu-darmstadt.de
    fingerprint: 99B0 1D9D 7919 644A 4837  7D73 FEF9 6856 335A 9E08


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
