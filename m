Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264063AbTDWO6W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264071AbTDWO6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:58:21 -0400
Received: from [195.167.170.152] ([195.167.170.152]:52134 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id S264063AbTDWO5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:57:54 -0400
Date: Wed, 23 Apr 2003 16:09:57 +0100
From: Athanasius <link@miggy.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: andre@linux-ide.org, andre@linuxdiskcert.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Linux 2.4.21-rc1
Message-ID: <20030423150956.GH25981@miggy.org>
Mail-Followup-To: Athanasius <link@miggy.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel <linux-kernel@vger.kernel.org>, andre@linux-ide.org,
	andre@linuxdiskcert.org, alan@lxorguk.ukuu.org.uk
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXr400anF0jyguTS"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
X-gpg-fingerprint: B34E4BC3
X-gpg-key: http://www.fysh.org/~athan/gpg-key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXr400anF0jyguTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2003 at 03:47:32PM -0300, Marcelo Tosatti wrote:
>=20
> Here goes the first candidate for 2.4.21.
>=20
> Please test it extensively.

  I'm still seeing a problem with my primary IDE channel locking up for
10-15s at a time, an event I can trigger by running updatedb (i.e. the
database update for 'locate').

  Original report was against 2.4.21-pre7.  I've tried 2.4.21-pre5-ac3
with the same problem, 2.4.21-pre4 does NOT exhibit the problem.

The problem manifests itself in dmesg as:

Apr 23 15:27:22 emelia kernel: hda: dma_timer_expiry: dma status =3D=3D 0x24
Apr 23 15:27:22 emelia kernel: hda: lost interrupt
Apr 23 15:27:22 emelia kernel: hda: dma_intr: bad DMA status (dma_stat=3D30)
Apr 23 15:27:22 emelia kernel: hda: dma_intr: status=3D0x50 { DriveReady Se=
ekComplete }

  In normal use this problem will manifest at 'random', but frequently
enough to make the machine unuseable for any great amount of HD
activity.

  The affected machine is based on a Gigabyte GA-7VTX-H motherboard, with
BIOS revision F8a.  That's an all-VIA KT266 chipset, as seen in the lspci
output below.  Athlon XP 1600+ CPU @1.4GHz (i.e. not overclocked).  512MB
PC2100 DDR RAM.  The only card is a PNY GF4Ti4800 128MB (unrecognised
in lspci output, but it's just an 8x AGP version of the 4600 model that
is recognised, as far as I know).  Sound and LAN are onboard.
  The affected Hard Disk is a Maxtor 60GB, as master on primary IDE channel,
no slave, using an 80wire cable.  Secondary IDE channel has a 4x CD-ROM
as master, and CD-RW as slave on a 40wire cable.  The two channels are
using seperate IRQ and memory ranges (see dmesg output in section 7.7).

hdparm -i /dev/hda
/dev/hda:

 Model=3DMAXTOR 4K060H3, FwRev=3DA08.1500, SerialNo=3D673200978766
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3D16383/16/63, TrkSize=3D32256, SectSize=3D21298, ECCbytes=3D4
 BuffType=3DDualPortCache, BuffSize=3D2000kB, MaxMultSect=3D16, MultSect=3D=
off
 CurCHS=3D34404/15/32, CurSects=3D16513920, LBA=3Dyes, LBAsects=3D117266688
 IORDY=3Don/off, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=3Dno WriteCache=3Denabled
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3 ATA-=
4 ATA-5

That's as it is configured post-boot, no hdparm command run to change
anything.  I do have to force the CHS to 14370,255,32 so that the BIOS,
Windows 98 and Linux are all happy.

  Information for how it just occurred with 2.4.21-rc1:

/proc/version:
Linux version 2.4.21-rc1 (athan@emelia) (gcc version 2.95.4 20011002 (Debia=
n prerelease)) #1 Mon Apr 21 21:07:22 BST 2003

ver_linux:
/root/bin/getinfo: /usr/local/src/kernels/2.4.21-rc1/scripts/ver_linux: No =
such file or directory

/proc/cpuinfo:
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) XP 1600+
stepping	: 2
cpu MHz		: 1406.013
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse3=
6 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 2804.94


/proc/modules:
mousedev                3904   0 (unused)
hid                    19520   0 (unused)
usb-uhci               21636   0 (unused)
ide-scsi                9120   0
scsi_mod               89880   1 [ide-scsi]
ide-cd                 29024   0
cdrom                  29024   0 [ide-cd]
8139too                15360   1
mii                     2448   0 [8139too]

