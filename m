Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbUBZUQj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbUBZUPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:15:00 -0500
Received: from main.gmane.org ([80.91.224.249]:59782 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262982AbUBZUMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:12:43 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?Leandro_Guimar=E3es_Faria_Corsetti_Dutra?= 
	<leandro@dutra.fastmail.fm>
Subject: PROBLEM: ext3 on raid5 failure
Date: Thu, 26 Feb 2004 17:17:50 -0300
Organization: =?ISO-8859-1?Q?=20Fam=C3=ADlia?= Dutra
Message-ID: <pan.2004.02.26.20.17.45.846858@dutra.fastmail.fm>
References: <1077731104.2213.61.camel@dis.bellua.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200.175.3.23.tbprof.gvt.net.br
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004 00:45:05 +0700, Muhammad L. wrote:

> Sorry to interrupt but the problem isn't fixed at all.

	OK, here goes another PROBLEM report.

	Even if there exist lists for ext3fs, LVM and RAID, I guess I
must post this here because I couldn't pinpoint what in the fs stack
generates the error.


[1.] One line summary of the problem:

	After I/O, journal is aborted and filesystems made read-only.


[2.] Full description of the problem/report:

	One can't anymore write to the affected file systems.  Upon
investigation, ext3fs journal was aborted and affected filesystems are
remounted read-only.  Reboot prompts for fsck to be run manually,
with fixes taking several prompts and minutes.


[3.] Keywords (i.e., modules, networking, kernel):

	File systems, I/O, RAID, LVM, kernel.


[4.] Kernel version (from /proc/version):

	Couldn't find /proc/version, uname -a gives: 
Linux mercurio 2.6.2-1-686-smp #1 SMP Sat Feb 7 15:27:45 EST 2004 i686
GNU/Linux


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

	N/A


[6.] A small shell script or example program which triggers the
     problem (if possible)

	N/A


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)



