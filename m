Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbULXEXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbULXEXH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 23:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbULXEXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 23:23:07 -0500
Received: from web51810.mail.yahoo.com ([206.190.38.241]:41828 "HELO
	web51810.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261365AbULXEWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 23:22:35 -0500
Message-ID: <20041224042234.10308.qmail@web51810.mail.yahoo.com>
Date: Thu, 23 Dec 2004 20:22:34 -0800 (PST)
From: Scott Mollica <scott@exit-109.com>
Reply-To: scott@exit-109.com
Subject: PROBLEM
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem: 
Problem 
make utility exits with an Error 2 when making
linux-2.6.9-final.  
 
[2.] Full description of the problem/report:
make seems to choke in the
"drivers/char/drm/gamma_drv.c" section during make
(output from make is attached at bottom).

[3.] Keywords (i.e., modules, networking, kernel):
modules, gamma driver

[4.] Kernel version (from /proc/version):
smollica@t42:/proc$ more /proc/version
Linux version 2.6.8-1-386 (joshk@trollwife) (gcc
version 3.3.5 (Debian 1:3.3.5-2)) #1 Thu Nov 25
04:24:08 UTC 2004

[5.] Output of Oops.. message (if applicable) with
symbolic information 
     resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which
triggers the
     problem (if possible)
Running make from the /usr/src/linux-2.6.9-final
directory.  

[7.] Environment
Please note that I'm running make as su (maybe not a
good idea) and I'm not using a link to the kernel
source as /usr/src/linux.

[7.1.] Software (add the output of the ver_linux
script here)

t42:/usr/src/kernel-source-2.6.8/scripts# sh ver_linux
If some fields are empty or look unusual you may have
an old version.
Compare to the current minimal requirements in
Documentation/Changes.

Linux t42 2.6.8-1-386 #1 Thu Nov 25 04:24:08 UTC 2004
i686 GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15
util-linux             2.12
mount                  2.12
module-init-tools      3.1
e2fsprogs              1.35
pcmcia-cs              3.2.5
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         ipv6 ds af_packet yenta_socket
pcmcia_core snd_intel8x0m snd_intel8x0 snd_ac97_codec
snd_pcm snd_timer snd_page_alloc gameport
snd_mpu401_uart snd_rawmidi snd_seq_device snd shpchp
pciehp pci_hotplug intel_agp agpgart parport_pc
parport floppy irtty_sir sir_dev irda crc_ccitt tsdev
mousedev joydev psmouse pcspkr rtc evdev sd_mod
usb_storage scsi_mod ehci_hcd uhci_hcd usbcore
i810_audio ac97_codec soundcore e1000 capability
commoncap ide_cd cdrom isofs ext3 jbd ide_generic piix
ide_disk ide_core unix font vesafb cfbcopyarea
cfbimgblt cfbfillrect

[7.2.] Processor information (from /proc/cpuinfo):
t42:/usr/src# more /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor
1.70GHz
stepping        : 6
cpu MHz         : 1694.773
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic
sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr
sse sse2 ss tm pbe tm2 est
bogomips        : 3358.72