/proc/ioports:
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
dc00-dcff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  dc00-dcff : 8139too
e000-e01f : VIA Technologies, Inc. USB (#3)
  e000-e01f : usb-uhci
e400-e41f : VIA Technologies, Inc. USB (#2)
  e400-e41f : usb-uhci
e800-e81f : VIA Technologies, Inc. USB
  e800-e81f : usb-uhci
ec00-ec3f : Ensoniq 5880 AudioPCI
fc00-fc0f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  fc00-fc07 : ide0
  fc08-fc0f : ide1

/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-00265824 : Kernel code
  00265825-002f987f : Kernel data
1fff0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
cdc00000-ddcfffff : PCI Bus #01
  d0000000-d7ffffff : PCI device 10de:0280 (nVidia Corporation)
dde00000-dfefffff : PCI Bus #01
  de000000-deffffff : PCI device 10de:0280 (nVidia Corporation)
dfffff00-dfffffff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  dfffff00-dfffffff : 8139too
e0000000-e7ffffff : VIA Technologies, Inc. VT8367 [KT266]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fffc0000-ffffffff : reserved

lspci -vvv:
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
	Subsystem: VIA Technologies, Inc. VT8367 [KT266]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 [=
Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: dde00000-dfefffff
	Prefetchable memory behind bridge: cdc00000-ddcfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 04)
	Subsystem: Giga-byte Technology: Unknown device a000
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- <TAbort- =
<MAbort- >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at ec00 [size=3D64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Subsystem: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog=
-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at fc00 [size=3D16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1b) (prog-if 0=
0 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e800 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1b) (prog-if 0=
0 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e400 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.4 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1b) (prog-if 0=
0 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e000 [size=3D32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:13.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev =
10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at dc00 [size=3D256]
	Region 1: Memory at dfffff00 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0-,D1+,D2+,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0280 =
(rev a1) (prog-if 00 [VGA])
	Subsystem: Micro-star International Co Ltd: Unknown device 9000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=3D16M]
	Region 1: Memory at d0000000 (32-bit, prefetchable) [size=3D128M]
	Expansion ROM at dfee0000 [disabled] [size=3D128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=3D31 SBA+ 64bit- FW+ Rate=3Dx1,x2
		Command: RQ=3D0 SBA- AGP- 64bit- FW- Rate=3D<none>


/proc/scsi/scsi
Attached devices:=20
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: MITSUMI  Model: CR-4804TE        Rev: 3.0D
  Type:   CD-ROM                           ANSI SCSI revision: 02

post-boot dmesg:
Linux version 2.4.21-rc1 (athan@emelia) (gcc version 2.95.4 20011002 (Debia=
n prerelease)) #1 Mon Apr 21 21:07:22 BST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fb9b0
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: GIGABYTE Product ID: 7VTXH        APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 2 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 1
Kernel command line: BOOT_IMAGE=3D2421r1 ro root=3D305 mem=3Dnopentium hda=
=3D14370,255,32 hdd=3Dide-scsi
ide_setup: hda=3D14370,255,32
ide_setup: hdd=3Dide-scsi
Initializing CPU#0
Detected 1406.013 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2804.94 BogoMIPS
Memory: 515248k/524224k available (1430k kernel code, 8588k reserved, 592k =
data, 116k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbf7 c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbf7 c1cbfbff 00000000 00000000
CPU: AMD Athlon(tm) XP 1600+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000080
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
=2E..changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-11, 2-12, 2-19, 2-20, 2-21, 2-22, 2-23 no=
t connected.
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 19.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
=2E... register #00: 02000000
=2E......    : physical APIC id: 02
=2E......    : Delivery Type: 0
=2E......    : LTS          : 0
=2E... register #01: 00178002
=2E......     : max redirection entries: 0017
=2E......     : PRQ implemented: 1
=2E......     : IO APIC version: 0002
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 001 01  0    0    0   0   0    1    1    69
 0a 001 01  1    1    0   1   0    1    1    71
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 001 01  0    0    0   0   0    1    1    79
 0e 001 01  0    0    0   0   0    1    1    81
 0f 001 01  0    0    0   0   0    1    1    89
 10 001 01  1    1    0   1   0    1    1    91
 11 001 01  1    1    0   1   0    1    1    99
 12 001 01  1    1    0   1   0    1    1    A1
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 1405.9966 MHz.
=2E.... host bus clock speed is 267.8089 MHz.
cpu: 0, clocks: 2678089, slice: 1339044
CPU0<T0:2678080,T1:1339024,D:12,S:1339044,C:2678089>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1106/3074] at 00:11.0
PCI->APIC IRQ transform: (B0,I16,P0) -> 17
PCI->APIC IRQ transform: (B0,I17,P0) -> 16
PCI->APIC IRQ transform: (B0,I17,P3) -> 10
PCI->APIC IRQ transform: (B0,I17,P3) -> 10
PCI->APIC IRQ transform: (B0,I17,P3) -> 10
PCI->APIC IRQ transform: (B0,I19,P0) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
Software Watchdog Timer: 0.05, timer margin: 60 sec
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT266 chipset
agpgart: AGP aperture is 128M @ 0xe0000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:DMA
hda: MAXTOR 4K060H3, ATA DISK drive
blk: queue c0346a60, I/O limit 4095Mb (mask 0xffffffff)
hdc: TOSHIBA CD-ROM XM-5302TA, ATAPI CD/DVD-ROM drive
hdd: CR-4804TE, ATAPI CD/DVD-ROM drive
hdc: set_drive_speed_status: status=3D0x51 { DriveReady SeekComplete Error }
hdc: set_drive_speed_status: error=3D0x04
ide1: Drive 0 didn't accept speed setting. Oh, well.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area =3D> 1
hda: 117266688 sectors (60041 MB) w/2000KiB Cache, CHS=3D14370/255/32, UDMA=
(100)
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 8
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
registering ipv6 mark target
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 116k freed
Adding Swap: 265176k swap-space (priority -1)
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xe0880f00, 00:20:ed:1d:fe:2a, IRQ 18
eth0:  Identified 8139 chip type 'RTL-8139B'
hdc: attached ide-cdrom driver.
hdc: ATAPI 4X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
hdd: attached ide-scsi driver.
hdd: DMA disabled
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MITSUMI   Model: CR-4804TE         Rev: 3.0D
  Type:   CD-ROM                             ANSI SCSI revision: 02
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,11), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability =
41e1.

Relevant lines of /var/log/kern.log:
Apr 23 15:22:16 emelia kernel: klogd 1.4.1#10, log source =3D /proc/kmsg st=
arted.
Apr 23 15:22:16 emelia kernel: Inspecting /boot/System.map-2.4.21-rc1
Apr 23 15:22:16 emelia kernel: Loaded 19134 symbols from /boot/System.map-2=
.4.21-rc1.
Apr 23 15:22:16 emelia kernel: Symbols match kernel version 2.4.21.
Apr 23 15:22:16 emelia kernel: Loaded 119 symbols from 6 modules.
Apr 23 15:22:16 emelia kernel: Linux version 2.4.21-rc1 (athan@emelia) (gcc=
 version 2.95.4 20011002 (Debian prerelease)) #1 Mon Apr 21 21:07:22 BST 20=
03
Apr 23 15:22:16 emelia kernel: BIOS-provided physical RAM map:
Apr 23 15:22:16 emelia kernel:  BIOS-e820: 0000000000000000 - 000000000009f=
c00 (usable)
Apr 23 15:22:16 emelia kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0=
000 (reserved)
Apr 23 15:22:16 emelia kernel:  BIOS-e820: 00000000000f0000 - 0000000000100=
000 (reserved)
Apr 23 15:22:16 emelia kernel:  BIOS-e820: 0000000000100000 - 000000001fff0=
000 (usable)
Apr 23 15:22:16 emelia kernel:  BIOS-e820: 000000001fff0000 - 000000001fff8=
000 (ACPI data)
Apr 23 15:22:16 emelia kernel:  BIOS-e820: 000000001fff8000 - 0000000020000=
000 (ACPI NVS)
Apr 23 15:22:16 emelia kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01=
000 (reserved)
Apr 23 15:22:16 emelia kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01=
000 (reserved)
Apr 23 15:22:16 emelia kernel:  BIOS-e820: 00000000fffc0000 - 0000000100000=
000 (reserved)
Apr 23 15:22:16 emelia kernel: 511MB LOWMEM available.
Apr 23 15:22:16 emelia kernel: found SMP MP-table at 000fb9b0
Apr 23 15:22:16 emelia kernel: hm, page 000fb000 reserved twice.
Apr 23 15:22:16 emelia kernel: hm, page 000fc000 reserved twice.
Apr 23 15:22:16 emelia kernel: hm, page 000f6000 reserved twice.
Apr 23 15:22:16 emelia kernel: hm, page 000f7000 reserved twice.
Apr 23 15:22:16 emelia kernel: On node 0 totalpages: 131056
Apr 23 15:22:16 emelia kernel: zone(0): 4096 pages.
Apr 23 15:22:16 emelia kernel: zone(1): 126960 pages.
Apr 23 15:22:16 emelia kernel: zone(2): 0 pages.
Apr 23 15:22:16 emelia kernel: Intel MultiProcessor Specification v1.4
Apr 23 15:22:16 emelia kernel:     Virtual Wire compatibility mode.
Apr 23 15:22:16 emelia kernel: OEM ID: GIGABYTE Product ID: 7VTXH        AP=
IC at: 0xFEE00000
Apr 23 15:22:16 emelia kernel: Processor #0 Pentium(tm) Pro APIC version 17
Apr 23 15:22:16 emelia kernel: I/O APIC #2 Version 2 at 0xFEC00000.
Apr 23 15:22:16 emelia kernel: Enabling APIC mode: Flat.^IUsing 1 I/O APICs
Apr 23 15:22:16 emelia kernel: Processors: 1
Apr 23 15:22:16 emelia kernel: Kernel command line: BOOT_IMAGE=3D2421r1 ro =
root=3D305 mem=3Dnopentium hda=3D14370,255,32 hdd=3Dide-scsi
Apr 23 15:22:16 emelia kernel: ide_setup: hda=3D14370,255,32
Apr 23 15:22:16 emelia kernel: ide_setup: hdd=3Dide-scsi
Apr 23 15:22:16 emelia kernel: Initializing CPU#0
Apr 23 15:22:16 emelia kernel: Detected 1406.013 MHz processor.
Apr 23 15:22:16 emelia kernel: Console: colour VGA+ 80x25
Apr 23 15:22:16 emelia kernel: Calibrating delay loop... 2804.94 BogoMIPS
Apr 23 15:22:16 emelia kernel: Memory: 515248k/524224k available (1430k ker=
nel code, 8588k reserved, 592k data, 116k init, 0k highmem)
Apr 23 15:22:16 emelia kernel: Checking if this processor honours the WP bi=
t even in supervisor mode... Ok.
Apr 23 15:22:16 emelia kernel: Dentry cache hash table entries: 65536 (orde=
r: 7, 524288 bytes)
Apr 23 15:22:16 emelia kernel: Inode cache hash table entries: 32768 (order=
: 6, 262144 bytes)
Apr 23 15:22:16 emelia kernel: Mount cache hash table entries: 512 (order: =
0, 4096 bytes)
Apr 23 15:22:16 emelia kernel: Buffer-cache hash table entries: 32768 (orde=
r: 5, 131072 bytes)
Apr 23 15:22:16 emelia kernel: Page-cache hash table entries: 131072 (order=
: 7, 524288 bytes)
Apr 23 15:22:16 emelia kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cach=
e 64K (64 bytes/line)
Apr 23 15:22:16 emelia kernel: CPU: L2 Cache: 256K (64 bytes/line)
Apr 23 15:22:16 emelia kernel: Intel machine check architecture supported.
Apr 23 15:22:16 emelia kernel: Intel machine check reporting enabled on CPU=
#0.
Apr 23 15:22:16 emelia kernel: CPU:     After generic, caps: 0383fbf7 c1cbf=
bff 00000000 00000000
Apr 23 15:22:16 emelia kernel: CPU:             Common caps: 0383fbf7 c1cbf=
bff 00000000 00000000
Apr 23 15:22:16 emelia kernel: CPU: AMD Athlon(tm) XP 1600+ stepping 02
Apr 23 15:22:16 emelia kernel: Enabling fast FPU save and restore... done.
Apr 23 15:22:16 emelia kernel: Enabling unmasked SIMD FPU exception support=
... done.
Apr 23 15:22:16 emelia kernel: Checking 'hlt' instruction... OK.
Apr 23 15:22:16 emelia kernel: POSIX conformance testing by UNIFIX
Apr 23 15:22:16 emelia kernel: enabled ExtINT on CPU#0
Apr 23 15:22:16 emelia kernel: ESR value before enabling vector: 00000080
Apr 23 15:22:16 emelia kernel: ESR value after enabling vector: 00000000
Apr 23 15:22:16 emelia kernel: ENABLING IO-APIC IRQs
Apr 23 15:22:16 emelia kernel: Setting 2 in the phys_id_present_map
Apr 23 15:22:16 emelia kernel: ...changing IO-APIC physical APIC ID to 2 ..=
. ok.
Apr 23 15:22:16 emelia kernel: init IO_APIC IRQs
Apr 23 15:22:16 emelia kernel:  IO-APIC (apicid-pin) 2-0, 2-5, 2-11, 2-12, =
2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Apr 23 15:22:16 emelia kernel: ..TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
Apr 23 15:22:16 emelia kernel: number of MP IRQ sources: 19.
Apr 23 15:22:16 emelia kernel: number of IO-APIC #2 registers: 24.
Apr 23 15:22:16 emelia kernel: testing the IO APIC.......................
Apr 23 15:22:16 emelia kernel:=20
Apr 23 15:22:16 emelia kernel: IO APIC #2......
Apr 23 15:22:16 emelia kernel: .... register #00: 02000000
Apr 23 15:22:16 emelia kernel: .......    : physical APIC id: 02
Apr 23 15:22:16 emelia kernel: .......    : Delivery Type: 0
Apr 23 15:22:16 emelia kernel: .......    : LTS          : 0
Apr 23 15:22:16 emelia kernel: .... register #01: 00178002
Apr 23 15:22:16 emelia kernel: .......     : max redirection entries: 0017
Apr 23 15:22:16 emelia kernel: .......     : PRQ implemented: 1
Apr 23 15:22:16 emelia kernel: .......     : IO APIC version: 0002
Apr 23 15:22:16 emelia kernel: .... IRQ redirection table:
Apr 23 15:22:16 emelia kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli=
 Vect:  =20
Apr 23 15:22:16 emelia kernel:  00 000 00  1    0    0   0   0    0    0   =
 00
Apr 23 15:22:16 emelia kernel:  01 001 01  0    0    0   0   0    1    1   =
 39
Apr 23 15:22:16 emelia kernel:  02 001 01  0    0    0   0   0    1    1   =
 31
Apr 23 15:22:16 emelia kernel:  03 001 01  0    0    0   0   0    1    1   =
 41
Apr 23 15:22:16 emelia kernel:  04 001 01  0    0    0   0   0    1    1   =
 49
Apr 23 15:22:16 emelia kernel:  05 000 00  1    0    0   0   0    0    0   =
 00
Apr 23 15:22:16 emelia kernel:  06 001 01  0    0    0   0   0    1    1   =
 51
Apr 23 15:22:16 emelia kernel:  07 001 01  0    0    0   0   0    1    1   =
 59
Apr 23 15:22:16 emelia kernel:  08 001 01  0    0    0   0   0    1    1   =
 61
Apr 23 15:22:16 emelia kernel:  09 001 01  0    0    0   0   0    1    1   =
 69
Apr 23 15:22:16 emelia kernel:  0a 001 01  1    1    0   1   0    1    1   =
 71
Apr 23 15:22:16 emelia kernel:  0b 000 00  1    0    0   0   0    0    0   =
 00
Apr 23 15:22:16 emelia kernel:  0c 000 00  1    0    0   0   0    0    0   =
 00
Apr 23 15:22:16 emelia kernel:  0d 001 01  0    0    0   0   0    1    1   =
 79
Apr 23 15:22:16 emelia kernel:  0e 001 01  0    0    0   0   0    1    1   =
 81
Apr 23 15:22:16 emelia kernel:  0f 001 01  0    0    0   0   0    1    1   =
 89
Apr 23 15:22:16 emelia kernel:  10 001 01  1    1    0   1   0    1    1   =
 91
Apr 23 15:22:16 emelia kernel:  11 001 01  1    1    0   1   0    1    1   =
 99
Apr 23 15:22:16 emelia kernel:  12 001 01  1    1    0   1   0    1    1   =
 A1
Apr 23 15:22:16 emelia kernel:  13 000 00  1    0    0   0   0    0    0   =
 00
Apr 23 15:22:16 emelia kernel:  14 000 00  1    0    0   0   0    0    0   =
 00
Apr 23 15:22:16 emelia kernel:  15 000 00  1    0    0   0   0    0    0   =
 00
Apr 23 15:22:16 emelia kernel:  16 000 00  1    0    0   0   0    0    0   =
 00
Apr 23 15:22:16 emelia kernel:  17 000 00  1    0    0   0   0    0    0   =
 00
Apr 23 15:22:16 emelia kernel: IRQ to pin mappings:
Apr 23 15:22:16 emelia kernel: IRQ0 -> 0:2
Apr 23 15:22:16 emelia kernel: IRQ1 -> 0:1
Apr 23 15:22:16 emelia kernel: IRQ3 -> 0:3
Apr 23 15:22:16 emelia kernel: IRQ4 -> 0:4
Apr 23 15:22:16 emelia kernel: IRQ6 -> 0:6
Apr 23 15:22:16 emelia kernel: IRQ7 -> 0:7
Apr 23 15:22:16 emelia kernel: IRQ8 -> 0:8
Apr 23 15:22:16 emelia kernel: IRQ9 -> 0:9
Apr 23 15:22:16 emelia kernel: IRQ10 -> 0:10
Apr 23 15:22:16 emelia kernel: IRQ13 -> 0:13
Apr 23 15:22:16 emelia kernel: IRQ14 -> 0:14
Apr 23 15:22:16 emelia kernel: IRQ15 -> 0:15
Apr 23 15:22:16 emelia kernel: IRQ16 -> 0:16
Apr 23 15:22:16 emelia kernel: IRQ17 -> 0:17
Apr 23 15:22:16 emelia kernel: IRQ18 -> 0:18
Apr 23 15:22:16 emelia kernel: .................................... done.
Apr 23 15:22:16 emelia kernel: Using local APIC timer interrupts.
Apr 23 15:22:16 emelia kernel: calibrating APIC timer ...
Apr 23 15:22:16 emelia kernel: ..... CPU clock speed is 1405.9966 MHz.
Apr 23 15:22:16 emelia kernel: ..... host bus clock speed is 267.8089 MHz.
Apr 23 15:22:16 emelia kernel: cpu: 0, clocks: 2678089, slice: 1339044
Apr 23 15:22:16 emelia kernel: CPU0<T0:2678080,T1:1339024,D:12,S:1339044,C:=
2678089>
Apr 23 15:22:16 emelia kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch=
@atnf.csiro.au)
Apr 23 15:22:16 emelia kernel: mtrr: detected mtrr type: Intel
Apr 23 15:22:16 emelia kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdb01=
, last bus=3D1
Apr 23 15:22:16 emelia kernel: PCI: Using configuration type 1
Apr 23 15:22:16 emelia kernel: PCI: Probing PCI hardware
Apr 23 15:22:16 emelia kernel: PCI: Using IRQ router default [1106/3074] at=
 00:11.0
Apr 23 15:22:16 emelia kernel: PCI->APIC IRQ transform: (B0,I16,P0) -> 17
Apr 23 15:22:16 emelia kernel: PCI->APIC IRQ transform: (B0,I17,P0) -> 16
Apr 23 15:22:16 emelia kernel: PCI->APIC IRQ transform: (B0,I17,P3) -> 10
Apr 23 15:22:16 emelia last message repeated 2 times
Apr 23 15:22:16 emelia kernel: PCI->APIC IRQ transform: (B0,I19,P0) -> 18
Apr 23 15:22:16 emelia kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Apr 23 15:22:16 emelia kernel: isapnp: Scanning for PnP cards...
Apr 23 15:22:16 emelia kernel: isapnp: No Plug & Play device found
Apr 23 15:22:16 emelia kernel: Linux NET4.0 for Linux 2.4
Apr 23 15:22:16 emelia kernel: Based upon Swansea University Computer Socie=
ty NET3.039
Apr 23 15:22:16 emelia kernel: Initializing RT netlink socket
Apr 23 15:22:16 emelia kernel: Starting kswapd
Apr 23 15:22:16 emelia kernel: VFS: Diskquotas version dquot_6.4.0 initiali=
zed
Apr 23 15:22:16 emelia kernel: Journalled Block Device driver loaded
Apr 23 15:22:16 emelia kernel: Detected PS/2 Mouse Port.
Apr 23 15:22:16 emelia kernel: pty: 256 Unix98 ptys configured
Apr 23 15:22:16 emelia kernel: Serial driver version 5.05c (2001-07-08) wit=
h MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Apr 23 15:22:16 emelia kernel: ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
Apr 23 15:22:16 emelia kernel: ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Apr 23 15:22:16 emelia kernel: Real Time Clock Driver v1.10e
Apr 23 15:22:16 emelia kernel: Non-volatile memory driver v1.2
Apr 23 15:22:16 emelia kernel: Software Watchdog Timer: 0.05, timer margin:=
 60 sec
Apr 23 15:22:16 emelia kernel: Floppy drive(s): fd0 is 1.44M
Apr 23 15:22:16 emelia kernel: FDC 0 is a post-1991 82077
Apr 23 15:22:16 emelia kernel: Linux agpgart interface v0.99 (c) Jeff Hartm=
ann
Apr 23 15:22:16 emelia kernel: agpgart: Maximum main memory to use for agp =
memory: 439M
Apr 23 15:22:16 emelia kernel: agpgart: Detected Via Apollo Pro KT266 chips=
et
Apr 23 15:22:16 emelia kernel: agpgart: AGP aperture is 128M @ 0xe0000000
Apr 23 15:22:16 emelia kernel: Uniform Multi-Platform E-IDE driver Revision=
: 7.00beta-2.4
Apr 23 15:22:16 emelia kernel: ide: Assuming 33MHz system bus speed for PIO=
 modes; override with idebus=3Dxx
Apr 23 15:22:16 emelia kernel: VP_IDE: IDE controller at PCI slot 00:11.1
Apr 23 15:22:16 emelia kernel: VP_IDE: chipset revision 6
Apr 23 15:22:16 emelia kernel: VP_IDE: not 100%% native mode: will probe ir=
qs later
Apr 23 15:22:16 emelia kernel: VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 cont=
roller on pci00:11.1
Apr 23 15:22:16 emelia kernel:     ide0: BM-DMA at 0xfc00-0xfc07, BIOS sett=
ings: hda:DMA, hdb:pio
Apr 23 15:22:16 emelia kernel:     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS sett=
ings: hdc:pio, hdd:DMA
Apr 23 15:22:16 emelia kernel: hda: MAXTOR 4K060H3, ATA DISK drive
Apr 23 15:22:16 emelia kernel: blk: queue c0346a60, I/O limit 4095Mb (mask =
0xffffffff)
Apr 23 15:22:16 emelia kernel: hdc: TOSHIBA CD-ROM XM-5302TA, ATAPI CD/DVD-=
ROM drive
Apr 23 15:22:16 emelia kernel: hdd: CR-4804TE, ATAPI CD/DVD-ROM drive
Apr 23 15:22:16 emelia kernel: hdc: set_drive_speed_status: status=3D0x51 {=
 DriveReady SeekComplete Error }
Apr 23 15:22:16 emelia kernel: hdc: set_drive_speed_status: error=3D0x04
Apr 23 15:22:16 emelia kernel: ide1: Drive 0 didn't accept speed setting. O=
h, well.
Apr 23 15:22:16 emelia kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Apr 23 15:22:16 emelia kernel: ide1 at 0x170-0x177,0x376 on irq 15
Apr 23 15:22:16 emelia kernel: hda: attached ide-disk driver.
Apr 23 15:22:16 emelia kernel: hda: host protected area =3D> 1
Apr 23 15:22:16 emelia kernel: hda: 117266688 sectors (60041 MB) w/2000KiB =
Cache, CHS=3D14370/255/32, UDMA(100)
Apr 23 15:22:16 emelia kernel: Partition check:
Apr 23 15:22:16 emelia kernel:  hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 h=
da9 hda10 hda11 >
Apr 23 15:22:16 emelia kernel: usb.c: registered new driver usbdevfs
Apr 23 15:22:16 emelia kernel: usb.c: registered new driver hub
Apr 23 15:22:16 emelia kernel: I2O Core - (C) Copyright 1999 Red Hat Softwa=
re
Apr 23 15:22:16 emelia kernel: I2O: Event thread created as pid 8
Apr 23 15:22:16 emelia kernel: Linux I2O PCI support (c) 1999 Red Hat Softw=
are.
Apr 23 15:22:16 emelia kernel: i2o: Checking for PCI I2O controllers...
Apr 23 15:22:16 emelia kernel: I2O configuration manager v 0.04.
Apr 23 15:22:16 emelia kernel:   (C) Copyright 1999 Red Hat Software
Apr 23 15:22:16 emelia kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Apr 23 15:22:16 emelia kernel: IP Protocols: ICMP, UDP, TCP
Apr 23 15:22:16 emelia kernel: IP: routing cache hash table of 4096 buckets=
, 32Kbytes
Apr 23 15:22:16 emelia kernel: TCP: Hash tables configured (established 327=
68 bind 32768)
Apr 23 15:22:16 emelia kernel: IPv4 over IPv4 tunneling driver
Apr 23 15:22:16 emelia kernel: GRE over IPv4 tunneling driver
Apr 23 15:22:16 emelia kernel: ip_conntrack version 2.1 (4095 buckets, 3276=
0 max) - 292 bytes per conntrack
Apr 23 15:22:16 emelia kernel: ip_tables: (C) 2000-2002 Netfilter core team
Apr 23 15:22:16 emelia kernel: NET4: Unix domain sockets 1.0/SMP for Linux =
NET4.0.
Apr 23 15:22:16 emelia kernel: IPv6 v0.8 for NET4.0
Apr 23 15:22:16 emelia kernel: IPv6 over IPv4 tunneling driver
Apr 23 15:22:16 emelia kernel: ip6_tables: (C) 2000-2002 Netfilter core team
Apr 23 15:22:16 emelia kernel: registering ipv6 mark target
Apr 23 15:22:16 emelia kernel: VFS: Mounted root (ext2 filesystem) readonly.
Apr 23 15:22:16 emelia kernel: Freeing unused kernel memory: 116k freed
Apr 23 15:22:16 emelia kernel: Adding Swap: 265176k swap-space (priority -1)
Apr 23 15:22:16 emelia kernel: 8139too Fast Ethernet driver 0.9.26
Apr 23 15:22:16 emelia kernel: eth0: RealTek RTL8139 Fast Ethernet at 0xe08=
80f00, 00:20:ed:1d:fe:2a, IRQ 18
Apr 23 15:22:16 emelia kernel: eth0:  Identified 8139 chip type 'RTL-8139B'
Apr 23 15:22:16 emelia kernel: hdc: attached ide-cdrom driver.
Apr 23 15:22:16 emelia kernel: hdc: ATAPI 4X CD-ROM drive, 128kB Cache
Apr 23 15:22:16 emelia kernel: Uniform CD-ROM driver Revision: 3.12
Apr 23 15:22:16 emelia kernel: SCSI subsystem driver Revision: 1.00
Apr 23 15:22:16 emelia kernel: hdd: attached ide-scsi driver.
Apr 23 15:22:16 emelia kernel: hdd: DMA disabled
Apr 23 15:22:16 emelia kernel: scsi0 : SCSI host adapter emulation for IDE =
ATAPI devices
Apr 23 15:22:16 emelia kernel:   Vendor: MITSUMI   Model: CR-4804TE        =
 Rev: 3.0D
Apr 23 15:22:16 emelia kernel:   Type:   CD-ROM                            =
 ANSI SCSI revision: 02
Apr 23 15:22:16 emelia kernel: kjournald starting.  Commit interval 5 secon=
ds
Apr 23 15:22:16 emelia kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3=
,7), internal journal
Apr 23 15:22:16 emelia kernel: EXT3-fs: mounted filesystem with ordered dat=
a mode.
Apr 23 15:22:16 emelia kernel: kjournald starting.  Commit interval 5 secon=
ds
Apr 23 15:22:16 emelia kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3=
,9), internal journal
Apr 23 15:22:16 emelia kernel: EXT3-fs: mounted filesystem with ordered dat=
a mode.
Apr 23 15:22:16 emelia kernel: kjournald starting.  Commit interval 5 secon=
ds
Apr 23 15:22:16 emelia kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3=
,10), internal journal
Apr 23 15:22:16 emelia kernel: EXT3-fs: mounted filesystem with ordered dat=
a mode.
Apr 23 15:22:16 emelia kernel: kjournald starting.  Commit interval 5 secon=
ds
Apr 23 15:22:16 emelia kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3=
,11), internal journal
Apr 23 15:22:16 emelia kernel: EXT3-fs: mounted filesystem with ordered dat=
a mode.
Apr 23 15:22:16 emelia kernel: eth0: Setting 100mbps full-duplex based on a=
uto-negotiated partner ability 41e1.
Apr 23 15:22:20 emelia kernel: usb-uhci.c: $Revision: 1.275 $ time 21:12:34=
 Apr 21 2003
