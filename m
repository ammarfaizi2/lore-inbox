Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVBRIsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVBRIsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 03:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVBRIsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 03:48:52 -0500
Received: from kermit.goldweb.com.au ([202.55.152.3]:12762 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261305AbVBRIsT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 03:48:19 -0500
Subject: BUG: stallion module cannot register it's ISR in a 2.6.10 kernel
	on a FC3 system
From: Burn Alting <burn@goldweb.com.au>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 18 Feb 2005 19:48:12 +1100
Message-Id: <1108716493.6213.8.camel@swtf.comptex.com.au>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the bug report. Stallion was purchased by Lantronix and they
don't really care about this bug.

[1.] One line summary of the problem:    
	Stallion 4 port IO card fails when modprobe'd into kernel

[2.] Full description of the problem/report:
	Under Fedora Core 3 using a ftp.kernel.org 2.6.10 kernel, when
	the stallion driver module is loaded into the kernel error
	messages appear in /var/log/messages. Then, if a port is accessed
	further messages appear and IRQ 11 is disabled/turned off.

[3.] Keywords (i.e., modules, networking, kernel):
	stallion, serial, kernel

[4.] Kernel version (from /proc/version):
Linux version 2.6.10 (root@swtf.comptex.com.au) (gcc version 3.4.2
20041017 (Red Hat 3.4.2-6.fc3)) #1 Fri Feb 18 17:44:05 EST 2005

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
     problem (if possible)

	modprobe stallion

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux swtf.comptex.com.au 2.6.10 #1 Fri Feb 18 17:44:05 EST 2005 i686
i686 i386 GNU/Linux
 
Gnu C                  3.4.2
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12a
mount                  2.12a
module-init-tools      3.1-pre5
e2fsprogs              1.35
jfsutils               1.1.7
reiserfsprogs          3.6.18
reiser4progs           line
xfsprogs               2.6.13
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         nfsd exportfs lockd parport_pc lp parport autofs4
sunrpc dm_mod video button battery ac pl2303 ftdi_sio usbserial md5 ipv6
uhci_hcd ehci_hcd i2c_i801 i2c_core snd_usb_audio snd_usb_lib
snd_rawmidi snd_seq_device snd_intel8x0 snd_ac97_codec snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc e1000
floppy ext3 jbd aic7xxx sd_mod scsi_mod


[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.53GHz
stepping	: 4
cpu MHz		: 2546.579
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 5046.27

[7.3.] Module information (from /proc/modules):

nfsd 210976 9 - Live 0xf8ccb000
exportfs 9344 1 nfsd, Live 0xf8c8a000
lockd 68264 2 nfsd, Live 0xf8c5a000
parport_pc 29636 1 - Live 0xf8c51000
lp 13292 0 - Live 0xf8c6d000
parport 41928 2 parport_pc,lp, Live 0xf8cbf000
autofs4 28292 0 - Live 0xf8a06000
sunrpc 182372 19 nfsd,lockd, Live 0xf8c23000
dm_mod 64276 0 - Live 0xf89ec000
video 16132 0 - Live 0xf89e7000
button 6928 0 - Live 0xf8a00000
battery 9604 0 - Live 0xf89c9000
ac 5124 0 - Live 0xf883d000
pl2303 24964 0 - Live 0xf89c1000
ftdi_sio 33796 0 - Live 0xf89b7000
usbserial 30312 2 pl2303,ftdi_sio, Live 0xf8985000
md5 4608 1 - Live 0xf893d000
ipv6 273088 22 - Live 0xf8d85000
uhci_hcd 36112 0 - Live 0xf89ad000
ehci_hcd 41732 0 - Live 0xf89a1000
i2c_i801 8844 0 - Live 0xf897a000
i2c_core 23040 1 i2c_i801, Live 0xf8973000
snd_usb_audio 67904 2 - Live 0xf8961000
snd_usb_lib 13824 1 snd_usb_audio, Live 0xf8980000
snd_rawmidi 29984 1 snd_usb_lib, Live 0xf8998000
snd_seq_device 9484 1 snd_rawmidi, Live 0xf8939000
snd_intel8x0 36768 2 - Live 0xf898e000
snd_ac97_codec 76000 1 snd_intel8x0, Live 0xf89cd000
snd_pcm_oss 55588 0 - Live 0xf892a000
snd_mixer_oss 19968 3 snd_pcm_oss, Live 0xf8884000
snd_pcm 110856 4 snd_usb_audio,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,
Live 0xf8a10000
snd_timer 34692 1 snd_pcm, Live 0xf8920000
snd 60260 13
snd_usb_audio,snd_rawmidi,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer, Live 0xf88ed000
soundcore 11360 3 snd, Live 0xf8880000
snd_page_alloc 10372 2 snd_intel8x0,snd_pcm, Live 0xf8864000
e1000 88756 0 - Live 0xf88d6000
floppy 66736 0 - Live 0xf886e000
ext3 134280 3 - Live 0xf88fe000
jbd 86808 1 ext3, Live 0xf888a000
aic7xxx 184024 0 - Live 0xf88a8000
sd_mod 18944 0 - Live 0xf8868000
scsi_mod 136320 2 aic7xxx,sd_mod, Live 0xf881a000

[7.4.] Loaded driver and hardware information
(/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-407f : 0000:00:1f.0
  4000-4003 : PM1a_EVT_BLK
  4004-4005 : PM1a_CNT_BLK
  4008-400b : PM_TMR
  4028-402f : GPE0_BLK
4080-40bf : 0000:00:1f.0
5000-501f : 0000:00:1f.3
  5000-500f : i801-smbus
a000-a0ff : 0000:02:01.0
a400-a47f : 0000:02:02.0
a800-a87f : 0000:02:02.0
ac00-ac3f : 0000:02:09.0
  ac00-ac3f : e1000
b000-b007 : 0000:02:0c.0
b400-b403 : 0000:02:0c.0
b800-b807 : 0000:02:0c.0
  b800-b807 : ide3
bc00-bc03 : 0000:02:0c.0
  bc02-bc02 : ide3
c000-c00f : 0000:02:0c.0
  c000-c007 : ide2
  c008-c00f : ide3
d000-d01f : 0000:00:1d.1
  d000-d01f : uhci_hcd
d400-d41f : 0000:00:1d.2
  d400-d41f : uhci_hcd
d800-d81f : 0000:00:1d.0
  d800-d81f : uhci_hcd
e000-e0ff : 0000:00:1f.5
  e000-e0ff : Intel 82801DB-ICH4
e400-e43f : 0000:00:1f.5
  e400-e43f : Intel 82801DB-ICH4
f000-f00f : 0000:00:1f.1
  f000-f007 : ide0
  f008-f00f : ide1


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cf3ff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-0037ea7c : Kernel code
  0037ea7d-004213ff : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
40000000-400003ff : 0000:00:1f.1
d0000000-d7ffffff : 0000:00:00.0
d8000000-e7ffffff : PCI Bus #01
  d8000000-dfffffff : 0000:01:00.0
  e0000000-e007ffff : 0000:01:00.0
e8000000-e9ffffff : PCI Bus #01
  e8000000-e8ffffff : 0000:01:00.0
eb000000-eb01ffff : 0000:02:09.0
  eb000000-eb01ffff : e1000
eb020000-eb023fff : 0000:02:0c.0
eb024000-eb024fff : 0000:02:01.0
  eb024000-eb024fff : aic7xxx
ec000000-ec0003ff : 0000:00:1d.7
  ec000000-ec0003ff : ehci_hcd
ec001000-ec0011ff : 0000:00:1f.5
  ec001000-ec0011ff : Intel 82801DB-ICH4
ec002000-ec0020ff : 0000:00:1f.5
  ec002000-ec0020ff : Intel 82801DB-ICH4
fec00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE DRAM
Controller/Host-Hub Interface (rev 02)
	Subsystem: Giga-byte Technology GA-8PE667 Ultra
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [e4] Vendor Specific Information
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 82845G/GL[Brookdale-G]/GE/PE Host-to-AGP
Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: d8000000-e7ffffff
	Secondary status: 66Mhz+ FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Giga-byte Technology: Unknown device 24c2
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 4: I/O ports at d800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Giga-byte Technology: Unknown device 24c2
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at d000 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Giga-byte Technology: Unknown device 24c2
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at d400 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI
Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: Giga-byte Technology: Unknown device 5004
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot
+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 82) (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000cfff
	Memory behind bridge: ea000000-ebffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	Secondary status: 66Mhz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC Interface
Bridge (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DB (ICH4) IDE Controller (rev
02) (prog-if 8a [Master SecP PriP])
	Subsystem: Giga-byte Technology GA-8PE667 Ultra
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at f000 [size=16]
	Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus
Controller (rev 02)
	Subsystem: Giga-byte Technology GA-8PE667 Ultra
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at 5000 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 02)
	Subsystem: Giga-byte Technology GA-8PE667 Ultra
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 9
	Region 0: I/O ports at e000 [size=256]
	Region 1: I/O ports at e400 [size=64]
	Region 2: Memory at ec001000 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at ec002000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot
+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti
4400] (rev a3) (prog-if 00 [VGA])
	Subsystem: LeadTek Research Inc.: Unknown device 2893
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 2: Memory at e0000000 (32-bit, prefetchable) [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME
(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit-
FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

02:01.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
	Subsystem: Adaptec AHA-2940U2W SCSI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (9750ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 11
	BIST result: 00
	Region 0: I/O ports at a000 [disabled] [size=256]
	Region 1: Memory at eb024000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME
(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:02.0 Communication controller: Stallion Technologies, Inc. EasyIO
(rev 01)
	Subsystem: Stallion Technologies, Inc. EasyIO
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 1: I/O ports at a400 [size=128]
	Region 2: I/O ports at a800 [size=128]

02:09.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet
Controller (rev 02)
	Subsystem: Intel Corp.: Unknown device 3013
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (63750ns min), Cache Line Size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at eb000000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at ac00 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot
+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple,
DMMRBC=2, DMOST=0, DMCRS=1, RSCEM-
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
		Address: 0000000000000000  Data: 0000

02:0c.0 RAID bus controller: Promise Technology, Inc. PDC20276
(MBFastTrak133 Lite) (rev 01) (prog-if 85)
	Subsystem: Giga-byte Technology MBUltra 133
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b000 [size=8]
	Region 1: I/O ports at b400 [size=4]
	Region 2: I/O ports at b800 [size=8]
	Region 3: I/O ports at bc00 [size=4]
	Region 4: I/O ports at c000 [size=16]
	Region 5: Memory at eb020000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME
(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

The following occurs in /var/log/messages when I enter
	modprobe stallion

Feb 18 18:20:31 swtf kernel: Debug: sleeping function called from
invalid context at include/asm/semaphore.h:107
Feb 18 18:20:31 swtf kernel: in_atomic():0, irqs_disabled():1
Feb 18 18:20:31 swtf kernel:  [<c011d675>] __might_sleep+0x95/0xb0
Feb 18 18:20:31 swtf kernel:  [<c022b1ba>] acpi_os_wait_semaphore
+0x72/0xd1
Feb 18 18:20:31 swtf kernel:  [<c0247de5>] acpi_bus_data_handler+0x0/0x1
Feb 18 18:20:31 swtf kernel:  [<c023efc6>] acpi_ut_acquire_mutex
+0x5d/0x70
Feb 18 18:20:31 swtf kernel:  [<c02378f1>] acpi_get_data+0x2f/0x62
Feb 18 18:20:31 swtf kernel:  [<c02420ed>] acpi_bus_get_device+0x1d/0x2e
Feb 18 18:20:31 swtf kernel:  [<c0243d41>] acpi_pci_link_get_irq
+0x1b/0x68
Feb 18 18:20:31 swtf kernel:  [<c024421d>] acpi_pci_irq_lookup+0x39/0x57
Feb 18 18:20:31 swtf kernel:  [<c0244350>] acpi_pci_irq_enable
+0x82/0x14e
Feb 18 18:20:31 swtf kernel:  [<c0301eb4>] pcibios_enable_device
+0x14/0x20
Feb 18 18:20:31 swtf kernel:  [<c021404e>] pci_enable_device_bars
+0x1e/0x40
Feb 18 18:20:31 swtf kernel:  [<c0214084>] pci_enable_device+0x14/0x40
Feb 18 18:20:31 swtf kernel:  [<f897ebbc>] stl_init+0xfc/0x451
[stallion]
Feb 18 18:20:31 swtf kernel:  [<f897e009>] stallion_module_init+0x9/0x10
[stallion]
Feb 18 18:20:31 swtf kernel:  [<c01444f5>] sys_init_module+0x1e5/0x320
Feb 18 18:20:31 swtf kernel:  [<c017a1b1>] sys_read+0x41/0x70
Feb 18 18:20:31 swtf kernel:  [<c010391d>] sysenter_past_esp+0x52/0x75
Feb 18 18:20:34 swtf kernel: ACPI: PCI Interrupt Link [LNK0] enabled at
IRQ 11
Feb 18 18:20:34 swtf kernel: ACPI: PCI interrupt 0000:02:02.0[A] -> GSI
11 (level, low) -> IRQ 11
Feb 18 18:20:34 swtf kernel: STALLION: failed to register interrupt
routine for serial(EIO-PCI) irq=11
Feb 18 18:20:34 swtf kernel: STALLION: EasyIO-PCI found, board=0 io=a800
irq=11 nrpanels=1 nrports=4

When I enter attempt to access one of the stallion ports (ttyE0)
	cu -p E0
the following occurs in the syslog plus a wall sent by the kernel.

Feb 18 18:21:02 swtf kernel: irq 11: nobody cared!
Feb 18 18:21:02 swtf kernel:  [<c014bd24>] __report_bad_irq+0x24/0x80
Feb 18 18:21:02 swtf kernel:  [<c014be3e>] note_interrupt+0x8e/0xb0
Feb 18 18:21:02 swtf kernel:  [<c014b27d>] __do_IRQ+0x21d/0x340
Feb 18 18:21:02 swtf kernel:  [<c01056af>] do_IRQ+0x5f/0xa0
Feb 18 18:21:02 swtf kernel:  [<c01056eb>] do_IRQ+0x9b/0xa0
Feb 18 18:21:02 swtf kernel:  [<c0103ae2>] common_interrupt+0x1a/0x20
Feb 18 18:21:02 swtf kernel:  [<c014b019>] handle_IRQ_event+0x29/0x70
Feb 18 18:21:02 swtf kernel:  [<c014b15c>] __do_IRQ+0xfc/0x340
Feb 18 18:21:02 swtf kernel:  [<c01056a8>] do_IRQ+0x58/0xa0
Feb 18 18:21:02 swtf kernel:  =======================
Feb 18 18:21:02 swtf kernel:  [<f89b0b10>] stall_callback+0x0/0x3d0
[uhci_hcd]
Feb 18 18:21:02 swtf kernel:  [<c0103ae2>] common_interrupt+0x1a/0x20
Feb 18 18:21:02 swtf kernel:  [<c0127d3d>] __do_softirq+0x2d/0x90
Feb 18 18:21:02 swtf kernel:  [<c01057d1>] do_softirq+0x41/0x50
Feb 18 18:21:02 swtf kernel:  =======================
Feb 18 18:21:02 swtf kernel:  [<c01056af>] do_IRQ+0x5f/0xa0
Feb 18 18:21:02 swtf kernel:  [<c0103ae2>] common_interrupt+0x1a/0x20
Feb 18 18:21:02 swtf kernel: handlers:
Feb 18 18:21:02 swtf kernel: [<f88c07a0>] (ahc_linux_isr+0x0/0x420
[aic7xxx])
Feb 18 18:21:02 swtf kernel: [<f88d9610>] (e1000_intr+0x0/0xd0 [e1000])
Feb 18 18:21:02 swtf kernel: Disabling IRQ #11

[X.] Other notes, patches, fixes, workarounds:



