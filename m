Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313524AbSDHMX5>; Mon, 8 Apr 2002 08:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313540AbSDHMX4>; Mon, 8 Apr 2002 08:23:56 -0400
Received: from kura.mail.jippii.net ([195.197.172.113]:39329 "HELO
	kura.mail.jippii.net") by vger.kernel.org with SMTP
	id <S313524AbSDHMXy>; Mon, 8 Apr 2002 08:23:54 -0400
Date: Mon, 8 Apr 2002 15:26:04 +0300
From: Anssi Saari <as@sci.fi>
To: linux-kernel@vger.kernel.org
Subject: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
Message-ID: <20020408122603.GA7877@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:    
CD burning at 16x uses excessive CPU, although DMA is enabled

[2.] Full description of the problem/report:
My system seems to use a lot of CPU time when writing CDs at 16x. The
system is unable to feed the burning software's buffer fast enough when
burning software (cdrecord 1.11a20, cdrdao 1.1.5) is run as normal user.
If run as root, system is almost unresponsive during the burn.

This concerns only audio and raw data burns, burning of ISO images goes
fine with very little load. 12x and 8x burns are also fine, although
using serial ports is error prone while even a 8x burn is going on.
CD Writer is LG GCE-8160B, secondary master, alone in the cable. CD
writer and HD has DMA enabled, by default writer uses mdma2. Other modes
have been tried, but no change. Disabling DMA does not help.

This problem does not happen in FreeBSD 4.5-STABLE with cdrecord 1.11a20.

[3.] Keywords (i.e., modules, networking, kernel):
CD writing, ATAPI, SG

[4.] Kernel version (from /proc/version):
2.4.18, 2.4.16, 2.2.19, 2.4.19pre6

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux dorkstar 2.4.18 #2 Wed Apr 3 22:03:26 EEST 2002 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.13
e2fsprogs              1.26
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    command
Sh-utils               2.0.11
Modules Loaded         sg cmpci soundcore ncr53c8xx isofs via686a i2c-proc i2c-isa i2c-core autofs4 lirc_serial ip_conntrack_ftp ipt_REJECT ipt_limit ipt_LOG ipt_state ip_conntrack iptable_filter ip_tables 3c59x ide-scsi sr_mod cdrom rtc nls_iso8859-1 nls_cp437 vfat fat

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) processor
stepping        : 1
cpu MHz         : 799.649
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1595.80

[7.3.] Module information (from /proc/modules):
sg                     25124   0 (autoclean)
cmpci                  25380   0 (autoclean)
soundcore               3652   2 (autoclean) [cmpci]
ncr53c8xx              53184   0
isofs                  18016   0 (autoclean)
via686a                 8036   0 (unused)
i2c-proc                6144   0 [via686a]
i2c-isa                 1188   0 (unused)
i2c-core               13128   0 [via686a i2c-proc i2c-isa]
autofs4                 8644   2 (autoclean)
lirc_serial             7520   0
ip_conntrack_ftp        3424   0 (unused)
ipt_REJECT              2976   1 (autoclean)
ipt_limit                928   3 (autoclean)
ipt_LOG                 3200  13 (autoclean)
ipt_state                576   2 (autoclean)
ip_conntrack           13548   2 (autoclean) [ip_conntrack_ftp ipt_state]
iptable_filter          1760   1 (autoclean)
ip_tables              10944   5 [ipt_REJECT ipt_limit ipt_LOG ipt_state iptable_filter]
3c59x                  25608   1 (autoclean)
ide-scsi                7712   0 (autoclean)
sr_mod                 13624   0 (autoclean)
cdrom                  28512   0 (autoclean) [sr_mod]
rtc                     5656   0 (autoclean)
nls_iso8859-1           2848   2 (autoclean)
nls_cp437               4384   2 (autoclean)
vfat                    9916   2 (autoclean)
fat                    31576   0 (autoclean) [vfat]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports :
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
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : lirc_serial
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
  6000-607f : via686a-sensors
c000-c00f : VIA Technologies, Inc. Bus Master IDE
  c000-c007 : ide0
  c008-c00f : ide1
c400-c41f : VIA Technologies, Inc. UHCI USB
c800-c81f : VIA Technologies, Inc. UHCI USB (#2)
cc00-ccff : ATI Technologies Inc 3D Rage Pro 215GP
d000-d07f : 3Com Corporation 3c905C-TX [Fast Etherlink]
  d000-d07f : 00:09.0
d400-d4ff : LSI Logic / Symbios Logic (formerly NCR) 53c810
  d400-d47f : ncr53c8xx
d800-d8ff : C-Media Electronics Inc CM8738
  d800-d8ff : cmpci
dc00-dc07 : Promise Technology, Inc. 20265
  dc00-dc07 : ide2
e000-e003 : Promise Technology, Inc. 20265
  e002-e002 : ide2
e400-e407 : Promise Technology, Inc. 20265
e800-e803 : Promise Technology, Inc. 20265
ec00-ec3f : Promise Technology, Inc. 20265
  ec00-ec07 : ide2
  ec08-ec0f : ide3
  ec10-ec3f : PDC20265

/proc/iomem: 
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-001fe615 : Kernel code
  001fe616-0024a0b7 : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d7ffffff : PCI Bus #01
  d0000000-d7ffffff : nVidia Corporation NV11 (GeForce2 MX)
d8000000-dbffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
dc000000-ddffffff : PCI Bus #01
  dc000000-dcffffff : nVidia Corporation NV11 (GeForce2 MX)
de000000-deffffff : ATI Technologies Inc 3D Rage Pro 215GP
e0000000-e001ffff : Promise Technology, Inc. 20265
e0020000-e002007f : 3Com Corporation 3c905C-TX [Fast Etherlink]
e0021000-e00210ff : LSI Logic / Symbios Logic (formerly NCR) 53c810
e0022000-e0022fff : ATI Technologies Inc 3D Rage Pro 215GP
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge: d0000000-d7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at c000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at c400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro 215GP (rev 5c) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0000
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at de000000 (32-bit, prefetchable) [disabled] [size=16M]
        Region 1: I/O ports at cc00 [disabled] [size=256]
        Region 2: Memory at e0022000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]

00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d000 [size=128]
        Region 1: Memory at e0020000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0a.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c810 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at e0021000 (32-bit, non-prefetchable) [size=256]

00:0d.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 RAID bus controller: Promise Technology, Inc. 20265 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dc00 [size=8]
        Region 1: I/O ports at e000 [size=4]
        Region 2: I/O ports at e400 [size=8]
        Region 3: I/O ports at e800 [size=4]
        Region 4: I/O ports at ec00 [size=64]
        Region 5: Memory at e0000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX) (rev a1) (prog-if 00 [VGA])
        Subsystem: Elsa AG: Unknown device 0c60
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HL-DT-ST Model: CD-RW GCE-8160B  Rev: 2.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: NEC      Model: CD-ROM DRIVE:462 Rev: 1.16
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 02 Lun: 00
  Vendor: RICOH    Model: CD-R/RW MP7060S  Rev: 1.70
  Type:   CD-ROM                           ANSI SCSI revision: 02
