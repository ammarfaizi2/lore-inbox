Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131625AbRDPWWS>; Mon, 16 Apr 2001 18:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131643AbRDPWWG>; Mon, 16 Apr 2001 18:22:06 -0400
Received: from slinux01.nas.nasa.gov ([129.99.71.104]:46976 "EHLO
	slinux01.nas.nasa.gov") by vger.kernel.org with ESMTP
	id <S131672AbRDPWVi>; Mon, 16 Apr 2001 18:21:38 -0400
Message-ID: <3ADB70C9.1F17981@nas.nasa.gov>
Date: Mon, 16 Apr 2001 15:23:06 -0700
From: pandya@nas.nasa.gov
Organization: NASA Ames Research Center
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-01INAsmpBM i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: amd/nfs with 2.4.3 BigMem kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. amd/nfs can not mount other disks under 2.4.3 BigMem kernel

2. I compiled 2 kernels(one with BigMem, one without).

   Both are SMP kernels.

   The one without BigMem supports works just fine.

   The only difference is that I turned on BigMem support, and recompiled kernel and modules.

   When I try to mount other disks through amd, it says: "No such file or directory."

   The log file for amd(/var/log/amd) after initial startup info says:

----
Apr 16 13:54:11 slinux01 amd[11530]/map:   Trying mount of
/etc/amd.fsmap on /fs fstype toplvl
Apr 16 13:54:11 slinux01 amd[11530]/map:   Trying mount of /etc/amd.rmap
on /r fstype toplvl
Apr 16 13:54:11 slinux01 amd[11531]/error: /fs: mount: No such device
Apr 16 13:54:11 slinux01 amd[11533]/error: /r: mount: No such device
----

   When I try to restart amd, the log file (/var/log/messages)

   has the following lines associated with amd startup

----
Apr 16 13:54:11 slinux01 amd: Apr 16 13:54:11 slinux01 amd[11529]/info:
using configuration file /etc/amd.conf
Apr 16 13:54:11 slinux01 insmod:
/lib/modules/2.4.3-01INAsmpBM/kernel/fs/nfs/nfs.o: insmod nfs failed
Apr 16 13:54:11 slinux01 insmod:
/lib/modules/2.4.3-01INAsmpBM/kernel/fs/nfs/nfs.o: insmod nfs failed
Apr 16 13:54:12 slinux01 amd: amd startup succeeded
----

   Noting that the insmod nfs failure may be responsible, I try to "insmod nfs" as root as follows:

----insmod nfs
Using /lib/modules/2.4.3-01INAsmpBM/kernel/fs/nfs/nfs.o
/lib/modules/2.4.3-01INAsmpBM/kernel/fs/nfs/nfs.o: unresolved symbol
kunmap_high
/lib/modules/2.4.3-01INAsmpBM/kernel/fs/nfs/nfs.o: unresolved symbol
highmem_start_page
/lib/modules/2.4.3-01INAsmpBM/kernel/fs/nfs/nfs.o: unresolved symbol
kmap_high
----insmod nfs


3. nfs module, BigMem kernel



4.

----
Linux version 2.4.3-01INAsmpBM (root@slinux01.nas.nasa.gov)
 (gcc version 2.96 20000731 (Red Hat Linux 7.0)) #4 SMP Thu Apr 12
17:35:48 PDT 2001
----

5.  No oops.

6. simply try "cd /net/machine_name" under 2.4.3 SMP, BigMem kernel

7.1  Output from ver_linux follows:

----
Linux slinux01.nas.nasa.gov 2.4.3-01INAsmpBM #4 SMP Thu Apr 12 17:35:48
PDT 2001 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10m
modutils               2.3.14
e2fsprogs              1.18
pcmcia-cs              3.1.19
Linux C Library        > libc.2.2
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         nfsd lockd sunrpc eepro100 agpgart i810_audio
ac97_codec soundcore aic7xxx sd_mod scsi_mod
----

7.2

----
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 797.978
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov
pat pse36 mmx fxsr sse
bogomips        : 1592.52

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 797.978
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov
pat pse36 mmx fxsr sse
bogomips        : 1595.80
----

7.3

----
nfsd                   70376   8 (autoclean)
lockd                  51056   1 (autoclean) [nfsd]
sunrpc                 65048   1 (autoclean) [nfsd lockd]
eepro100               18616   1 (autoclean)
agpgart                24568   0 (unused)
i810_audio             15172   0
ac97_codec              7908   0 [i810_audio]
soundcore               4612   2 [i810_audio]
aic7xxx               123500   4
sd_mod                 11124   4
scsi_mod               97436   2 [aic7xxx sd_mod]
----

7.5

----
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
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
7000-7fff : PCI Bus #04
  7000-703f : Intel Corporation 82557 [Ethernet Pro 100]
    7000-703f : eepro100
8000-9fff : PCI Bus #02
  8000-8fff : PCI Bus #03
    8000-80ff : Adaptec 7899P
    8400-84ff : Adaptec 7899P (#2)
b000-b0ff : Intel Corporation 82801AA AC'97 Audio
  b000-b0ff : Intel ICH 82801AA
b400-b43f : Intel Corporation 82801AA AC'97 Audio
  b400-b43f : Intel ICH 82801AA
b480-b48f : Intel Corporation 82801AA SMBus
b4c0-b4df : Intel Corporation 82801AA USB
b800-b80f : Intel Corporation 82801AA IDE
  b800-b807 : ide0
----
----
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-0021b540 : Kernel code
  0021b541-0028321f : Kernel data
3fff0000-3fff7fff : ACPI Tables
3fff8000-3fffffff : ACPI Non-volatile Storage
80100000-804fffff : PCI Bus #04
  80100000-80100fff : Intel Corporation 82557 [Ethernet Pro 100]
    80100000-80100fff : eepro100
  80200000-802fffff : Intel Corporation 82557 [Ethernet Pro 100]
80500000-806fffff : PCI Bus #02
  80500000-805fffff : PCI Bus #03
    80500000-80500fff : Intel Corporation 82806AA PCI64 Hub Advanced
Programmabl
e Interrupt Controller
    80501000-80501fff : Adaptec 7899P
      80501000-80501fff : aic7xxx
    80502000-80502fff : Adaptec 7899P (#2)
      80502000-80502fff : aic7xxx
80700000-820fffff : PCI Bus #01
  81000000-81ffffff : nVidia Corporation Quadro (GeForce 256 GL)
82500000-900fffff : PCI Bus #01
  88000000-8fffffff : nVidia Corporation Quadro (GeForce 256 GL)
e0000000-e3ffffff : Intel Corporation 82840 840 (Carmel) Chipset Host
Bridge (Hu
b A)
fff80000-ffffffff : reserved
----

7.5

----
00:00.0 Host bridge: Intel Corporation 82840 840 (Carmel) Chipset Host
Bridge (Hub A) (rev 01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 1025
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 82840 840 (Carmel) Chipset AGP
Bridge (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: 80700000-820fffff
        Prefetchable memory behind bridge: 82500000-900fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 PCI bridge: Intel Corporation 82840 840 (Carmel) Chipset PCI
Bridge (Hub B) (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=03, sec-latency=0
        I/O behind bridge: 00008000-00009fff
        Memory behind bridge: 80500000-806fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
        I/O behind bridge: 00007000-00007fff
        Memory behind bridge: 80100000-804fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801AA ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if
80 [Master])
        Subsystem: Intel Corporation 82801AA IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at b800 [size=16]

00:1f.2 USB Controller: Intel Corporation 82801AA USB (rev 02) (prog-if
00 [UHCI])
        Subsystem: Intel Corporation 82801AA USB
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 17
        Region 4: I/O ports at b4c0 [size=32]

00:1f.3 SMBus: Intel Corporation 82801AA SMBus (rev 02)
        Subsystem: Intel Corporation 82801AA SMBus
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at b480 [size=16]

00:1f.5 Multimedia audio controller: Intel Corporation 82801AA AC'97
Audio (rev 02)
        Subsystem: Acer Incorporated [ALI]: Unknown device 1025
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at b000 [size=256]
        Region 1: I/O ports at b400 [size=64]

01:00.0 VGA compatible controller: nVidia Corporation Quadro (GeForce
256 GL) (rev 10) (prog-if 00 [VGA])
        Subsystem: Silicon Graphics, Inc.: Unknown device 9002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at 81000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at 88000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at 80700000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

02:1f.0 PCI bridge: Intel Corporation 82806AA PCI64 Hub PCI Bridge (rev
02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 00008000-00008fff
        Memory behind bridge: 80500000-805fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

03:00.0 PIC: Intel Corporation 82806AA PCI64 Hub Advanced Programmable
Interrupt Controller (rev 01) (prog-if 20 [IO(X)-APIC])
        Subsystem: Intel Corporation 82806AA PCI64 Hub Advanced
Programmable Interrupt Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at 80500000 (32-bit, non-prefetchable)
[size=4K]

03:03.0 SCSI storage controller: Adaptec 7899P (rev 01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0006
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 19
        BIST result: 00
        Region 0: I/O ports at 8000 [disabled] [size=256]
        Region 1: Memory at 80501000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at 80520000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:03.1 SCSI storage controller: Adaptec 7899P (rev 01)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0006
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin B routed to IRQ 19
        BIST result: 00
        Region 0: I/O ports at 8400 [disabled] [size=256]
        Region 1: Memory at 80502000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at 80540000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:0c.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
        Subsystem: Intel Corporation 82559 Fast Ethernet LAN on
Motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at 80100000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at 7000 [size=64]
        Region 2: Memory at 80200000 (32-bit, non-prefetchable)
[size=1M]
        Expansion ROM at 80300000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=2 PME-
----

7.6

----
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST318436LW       Rev: 0010
  Type:   Direct-Access                    ANSI SCSI revision: 03
----

--
----------------------------------------------------
Shishir Pandya,PhD                  M/S T27B-1
Code INR                            NASA Ames Research Center
                                    Moffett Field, CA 94035
pandya@nas.nasa.gov
(650)604-3981                http://www.engr.ucdavis.edu/~spandya



