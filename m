Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbRGQRGh>; Tue, 17 Jul 2001 13:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbRGQRGS>; Tue, 17 Jul 2001 13:06:18 -0400
Received: from gatekeeper.zeitgeist.com ([204.243.76.2]:15054 "EHLO
	charon.ny.zeitgeist.com") by vger.kernel.org with ESMTP
	id <S266795AbRGQRGG>; Tue, 17 Jul 2001 13:06:06 -0400
Message-Id: <200107171706.f6HH63S05993@thx1138.ny.zeitgeist.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: PCI hiccup installing Lucent/Orinoco carbus PCI adapter
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Jul 2001 13:06:03 -0400
From: David HM Spector <spector@zeitgeist.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  included is a bug-report that seems to be a PCI oops that affects the 
intallation of a Lucent PCI CardBus adapter.

[1.] One line summary of the problem:    

     PCI Drivers fail to allocate interrrupt for Lucent Cardbus bridge

[2.] Full description of the problem/report:

The 2.4.3 kernel recognizes the card but failts to allocate an
interrupt for it.  This is the Lucent Oinoco PCI Carbus bridge product
which is based on the TI1410 chip.  In talking with Dave Hinds about
the problem, he looked at the enclose outbut and suggested that it
looks like a kernel/PCI problem.

Moving PCI cards arong, removing other from the system etc has no affect.


[3.] Keywords (i.e., modules, networking, kernel): PCI, Kernel
[4.] Kernel version (from /proc/version):

Linux version 2.4.3-12smp (root@porky.devel.redhat.com) (gcc version 2.96 200007
31 (Red Hat Linux 7.1 2.96-85)) #1 SMP Fri Jun 8 14:38:50 EDT 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

Kernel messages at boot time:
	Jul 16 15:55:26 thx1138 kernel: PCI: Using configuration type 1
	Jul 16 15:55:26 thx1138 kernel: PCI: Probing PCI hardware
	Jul 16 15:55:26 thx1138 kernel: PCI->APIC IRQ transform: (B0,I7,P3) -> 19
	Jul 16 15:55:26 thx1138 snmpd: snmpd startup succeeded
	Jul 16 15:55:26 thx1138 kernel: PCI->APIC IRQ transform: (B0,I17,P0) -> 19
	Jul 16 15:55:26 thx1138 kernel: PCI->APIC IRQ transform: (B0,I18,P0) -> 16
	Jul 16 15:55:26 thx1138 kernel: PCI->APIC IRQ transform: (B0,I18,P1) -> 16
	Jul 16 15:55:26 thx1138 kernel: PCI->APIC IRQ transform: (B0,I20,P0) -> 17
	Jul 16 15:55:26 thx1138 kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 16
	Jul 16 15:55:26 thx1138 kernel: PCI->APIC IRQ transform: (B2,I5,P0) -> 17
	Jul 16 15:55:26 thx1138 kernel: PCI->APIC IRQ transform: (B2,I5,P0) -> 17
	Jul 16 15:55:26 thx1138 kernel:   got res[40000000:40000fff] for resource 0 of Texas Instruments PCI1410 PC card Cardbus Controller
	Jul 16 15:55:27 thx1138 kernel: isapnp: Scanning for PnP cards...
	Jul 16 15:55:27 thx1138 kernel: isapnp: No Plug & Play device found
				:

Error when starting PCMCIA drivers:
      ds: no socket drivers loaded!
      PCI: Enabling device 00:13.0 (0000 -> 0002)
      PCI: No IRQ known for interrupt pin A of device 00:13.0. Probably buggy MP table.
      ds: no socket drivers loaded!
      Yenta IRQ list 0000, PCI irq0
      Socket status: 10000047 


[6.] A small shell script or example program which triggers the
     problem (if possible)

	     N/A

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux thx1138.ny.zeitgeist.com 2.4.3-12smp #1 SMP Fri Jun 8 14:38:50 EDT 2001 i6
86 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.11b
modutils               2.4.2
e2fsprogs              1.19
pcmcia-cs              3.1.22
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ds es1371 ac97_codec gameport soundcore bttv i2c-algo-bit
 videodev tuner nls_iso8859-1 sr_mod yenta_socket tvaudio i2c-core rocket applet
alk nfs lockd sunrpc pcmcia_core autofs eepro100 ipchains ide-scsi ide-cd cdrom 
hid usb-storage input usb-uhci usbcore aic7xxx sd_mod scsi_mod
[root@thx1138 spector]# 


[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 2
cpu MHz		: 501.141
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 999.42

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 2
cpu MHz		: 501.141
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 999.42


[7.3.] Module information (from /proc/modules):

ds                      6736   1
es1371                 30112   1 (autoclean)
ac97_codec              8608   0 (autoclean) [es1371]
gameport                1584   0 (autoclean) [es1371]
soundcore               3984   4 (autoclean) [es1371]
bttv                   54320   1 (autoclean)
i2c-algo-bit            7104   1 (autoclean) [bttv]
videodev                5056   3 (autoclean) [bttv]
tuner                   4080   1 (autoclean)
nls_iso8859-1           2880   1 (autoclean)
sr_mod                 13568   1 (autoclean)
yenta_socket            8816   1
tvaudio                 8192   0 (autoclean) (unused)
i2c-core               13472   0 (autoclean) [bttv i2c-algo-bit tuner tvaudio]
rocket                 23472   0 (unused)
appletalk              21712   0
nfs                    73568   2 (autoclean)
lockd                  49264   1 (autoclean) [nfs]
sunrpc                 62576   1 (autoclean) [nfs lockd]
pcmcia_core            40864   0 [ds yenta_socket]
autofs                  9504   3 (autoclean)
eepro100               16144   1 (autoclean)
ipchains               32000   0 (unused)
ide-scsi                7840   0
ide-cd                 26720   0
cdrom                  28160   0 [sr_mod ide-cd]
hid                    11568   0 (unused)
usb-storage            33568   0
input                   3424   0 [hid]
usb-uhci               21392   0 (unused)
usbcore                50560   1 [hid usb-storage usb-uhci]
aic7xxx               113840  13
sd_mod                 11040  12
scsi_mod               88864   5 [sr_mod ide-scsi usb-storage aic7xxx sd_mod]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
thx1138.ny.zeitgeist.com % cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0180-01c3 : Comtrol Rocketport
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0400-043f : Intel Corporation 82371AB PIIX4 ACPI
0440-045f : Intel Corporation 82371AB PIIX4 ACPI
0cf8-0cff : PCI conf1
1000-10ff : PCI CardBus #03
1400-14ff : PCI CardBus #03
c000-cfff : PCI Bus #01
  c800-c8ff : ATI Technologies Inc Rage 128 RF
d000-dfff : PCI Bus #02
e400-e4ff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895
  e400-e4fe : aic7xxx
e800-e8ff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2)
  e800-e8fe : aic7xxx
ef00-ef3f : Ensoniq ES1371 [AudioPCI-97]
  ef00-ef3f : es1371
ef40-ef5f : Intel Corporation 82557 [Ethernet Pro 100]
  ef40-ef5f : eepro100
ef80-ef9f : Intel Corporation 82371AB PIIX4 USB
  ef80-ef9f : usb-uhci
ffa0-ffaf : Intel Corporation 82371AB PIIX4 IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

thx1138.ny.zeitgeist.com % cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000d07ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffdffff : System RAM
  00100000-0024e4a7 : Kernel code
  0024e4a8-0026879f : Kernel data
3ffe0000-3fff7fff : ACPI Tables
3fff8000-3fffffff : ACPI Non-volatile Storage
40000000-40000fff : Texas Instruments PCI1410 PC card Cardbus Controller
40400000-407fffff : PCI CardBus #03
40800000-40bfffff : PCI CardBus #03
ee900000-f69fffff : PCI Bus #01
  f0000000-f3ffffff : ATI Technologies Inc Rage 128 RF
f6a00000-f6afffff : PCI Bus #02
  f6afe000-f6afefff : Brooktree Corporation Bt878
    f6afe000-f6afefff : bttv
  f6aff000-f6afffff : Brooktree Corporation Bt878
f8000000-fbffffff : Intel Corporation 440GX - 82443GX Host bridge
febff000-febfffff : Intel Corporation 82557 [Ethernet Pro 100]
  febff000-febfffff : eepro100
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ff400000-ff4fffff : PCI Bus #01
  ff4fc000-ff4fffff : ATI Technologies Inc Rage 128 RF
ff500000-ff5fffff : PCI Bus #02
ff900000-ff9fffff : Intel Corporation 82557 [Ethernet Pro 100]
ffafe000-ffafefff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895
ffaff000-ffafffff : Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (#2)
fffc0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
thx1138.ny.zeitgeist.com % lspci -vvv
00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ff400000-ff4fffff
	Prefetchable memory behind bridge: ee900000-f69fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 19
	Region 4: I/O ports at ef80 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:10.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: ff500000-ff5fffff
	Prefetchable memory behind bridge: 00000000f6a00000-00000000f6a00000
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

00:11.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 05)
	Subsystem: Intel Corporation 82558 10/100 with Wake on LAN
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at febff000 (32-bit, prefetchable) [size=4K]
	Region 1: I/O ports at ef40 [size=32]
	Region 2: Memory at ff900000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at ff800000 [disabled] [size=1M]
	Capabilities: <available only to root>

00:12.0 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (rev 04)
	Subsystem: Adaptec AHA-2940U/2940UW Dual AHA-394xAU/AUW/AUWD AIC-7895B
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at e400 [size=256]
	Region 1: Memory at ffafe000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at ffae0000 [disabled] [size=64K]
	Capabilities: <available only to root>

00:12.1 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (rev 04)
	Subsystem: Adaptec AHA-2940U/2940UW Dual AHA-394xAU/AUW/AUWD AIC-7895B
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin B routed to IRQ 16
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at ffaff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

00:13.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: SCM Microsystems: Unknown device 3000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, cache line size 08
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=176
	Memory window 0: 40400000-407ff000 (prefetchable)
	Memory window 1: 40800000-40bff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

00:14.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at ef00 [size=64]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0448
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at c800 [size=256]
	Region 2: Memory at ff4fc000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at ff4c0000 [disabled] [size=128K]
	Capabilities: <available only to root>

02:05.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at f6afe000 (32-bit, prefetchable) [size=4K]

02:05.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at f6aff000 (32-bit, prefetchable) [size=4K]



[7.6.] SCSI information (from /proc/scsi/scsi)
thx1138.ny.zeitgeist.com % cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST39140W         Rev: 1281
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: TOSHIBA  Model: CD-ROM XM-6401TA Rev: 1009
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST39140W         Rev: 1281
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: iomega   Model: jaz 2GB          Rev: E.16
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 04 Lun: 00
  Vendor: SEAGATE  Model: ST39140W         Rev: 1281
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: IOMEGA   Model: ZIP 250          Rev: 60.T
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: PHILIPS  Model: CDD3610 CD-R/RW  Rev: 3.01
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:




--------------------------------------------------------------------------------
David HM Spector                   spector@zeitgeist.com/spector@really-fast.com
President & CEO                                           voice: +1 631.261.5013
Really Fast Systems, LLC                                    Fax: +1 631.262.7497
				-----
Supercomputer performance to get the job done.
                                         Commodity pricing to make it affordable.





