Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbQLALfW>; Fri, 1 Dec 2000 06:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbQLALfM>; Fri, 1 Dec 2000 06:35:12 -0500
Received: from smtp2.ihug.co.nz ([203.109.252.8]:9988 "EHLO smtp2.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S129737AbQLALfB>;
	Fri, 1 Dec 2000 06:35:01 -0500
Message-ID: <3A2785BB.EB36DDE0@ihug.co.nz>
Date: Sat, 02 Dec 2000 00:04:27 +1300
From: Gerard Sharp <gsharp@ihug.co.nz>
Reply-To: gsharp@ihug.co.nz
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11-ac4-smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
[1.] One line summary of the problem:    
Intermittent corruption of 4 bytes in SMP kernels using HPT366

[2.] Full description of the problem/report:
First noticed in 2.3.99-preX; but hard to track down then.
When the system was under load - e.g. cp /usr/src/linux /usr/src/l2,
it would occasionally and randomly corrupt some files; possibly multiple
times per file; possibly multiple files. always exactly 4 bytes would be
altered per corruption.
Nothing shows up in logs; no oopses; no messages.
Tests on 2.3.99 found the problem to be unreproducable on UP kernels
Tests on the current kernel found the problem to be unreproducable on
the BX chipset's own ATA33 controller.

[3.] Keywords (i.e., modules, networking, kernel):
IDE, HPT366, EXT2, SMP, Corruption, Worrying

[4.] Kernel version (from /proc/version):
#cat /proc/version 
Linux version 2.4.0-test11-ac4-smp (root@midnight) (gcc version
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #2 SMP Tue Nov 28
22:38:21 NZDT 2000

[5.]
Nada

[6.] A small shell script or example program which triggers the
     problem (if possible)
cp /usr/src/linux /usr/src/l2 ; diff -dur /usr/src/linux /usr/src/l2
shows the problem up if diff produces any output
system may 'survive' two copies (I tend to use a different, uncached
kernel for each attempt - to rule out/minimise the effect of caching)
but 'fail' the third.
where 'survive' = no corruption; 'fail' = some / lots of corruption.
High memory usage increases likelihood; hitting swap at ALL seems to
increase likelihood (swap on same drive)

[7.] Environment
Redhat 6.2 basis.
Abit BP6 Motherboard.
Dual Celeron 466's
128 Mb ram; 13.6 Gb Seagate Barracuda HDD
"hda: ST313620A, ATA DISK drive"
CD-ROM on hdd

[7.1.] Software (add the output of the ver_linux script here)

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux midnight 2.4.0-test11-ac4-smp #2 SMP Tue Nov 28 22:38:21 NZDT 2000
i686 unknown
Kernel modules         2.3.13
Gnu C                  egcs-2.91.66
Gnu Make               3.78.1
Binutils               2.9.5.0.22
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10q
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 467.000741
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags   : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr
bogomips        : 933.89

processor       : 0
vendor_id       : GenuineIntel
...

[7.3.] Module information (from /proc/modules):
Doesn't Impact Problem.

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
#cat /proc/ioports 
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
0220-022f : soundblaster
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
  03c0-03df : matrox
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
  5000-5007 : piix4-smbus
d000-d01f : Intel Corporation 82371AB PIIX4 USB
d400-d4ff : Realtek Semiconductor Co., Ltd. RTL-8139
  d400-d4ff : eth0
d800-d807 : Triones Technologies, Inc. HPT366
dc00-dc03 : Triones Technologies, Inc. HPT366
e000-e0ff : Triones Technologies, Inc. HPT366
  e000-e007 : ide2
  e010-e0ff : HPT366
e400-e407 : Triones Technologies, Inc. HPT366 (#2)
e800-e803 : Triones Technologies, Inc. HPT366 (#2)
ec00-ecff : Triones Technologies, Inc. HPT366 (#2)
  ec00-ec07 : ide3
  ec10-ecff : HPT366
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

#cat /proc/iomem   
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-0021232f : Kernel code
  00212330-002239ff : Kernel data
e0000000-e3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
e4000000-e4003fff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
  e4000000-e4003fff : matroxfb MMIO
e5000000-e57fffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
  e5000000-e57fffff : matroxfb FB
e6000000-e67fffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
e9000000-e90000ff : Realtek Semiconductor Co., Ltd. RTL-8139
  e9000000-e90000ff : eth0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
===
#lspci -vvv | less
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03
)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort+ >SERR- <PERR-
        Latency: 32 set
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 
[Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Region 4: I/O ports at f000 [size=16]
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00
 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at d000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-

00:0b.0 VGA compatible controller: Matrox Graphics, Inc. MGA 1064SG
[Mystique] (
rev 02) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at e4000000 (32-bit, non-prefetchable)
[size=16K]
        Region 1: Memory at e5000000 (32-bit, prefetchable) [size=8M]
        Region 2: Memory at e6000000 (32-bit, non-prefetchable)
[size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 32 min, 64 max, 32 set
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at e9000000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
        Capabilities: [60] Vital Product Data
00:13.0 Unknown mass storage controller: Triones Technologies, Inc.
HPT366 (rev 
01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 120 set, cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d800 [size=8]
        Region 1: I/O ports at dc00 [size=4]
        Region 4: I/O ports at e000 [size=256]
        Expansion ROM at e8000000 [disabled] [size=128K]

00:13.1 Unknown mass storage controller: Triones Technologies, Inc.
HPT366 (rev 
01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 120 set, cache line size 08
        Interrupt: pin B routed to IRQ 18
        Region 0: I/O ports at e400 [size=8]
        Region 1: I/O ports at e800 [size=4]
        Region 4: I/O ports at ec00 [size=256]
===

[7.6.] SCSI information (from /proc/scsi/scsi)
Nada

[7.7.]
snippets from dmesg:
=== <hard drive on hde> ===
HPT366: onboard version of chipset, pin1=1 pin2=2 
HPT366: IDE controller on PCI bus 00 dev 98 
PCI: Enabling device 00:13.0 (0005 -> 0007) 
HPT366: chipset revision 1 
HPT366: not 100% native mode: will probe irqs later 
    ide2: BM-DMA at 0xe000-0xe007, BIOS settings: hde:DMA, hdf:pio 
HPT366: IDE controller on PCI bus 00 dev 99 
HPT366: chipset revision 1 
HPT366: not 100% native mode: will probe irqs later 
    ide3: BM-DMA at 0xec00-0xec07, BIOS settings: hdg:pio, hdh:pio 
hdd: FX240S, ATAPI CDROM drive 
hde: ST313620A, ATA DISK drive 
ide1 at 0x170-0x177,0x376 on irq 15 
ide2 at 0xd800-0xd807,0xdc02 on irq 18 
hde: 26692776 sectors (13667 MB) w/512KiB Cache, CHS=26480/16/63,
UDMA(66) 
=== </hard drive on hde> ===

=== <hard drive on hda> ===
HPT366: onboard version of chipset, pin1=1 pin2=2
HPT366: IDE controller on PCI bus 00 dev 98
PCI: Enabling device 00:13.0 (0005 -> 0007)
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xe000-0xe007, BIOS settings: hde:pio, hdf:pio
HPT366: IDE controller on PCI bus 00 dev 99
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide3: BM-DMA at 0xec00-0xec07, BIOS settings: hdg:pio, hdh:pio
hda: ST313620A, ATA DISK drive
hdd: FX240S, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 26692776 sectors (13667 MB) w/512KiB Cache, CHS=1661/255/63,
UDMA(33)
=== </hard drive on hda> ===


[X.] Other notes, patches, fixes, workarounds:

Only current workaround is to avoid the HPT chip :(

I can't help but worry that (especially after the volume of this email)
it's a simple problem / my fault - however; I have not seen anything
specific to this in the past few months.

I can offer to help debug; but my time is limited due to the twin evils
of Work and Sleep; and I don't have too many leads what with no error
output; just silent corruption :(


Gerard Sharp
Two Penguins at 1024x768
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
