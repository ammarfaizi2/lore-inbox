Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbUBYPjz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 10:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUBYPjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 10:39:55 -0500
Received: from mail.acu.edu ([150.252.135.93]:28587 "EHLO nicanor.acu.edu")
	by vger.kernel.org with ESMTP id S261364AbUBYPjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 10:39:37 -0500
Date: Wed, 25 Feb 2004 09:39:31 -0600
From: Michael Joy <mdj00b@acu.edu>
Subject: 2.6.3 Boot Failure on Nforce2 Board
To: LKML <linux-kernel@vger.kernel.org>, mdj00b@acu.edu
Message-id: <1077723571.9844.22.camel@physx01.acu.edu>
Organization: Abilene Christian University
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
We're having an interesting problem with the latest kernel release. On
an Albatron KM18G, latest bios, 1024MB system with athlon xp proc, 2.6.3
refuses to boot. It hangs on initializing the ide devices.

[2.] Full description of the problem/report: The problem is most
definately related to the ide controller changes made in 2.6.3 as in
2.4.22 we did not have this issue. We haven't tried any of the previous
kernels as this is a production system.

When booting the 2.6.3 kernel, either compiled by Mandrake (cooker) or
using the straight up source, the kernel hangs without any error on hda:
max request size : 128KiB.

I don't have a log of this as it won't initialize the HD (wd1200jb on an
80pin cable) to log the dmesg dump. Anyways we have two identical
machines that do this. Both are nforce2 integrated gpu's, using onboard
networking and sound. They have 2x512 Kingston HyperX memory modules
which have been thouroughly tested in these machines with memtest and no
errors are found.

Of note is that these machines exhibit the random freezes (blank screen,
hard lock, normally associated with heavy disk thrashing) many other
nforce2 boards seem to be experiencing. To fix this, we boot them with
the noapic and nolapic option and the problem does not reappear. 

What I have tried:

passing these boot time commands:

acpi=off
noapic
nolapic
ide=nodma
elevator=as
elevator=noop
elevator=deadline

All permutations of these produce the same result, kernel hard locks on
initializing hda. Both systems exhibit this behavior.

Please advise :)

[3.] Keywords (i.e., modules, networking, kernel):