[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping	: 9
cpu MHz		: 2394.494
cache size	: 512 KB
physical id	: 0
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 4718.59

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping	: 9
cpu MHz		: 2394.494
cache size	: 512 KB
physical id	: 0
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips	: 4784.12


[7.3.] Module information (from /proc/modules):

ipv6 273856 25 - Live 0xf8d4e000
i810_audio 35476 0 - Live 0xf8cc9000
ac97_codec 19340 1 i810_audio, Live 0xf8cc3000
ide_scsi 15716 0 - Live 0xf8bf1000
parport_pc 37228 1 - Live 0xf8cf4000
lp 11844 0 - Live 0xf8ca9000
parport 45608 2 parport_pc,lp, Live 0xf8ce7000
ext2 75528 3 - Live 0xf8cd3000
dm_mod 42304 8 - Live 0xf8c66000
raid5 23392 1 - Live 0xf8c06000
xor 15848 1 raid5, Live 0xf8b40000
md 48680 2 raid5, Live 0xf8caf000
i810fb 33088 0 - Live 0xf8bfc000
vgastate 10272 1 i810fb, Live 0xf8b91000
e100 65448 0 - Live 0xf8c55000
ntfs 92044 0 - Live 0xf8c3d000
cifs 178380 0 - Live 0xf8c72000
autofs4 17344 0 - Live 0xf8bdc000
smbfs 70424 0 - Live 0xf8c2a000
udf 105188 0 - Live 0xf8c0f000
vfat 16512 0 - Live 0xf8bd6000
msdos 11424 0 - Live 0xf8b8d000
fat 48064 2 vfat,msdos, Live 0xf8be4000
aes 32704 0 - Live 0xf8ba2000
md5 4096 1 - Live 0xf8932000
quota_v2 9536 0 - Live 0xf8b80000
binfmt_misc 11400 0 - Live 0xf8b7c000
microcode 8160 0 - Live 0xf8b4d000
snd_intel8x0 33220 0 - Live 0xf8b98000
snd_ac97_codec 55556 1 snd_intel8x0, Live 0xf8bc7000
snd_pcm 104640 1 snd_intel8x0, Live 0xf8bac000
snd_timer 26788 1 snd_pcm, Live 0xf8b85000
snd_page_alloc 12100 2 snd_intel8x0,snd_pcm, Live 0xf8b16000
snd_mpu401_uart 8352 1 snd_intel8x0, Live 0xf8b3c000
snd_rawmidi 25536 1 snd_mpu401_uart, Live 0xf8b45000
snd_seq_device 8296 1 snd_rawmidi, Live 0xf8b38000
snd 55012 7 snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xf8b6d000
soundcore 10752 2 i810_audio,snd, Live 0xf8b0e000
firmware_class 9440 0 - Live 0xf8b12000
cpufreq_powersave 1824 0 - Live 0xf8959000
usbkbd 7552 0 - Live 0xf89ed000
usbmouse 5792 0 - Live 0xf8b0b000
hid 33792 0 - Live 0xf8b2e000
usbcore 114652 4 usbkbd,usbmouse,hid, Live 0xf8b50000
i2c_i810 4740 0 - Live 0xf8b02000
i2c_algo_bit 10024 1 i2c_i810, Live 0xf8b07000
i2c_core 23844 1 i2c_algo_bit, Live 0xf8af4000
i830 75756 2 - Live 0xf8b1a000
raw 8192 0 - Live 0xf89d9000
pcspkr 3724 0 - Live 0xf8952000
psmouse 20264 0 - Live 0xf8afc000
pcips2 4352 0 - Live 0xf89d6000
analog 11776 0 - Live 0xf8af0000
gameport 5120 1 analog, Live 0xf89cd000
intel_agp 18684 1 - Live 0xf89d0000
nls_cp850 4960 0 - Live 0xf89a6000
nls_cp437 5792 0 - Live 0xf89a3000
nls_iso8859_1 4128 0 - Live 0xf89a0000
nls_iso8859_15 4704 0 - Live 0xf899d000
nls_utf8 2144 0 - Live 0xf8950000
nfs 169244 2 - Live 0xf8a14000
nfsd 181600 0 - Live 0xf8a41000
exportfs 7328 1 nfsd, Live 0xf8927000
lockd 64168 3 nfs,nfsd, Live 0xf89dc000
sunrpc 140328 9 nfs,nfsd,lockd, Live 0xf89f0000
coda 42660 0 - Live 0xf89bc000
mousedev 10264 1 - Live 0xf8955000
nbd 21256 0 - Live 0xf8996000
loop 18504 0 - Live 0xf8965000
floppy 62516 0 - Live 0xf89ab000
agpgart 33132 3 intel_agp, Live 0xf895b000
fan 4140 0 - Live 0xf892a000
thermal 13360 0 - Live 0xf894b000
processor 14608 1 thermal, Live 0xf892d000
ide_detect 1312 0 - Live 0xf8825000
ide_cd 42404 0 - Live 0xf893f000
ide_core 163600 3 ide_scsi,ide_detect,ide_cd, Live 0xf896d000
cdrom 39168 1 ide_cd, Live 0xf8934000
rtc 14120 0 - Live 0xf882b000
ext3 123880 7 - Live 0xf8844000
jbd 70424 1 ext3, Live 0xf8899000
mbcache 10212 2 ext2,ext3, Live 0xf8830000
sd_mod 17024 10 - Live 0xf883e000
BusLogic 82620 7 - Live 0xf8883000
scsi_mod 120208 3 ide_scsi,sd_mod,BusLogic, Live 0xf8864000
unix 31216 543 - Live 0xf8835000
font 8544 0 - Live 0xf8827000
cfbcopyarea 4192 1 i810fb, Live 0xf8820000
cfbimgblt 3360 1 i810fb, Live 0xf881e000
cfbfillrect 4096 1 i810fb, Live 0xf881c000


[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
04d0-04d1 : pnp 00:0d
0cf8-0cff : PCI conf1
b800-b8ff : 0000:01:00.0
  b800-b8ff : BusLogic BT-950
bc00-bc3f : 0000:01:08.0
  bc00-bc3f : e100
c400-c41f : 0000:00:1f.3
c800-c81f : 0000:00:1d.0
cc00-cc1f : 0000:00:1d.1
d000-d01f : 0000:00:1d.2
d400-d41f : 0000:00:1d.3
d800-d80f : 0000:00:1f.2
dc00-dc03 : 0000:00:1f.2
e000-e007 : 0000:00:1f.2
e400-e403 : 0000:00:1f.2
e800-e807 : 0000:00:1f.2
ec00-ec07 : 0000:00:02.0
ffa0-ffaf : 0000:00:1f.1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000ca800-000cf7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ef2fbff : System RAM
  00100000-0028fdc1 : Kernel code
  0028fdc2-0032e31f : Kernel data
3ef2fc00-3ef2ffff : ACPI Non-volatile Storage
3ef30000-3ef3ffff : ACPI Tables
3ef40000-3efeffff : ACPI Non-volatile Storage
3eff0000-3effffff : reserved
3f000000-3f0003ff : 0000:00:1f.1
f0000000-f7ffffff : 0000:00:02.0
f8000000-fbffffff : 0000:00:00.0
fe00f000-fe00ffff : 0000:01:00.0
fecf0000-fecf0fff : reserved
fed20000-fed9ffff : reserved
ff8fe000-ff8fefff : 0000:01:08.0
  ff8fe000-ff8fefff : e100
ffa7f400-ffa7f4ff : 0000:00:1f.5
  ffa7f400-ffa7f4ff : Intel ICH5 - Controller
ffa7f800-ffa7f9ff : 0000:00:1f.5
  ffa7f800-ffa7f9ff : Intel ICH5 - AC'97
ffa7fc00-ffa7ffff : 0000:00:1d.7
ffa80000-ffafffff : 0000:00:02.0


[7.5.] PCI information ('lspci -vvv' as root)

/sys $ lspci -vvv
00:00.0 Host bridge: Intel Corp. 82865G/PE/P Processor to I/O Controller (rev 02)
	Subsystem: Intel Corp. 82865G/PE/P Processor to I/O Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:02.0 VGA compatible controller: Intel Corp. 82865G Integrated Graphics Device (rev 02) (prog-if 00 [VGA])
	Subsystem: Intel Corp.: Unknown device 4c43
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at ffa80000 (32-bit, non-prefetchable) [size=512K]
	Region 2: I/O ports at ec00 [size=8]
	Capabilities: <available only to root>

00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4c43
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at c800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4c43
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at cc00 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4c43
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at d000 [size=32]

00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4c43
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at d400 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Intel Corp.: Unknown device 4c43
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 23
	Region 0: Memory at ffa7fc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: ff800000-ff8fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corp.: Unknown device 4c43
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]
	Region 5: Memory at 3f000000 (32-bit, non-prefetchable) [disabled] [size=1K]

00:1f.2 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Intel Corp.: Unknown device 4c43
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at e800 [size=8]
	Region 1: I/O ports at e400 [size=4]
	Region 2: I/O ports at e000 [size=8]
	Region 3: I/O ports at dc00 [size=4]
	Region 4: I/O ports at d800 [size=16]

00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
	Subsystem: Intel Corp.: Unknown device 4c43
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at c400 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio Controller (rev 02)
	Subsystem: Intel Corp.: Unknown device e002
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 2: Memory at ffa7f800 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at ffa7f400 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

01:00.0 SCSI storage controller: BusLogic Flashpoint LT (rev 02)
	Subsystem: BusLogic Flashpoint LT
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 2000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 21
	Region 0: I/O ports at b800 [size=256]
	Region 1: Memory at fe00f000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fe000000 [disabled] [size=64K]

01:08.0 Ethernet controller: Intel Corp.: Unknown device 1050 (rev 01)
	Subsystem: Intel Corp.: Unknown device 303a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at ff8fe000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at bc00 [size=64]
	Capabilities: <available only to root>

/sys $ 


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST336607LW       Rev: 0006
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST336607LW       Rev: 0006
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: SEAGATE  Model: ST336607LW       Rev: 0006
  Type:   Direct-Access                    ANSI SCSI revision: 03


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

/var/log/kern.log:

Feb 26 06:25:24 mercurio kernel: EXT3-fs error (device dm-2): ext3_readdir: bad entry in directory #381585: directory entry across blocks - offset=0, inode=0, rec_len=4132, name_len=63
Feb 26 06:25:24 mercurio kernel: Aborting journal on device dm-2.
Feb 26 06:25:24 mercurio kernel: ext3_abort called.
Feb 26 06:25:24 mercurio kernel: EXT3-fs abort (device dm-2): ext3_journal_start: Detected aborted journal
Feb 26 06:25:24 mercurio kernel: Remounting filesystem read-only
[...]
Feb 26 15:57:21 mercurio kernel: EXT3-fs error (device dm-2) in start_transaction: Journal has aborted
Feb 26 15:57:21 mercurio kernel: EXT3-fs error (device dm-2) in ext3_delete_inode: Journal has aborted



[X.] Other notes, patches, fixes, workarounds:

	No known patch or fix, not enough knowledge or skill, sorry...

	Have seen various reports by Googling around, from 2.5
something up to 2.6.3.


-- 
Leandro Guimarães Faria Corsetti Dutra           +55 (11) 5685 2219
Av Sgto Geraldo Santana, 1100 6/71               +55 (11) 5686 9607
04.674-000  São Paulo, SP                                    BRASIL
http://br.geocities.com./lgcdutra/

