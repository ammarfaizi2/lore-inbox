Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310380AbSCBNpv>; Sat, 2 Mar 2002 08:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310381AbSCBNpm>; Sat, 2 Mar 2002 08:45:42 -0500
Received: from pc-62-31-78-67-ed.blueyonder.co.uk ([62.31.78.67]:16512 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S310380AbSCBNph>;
	Sat, 2 Mar 2002 08:45:37 -0500
Date: Sat, 2 Mar 2002 13:45:23 +0000
From: rob@mur.org.uk
To: linux-kernel@vger.kernel.org
Subject: strange hang with promise ide and 2.4.18
Message-ID: <20020302134523.GA1022@mur.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have the following:

00:14.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)

I did have three of these cards, but I gave one away. The kernel
sometimes hangs during boot with no oops or panic. It depends on the
number of cards installed and how many disks are attached. If all 3
are installed and all channels have 1 disk, or 2 cards are installed
with a disk on each channel, the boot hangs. If 3 cards are installed,
but only 5 disks are attached, it doesn't hang. if 1 card is installed
with 2 disks attached, it doesn't hang.

PDC20267: IDE controller on PCI bus 00 dev a0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI
Mode.
    ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA, hdh:pio
<hangs at this point>

If I run grub with the current configuration (2 drives on 1 card) I
get the message saying it's probing drives and then it dies in the
same way without any error.

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 451.029
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 897.84

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 451.029
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 901.12


           CPU0       CPU1       
  0:      60003      53994    IO-APIC-edge  timer
  1:          1          1    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:        265        217    IO-APIC-edge  serial
  4:       3062       3107    IO-APIC-edge  serial
  8:          1          2    IO-APIC-edge  rtc
 14:      71692      62006    IO-APIC-edge  ide0
 15:      89068      86198    IO-APIC-edge  ide1
 16:       2939       2711   IO-APIC-level  eth0
 19:          8          5   IO-APIC-level  ide2, ide3
NMI:          0          0 
LOC:     113842     113839 
ERR:          0
MIS:          0

00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d5000000 (32-bit, prefetchable) [size=4M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: 86 80 90 71 06 00 10 22 03 00 00 06 00 20 00 00
10: 08 00 00 d5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: d0000000-d3ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+
00: 86 80 91 71 07 01 20 02 03 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 20 c0 c0 a0 22
20: 00 d0 f0 d3 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 88 00

00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 10 71 0f 00 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 19
	Region 4: I/O ports at d000 [size=32]
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00

00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
00: 86 80 13 71 03 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0b.0 SCSI storage controller: Adaptec AIC-7880U
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at d400 [size=256]
	Region 1: Memory at d5520000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 04 90 78 80 07 00 80 02 00 00 00 01 08 20 00 00
10: 01 d4 00 00 00 00 52 d5 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 08 08

00:13.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at d5521000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d800 [size=64]
	Region 2: Memory at d5400000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 29 12 07 00 90 02 08 00 00 02 08 20 00 00
10: 00 10 52 d5 01 d8 00 00 00 00 40 d5 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 0c 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 08 38

00:14.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 02)
	Subsystem: Promise Technology, Inc.: Unknown device 4d33
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at dc00 [size=8]
	Region 1: I/O ports at e000 [size=4]
	Region 2: I/O ports at e400 [size=8]
	Region 3: I/O ports at e800 [size=4]
	Region 4: I/O ports at ec00 [size=64]
	Region 5: Memory at d5500000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5a 10 30 4d 07 00 10 02 02 00 80 01 00 20 00 00
10: 01 dc 00 00 01 e0 00 00 01 e4 00 00 01 e8 00 00
20: 01 ec 00 00 00 00 50 d5 00 00 00 00 5a 10 33 4d
30: 00 00 00 00 58 00 00 00 00 00 00 00 0b 01 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev 27) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at d2000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 4d 47 87 00 90 02 27 00 00 03 08 20 00 00
10: 00 00 00 d0 01 c0 00 00 00 00 00 d2 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 08 00
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 01 08 00

config at http://mur.org.uk/~robbie/config-2.4.18

Cheers

-- 
Rob Murray
