Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129201AbRBINlu>; Fri, 9 Feb 2001 08:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129258AbRBINln>; Fri, 9 Feb 2001 08:41:43 -0500
Received: from 06-admin.deltav.hu ([213.163.4.102]:1796 "EHLO oxygene.albi.hu")
	by vger.kernel.org with ESMTP id <S129201AbRBINle>;
	Fri, 9 Feb 2001 08:41:34 -0500
Date: Fri, 9 Feb 2001 14:41:19 +0100
From: Gabor Lenart <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: IDE DVD ROM & 2.2.18 & UDMA = random freeze
Message-ID: <20010209144119.A463@supervisor.hu>
Reply-To: lgb@lgb.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Operating-System: oxygene Linux 2.2.18 i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just bought a DVD ROM drive to do something with our player (mplayer),
namely developing a css module for it. The problem is that after random
time of massive usage of drive, my computer freeze. It's most likely to
freeze when I'm copying large amount of data, but with only playing
mp3 from a CD (using my DVD drive) it freezed as well, but after some
hour only. The kernel log is empty but sometimes I found some zero byte
series (^@) in it (see the attached file).

I'm using the following
hdparm settings (hda is my harddisk, hdc is my dvd drive,
run from init script):

hdparm -u 1 -c 1 -m 8 -d 1 -k 1 -X66 /dev/hda
modprobe ide-cd cdrom
hdparm -d 1 -c 1 -X66 -u 1 -k 1 /dev/hdc

Note, that with harddisk I hadn't got any problem for months.

CPU (/proc/cpuinfo:)

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 400.916
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mmx 3dnow
bogomips        : 799.53


DVD drive (booting message):

VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
ide0: VIA Bus-Master (U)DMA Timing Config Success
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
ide1: VIA Bus-Master (U)DMA Timing Config Success
hda: QUANTUM FIREBALL EL5.1A, ATA DISK drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-105S 012, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15

DVD drive (hdparm -i /dev/hdc):

/dev/hdc:

 Model=Pioneer DVD-ROM ATAPIModel DVD-105S 012, FwRev=E1.22, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=13395, BuffSize=64kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2


Kernel (uname -a):

Linux oxygene 2.2.18 #1 Sat Dec 16 21:53:21 CET 2000 i586 unknown

PCI information (lspci -vvv as root):

00:00.0 Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 16
	Region 0: Memory at e0000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e4000000-e7ffffff
	Prefetchable memory behind bridge: e8000000-e9ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 41)
	Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at e000

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 0
	Region 4: I/O ports at e400

00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 05) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 Dual Head 16Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e8000000 (32-bit, prefetchable)
	Region 1: Memory at e4000000 (32-bit, non-prefetchable)
	Region 2: Memory at e5000000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1


Can you offer something to avoid freezes? My first try was to copy some
vob file from Matrix DVD with css-auth (reset,tstdvd,css-cat). The copyied
stream seems to be good (playable) but my PC freezed at the middle of
copying. It also happens when I inserted a CD into the drive and I played
various mpeg and divx streams from it.

I don't want to turn off DMA since it wouldn't enough to play mpeg2
streams (tested: on my CPU I'm able to play vob files from a CD directly
with our mpeg player and with the help of G400's hardware BES ;-)

PS: sorry for my probably bad English.

Thanx, Gabor

-- 
 --[ Gábor Lénárt ]---[ Vivendi Telecom Hungary ]--[ lgb@supervisor.hu ]--
 U have 8 bit comp or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]------> LGB <-----[ Linux/UNIX/8bit 4ever ]-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