Apr 23 15:22:20 emelia kernel: usb-uhci.c: High bandwidth mode enabled
Apr 23 15:22:20 emelia kernel: usb-uhci.c: USB UHCI at I/O 0xe800, IRQ 10
Apr 23 15:22:20 emelia kernel: usb-uhci.c: Detected 2 ports
Apr 23 15:22:20 emelia kernel: usb.c: new USB bus registered, assigned bus =
number 1
Apr 23 15:22:20 emelia kernel: hub.c: USB hub found
Apr 23 15:22:20 emelia kernel: hub.c: 2 ports detected
Apr 23 15:22:20 emelia kernel: usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 10
Apr 23 15:22:20 emelia kernel: usb-uhci.c: Detected 2 ports
Apr 23 15:22:20 emelia kernel: usb.c: new USB bus registered, assigned bus =
number 2
Apr 23 15:22:20 emelia kernel: hub.c: USB hub found
Apr 23 15:22:20 emelia kernel: hub.c: 2 ports detected
Apr 23 15:22:20 emelia kernel: usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 10
Apr 23 15:22:20 emelia kernel: usb-uhci.c: Detected 2 ports
Apr 23 15:22:20 emelia kernel: usb.c: new USB bus registered, assigned bus =
number 3
Apr 23 15:22:20 emelia kernel: hub.c: USB hub found
Apr 23 15:22:20 emelia kernel: hub.c: 2 ports detected
Apr 23 15:22:20 emelia kernel: usb-uhci.c: v1.275:USB Universal Host Contro=
ller Interface driver
Apr 23 15:22:21 emelia kernel: usb.c: registered new driver hiddev
Apr 23 15:22:21 emelia kernel: usb.c: registered new driver hid
Apr 23 15:22:21 emelia kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavl=
ik <vojtech@suse.cz>
Apr 23 15:22:21 emelia kernel: hid-core.c: USB HID support drivers
Apr 23 15:22:21 emelia kernel: mice: PS/2 mouse device common for all mice
Apr 23 15:22:21 emelia kernel: hub.c: new USB device 00:11.2-1, assigned ad=
dress 2
Apr 23 15:22:21 emelia kernel: input0: USB HID v1.10 Mouse [Logitech USB-PS=
/2 Optical Mouse] on usb1:2.0
Apr 23 15:22:22 emelia kernel: eth0: no IPv6 routers present
Apr 23 15:27:22 emelia kernel: hda: dma_timer_expiry: dma status =3D=3D 0x24
Apr 23 15:27:22 emelia kernel: hda: lost interrupt
Apr 23 15:27:22 emelia kernel: hda: dma_intr: bad DMA status (dma_stat=3D30)
Apr 23 15:27:22 emelia kernel: hda: dma_intr: status=3D0x50 { DriveReady Se=
ekComplete }
Apr 23 15:27:22 emelia kernel:=20
Apr 23 15:27:47 emelia kernel: hda: dma_timer_expiry: dma status =3D=3D 0x24
Apr 23 15:27:47 emelia kernel: hda: lost interrupt
Apr 23 15:27:47 emelia kernel: hda: dma_intr: bad DMA status (dma_stat=3D30)
Apr 23 15:27:47 emelia kernel: hda: dma_intr: status=3D0x50 { DriveReady Se=
ekComplete }
Apr 23 15:27:47 emelia kernel:=20
Apr 23 15:28:08 emelia kernel: hda: dma_timer_expiry: dma status =3D=3D 0x24
Apr 23 15:28:08 emelia kernel: hda: lost interrupt
Apr 23 15:28:08 emelia kernel: hda: dma_intr: bad DMA status (dma_stat=3D30)
Apr 23 15:28:08 emelia kernel: hda: dma_intr: status=3D0x50 { DriveReady Se=
ekComplete }
Apr 23 15:28:08 emelia kernel:=20
Apr 23 15:28:42 emelia kernel: hda: dma_timer_expiry: dma status =3D=3D 0x24
Apr 23 15:28:42 emelia kernel: hda: lost interrupt
Apr 23 15:28:42 emelia kernel: hda: dma_intr: bad DMA status (dma_stat=3D30)
Apr 23 15:28:42 emelia kernel: hda: dma_intr: status=3D0x50 { DriveReady Se=
ekComplete }
Apr 23 15:28:42 emelia kernel:=20
--=20
- Athanasius =3D Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--BXr400anF0jyguTS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj6mrMQACgkQIr2uvLNOS8P35QCePFsdfuxl0a9un0Y6bQMPcwye
pokAn0W2JcxJu8jYBSsdhjqlncOwxwRx
=fS+o
-----END PGP SIGNATURE-----

--BXr400anF0jyguTS--