[7.3.] Module information (from /proc/modules):
t42:/usr/src# more /proc/modules
ipv6 229764 8 - Live 0xf8c23000
ds 17796 4 - Live 0xf8bdb000
af_packet 20872 2 - Live 0xf8b9d000
yenta_socket 19200 0 - Live 0xf8b90000
pcmcia_core 63028 2 ds,yenta_socket, Live 0xf8bca000
snd_intel8x0m 18632 0 - Live 0xf8b8a000
snd_intel8x0 33068 0 - Live 0xf8b72000
snd_ac97_codec 59268 2 snd_intel8x0m,snd_intel8x0,
Live 0xf8bba000
snd_pcm 85384 2 snd_intel8x0m,snd_intel8x0, Live
0xf8ba4000
snd_timer 23172 1 snd_pcm, Live 0xf8b6b000
snd_page_alloc 11144 3
snd_intel8x0m,snd_intel8x0,snd_pcm, Live 0xf8a4d000
gameport 4736 1 snd_intel8x0, Live 0xf8a81000
snd_mpu401_uart 7296 1 snd_intel8x0, Live 0xf8a77000
snd_rawmidi 23204 1 snd_mpu401_uart, Live 0xf8b25000
snd_seq_device 7944 1 snd_rawmidi, Live 0xf8a69000
snd 50660 8
snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device,
Live 0xf8b7c000
shpchp 87148 0 - Live 0xf8b39000
pciehp 83948 0 - Live 0xf8b55000
pci_hotplug 30640 2 shpchp,pciehp, Live 0xf8b30000
intel_agp 20512 1 - Live 0xf8a7a000
agpgart 31784 1 intel_agp, Live 0xf8adb000
parport_pc 33348 0 - Live 0xf8ad1000
parport 37320 1 parport_pc, Live 0xf8ac6000
floppy 54992 0 - Live 0xf8a85000
irtty_sir 8320 0 - Live 0xf8a65000
sir_dev 18092 1 irtty_sir, Live 0xf8a6c000
irda 167360 2 irtty_sir,sir_dev, Live 0xf8a9c000
crc_ccitt 2432 1 irda, Live 0xf89d0000
tsdev 7168 0 - Live 0xf8a51000
mousedev 9996 2 - Live 0xf8a45000
joydev 9536 0 - Live 0xf8a49000
psmouse 17800 0 - Live 0xf88b4000
pcspkr 3816 0 - Live 0xf889f000
rtc 12088 0 - Live 0xf8a41000
evdev 9088 0 - Live 0xf89cc000
sd_mod 20480 0 - Live 0xf88ba000
usb_storage 59456 0 - Live 0xf8a55000
scsi_mod 115148 2 sd_mod,usb_storage, Live 0xf8a07000
ehci_hcd 27908 0 - Live 0xf89c4000
uhci_hcd 29328 0 - Live 0xf89bb000
usbcore 104164 5 usb_storage,ehci_hcd,uhci_hcd, Live
0xf8a26000
i810_audio 33300 1 - Live 0xf88cb000
ac97_codec 16908 1 i810_audio, Live 0xf8887000
soundcore 9824 3 snd,i810_audio, Live 0xf8834000
e1000 75268 0 - Live 0xf89d2000
capability 4872 0 - Live 0xf8852000
commoncap 7168 1 capability, Live 0xf8838000
ide_cd 38176 0 - Live 0xf88c0000
cdrom 35740 1 ide_cd, Live 0xf88a6000
isofs 33976 0 - Live 0xf8893000
ext3 109672 1 - Live 0xf88d5000
jbd 54552 1 ext3, Live 0xf8857000
ide_generic 1664 0 - Live 0xf88b2000
piix 12448 1 - Live 0xf88a1000
ide_disk 16768 3 - Live 0xf888d000
ide_core 125028 5
usb_storage,ide_cd,ide_generic,piix,ide_disk, Live
0xf8867000
unix 25908 438 - Live 0xf883d000
font 8576 0 - Live 0xf8830000
vesafb 6688 0 - Live 0xf8823000
cfbcopyarea 3840 1 vesafb, Live 0xf882a000
cfbimgblt 3200 1 vesafb, Live 0xf8828000
cfbfillrect 3712 1 vesafb, Live 0xf8826000

[7.4.] Loaded driver and hardware information
(/proc/ioports, /proc/iomem)
smollica@t42:/proc$ more /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03bc-03be : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
04d0-04d1 : pnp 00:0b
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-105f : pnp 00:0b
  1060-107f : pnp 00:0b
1180-11bf : 0000:00:1f.0
  1180-11bf : pnp 00:0b
1800-181f : 0000:00:1d.0
  1800-181f : uhci_hcd
1820-183f : 0000:00:1d.1
  1820-183f : uhci_hcd
1840-185f : 0000:00:1d.2
  1840-185f : uhci_hcd
1860-186f : 0000:00:1f.1
  1860-1867 : ide0
  1868-186f : ide1
1880-189f : 0000:00:1f.3
18c0-18ff : 0000:00:1f.5
  18c0-18ff : Intel ICH4
1c00-1cff : 0000:00:1f.5
  1c00-1cff : Intel ICH4
2000-207f : 0000:00:1f.6
  2000-207f : Intel 82801DB-ICH4 Modem - Controller
2400-24ff : 0000:00:1f.6
  2400-24ff : Intel 82801DB-ICH4 Modem - AC'97
3000-3fff : PCI Bus #01
  3000-30ff : 0000:01:00.0
4000-40ff : PCI CardBus #03
4400-44ff : PCI CardBus #03
4800-48ff : PCI CardBus #07
4c00-4cff : PCI CardBus #07
8000-803f : 0000:02:01.0
  8000-803f : e1000
------------------------------------------------
t42:/usr/src#    more /proc/iomem
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000d0000-000d0fff : Adapter ROM
000d1000-000d1fff : Adapter ROM
000d2000-000d3fff : reserved
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ff5ffff : System RAM
  00100000-0024d12a : Kernel code
  0024d12b-0030357f : Kernel data
