Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282002AbRKUXhc>; Wed, 21 Nov 2001 18:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282001AbRKUXhW>; Wed, 21 Nov 2001 18:37:22 -0500
Received: from mercury.Sun.COM ([192.9.25.1]:44461 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S281997AbRKUXhL>;
	Wed, 21 Nov 2001 18:37:11 -0500
Message-ID: <3BFC3CD8.3B955DA8@sun.com>
Date: Wed, 21 Nov 2001 15:46:32 -0800
From: Stephane Brossier <stephane.brossier@sun.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-26mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Stephane Brossier <Stephane.Brossier@sun.com>
Subject: Problem when using a nfs mounted filesystem.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

Problem when using a nfs mounted filesystem.

[2.] Full description of the problem/report:

I mounted a remote filesystem on my machine with the following command:

[root@localhost mnt]# mount -t nfs -o "hard,intr,nodev,nosuid"
hats105:/export1
/mnt/export1

[root@localhost mnt]# df -ak
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda1              1597004    141176   1374704  10% /
none                         0         0         0   -  /proc
devfs                        0         0         0   -  /dev
none                         0         0         0   -  /dev/pts
none                    127620         0    127620   0% /dev/shm
/dev/hda9              8380704     18944   7936040   1% /home
/dev/hda8              6720216    123056   6255784   2% /tmp
/dev/hda6             10381004   2282880   7570792  24% /usr
/dev/hda7             12096724     18664  11463576   1% /usr/local
hats105:/export1       4113280   1476736   2595392  37% /mnt/export1


Everything seems OK for a while since I can access any directory/file
under 
/mnt/export1. Suddenly, after a few minutes, I cannot access anymore
this file
system. All my programs which where using these filesystems are frozen
and I they dont even receive any signals. I cannot umount this
filesystem
neither. I checked the nfs server is still up and running so the problem
seems to come from the client side.

[3.] Keywords (i.e., modules, networking, kernel):

file system, NFS

[4.] Kernel version (from /proc/version):

[root@localhost mnt]# cat /proc/version
Linux version 2.4.8-26mdk (root@localhost.localdomain) (gcc version 2.96
20000731 (Mandrake Linux 8.1 2.96-0.62mdk)) #3 Sun Oct 21 18:02:36 EDT
2001

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)

See description above.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

[stephb@localhost linux]$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux localhost.localdomain 2.4.8-26mdk #3 Sun Oct 21 18:02:36 EDT 2001
i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11h
mount                  2.11h
modutils               2.4.6
e2fsprogs              tune2fs
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ide-scsi loop sr_mod sg scsi_mod es1371
ac97_codec gameport rtc

[7.2.] Processor information (from /proc/cpuinfo):

[root@localhost mnt]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 4
cpu MHz         : 1401.721
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2798.38

[7.3.] Module information (from /proc/modules):

[root@localhost mnt]# cat /proc/modules
ide-scsi                8064   0
loop                    8240   0 (unused)
sr_mod                 14208   0
sg                     28016   0
scsi_mod               90880   3 [ide-scsi sr_mod sg]
es1371                 26304   0 (autoclean)
ac97_codec              9216   0 (autoclean) [es1371]
gameport                1856   0 (autoclean) [es1371]
rtc                     5568   0 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

[root@localhost mnt]# cat /proc/ioports
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
d000-d003 : Advanced Micro Devices [AMD] AMD-760 [Irongate] System
Controller
d400-d40f : VIA Technologies, Inc. Bus Master IDE
  d400-d407 : ide0
  d408-d40f : ide1
d800-d81f : VIA Technologies, Inc. UHCI USB
dc00-dc1f : VIA Technologies, Inc. UHCI USB (#2)
e000-e01f : Intel Corporation 82557 [Ethernet Pro 100]
  e000-e01f : eepro100
e400-e43f : Ensoniq CT5880 [AudioPCI]
  e400-e43f : es1371

[root@localhost mnt]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-002411a1 : Kernel code
  002411a2-002b8c8f : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d7ffffff : PCI Bus #01
  d0000000-d7ffffff : nVidia Corporation NV11 DDR
    d0000000-d1ffffff : vesafb
d8000000-dbffffff : Advanced Micro Devices [AMD] AMD-760 [Irongate]
System Controller
dc000000-ddffffff : PCI Bus #01
  dc000000-dcffffff : nVidia Corporation NV11 DDR
df000000-df0fffff : Intel Corporation 82557 [Ethernet Pro 100]
df100000-df100fff : Advanced Micro Devices [AMD] AMD-760 [Irongate]
System Controller
df101000-df101fff : Intel Corporation 82557 [Ethernet Pro 100]
  df101000-df101fff : eepro100
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

[root@localhost mnt]# lspci -vvv
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700e
(rev 13)         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at df100000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at d000 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700f
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge: d0000000-d7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
40)
        Subsystem: ABIT Computer Corp.: Unknown device a702
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT82C586 IDE [Apollo]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d400 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 01)        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at df101000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at e000 [size=32]
        Region 2: Memory at df000000 (32-bit, non-prefetchable)
[size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]

00:11.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq: Unknown device 8001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e400 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: nVidia Corporation NV11 DDR (rev b2)
(prog-if 00 [VGA])
        Subsystem: ABIT Computer Corp.: Unknown device 6106
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at dc000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)

[root@localhost mnt]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: BCD 24XM Model:  CD-ROM          Rev: U2.1
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: YAMAHA   Model: CRW2100E         Rev: 1.0N
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

N/A
[X.] Other notes, patches, fixes, workarounds:

N/A