[4.] Kernel version (from /proc/version): 2.6.3
[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux physx01.acu.edu 2.4.22-21mdkenterprise #1 SMP Fri Oct 24 19:48:37 MDT 2003 i686 unknown unknown GNU/Linux

Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      3.0-pre9
e2fsprogs              1.34
nfs-utils              1.0.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.11
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         lp parport agpgart nvidia sd_mod ide-floppy ide-tape snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-intel8x0 snd-ac97-codec snd-pcm snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device snd-page-alloc snd soundcore nfsd af_packet w83781d i2c-proc i2c-isa i2c-nforce2 i2c-core sr_mod floppy nvnet supermount keybdev mousedev hid input ide-cd cdrom ide-scsi scsi_mod printer ehci-hcd usb-ohci usbcore rtc reiserfs

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2400+
stepping        : 1
cpu MHz         : 1997.008
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3984.58

[7.3.] Module information (from /proc/modules):
lp                      8864   0 (autoclean) (unused)
parport                39592   0 (autoclean) [lp]
agpgart                58628   5 (autoclean)
nvidia               1766368  33 (autoclean)
sd_mod                 14572   0 (autoclean) (unused)
ide-floppy             17408   0 (autoclean)
ide-tape               54768   0 (autoclean)
snd-seq-oss            37152   0 (unused)
snd-seq-midi-event      6592   0 [snd-seq-oss]
snd-seq                49840   2 [snd-seq-oss snd-seq-midi-event]
snd-pcm-oss            46820   0
snd-mixer-oss          15992   0 [snd-pcm-oss]
snd-intel8x0           24036   0
snd-ac97-codec         50104   0 [snd-intel8x0]
snd-pcm                90592   0 [snd-pcm-oss snd-intel8x0]
snd-timer              20932   0 [snd-seq snd-pcm]
snd-mpu401-uart         5436   0 [snd-intel8x0]
snd-rawmidi            19488   0 [snd-mpu401-uart]
snd-seq-device          6268   0 [snd-seq-oss snd-seq snd-rawmidi]
snd-page-alloc         10228   0 [snd-intel8x0 snd-pcm]
snd                    46596   0 [snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-intel8x0 snd-ac97-codec snd-pcm snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               7236   0 [snd]
nfsd                   83280   8 (autoclean)
af_packet              16904   0 (autoclean)
w83781d                26164   0 (unused)
i2c-proc                8692   0 [w83781d]
i2c-isa                 1332   0 (unused)
i2c-nforce2             4392   0 (unused)
i2c-core               22052   0 [w83781d i2c-proc i2c-isa i2c-nforce2]
sr_mod                 18168   0 (autoclean)
floppy                 59548   0
nvnet                  30880   1 (autoclean)
supermount             87328   3 (autoclean)
keybdev                 3012   0 (unused)
mousedev                5912   0 (unused)
hid                    25668   0 (unused)
input                   6272   0 [keybdev mousedev hid]
ide-cd                 36548   0
cdrom                  35360   0 [sr_mod ide-cd]
ide-scsi               12624   0
scsi_mod              112992   3 [sd_mod sr_mod ide-scsi]
printer                 9376   0 (unused)
ehci-hcd               21036   0 (unused)
usb-ohci               22568   0 (unused)
usbcore                83468   1 [hid printer ehci-hcd usb-ohci]
rtc                    10508   0 (autoclean)
reiserfs              219988   5

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
ioports:
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
0290-0297 : w83627hf
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
5000-5007 : nForce2 SMBus
5100-5107 : nForce2 SMBus
d000-d01f : nVidia Corporation nForce2 SMBus (MCP)
d400-d407 : nVidia Corporation nForce2 Ethernet Controller (MCP)
d800-d8ff : nVidia Corporation nForce2 AC97 Audio Controler (MCP)
dc00-dc7f : nVidia Corporation nForce2 AC97 Audio Controler (MCP)
  dc00-dc3f : NVidia nForce2 - Controller
f000-f00f : nVidia Corporation nForce2 IDE UDMA133
  f000-f007 : ide0
  f008-f00f : ide1

iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d4000-000d57ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3dfeffff : System RAM
  001f8000-00392ab4 : Kernel code
3dff0000-3dff2fff : ACPI Non-volatile Storage
3dff3000-3dffffff : ACPI Tables
d0000000-d7ffffff : nVidia Corporation nForce2 AGP (different version?)
d8000000-dfffffff : PCI Bus #02
  d8000000-dbffffff : nVidia Corporation NV18 [GeForce4 MX - nForce GPU]
    d8000000-d84fffff : vesafb
  dc000000-dc07ffff : nVidia Corporation NV18 [GeForce4 MX - nForce GPU]
e0000000-e1ffffff : PCI Bus #02
  e0000000-e0ffffff : nVidia Corporation NV18 [GeForce4 MX - nForce GPU]
e2000000-e20000ff : nVidia Corporation nForce2 USB 2.0 EHCI Controller
  e2000000-e20000ff : ehci_hcd
e2001000-e2001fff : nVidia Corporation nForce2 Ethernet Controller (MCP)
  e2001000-e2001fff : nvnet
e2002000-e2002fff : nVidia Corporation nForce2 AC97 Audio Controler (MCP)
  e2002000-e20021ff : NVidia nForce2 - AC'97
e2004000-e2004fff : nVidia Corporation nForce2 USB 1.1 OHCI Controller
  e2004000-e2004fff : usb-ohci
e2005000-e2005fff : nVidia Corporation nForce2 USB 1.1 OHCI Controller (#2)
  e2005000-e2005fff : usb-ohci
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev a2)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [40] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev a2)
	Subsystem: Unknown device 17f2:3401
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev a2)
	Subsystem: Unknown device 17f2:3401
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev a2)
	Subsystem: Unknown device 17f2:3401
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev a2)
	Subsystem: Unknown device 17f2:3401
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev a2)
	Subsystem: Unknown device 17f2:3401
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
	Subsystem: Unknown device 17f2:3401
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [48] #08 [01e1]

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
	Subsystem: Unknown device 17f2:3401
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d000 [size=32]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3) (prog-if 10 [OHCI])
	Subsystem: Unknown device 17f2:3401
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 4
	Region 0: Memory at e2004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3) (prog-if 10 [OHCI])
	Subsystem: Unknown device 17f2:3401
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 3
	Region 0: Memory at e2005000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3) (prog-if 20 [EHCI])
	Subsystem: Unknown device 17f2:3401
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 7
	Region 0: Memory at e2000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] #0a [2080]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
	Subsystem: Unknown device 17f2:3401
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e2001000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d400 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
	Subsystem: Unknown device 17f2:3401
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d800 [size=256]
	Region 1: I/O ports at dc00 [size=128]
	Region 2: Memory at e2002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: Unknown device 17f2:3401
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev a2) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e0000000-e1ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

02:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX - nForce GPU] (rev a3) (prog-if 00 [VGA])
	Subsystem: Unknown device 17f2:3401
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=64M]
	Region 2: Memory at dc000000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SONY     Model: CD-RW  CRX210E1  Rev: 2YS2
  Type:   CD-ROM
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
/proc/sys/devices:
Character devices:
  1 mem
  2 pty/m%d
  3 pty/s%d
  4 tts/%d
  5 cua/%d
  6 lp
  7 vcs
 10 misc
 13 input
 14 sound
 29 fb
116 alsa
128 ptm
129 ptm
130 ptm
131 ptm
136 pts/%d
137 pts/%d
138 pts/%d
139 pts/%d
162 raw
180 usb
195 nvidia

Block devices:
  1 ramdisk
  2 fd
  3 ide0
  9 md
 11 sr
 22 ide1

/proc/sys/apm:
1.16 1.2 0x07 0x01 0xff 0x80 -1% -1 ?

/proc/sys/interrupts:
           CPU0
  0:    6758438          XT-PIC  timer
  1:       9642          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:          0          XT-PIC  usb-ohci
  4:        280          XT-PIC  usb-ohci
  5:       2584          XT-PIC  NVidia nForce2
  7:          0          XT-PIC  ehci_hcd
  8:          1          XT-PIC  rtc
 10:    4053203          XT-PIC  nvidia
 11:    3178346          XT-PIC  eth0
 12:     109573          XT-PIC  PS/2 Mouse
 14:    2592291          XT-PIC  ide0
 15:         99          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0
MIS:          0


[X.] Other notes, patches, fixes, workarounds:
No known work around.

If ya'll need any other information, please cc me personally as well as posting to the list as I might miss it otherwise. I appreciate all the hard work ya'll put into this project! Your assistance is worth more than you can imagine.

Thanks in advance for any assistance ya'll can provide.
-- 
Michael Joy <mdj00b@n0sp5m.acu.edu>
Physics Systems Administrator
Abilene Christian University