3ff60000-3ff76fff : ACPI Tables
3ff77000-3ff78fff : ACPI Non-volatile Storage
3ff79000-3ff793ff : 0000:00:1f.1
3ff80000-3fffffff : reserved
40000000-403fffff : PCI CardBus #03
40400000-407fffff : PCI CardBus #03
40800000-40bfffff : PCI CardBus #07
40c00000-40ffffff : PCI CardBus #07
b0000000-b0000fff : 0000:02:00.0
  b0000000-b0000fff : yenta_socket
b1000000-b1000fff : 0000:02:00.1
  b1000000-b1000fff : yenta_socket
c0000000-c00003ff : 0000:00:1d.7
  c0000000-c00003ff : ehci_hcd
c0000800-c00008ff : 0000:00:1f.5
  c0000800-c00008ff : ich_audio MBBAR
c0000c00-c0000dff : 0000:00:1f.5
  c0000c00-c0000dff : ich_audio MMBAR
c0100000-c01fffff : PCI Bus #01
  c0100000-c010ffff : 0000:01:00.0
c0200000-c020ffff : 0000:02:01.0
  c0200000-c020ffff : e1000
c0210000-c0210fff : 0000:02:02.0
c0220000-c023ffff : 0000:02:01.0
  c0220000-c023ffff : e1000
d0000000-dfffffff : 0000:00:00.0
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
ff800000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
smollica@t42:/proc$   lspci -vvv
0000:00:00.0 Host bridge: Intel Corp. 82855PM
Processor to I/O Controller (rev 03)
        Subsystem: IBM: Unknown device 0529
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit,
prefetchable) [size=256M]
        Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor
