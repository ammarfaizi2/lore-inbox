Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbTDLFC0 (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 01:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbTDLFC0 (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 01:02:26 -0400
Received: from [195.167.170.152] ([195.167.170.152]:1986 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id S263156AbTDLFB4 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 01:01:56 -0400
Date: Sat, 12 Apr 2003 06:13:40 +0100
From: Athanasius <link@miggy.org>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre7 & 2.4.21-pre5-ac3 IDE resets
Message-ID: <20030412051340.GI19165@miggy.org>
Mail-Followup-To: Athanasius <link@miggy.org>, andre@linux-ide.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1EKig6ypoSyM7jaD"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-gpg-fingerprint: B34E4BC3
X-gpg-key: http://www.fysh.org/~athan/gpg-key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1EKig6ypoSyM7jaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In REPORTING-BUGS format:

[1.] One line summary of the problem:   =20

  Intermittent instances of dma_timer_expiry locking up IDE channel for
seconds at a time.  Experienced with 2.4.21-pre7 and 2.4.21-pre5-ac3,
but not 2.4.21-pre4.  The system can run fine for *days*, including
intensive disk load of compiles and copying large (100s of MB) files on
2.4.21-pre4.  The rest of this problem report is specifically from a
boot of 2.4.21-pre7.

[2.] Full description of the problem/report:
Relevant kern.log output at the time of the problem:
Apr 12 05:35:08 emelia kernel: hda: dma_timer_expiry: dma status =3D=3D 0x24
Apr 12 05:35:08 emelia kernel: hda: lost interrupt
Apr 12 05:35:08 emelia kernel: hda: dma_intr: bad DMA status (dma_stat=3D30)
Apr 12 05:35:08 emelia kernel: hda: dma_intr: status=3D0x50 { DriveReady Se=
ekComplete }
Apr 12 05:35:43 emelia kernel: hda: dma_timer_expiry: dma status =3D=3D 0x24
Apr 12 05:35:43 emelia kernel: hda: lost interrupt
Apr 12 05:35:43 emelia kernel: hda: dma_intr: bad DMA status (dma_stat=3D30)
Apr 12 05:35:43 emelia kernel: hda: dma_intr: status=3D0x50 { DriveReady Se=
ekComplete }
Apr 12 05:36:17 emelia kernel: hda: dma_timer_expiry: dma status =3D=3D 0x24
Apr 12 05:36:17 emelia kernel: hda: lost interrupt
Apr 12 05:36:17 emelia kernel: hda: dma_intr: bad DMA status (dma_stat=3D30)
Apr 12 05:36:17 emelia kernel: hda: dma_intr: status=3D0x50 { DriveReady Se=
ekComplete }

[3.] Keywords (i.e., modules, networking, kernel):
IDE, DMA, reset

[4.] Kernel version (from /proc/version):
Linux version 2.4.21-pre7 (athan@emelia) (gcc version 2.95.4 20011002 (Debi=
an prerelease)) #2 Fri Apr 11 02:23:44 BST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information=20
     resolved (see Documentation/oops-tracing.txt)
No Oops

[6.] A small shell script or example program which triggers the
     problem (if possible)
  I can't find a way to reliably reproduce this.  I've tried cat'ing big
files to /dev/null, running hdparm -t -T /dev/hda in a loop and several
other disk intensive processes.  The problem does invariably occur within
less than 15 minutes of boot up though.  Normally I'd be running X, but I
took that out for test purposes to avoid ever loading the nvidia module.
  anacron does cause some things like updatedb to be run shortly after
boot-time, which is what specifically seemed to trigger the instances
in the logs above.

[7.] Environment
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
 PIO modes: pio0 pio1 pio2 pio3 pio4=20
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5=20
 AdvancedPM=3Dno WriteCache=3Denabled
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3 ATA-=
4 ATA-5=20

That's as it is configured post-boot, no hdparm command run to change anyth=
ing.
I do have to force the CHS to 14370,255,32 so that the BIOS, Windows 98 and=
 Linux are all happy.

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux emelia 2.4.21-pre7 #2 Fri Apr 11 02:23:44 BST 2003 i686 unknown
=20
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.11
Modules Loaded         mousedev hid usb-uhci snd-seq-midi snd-seq-oss snd-s=
eq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-ens1371 snd-pcm snd-tim=
er snd-rawmidi snd-seq-device snd-ac97-codec snd soundcore 8139too mii

[7.2.] Processor information (from /proc/cpuinfo):
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

[7.3.] Module information (from /proc/modules):
  NB: This *is* purely the only modules loaded since boot-time.  I normally
have a few others loaded but commented them out for testing, specifically:
nvidia (the closed-source module), i2c-isa and it87 for lm_sensors,
ide-cd (for hdc) and ide-scsi (for hdd).

mousedev                3904   0 (unused)
hid                    19520   0 (unused)
usb-uhci               21668   0 (unused)
snd-seq-midi            3264   0 (autoclean) (unused)
snd-seq-oss            23168   0 (unused)
snd-seq-midi-event      3112   0 [snd-seq-midi snd-seq-oss]
snd-seq                37580   2 [snd-seq-midi snd-seq-oss snd-seq-midi-eve=
nt]
snd-pcm-oss            36100   0 (unused)
snd-mixer-oss           9120   0 [snd-pcm-oss]
snd-ens1371             9796   0
snd-pcm                46400   0 [snd-pcm-oss snd-ens1371]
snd-timer              10528   0 [snd-seq snd-pcm]
snd-rawmidi            12256   0 [snd-seq-midi snd-ens1371]
snd-seq-device          3952   0 [snd-seq-midi snd-seq-oss snd-seq snd-rawm=
idi]
snd-ac97-codec         23204   0 [snd-ens1371]
snd                    23912   0 [snd-seq-midi snd-seq-oss snd-seq-midi-eve=
nt snd-seq snd-pcm-oss snd-mixer-oss snd-ens1371 snd-pcm snd-timer snd-rawm=
idi snd-seq-device snd-ac97-codec]
soundcore               3588   8 [snd]
8139too                15360   1
mii                     2464   0 [8139too]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports
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
  ec00-ec3f : Ensoniq AudioPCI
fc00-fc0f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  fc00-fc07 : ide0
  fc08-fc0f : ide1

/proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-00263f44 : Kernel code
  00263f45-002f7d3f : Kernel data
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

[7.5.] PCI information ('lspci -vvv' as root)
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

[7.6.] SCSI information (from /proc/scsi/scsi)
  No /proc/scsi on the system as tested.  Normally I'd be loading ide-cd
and ide-scsi modules to make the CD-ROM all IDE, and the CD-RW ide-scsi
to burn CDs.

[7.7.] Other information that might be relevant to the problem

  Boot-time dmesg output is:

Linux version 2.4.21-pre7 (athan@emelia) (gcc version 2.95.4 20011002 (Debi=
an prerelease)) #2 Fri Apr 11 02:23:44 BST 2003
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
Kernel command line: BOOT_IMAGE=3D2421p7 ro root=3D305 mem=3Dnopentium hda=
=3D14370,255,32 hdd=3Dide-scsi
ide_setup: hda=3D14370,255,32
ide_setup: hdd=3Dide-scsi
Initializing CPU#0
Detected 1406.013 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2804.94 BogoMIPS
Memory: 515256k/524224k available (1423k kernel code, 8580k reserved, 591k =
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
=2E.... CPU clock speed is 1406.0730 MHz.
=2E.... host bus clock speed is 267.8233 MHz.
cpu: 0, clocks: 2678233, slice: 1339116
CPU0<T0:2678224,T1:1339104,D:4,S:1339116,C:2678233>
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
blk: queue c0344a60, I/O limit 4095Mb (mask 0xffffffff)
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

  Kernel config:
#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=3Dy
# CONFIG_SBUS is not set
CONFIG_UID16=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=3Dy
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_X86_HAS_TSC=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_USE_3DNOW=3Dy
CONFIG_X86_PGE=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_F00F_WORKS_OK=3Dy
CONFIG_X86_MCE=3Dy
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=3Dy
CONFIG_X86_CPUID=3Dy
CONFIG_NOHIGHMEM=3Dy
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=3Dy
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=3Dy

#
# General setup
#
CONFIG_NET=3Dy
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_ISA=3Dy
CONFIG_PCI_NAMES=3Dy
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=3Dy

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_SYSVIPC=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=3Dy
CONFIG_KCORE_ELF=3Dy
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dm
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_PC_CML1=3Dm
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=3Dy
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play configuration
#
CONFIG_PNP=3Dy
CONFIG_ISAPNP=3Dy

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dy
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_NBD=3Dm
CONFIG_BLK_DEV_RAM=3Dm
CONFIG_BLK_DEV_RAM_SIZE=3D4096
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_BLK_STATS=3Dy

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
CONFIG_NETLINK_DEV=3Dy
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dy
CONFIG_NET_IPGRE=3Dy
# CONFIG_ARPD is not set
CONFIG_INET_ECN=3Dy
CONFIG_SYN_COOKIES=3Dy

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dy
CONFIG_IP_NF_FTP=3Dm
CONFIG_IP_NF_IRC=3Dm
CONFIG_IP_NF_QUEUE=3Dy
CONFIG_IP_NF_IPTABLES=3Dy
CONFIG_IP_NF_MATCH_LIMIT=3Dy
CONFIG_IP_NF_MATCH_MAC=3Dy
CONFIG_IP_NF_MATCH_PKTTYPE=3Dy
CONFIG_IP_NF_MATCH_MARK=3Dy
CONFIG_IP_NF_MATCH_MULTIPORT=3Dy
CONFIG_IP_NF_MATCH_TOS=3Dy
CONFIG_IP_NF_MATCH_ECN=3Dy
CONFIG_IP_NF_MATCH_DSCP=3Dy
CONFIG_IP_NF_MATCH_AH_ESP=3Dy
CONFIG_IP_NF_MATCH_LENGTH=3Dy
CONFIG_IP_NF_MATCH_TTL=3Dy
CONFIG_IP_NF_MATCH_TCPMSS=3Dy
CONFIG_IP_NF_MATCH_HELPER=3Dy
CONFIG_IP_NF_MATCH_STATE=3Dy
CONFIG_IP_NF_MATCH_CONNTRACK=3Dy
CONFIG_IP_NF_MATCH_UNCLEAN=3Dy
CONFIG_IP_NF_MATCH_OWNER=3Dy
CONFIG_IP_NF_FILTER=3Dy
CONFIG_IP_NF_TARGET_REJECT=3Dy
CONFIG_IP_NF_TARGET_MIRROR=3Dy
CONFIG_IP_NF_NAT=3Dy
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dy
CONFIG_IP_NF_TARGET_REDIRECT=3Dy
CONFIG_IP_NF_NAT_LOCAL=3Dy
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dy
CONFIG_IP_NF_NAT_IRC=3Dm
CONFIG_IP_NF_NAT_FTP=3Dm
CONFIG_IP_NF_MANGLE=3Dy
CONFIG_IP_NF_TARGET_TOS=3Dy
CONFIG_IP_NF_TARGET_ECN=3Dy
CONFIG_IP_NF_TARGET_DSCP=3Dy
CONFIG_IP_NF_TARGET_MARK=3Dy
CONFIG_IP_NF_TARGET_LOG=3Dy
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dy
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IPV6=3Dy

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=3Dm
CONFIG_IP6_NF_IPTABLES=3Dy
CONFIG_IP6_NF_MATCH_LIMIT=3Dy
CONFIG_IP6_NF_MATCH_MAC=3Dy
CONFIG_IP6_NF_MATCH_RT=3Dm
CONFIG_IP6_NF_MATCH_OPTS=3Dm
CONFIG_IP6_NF_MATCH_FRAG=3Dm
CONFIG_IP6_NF_MATCH_HL=3Dm
CONFIG_IP6_NF_MATCH_MULTIPORT=3Dy
CONFIG_IP6_NF_MATCH_OWNER=3Dy
CONFIG_IP6_NF_MATCH_MARK=3Dy
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
CONFIG_IP6_NF_MATCH_AHESP=3Dm
CONFIG_IP6_NF_MATCH_LENGTH=3Dy
CONFIG_IP6_NF_MATCH_EUI64=3Dy
CONFIG_IP6_NF_FILTER=3Dy
CONFIG_IP6_NF_TARGET_LOG=3Dy
CONFIG_IP6_NF_MANGLE=3Dy
CONFIG_IP6_NF_TARGET_MARK=3Dy
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=3Dm

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=3Dy

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=3Dy
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=3Dm
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=3Dm
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
CONFIG_IDEDMA_ONLYDISK=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=3Dy
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=3Dy
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
CONFIG_SCSI=3Dm
CONFIG_BLK_DEV_SD=3Dm
CONFIG_SD_EXTRA_DEVS=3D40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dm
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=3D2
CONFIG_CHR_DEV_SG=3Dm
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SCSI_LOGGING=3Dy

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=3Dy
CONFIG_I2O_PCI=3Dy
CONFIG_I2O_BLOCK=3Dm
CONFIG_I2O_LAN=3Dm
# CONFIG_I2O_SCSI is not set
CONFIG_I2O_PROC=3Dm

#
# Network device support
#
CONFIG_NETDEVICES=3Dy

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=3Dm
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=3Dm
CONFIG_ETHERTAP=3Dm
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=3Dy
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=3Dm
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
CONFIG_8139CP=3Dm
CONFIG_8139TOO=3Dm
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_SUNDANCE_MMIO is not set
# CONFIG_TLAN is not set
# CONFIG_TC35815 is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=3Dm
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPPOE=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=3Dy
# CONFIG_INPUT_KEYBDEV is not set
CONFIG_INPUT_MOUSEDEV=3Dm
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D1024
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=3Dm

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_SERIAL=3Dy
CONFIG_SERIAL_CONSOLE=3Dy
CONFIG_SERIAL_EXTENDED=3Dy
# CONFIG_SERIAL_MANY_PORTS is not set
CONFIG_SERIAL_SHARE_IRQ=3Dy
# CONFIG_SERIAL_DETECT_IRQ is not set
# CONFIG_SERIAL_MULTIPORT is not set
# CONFIG_HUB6 is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_PRINTER=3Dm
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=3Dm
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_PHILIPSPAR=3Dm
CONFIG_I2C_ELV=3Dm
CONFIG_I2C_VELLEMAN=3Dm
# CONFIG_SCx200_I2C is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_ALGOPCF=3Dm
CONFIG_I2C_ELEKTOR=3Dm
CONFIG_I2C_CHARDEV=3Dm
CONFIG_I2C_PROC=3Dm

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=3Dy
CONFIG_PSMOUSE=3Dy
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
CONFIG_INPUT_GAMEPORT=3Dy
CONFIG_INPUT_NS558=3Dm
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set
CONFIG_INPUT_ANALOG=3Dm
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
CONFIG_SOFT_WATCHDOG=3Dy
# CONFIG_W83877F_WDT is not set
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_AMD7XX_TCO is not set
# CONFIG_SCx200_GPIO is not set
CONFIG_AMD_RNG=3Dm
# CONFIG_INTEL_RNG is not set
# CONFIG_AMD_PM768 is not set
CONFIG_NVRAM=3Dy
CONFIG_RTC=3Dy
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dy
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=3Dy
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=3Dy
# CONFIG_DRM_OLD is not set
CONFIG_DRM_NEW=3Dy
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I810_XFREE_41 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=3Dy
CONFIG_AUTOFS_FS=3Dm
CONFIG_AUTOFS4_FS=3Dm
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=3Dy
CONFIG_JBD=3Dy
CONFIG_JBD_DEBUG=3Dy
CONFIG_FAT_FS=3Dy
CONFIG_MSDOS_FS=3Dm
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=3Dy
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_TMPFS is not set
CONFIG_RAMFS=3Dy
CONFIG_ISO9660_FS=3Dy
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_MINIX_FS=3Dm
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=3Dy
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=3Dy
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=3Dy
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_TCP=3Dy
CONFIG_SUNRPC=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_SMB_FS=3Dm
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"cp437"
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=3Dy

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_SMB_NLS=3Dy
CONFIG_NLS=3Dy

#
# Native Language Support
#
CONFIG_NLS_DEFAULT=3D"cp437"
CONFIG_NLS_CODEPAGE_437=3Dy
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=3Dy
CONFIG_NLS_CODEPAGE_852=3Dy
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=3Dy
CONFIG_NLS_ISO8859_2=3Dy
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=3Dy
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_VESA=3Dy
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FBCON_ADVANCED=3Dy
CONFIG_FBCON_MFB=3Dm
CONFIG_FBCON_CFB2=3Dm
CONFIG_FBCON_CFB4=3Dm
CONFIG_FBCON_CFB8=3Dy
CONFIG_FBCON_CFB16=3Dy
CONFIG_FBCON_CFB24=3Dy
CONFIG_FBCON_CFB32=3Dy
# CONFIG_FBCON_AFB is not set
# CONFIG_FBCON_ILBM is not set
# CONFIG_FBCON_IPLAN2P2 is not set
# CONFIG_FBCON_IPLAN2P4 is not set
# CONFIG_FBCON_IPLAN2P8 is not set
# CONFIG_FBCON_MAC is not set
CONFIG_FBCON_VGA_PLANES=3Dy
CONFIG_FBCON_VGA=3Dy
# CONFIG_FBCON_HGA is not set
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
CONFIG_FBCON_FONTS=3Dy
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set

#
# Sound
#
CONFIG_SOUND=3Dm
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=3Dy
# CONFIG_USB_DEBUG is not set
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_UHCI=3Dm
CONFIG_USB_UHCI_ALT=3Dm
CONFIG_USB_OHCI=3Dm
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_HID=3Dm
CONFIG_USB_HIDINPUT=3Dy
CONFIG_USB_HIDDEV=3Dy
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=3Dy
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=3Dy
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_FRAME_POINTER is not set

#
# Library routines
#
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dm
--=20
- Athanasius =3D Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--1EKig6ypoSyM7jaD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj6XoIQACgkQIr2uvLNOS8M1pwCdHx5YxSFDrQs8Gt3skfRYkJ3I
rdsAn2vqLsAD/2zYEXcaJFYuA9h6kvyW
=7rx3
-----END PGP SIGNATURE-----

--1EKig6ypoSyM7jaD--
