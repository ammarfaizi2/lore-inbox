Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313356AbSDLEPw>; Fri, 12 Apr 2002 00:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313358AbSDLEPv>; Fri, 12 Apr 2002 00:15:51 -0400
Received: from bonneville.tdb.com ([216.99.214.10]:44205 "HELO coulee.tdb.com")
	by vger.kernel.org with SMTP id <S313356AbSDLEPs>;
	Fri, 12 Apr 2002 00:15:48 -0400
To: linux-kernel@vger.kernel.org
Subject: non-pingable lockups on 2.4.18-SMP
From: Russell Senior <seniorr@aracnet.com>
Date: 11 Apr 2002 21:15:45 -0700
Message-ID: <86k7rd1rim.fsf@coulee.tdb.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Four times since April 5th, my desktop box has locked up.  It has
uniformily, but perhaps coincidentally, occurred while I was mousing
around in Mozilla 0.9.9.  Mouse freezes, can't change vt's, can't
Alt-SysRq-<anything>, box doesn't respond to pings.  No terribly heavy
activity going on.  Reboot via big-red-switch.  Nothing terribly
unusual shows up in the logs, though I have seen an APIC error on
CPUx, which I don't remember seeing before.  This is on a dual 1GHz
PIII Abit VP6, with 1gig of RAM, which I've had about a year and have
seen no memorable problems before a few weeks ago.  This is a Debian
"unstable" box that is sync'd up every few days.  I've got
CONFIG_HIGHMEM=y and CONFIG_HIGHMEM4G=y if that makes a difference.
Any ideas?

The APIC errors look like:

Apr  6 23:19:22 celilo kernel: APIC error on CPU0: 00(02)
Apr  8 06:25:40 celilo kernel: APIC error on CPU0: 00(02)
Apr  8 06:25:40 celilo kernel: APIC error on CPU1: 00(04)
Apr  8 14:59:04 celilo kernel: APIC error on CPU1: 04(04)
Apr  8 14:59:04 celilo kernel: APIC error on CPU0: 02(02)
Apr 10 15:07:18 celilo kernel: APIC error on CPU0: 02(02)
Apr 10 15:07:18 celilo kernel: APIC error on CPU1: 04(04)
Apr 11 08:37:21 celilo kernel: APIC error on CPU0: 00(02)


$ cat /proc/version
Linux version 2.4.18 (root@celilo) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 SMP Sun Mar 10 14:43:30 PST 2002

$ sh /src/linux/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux celilo 2.4.18 #2 SMP Sun Mar 10 14:43:30 PST 2002 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.11
Modules Loaded         nls_iso8859-1 nls_cp437 vfat fat

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 998.393
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1992.29

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 998.393
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1992.29

$ cat /proc/modules
nls_iso8859-1           2848   1 (autoclean)
nls_cp437               4384   1 (autoclean)
vfat                    9916   1 (autoclean)
fat                    31480   0 (autoclean) [vfat]

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
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
9000-900f : VIA Technologies, Inc. Bus Master IDE
  9000-9007 : ide0
  9008-900f : ide1
9400-941f : VIA Technologies, Inc. UHCI USB
  9400-941f : usb-uhci
9800-981f : VIA Technologies, Inc. UHCI USB (#2)
  9800-981f : usb-uhci
9c00-9cff : 3Dfx Interactive, Inc. Voodoo 3
a000-a01f : Creative Labs SB Live! EMU10k1
  a000-a01f : EMU10K1
a400-a407 : Creative Labs SB Live!
a800-a83f : Intel Corp. 82557 [Ethernet Pro 100]
  a800-a83f : eepro100
ac00-acff : LSI Logic / Symbios Logic (formerly NCR) 53c810
  ac00-ac7f : sym53c8xx
b000-b007 : Triones Technologies, Inc. HPT366 / HPT370
  b000-b007 : ide2
b400-b403 : Triones Technologies, Inc. HPT366 / HPT370
  b402-b402 : ide2
b800-b807 : Triones Technologies, Inc. HPT366 / HPT370
  b800-b807 : ide3
bc00-bc03 : Triones Technologies, Inc. HPT366 / HPT370
  bc02-bc02 : ide3
c000-c0ff : Triones Technologies, Inc. HPT366 / HPT370
  c000-c007 : ide2
  c008-c00f : ide3
  c010-c0ff : HPT370

$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-00278131 : Kernel code
  00278132-002e80ff : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
d0000000-d3ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
d4000000-d5ffffff : 3Dfx Interactive, Inc. Voodoo 3
d6000000-d7ffffff : 3Dfx Interactive, Inc. Voodoo 3
d9000000-d901ffff : Intel Corp. 82557 [Ethernet Pro 100]
d9020000-d9020fff : Intel Corp. 82557 [Ethernet Pro 100]
  d9020000-d9020fff : eepro100
d9021000-d90210ff : LSI Logic / Symbios Logic (formerly NCR) 53c810
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
	Subsystem: ABIT Computer Corp.: Unknown device a204
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: ABIT Computer Corp.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at 9000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at 9400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at 9800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 11
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc. Voodoo3
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at d6000000 (32-bit, prefetchable) [size=32M]
	Region 2: I/O ports at 9c00 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
	Subsystem: Creative Labs: Unknown device 8071
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at a000 [size=32]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 Input device controller: Creative Labs SB Live! (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32
	Region 0: I/O ports at a400 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 0c)
	Subsystem: Intel Corp.: Unknown device 0040
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d9020000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at a800 [size=64]
	Region 2: Memory at d9000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0d.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c810 (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ac00 [size=256]
	Region 1: Memory at d9021000 (32-bit, non-prefetchable) [size=256]

00:0e.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 03)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at b000 [size=8]
	Region 1: I/O ports at b400 [size=4]
	Region 2: I/O ports at b800 [size=8]
	Region 3: I/O ports at bc00 [size=4]
	Region 4: I/O ports at c000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


$ cat /proc/scsi/scsi 
Attached devices: none



-- 
Russell Senior         ``The two chiefs turned to each other.        
seniorr@aracnet.com      Bellison uncorked a flood of horrible       
                         profanity, which, translated meant, `This is
                         extremely unusual.' ''                      