to AGP Controller (rev 03) (prog-if 00 [Normal
decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 96
        Bus: primary=00, secondary=01, subordinate=01,
sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: c0100000-c01fffff
        Prefetchable memory behind bridge:
e0000000-e7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort-
>Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp.
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI
Controller #1 (rev 01) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Control: I/O+ Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at 1800 [size=32]

0000:00:1d.1 USB Controller: Intel Corp.
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI
Controller #2 (rev 01) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Control: I/O+ Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 1820 [size=32]

0000:00:1d.2 USB Controller: Intel Corp.
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI
Controller #3 (rev 01) (prog-if 00 [UHCI])
        Subsystem: IBM: Unknown device 052d
        Control: I/O+ Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at 1840 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM
(ICH4/ICH4-M) USB 2.0 EHCI Controller (rev 01)
(prog-if 20 [EHCI])
        Subsystem: IBM: Unknown device 052e
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at c0000000 (32-bit,
non-prefetchable) [size=1K]
        Capabilities: <available only to root>

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge
(rev 81) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=08,
sec-latency=64
        I/O behind bridge: 00004000-00008fff
        Memory behind bridge: c0200000-cfffffff
        Prefetchable memory behind bridge:
e8000000-efffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort-
>Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC
Interface Controller (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DBM
(ICH4) Ultra ATA Storage Controller (rev 01) (prog-if
8a [Master SecP PriP])
        Subsystem: IBM: Unknown device 052d
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 1860 [size=16]
        Region 5: Memory at 3ff79000 (32-bit,
non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 01)
        Subsystem: IBM: Unknown device 052d
        Control: I/O+ Mem- BusMaster- SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 1880 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp.
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio
Controller (rev 01)
        Subsystem: IBM: Unknown device 0554
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 1c00 [size=256]
        Region 1: I/O ports at 18c0 [size=64]
        Region 2: Memory at c0000c00 (32-bit,
non-prefetchable) [size=512]
        Region 3: Memory at c0000800 (32-bit,
non-prefetchable) [size=256]
        Capabilities: <available only to root>

0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 01)
(prog-if 00 [Generic])
        Subsystem: IBM: Unknown device 0559
        Control: I/O+ Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at 2400 [size=256]
        Region 1: I/O ports at 2000 [size=128]
        Capabilities: <available only to root>

0000:01:00.0 VGA compatible controller: ATI
Technologies Inc RV350 [Mobility Radeon 9600 M10]
(prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 0550
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), Cache Line Size:
0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit,
prefetchable) [size=128M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at c0100000 (32-bit,
non-prefetchable) [size=64K]
        Capabilities: <available only to root>

0000:02:00.0 CardBus bridge: Texas Instruments PCI4520
PC card Cardbus Controller (rev 01)
        Subsystem: IBM: Unknown device 0552
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 0x20 (128
bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at b0000000 (32-bit,
non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06,
sec-latency=176
        Memory window 0: 40000000-403ff000
(prefetchable)
        Memory window 1: 40400000-407ff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort-
>Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

0000:02:00.1 CardBus bridge: Texas Instruments PCI4520
PC card Cardbus Controller (rev 01)
        Subsystem: IBM: Unknown device 0552
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 0x20 (128
bytes)
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at b1000000 (32-bit,
non-prefetchable) [size=4K]
        Bus: primary=02, secondary=07, subordinate=0a,
sec-latency=176
        Memory window 0: 40800000-40bff000
(prefetchable)
        Memory window 1: 40c00000-40fff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort-
>Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

0000:02:01.0 Ethernet controller: Intel Corp. 82540EP
Gigabit Ethernet Controller (Mobile) (rev 03)
        Subsystem: IBM PRO/1000 MT Mobile Connection
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), Cache Line Size:
0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at c0220000 (32-bit,
non-prefetchable) [size=128K]
        Region 1: Memory at c0200000 (32-bit,
non-prefetchable) [size=64K]
        Region 2: I/O ports at 8000 [size=64]
        Capabilities: <available only to root>

0000:02:02.0 Network controller: Intel Corp.
PRO/Wireless 2200BG (rev 05)
        Subsystem: Intel Corp.: Unknown device 2711
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 6000ns max), Cache
Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at c0210000 (32-bit,
non-prefetchable) [size=4K]
        Capabilities: <available only to root>

[7.6.] SCSI information (from /proc/scsi/scsi)
smollica@t42:/proc$ more /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SanDisk  Model: Cruzer Mini      Rev: 0.1
  Type:   Direct-Access                    ANSI SCSI
revision: 02

[7.7.] Other information that might be relevant to the
problem
       (please look in /proc and include all
information that you
       think to be relevant):
Machine - IBM Thinkpad T42.
OS - customized debian 2.6.8 testing kernel.  The mods
I made were enabling HIMEM for 4 GB (although I run
with 1GB), .config support and selection of Pentium M
processor.
[X.] Other notes, patches, fixes, workarounds:

----------------make output------------------

CC [M]  drivers/char/agp/backend.o
  CC [M]  drivers/char/agp/frontend.o
  CC [M]  drivers/char/agp/generic.o
  CC [M]  drivers/char/agp/isoch.o
  LD [M]  drivers/char/agp/agpgart.o
  CC [M]  drivers/char/agp/ali-agp.o
  CC [M]  drivers/char/agp/ati-agp.o
  CC [M]  drivers/char/agp/amd-k7-agp.o
  CC [M]  drivers/char/agp/amd64-agp.o
  CC [M]  drivers/char/agp/efficeon-agp.o
  CC [M]  drivers/char/agp/intel-mch-agp.o
  CC [M]  drivers/char/agp/intel-agp.o
  CC [M]  drivers/char/agp/nvidia-agp.o
  CC [M]  drivers/char/agp/sis-agp.o
  CC [M]  drivers/char/agp/sworks-agp.o
  CC [M]  drivers/char/agp/via-agp.o
  LD      drivers/char/drm/built-in.o
  CC [M]  drivers/char/drm/gamma_drv.o
In file included from drivers/char/drm/gamma_drv.c:42:
drivers/char/drm/gamma_context.h: In function
`gamma_context_switch_complete':
drivers/char/drm/gamma_context.h:193: error: structure
has no member named `next_buffer'
drivers/char/drm/gamma_context.h:193: error: structure
has no member named `next_buffer'
In file included from drivers/char/drm/gamma_drv.c:44:
drivers/char/drm/gamma_old_dma.h: In function
`gamma_clear_next_buffer':
drivers/char/drm/gamma_old_dma.h:40: error: structure
has no member named `next_buffer'
drivers/char/drm/gamma_old_dma.h:41: error: structure
has no member named `next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure
has no member named `next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure
has no member named `next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure
has no member named `next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure
has no member named `next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure
has no member named `next_queue'
drivers/char/drm/gamma_old_dma.h:42: error: structure
has no member named `next_queue'
drivers/char/drm/gamma_old_dma.h:44: error: structure
has no member named `next_queue'
In file included from drivers/char/drm/gamma_drv.c:46:
drivers/char/drm/drm_drv.h: In function
`gamma_release':
drivers/char/drm/drm_drv.h:808: warning: implicit
declaration of function `gamma_ctxbitmap_free'
make[3]: *** [drivers/char/drm/gamma_drv.o] Error 1
make[2]: *** [drivers/char/drm] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

Regards,
Scott Mollica

