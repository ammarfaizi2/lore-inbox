Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314609AbSELQTU>; Sun, 12 May 2002 12:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314870AbSELQTT>; Sun, 12 May 2002 12:19:19 -0400
Received: from mail001.chicago.lightfirst.com ([216.105.92.11]:24967 "EHLO
	mail001.chicago.lightfirst.com") by vger.kernel.org with ESMTP
	id <S314609AbSELQTQ>; Sun, 12 May 2002 12:19:16 -0400
Message-ID: <3CDE95A1.7F3D005@lightfirst.com>
Date: Sun, 12 May 2002 11:17:37 -0500
From: Tom Roberts <TomRoberts@lightfirst.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: CR-RW works on Win98se but not Linux 2.4.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PROBLEM: CR-RW works on Win98se but not Linux 2.4.18
NOTE: This is probably the Via chipset data corruption bug

I have installed a Philips PCRW2412 CD writer (24x12x40x). It works
fine when I boot into Windows 98se, but does not work when I boot into
Linux 2.4.18.  Gtoaster and cdrecord give no errors, but when I compare
to the original a few files have permanent compare errors (different
files for different CDRs); writing while booted in Win98se gets no
compare errors (comparing while booted in Linux 2.4.18). I have tried
3 other CD writers with similar results, except that an old HP 4x2x10x
writer worked mostly (compare errors about 1 out of 10 CDRs). The
system is as idle as I can make it, but CPU activity does not seem
to affect this.

I have upgraded everything I know how to:
        RedHat 7.2 (includes cdrecord 1.10)
        BIOS 1008a (latest from the manufacturer, Asus A7V133)
        Kernel 2.4.18 (configured and built it myself (:-)) -- system
           boots just fine using this or the RH 7.2 kernel (2.4.7-10).
           CD-R problems are the same for both kernels. I had to
           config it for PentiumIII, because the Athlon config has
           unsatisfied external _mmx_memcopy() in some modules. I
           used PCI access = BIOS (see below).

>From the success in Windows without the updated "4-in-1" driver, I
believe that the BIOS is configuring the PCI and IDE systems correctly
(that is Via's way to fix the bug). This implies that Linux is re-
configuring them incorrectly. I did configure the Kernel to use "BIOS"
access mode for PCI, hoping that would preserve the BIOS settings which
work in Windows, but I still get errors.

Here I describe things with a single harddisk (master) and the CD-RW
(slave) on the first IDE cable. I have a second harddisk (master) on
the second IDE cable; I can copy ~700 MB ISO images between drives
(hda and hdc) without errors, so the most common manifestation of the
"Via chipset data corruption bug" does not affect me (I unmounted
/dev/hdc while burning, to make sure cable-to-cable was not the
problem). I also had these errors in an older configuration with both
harddisks on the first IDE cable and the CD-RW on the second. Both
cables are 80-wire; trying the CD-RW on a 40-wire second cable still
had errors (did not try that in Win98se). I am of course using
ide-scsi for the CD-RW drive.

	[I seem to recall comments in via82cxxx.c which said there
	 is a bug in the 40-wire detection; this may have compromized
	 my test with the 40-wire cable.]

So I think I have eliminated hardware problems as the source of these
errors.  Does anyone have a clue?  Is there some special kernel CONFIG
I need to select? Do I need to discard this motherboard and start over?
I recall seeing a Windows program which dumps some PCI config registers,
and the article discussed how to change them to fix this problem -- is
there such a program for Linux?

A Google search on "via data corruption bug" returns volumes of
information, but I cannot separate the wheat from the chaff....
I have asked this on several Linux newsgroups, but got no answer.

Thanks for any insight or assistance....


Tom Roberts     tjroberts@lucent.com	tomroberts@lightfirst.com


cat /proc/version:
Linux version 2.4.18 (root@lucy2) (gcc version 2.96 20000731 \
(Red Hat Linux 7.1 2.96-98)) #21 Thu May 9 20:14:55 CDT 2002

cat /proc/ide/via:
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.29
South Bridge:                       VIA vt82c686b
Revision:                           ISA 0x40 IDE 0x6
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xd800
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                 yes
Post Write Buffer:             no                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 80w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA      UDMA      UDMA       PIO
Address Setup:       30ns      30ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns      90ns      90ns     330ns
Data Recovery:       30ns      30ns      30ns     270ns
Cycle Time:          20ns      60ns      20ns     600ns
Transfer Rate:   99.0MB/s  33.0MB/s  99.0MB/s   3.3MB/s


cat /proc/ide/drivers:
ide-scsi version 0.9
ide-cdrom version 4.59
ide-disk version 1.10


cat /proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 807.209
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca \
                  cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1608.90


scripts/ver_linux output:
Linux lucy2 2.4.18 #21 Thu May 9 20:14:55 CDT 2002 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.6
e2fsprogs              1.23
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         es1371 ac97_codec soundcore vmnet parport_pc vmmon \
                        ide-scsi vfat fat

lspci -vvv:
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 8042
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e6000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: e2000000-e3dfffff
        Prefetchable memory behind bridge: e3f00000-e5ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
        Subsystem: Asustek Computer, Inc.: Unknown device 8042
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])

        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: Asustek Computer, Inc.: Unknown device 8042
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at a400 [size=256]
        Region 1: Memory at e1800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: Ensoniq CT5880 [AudioPCI] (rev 02)
        Subsystem: Ensoniq: Unknown device 2003
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at a000 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 9800 [size=8]
        Region 1: I/O ports at 9400 [size=4]
        Region 2: I/O ports at 9000 [size=8]
        Region 3: I/O ports at 8800 [size=4]
        Region 4: I/O ports at 8400 [size=64]
        Region 5: Memory at e1000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e2000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e4000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at e3ff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


cat /etc/lilo.conf:
prompt
timeout=50
default=linux-2.4.18
boot=/dev/hda
map=/boot/map
install=/boot/boot.b
message=/boot/message
lba32

image=/boot/vmlinuz-2.4.18
        label=linux-2.4.18
        read-only
        root=/dev/hda3
        append="hdb=ide-scsi"

image=/boot/vmlinuz-2.4.7-10
        label=linux-2.4.7-10
        initrd=/boot/initrd-2.4.7-10.img
        read-only
        root=/dev/hda3
        append="hdb=ide-scsi"

other=/dev/hda1
        optional
        label=Win98
