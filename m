Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVCUKKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVCUKKW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 05:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVCUKKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 05:10:22 -0500
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:54429 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S261176AbVCUKIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 05:08:11 -0500
Message-ID: <423EA96D.1030201@mail.ru>
Date: Mon, 21 Mar 2005 14:01:01 +0300
From: Dmitry Antipov <dmitry.antipov@mail.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Radeonfb blanks the screen / hangs the system with 2.6.11
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this looks like an issue with radeonfb driver.

If radeonfb and fb console are built-in, the console blanks and system 
bootup
stopped immediately after switching to fb console, and monitor displays 
"No signal"
message. C-A-D works, but nothing is logged.

For modular radeonfb, the console becomes blank after 'modprobe 
radeonfb'. But the
rest of the system is fine and console input works, so I can safely 
reboot the box
and get log messages at the next boot:

radeonfb_pci_register BEGIN
PCI: Found IRQ 10 for device 0000:04:00.0
PCI: Sharing IRQ 10 with 0000:00:01.0
PCI: Sharing IRQ 10 with 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:00:1c.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
radeonfb (0000:04:00.0): Found 131072k of DDR 128 bits wide videoram
radeonfb (0000:04:00.0): mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=503.00 Mhz, 
System=370.00 MHz
radeonfb: PLL min 20000 max 40000
1 chips in connector info
 - chip 1 has 1 connectors
  * connector 0 of type 3 (DVI-I) : 3300
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... found TMDS panel
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 3) ... found TMDS panel
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Parsing EDID data for panel info
Setting up default mode based on panel info
radeonfb (0000:04:00.0): ATI Radeon >P
radeonfb_pci_register END

Another information which may be useful:

* 'dmesg' before 'modprobe radeonfb':

Linux version 2.6.11 (root@host) (gcc version 3.4.2 20041017 (Red Hat 
3.4.2-6.fc3)) #5 SMP Mon Mar 21 08:36:08 MSK 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffbe000 (ACPI data)
 BIOS-e820: 000000003ffbe000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
255MB HIGHMEM available.
768MB LOWMEM available.
found SMP MP-table at 000ff780
DMI 2.3 present.
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: BASIC        APIC at: 0xFEE00000
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 40000000 (gap: 40000000:bfb80000)
Built 1 zonelists
Kernel command line: ro root=/dev/sda5 noapic vmalloc=256M pci=usepirqmask
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3212.211 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035536k/1048256k available (1535k kernel code, 11860k reserved, 
727k data, 168k init, 261824k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 04
per-CPU timeslice cutoff: 2925.04 usecs.
task migration cache decay timeout: 3 msecs.
Booting processor 1/1 eip 2000
Initializing CPU#1
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 04
Total of 2 processors activated (12746.75 BogoMIPS).
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/2640] at 0000:00:1f.0
PCI: Found IRQ 10 for device 0000:00:01.0
PCI: Sharing IRQ 10 with 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:00:1c.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:04:00.0
PCI: Found IRQ 5 for device 0000:00:1c.1
PCI: Sharing IRQ 5 with 0000:02:00.0
PCI: Found IRQ 5 for device 0000:00:1f.1
PCI: Sharing IRQ 5 with 0000:00:1d.2
PCI: Found IRQ 10 for device 0000:00:1f.3
PCI: Sharing IRQ 10 with 0000:00:1d.1
PCI: Sharing IRQ 10 with 0000:00:1f.2
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
PCI: Found IRQ 10 for device 0000:00:01.0
PCI: Sharing IRQ 10 with 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:00:1c.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:04:00.0
assign_interrupt_mode Found MSI capability
PCI: Found IRQ 10 for device 0000:00:1c.0
PCI: Sharing IRQ 10 with 0000:00:01.0
PCI: Sharing IRQ 10 with 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:04:00.0
assign_interrupt_mode Found MSI capability
PCI: Found IRQ 5 for device 0000:00:1c.1
PCI: Sharing IRQ 5 with 0000:02:00.0
assign_interrupt_mode Found MSI capability
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
PCI: Found IRQ 5 for device 0000:00:1f.1
PCI: Sharing IRQ 5 with 0000:00:1d.2
ICH6: chipset revision 3
ICH6: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
hda: PLEXTOR DVDR PX-712A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
PCI: Found IRQ 10 for device 0000:00:1f.2
PCI: Sharing IRQ 10 with 0000:00:1d.1
PCI: Sharing IRQ 10 with 0000:00:1f.3
ata1: SATA max UDMA/133 cmd 0xAC00 ctl 0xA882 bmdma 0xA400 irq 10
ata2: SATA max UDMA/133 cmd 0xA800 ctl 0xA482 bmdma 0xA408 irq 10
ATA: abnormal status 0x7F on port 0xAC07
ata1: disabling port
scsi0 : ata_piix
ata2: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host1/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
IPv4 over IPv4 tunneling driver
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Starting balanced_irq
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 168k freed

(Huge output produced by modules loading skipped).

lcpci -vv output:

04:00.0 VGA compatible controller: ATI Technologies Inc RV380 0x3e50 
[Radeon X600] (prog-if 00 [VGA])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 0020
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 04
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at e000 [size=256]
        Region 2: Memory at d7fe0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at d7fc0000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Express Endpoint IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag+
                Device: Latency L0s <128ns, L1 <2us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, 
Port 0
                Link: Latency L0s <128ns, L1 <1us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x16
        Capabilities: [80] Message Signalled Interrupts: 64bit+ 
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

04:00.1 Display controller: ATI Technologies Inc: Unknown device 3e70
        Subsystem: ASUSTeK Computer Inc.: Unknown device 0021
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 04
        Region 0: Memory at d7ff0000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Express Endpoint IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag-
                Device: Latency L0s <128ns, L1 <2us
                Device: AtnBtn- AtnInd- PwrInd-
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, 
Port 0
                Link: Latency L0s <128ns, L1 <1us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed 2.5Gb/s, Width x16

X output (captured on 2.6.10, ATI's proprietary driver version 8.10.19):

X Window System Version 6.8.1
Release Date: 17 September 2004
X Protocol Version 11, Revision 0, Release 6.8.1
Build Operating System: Linux 2.4.21-14.ELsmp i686 [ELF]
Current Operating System: Linux host 2.6.10 #5 SMP Thu Jan 27 21:19:20 
MSK 2005 i686
Build Date: 20 October 2004
Build Host: tweety.build.redhat.com
 
        Before reporting problems, check http://wiki.X.Org
        to make sure that you have the latest version.
Module Loader present
OS Kernel: Linux version 2.6.10 (root@host) (gcc version 3.4.2 20041017 
(Red Hat 3.4.2-6.fc3))
#5 SMP Thu Jan 27 21:19:20 MSK 2005 P
Markers: (--) probed, (**) from config file, (==) default setting,
        (++) from command line, (!!) notice, (II) informational,
        (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/Xorg.0.log", Time: Mon Mar 21 09:21:14 2005
(==) Using config file: "/etc/X11/xorg.conf"
(==) ServerLayout "Default Layout"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "ATI Graphics Adapter"
(**) |-->Input Device "Mouse0"
(**) |-->Input Device "Keyboard0"
(**) FontPath set to "unix/:7100"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(WW) Open APM failed (/dev/apm_bios) (No such file or directory)
(II) Module ABI versions:
        X.Org ANSI C Emulation: 0.2
        X.Org Video Driver: 0.7
        X.Org XInput driver : 0.4
        X.Org Server Extension : 0.2
        X.Org Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        Module class: X.Org Font Renderer
        ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        ABI class: X.Org Video Driver, version 0.7
(--) using VT number 7

(II) PCI: Probing config type using method 1
(II) PCI: Config type is 1
(II) PCI: stages = 0x03, oldVal1 = 0x00000000, mode1Res1 = 0x80000000
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 8086,2580 card 8086,2580 rev 04 class 06,00,00 
hdr 00
(II) PCI: 00:01:0: chip 8086,2581 card 0000,0000 rev 04 class 06,04,00 
hdr 01
(II) PCI: 00:1b:0: chip 8086,2668 card 1043,814e rev 03 class 04,03,00 
hdr 00
(II) PCI: 00:1c:0: chip 8086,2660 card 0000,0000 rev 03 class 06,04,00 
hdr 81
(II) PCI: 00:1c:1: chip 8086,2662 card 0000,0000 rev 03 class 06,04,00 
hdr 81
(II) PCI: 00:1d:0: chip 8086,2658 card 1043,80a6 rev 03 class 0c,03,00 
hdr 80
(II) PCI: 00:1d:1: chip 8086,2659 card 1043,80a6 rev 03 class 0c,03,00 
hdr 00
(II) PCI: 00:1d:2: chip 8086,265a card 1043,80a6 rev 03 class 0c,03,00 
hdr 00
(II) PCI: 00:1d:3: chip 8086,265b card 1043,80a6 rev 03 class 0c,03,00 
hdr 00
(II) PCI: 00:1d:7: chip 8086,265c card 1043,80a6 rev 03 class 0c,03,20 
hdr 00
(II) PCI: 00:1e:0: chip 8086,244e card 0000,0000 rev d3 class 06,04,01 
hdr 01
(II) PCI: 00:1f:0: chip 8086,2640 card 0000,0000 rev 03 class 06,01,00 
hdr 80
(II) PCI: 00:1f:1: chip 8086,266f card 1043,80a6 rev 03 class 01,01,8a 
hdr 00
(II) PCI: 00:1f:2: chip 8086,2652 card 1043,2601 rev 03 class 01,01,8f 
hdr 00
(II) PCI: 00:1f:3: chip 8086,266a card 1043,80a6 rev 03 class 0c,05,00 
hdr 00
(II) PCI: 02:00:0: chip 11ab,4362 card 1043,8142 rev 15 class 02,00,00 
hdr 00
(II) PCI: 04:00:0: chip 1002,3e50 card 1043,0020 rev 00 class 03,00,00 
hdr 80
(II) PCI: 04:00:1: chip 1002,3e70 card 1043,0021 rev 00 class 03,80,00 
hdr 00
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,4), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
        [0] -1        0        0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
        [0] -1        0        0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
        [0] -1        0        0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 4: bridge is at (0:1:0), (0,4,4), BCTRL: 0x000a (VGA_EN is set)
(II) Bus 4 I/O range:
        [0] -1        0        0x0000e000 - 0x0000efff (0x1000) IX[B]
(II) Bus 4 non-prefetchable memory range:
        [0] -1        0        0xd7f00000 - 0xd7ffffff (0x100000) MX[B]
(II) Bus 4 prefetchable memory range:
        [0] -1        0        0xd8000000 - 0xdfffffff (0x8000000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 3: bridge is at (0:28:0), (0,3,3), BCTRL: 0x0002 (VGA_EN is 
cleared)
(II) Bus 3 I/O range:
        [0] -1        0        0x0000d000 - 0x0000dfff (0x1000) IX[B]
(II) PCI-to-PCI bridge:
(II) Bus 2: bridge is at (0:28:1), (0,2,2), BCTRL: 0x0002 (VGA_EN is 
cleared)
(II) Bus 2 I/O range:
        [0] -1        0        0x0000c000 - 0x0000cfff (0x1000) IX[B]
(II) Bus 2 non-prefetchable memory range:
        [0] -1        0        0xd7e00000 - 0xd7efffff (0x100000) MX[B]
(II) Subtractive PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:30:0), (0,1,1), BCTRL: 0x0002 (VGA_EN is 
cleared)
(II) Bus 1 I/O range:
        [0] -1        0        0x0000b000 - 0x0000bfff (0x1000) IX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:31:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(--) PCI:*(4:0:0) ATI Technologies Inc unknown chipset (0x3e50) rev 0, 
Mem @ 0xd8000000/27, 0xd7fe0000/16, I/O @ 0xe000/8, BIOS @ 0xd7fc0000/17
(--) PCI: (4:0:1) ATI Technologies Inc unknown chipset (0x3e70) rev 0, 
Mem @ 0xd7ff0000/16
(II) Addressable bus resource ranges are
        [0] -1        0        0x00000000 - 0xffffffff (0x0) MX[B]
        [1] -1        0        0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
        [0] -1        0        0xffe00000 - 0xffffffff (0x200000) MX[B](B)
        [1] -1        0        0x00100000 - 0x3fffffff (0x3ff00000) 
MX[B]E(B)
        [2] -1        0        0x000f0000 - 0x000fffff (0x10000) MX[B]
        [3] -1        0        0x000c0000 - 0x000effff (0x30000) MX[B]
        [4] -1        0        0x00000000 - 0x0009ffff (0xa0000) MX[B]
        [5] -1        0        0x0000ffff - 0x0000ffff (0x1) IX[B]
        [6] -1        0        0x00000000 - 0x000000ff (0x100) IX[B]
(II) Active PCI resource ranges:
        [0] -1        0        0xd7efc000 - 0xd7efffff (0x4000) MX[B]
        [1] -1        0        0xd7dffc00 - 0xd7dfffff (0x400) MX[B]
        [2] -1        0        0xd7dff800 - 0xd7dffbff (0x400) MX[B]
        [3] -1        0        0xd7df4000 - 0xd7df7fff (0x4000) MX[B]
        [4] -1        0        0xd7ff0000 - 0xd7ffffff (0x10000) MX[B](B)
        [5] -1        0        0xd7fc0000 - 0xd7fdffff (0x20000) MX[B](B)
        [6] -1        0        0xd7fe0000 - 0xd7feffff (0x10000) MX[B](B)
        [7] -1        0        0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
        [8] -1        0        0x0000c800 - 0x0000c8ff (0x100) IX[B]
        [9] -1        0        0x00000400 - 0x0000041f (0x20) IX[B]
        [10] -1        0        0x0000a400 - 0x0000a40f (0x10) IX[B]
        [11] -1        0        0x0000a480 - 0x0000a483 (0x4) IX[B]
        [12] -1        0        0x0000a800 - 0x0000a807 (0x8) IX[B]
        [13] -1        0        0x0000a880 - 0x0000a883 (0x4) IX[B]
        [14] -1        0        0x0000ac00 - 0x0000ac07 (0x8) IX[B]
        [15] -1        0        0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
        [16] -1        0        0x0000a080 - 0x0000a09f (0x20) IX[B]
        [17] -1        0        0x0000a000 - 0x0000a01f (0x20) IX[B]
        [18] -1        0        0x00009c00 - 0x00009c1f (0x20) IX[B]
        [19] -1        0        0x00009880 - 0x0000989f (0x20) IX[B]
        [20] -1        0        0x0000e000 - 0x0000e0ff (0x100) IX[B](B)
(II) Active PCI resource ranges after removing overlaps:
        [0] -1        0        0xd7efc000 - 0xd7efffff (0x4000) MX[B]
        [1] -1        0        0xd7dffc00 - 0xd7dfffff (0x400) MX[B]
        [2] -1        0        0xd7dff800 - 0xd7dffbff (0x400) MX[B]
        [3] -1        0        0xd7df4000 - 0xd7df7fff (0x4000) MX[B]
        [4] -1        0        0xd7ff0000 - 0xd7ffffff (0x10000) MX[B](B)
        [5] -1        0        0xd7fc0000 - 0xd7fdffff (0x20000) MX[B](B)
        [6] -1        0        0xd7fe0000 - 0xd7feffff (0x10000) MX[B](B)
        [7] -1        0        0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
        [8] -1        0        0x0000c800 - 0x0000c8ff (0x100) IX[B]
        [9] -1        0        0x00000400 - 0x0000041f (0x20) IX[B]
        [10] -1        0        0x0000a400 - 0x0000a40f (0x10) IX[B]
        [11] -1        0        0x0000a480 - 0x0000a483 (0x4) IX[B]
        [12] -1        0        0x0000a800 - 0x0000a807 (0x8) IX[B]
        [13] -1        0        0x0000a880 - 0x0000a883 (0x4) IX[B]
        [14] -1        0        0x0000ac00 - 0x0000ac07 (0x8) IX[B]
        [15] -1        0        0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
        [16] -1        0        0x0000a080 - 0x0000a09f (0x20) IX[B]
        [17] -1        0        0x0000a000 - 0x0000a01f (0x20) IX[B]
        [18] -1        0        0x00009c00 - 0x00009c1f (0x20) IX[B]
        [19] -1        0        0x00009880 - 0x0000989f (0x20) IX[B]
        [20] -1        0        0x0000e000 - 0x0000e0ff (0x100) IX[B](B)
(II) OS-reported resource ranges after removing overlaps with PCI:
        [0] -1        0        0xffe00000 - 0xffffffff (0x200000) MX[B](B)
        [1] -1        0        0x00100000 - 0x3fffffff (0x3ff00000) 
MX[B]E(B)
        [2] -1        0        0x000f0000 - 0x000fffff (0x10000) MX[B]
        [3] -1        0        0x000c0000 - 0x000effff (0x30000) MX[B]
        [4] -1        0        0x00000000 - 0x0009ffff (0xa0000) MX[B]
        [5] -1        0        0x0000ffff - 0x0000ffff (0x1) IX[B]
        [6] -1        0        0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
        [0] -1        0        0xffe00000 - 0xffffffff (0x200000) MX[B](B)
        [1] -1        0        0x00100000 - 0x3fffffff (0x3ff00000) 
MX[B]E(B)
        [2] -1        0        0x000f0000 - 0x000fffff (0x10000) MX[B]
        [3] -1        0        0x000c0000 - 0x000effff (0x30000) MX[B]
        [4] -1        0        0x00000000 - 0x0009ffff (0xa0000) MX[B]
        [5] -1        0        0xd7efc000 - 0xd7efffff (0x4000) MX[B]
        [6] -1        0        0xd7dffc00 - 0xd7dfffff (0x400) MX[B]
        [7] -1        0        0xd7dff800 - 0xd7dffbff (0x400) MX[B]
        [8] -1        0        0xd7df4000 - 0xd7df7fff (0x4000) MX[B]
        [9] -1        0        0xd7ff0000 - 0xd7ffffff (0x10000) MX[B](B)
        [10] -1        0        0xd7fc0000 - 0xd7fdffff (0x20000) MX[B](B)
        [11] -1        0        0xd7fe0000 - 0xd7feffff (0x10000) MX[B](B)
        [12] -1        0        0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
        [13] -1        0        0x0000ffff - 0x0000ffff (0x1) IX[B]
        [14] -1        0        0x00000000 - 0x000000ff (0x100) IX[B]
        [15] -1        0        0x0000c800 - 0x0000c8ff (0x100) IX[B]
        [16] -1        0        0x00000400 - 0x0000041f (0x20) IX[B]
        [17] -1        0        0x0000a400 - 0x0000a40f (0x10) IX[B]
        [18] -1        0        0x0000a480 - 0x0000a483 (0x4) IX[B]
        [19] -1        0        0x0000a800 - 0x0000a807 (0x8) IX[B]
        [20] -1        0        0x0000a880 - 0x0000a883 (0x4) IX[B]
        [21] -1        0        0x0000ac00 - 0x0000ac07 (0x8) IX[B]
        [22] -1        0        0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
        [23] -1        0        0x0000a080 - 0x0000a09f (0x20) IX[B]
        [24] -1        0        0x0000a000 - 0x0000a01f (0x20) IX[B]
        [25] -1        0        0x00009c00 - 0x00009c1f (0x20) IX[B]
        [26] -1        0        0x00009880 - 0x0000989f (0x20) IX[B]
        [27] -1        0        0x0000e000 - 0x0000e0ff (0x100) IX[B](B)
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        Module class: X.Org Server Extension
        ABI class: X.Org Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        Module class: X.Org Server Extension
        ABI class: X.Org Server Extension, version 0.2
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "fbdevhw"
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 0.0.2
        ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        ABI class: X.Org Server Extension, version 0.2
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        ABI class: X.Org Server Extension, version 0.2
(II) Loading extension GLX
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.13.0
        Module class: X.Org Server Extension
        ABI class: X.Org Server Extension, version 0.2
(II) Loading extension RECORD
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.so
(II) Module freetype: vendor="X.Org Foundation & the After X-TT Project"
        compiled for 6.8.1, module version = 2.1.0
        Module class: X.Org Font Renderer
        ABI class: X.Org Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.2
        Module class: X.Org Font Renderer
        ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        ABI class: X.Org Server Extension, version 0.2
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        ABI class: X.Org Server Extension, version 0.2
(II) Loading extension XFree86-DRI
(II) LoadModule: "fglrx"
(II) Loading /usr/X11R6/lib/modules/drivers/fglrx_drv.o
(II) Module fglrx: vendor="FireGL - ATI Technologies Inc."
        compiled for 4.3.99.902, module version = 8.10.19
        Module class: X.Org Video Driver
        ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        Module class: X.Org XInput Driver
        ABI class: X.Org XInput driver, version 0.4
(II) LoadModule: "kbd"
(II) Loading /usr/X11R6/lib/modules/input/kbd_drv.o
(II) Module kbd: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        Module class: X.Org XInput Driver
        ABI class: X.Org XInput driver, version 0.4
(II) ATI Radeon/FireGL: The following chipsets are supported:
        RADEON 9000/9000 PRO (RV250 4966), RADEON 9000 LE (RV250 4967),
        MOBILITY FireGL 9000 (M9 4C64), MOBILITY RADEON 9000 (M9 4C66),
        RADEON 9000 PRO (D9 4C67), RADEON 9250 (RV280 5960),
        RADEON 9200 (RV280 5961), RADEON 9200 SE (RV280 5964),
        MOBILITY RADEON 9200 (M9+ 5C61), MOBILITY RADEON 9200 (M9+ 5C63),
        FireGL 8800 (R200 5148), RADEON 8500 (R200 514C),
        RADEON 9100 (R200 514D), RADEON 8500 AIW (R200 4242),
        RADEON 9600 (RV350 4150), RADEON 9600 SE (RV350 4151),
        RADEON 9600 PRO (RV360 4152),
        MOBILITY RADEON 9600/9700 (M10/M11 4E50), RADEON 9500 (R300 4144),
        RADEON 9600 TX (R300 4146), FireGL Z1 (R300 4147),
        RADEON 9700 PRO (R300 4E44), RADEON 9500 PRO/9700 (R300 4E45),
        RADEON 9600 TX (R300 4E46), FireGL X1 (R300 4E47),
        RADEON 9800 SE (R350 4148), RADEON 9550 (RV350 4153),
        FireGL T2 (RV350 4154), RADEON 9800 PRO (R350 4E48),
        RADEON 9800 (R350 4E49), RADEON 9800 XT (R360 4E4A),
        FireGL X2-256/X2-256t (R350 4E4B),
        MOBILITY FireGL T2/T2e (M10/M11 4E54), RADEON X300 (RV370 5B60),
        RADEON X600 (RV380 5B62), FireGL V3100 (RV370 5B64),
        MOBILITY RADEON X300 (M22 5460), MOBILITY FireGL V3100 (M22 5464),
        RADEON X600 (RV380 3E50), FireGL V3200* (RV380 3E54),
        MOBILITY RADEON X600 (M24 3150), MOBILITY RADEON X300 (M22 3152),
        MOBILITY FireGL V3200 (M24 3154), RADEON X800 (R420 4A48),
        RADEON X800 PRO (R420 4A49), RADEON X800 SE (R420 4A4A),
        RADEON X800 XT (R420 4A4B), RADEON X800 (R420 4A4C),
        FireGL X3-256 (R420 4A4D), MOBILITY RADEON 9800 (M18 4A4E),
        RADEON X800 XT Platinum Edition (R420 4A50), RADEON X800 (R423 
5548),
        RADEON X800 PRO (R423 5549),
        RADEON X800 XT Platinum Edition (R423 554A),
        RADEON X800 SE (R423 554B), RADEON X800 XT (R423 5D57),
        FireGL V7100 (R423 5550), FireGL V5100 (R423 5551),
        MOBILITY RADEON X800 XT (M28 5D48),
        MOBILITY FireGL V5100* (M28 5D49), FireGL V5000 (RV410 5E48),
        RADEON X700 XT (RV410 5E4A), RADEON X700 PRO (RV410 5E4B),
        RADEON X700 SE (RV410 5E4C), RADEON X700 (RV410 5E4D),
        RADEON X700 (RV410 5E4F), RADEON 9100 IGP (RS300 5834),
        RADEON 9000 PRO/9100 PRO IGP (RS350 7834),
        MOBILITY RADEON 9000/9100 IGP (RS300M 5835)
(II) Primary Device is: PCI 04:00:0
(WW) fglrx: No matching Device section for instance (BusID PCI:4:0:1) found
(--) Chipset RADEON X600 (RV380 3E50) found
(II) resource ranges after xf86ClaimFixedResources() call:
        [0] -1        0        0xffe00000 - 0xffffffff (0x200000) MX[B](B)
        [1] -1        0        0x00100000 - 0x3fffffff (0x3ff00000) 
MX[B]E(B)
        [2] -1        0        0x000f0000 - 0x000fffff (0x10000) MX[B]
        [3] -1        0        0x000c0000 - 0x000effff (0x30000) MX[B]
        [4] -1        0        0x00000000 - 0x0009ffff (0xa0000) MX[B]
        [5] -1        0        0xd7efc000 - 0xd7efffff (0x4000) MX[B]
        [6] -1        0        0xd7dffc00 - 0xd7dfffff (0x400) MX[B]
        [7] -1        0        0xd7dff800 - 0xd7dffbff (0x400) MX[B]
        [8] -1        0        0xd7df4000 - 0xd7df7fff (0x4000) MX[B]
        [9] -1        0        0xd7ff0000 - 0xd7ffffff (0x10000) MX[B](B)
        [10] -1        0        0xd7fc0000 - 0xd7fdffff (0x20000) MX[B](B)
        [11] -1        0        0xd7fe0000 - 0xd7feffff (0x10000) MX[B](B)
        [12] -1        0        0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
        [13] -1        0        0x0000ffff - 0x0000ffff (0x1) IX[B]
        [14] -1        0        0x00000000 - 0x000000ff (0x100) IX[B]
        [15] -1        0        0x0000c800 - 0x0000c8ff (0x100) IX[B]
        [16] -1        0        0x00000400 - 0x0000041f (0x20) IX[B]
        [17] -1        0        0x0000a400 - 0x0000a40f (0x10) IX[B]
        [18] -1        0        0x0000a480 - 0x0000a483 (0x4) IX[B]
        [19] -1        0        0x0000a800 - 0x0000a807 (0x8) IX[B]
        [20] -1        0        0x0000a880 - 0x0000a883 (0x4) IX[B]
        [21] -1        0        0x0000ac00 - 0x0000ac07 (0x8) IX[B]
        [22] -1        0        0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
        [23] -1        0        0x0000a080 - 0x0000a09f (0x20) IX[B]
        [24] -1        0        0x0000a000 - 0x0000a01f (0x20) IX[B]
        [25] -1        0        0x00009c00 - 0x00009c1f (0x20) IX[B]
        [26] -1        0        0x00009880 - 0x0000989f (0x20) IX[B]
        [27] -1        0        0x0000e000 - 0x0000e0ff (0x100) IX[B](B)
(II) fglrx(0): pEnt->device->identifier=0x820aa50
(II) resource ranges after probing:
        [0] -1        0        0xffe00000 - 0xffffffff (0x200000) MX[B](B)
        [1] -1        0        0x00100000 - 0x3fffffff (0x3ff00000) 
MX[B]E(B)
        [2] -1        0        0x000f0000 - 0x000fffff (0x10000) MX[B]
        [3] -1        0        0x000c0000 - 0x000effff (0x30000) MX[B]
        [4] -1        0        0x00000000 - 0x0009ffff (0xa0000) MX[B]
        [5] -1        0        0xd7efc000 - 0xd7efffff (0x4000) MX[B]
        [6] -1        0        0xd7dffc00 - 0xd7dfffff (0x400) MX[B]
        [7] -1        0        0xd7dff800 - 0xd7dffbff (0x400) MX[B]
        [8] -1        0        0xd7df4000 - 0xd7df7fff (0x4000) MX[B]
        [9] -1        0        0xd7ff0000 - 0xd7ffffff (0x10000) MX[B](B)
        [10] -1        0        0xd7fc0000 - 0xd7fdffff (0x20000) MX[B](B)
        [11] -1        0        0xd7fe0000 - 0xd7feffff (0x10000) MX[B](B)
        [12] -1        0        0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
        [13] 0        0        0x000a0000 - 0x000affff (0x10000) MS[B]
        [14] 0        0        0x000b0000 - 0x000b7fff (0x8000) MS[B]
        [15] 0        0        0x000b8000 - 0x000bffff (0x8000) MS[B]
        [16] -1        0        0x0000ffff - 0x0000ffff (0x1) IX[B]
        [17] -1        0        0x00000000 - 0x000000ff (0x100) IX[B]
        [18] -1        0        0x0000c800 - 0x0000c8ff (0x100) IX[B]
        [19] -1        0        0x00000400 - 0x0000041f (0x20) IX[B]
        [20] -1        0        0x0000a400 - 0x0000a40f (0x10) IX[B]
        [21] -1        0        0x0000a480 - 0x0000a483 (0x4) IX[B]
        [22] -1        0        0x0000a800 - 0x0000a807 (0x8) IX[B]
        [23] -1        0        0x0000a880 - 0x0000a883 (0x4) IX[B]
        [24] -1        0        0x0000ac00 - 0x0000ac07 (0x8) IX[B]
        [25] -1        0        0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
        [26] -1        0        0x0000a080 - 0x0000a09f (0x20) IX[B]
        [27] -1        0        0x0000a000 - 0x0000a01f (0x20) IX[B]
        [28] -1        0        0x00009c00 - 0x00009c1f (0x20) IX[B]
        [29] -1        0        0x00009880 - 0x0000989f (0x20) IX[B]
        [30] -1        0        0x0000e000 - 0x0000e0ff (0x100) IX[B](B)
        [31] 0        0        0x000003b0 - 0x000003bb (0xc) IS[B]
        [32] 0        0        0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) fglrx(0): === [R200PreInit] === begin, [s]
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 0.1.0
        ABI class: X.Org Video Driver, version 0.7
(II) fglrx(0): PCI bus 4 card 0 func 0
(**) fglrx(0): Depth 24, (--) framebuffer bpp 32
(II) fglrx(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) fglrx(0): Default visual is TrueColor
(**) fglrx(0): Option "NoAccel" "no"
(**) fglrx(0): Option "NoDRI" "no"
(**) fglrx(0): Option "Capabilities" "0x00000000"
(**) fglrx(0): Option "GammaCorrectionI" "0x00000000"
(**) fglrx(0): Option "GammaCorrectionII" "0x00000000"
(**) fglrx(0): Option "OpenGLOverlay" "off"
(**) fglrx(0): Option "VideoOverlay" "on"
(**) fglrx(0): Option "DesktopSetup" "0x00000000"
(**) fglrx(0): Option "MonitorLayout" "AUTO, AUTO"
(**) fglrx(0): Option "HSync2" "unspecified"
(**) fglrx(0): Option "VRefresh2" "unspecified"
(**) fglrx(0): Option "ScreenOverlap" "0"
(**) fglrx(0): Option "IgnoreEDID" "off"
(**) fglrx(0): Option "UseInternalAGPGART" "yes"
(**) fglrx(0): Option "Stereo" "off"
(**) fglrx(0): Option "StereoSyncEnable" "1"
(**) fglrx(0): Option "UseFastTLS" "0"
(**) fglrx(0): Option "BlockSignalsOnLock" "on"
(**) fglrx(0): Option "ForceGenericCPU" "no"
(**) fglrx(0): Option "CenterMode" "off"
(**) fglrx(0): Option "FSAAScale" "1"
(**) fglrx(0): Option "FSAAEnable" "no"
(**) fglrx(0): Option "FSAADisableGamma" "no"
(**) fglrx(0): Option "FSAACustomizeMSPos" "no"
(**) fglrx(0): Option "FSAAMSPosX0" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY0" "0.000000"
(**) fglrx(0): Option "FSAAMSPosX1" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY1" "0.000000"
(**) fglrx(0): Option "FSAAMSPosX2" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY2" "0.000000"
(**) fglrx(0): Option "FSAAMSPosX3" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY3" "0.000000"
(**) fglrx(0): Option "FSAAMSPosX4" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY4" "0.000000"
(**) fglrx(0): Option "FSAAMSPosX5" "0.000000"
(**) fglrx(0): Option "FSAAMSPosY5" "0.000000"
(**) fglrx(0): Option "NoTV" "yes"
(**) fglrx(0): Option "TVStandard" "NTSC-M"
(**) fglrx(0): Option "TVHSizeAdj" "0"
(**) fglrx(0): Option "TVVSizeAdj" "0"
(**) fglrx(0): Option "TVHPosAdj" "0"
(**) fglrx(0): Option "TVVPosAdj" "0"
(**) fglrx(0): Option "TVHStartAdj" "0"
(**) fglrx(0): Option "TVColorAdj" "0"
(**) fglrx(0): Option "PseudoColorVisuals" "off"
(**) fglrx(0): Qbs disabled
(==) fglrx(0): RGB weight 888
(II) fglrx(0): Using 8 bits per RGB (8 bit DAC)
(**) fglrx(0): Gamma Correction for I is 0x00000000
(**) fglrx(0): Gamma Correction for II is 0x00000000
(==) fglrx(0): Buffer Tiling is ON
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        ABI class: X.Org Video Driver, version 0.7
(II) fglrx(0): initializing int10
(II) fglrx(0): Primary V_BIOS segment is: 0xc000
(**) fglrx(0): Option "mtrr" "off"
(--) fglrx(0): Chipset: "RADEON X600 (RV380 3E50)" (Chipset = 0x3e50)
(--) fglrx(0): (PciSubVendor = 0x1043, PciSubDevice = 0x0020)
(--) fglrx(0): board vendor info: third party grafics adapter - NOT 
original ATI
(--) fglrx(0): Linear framebuffer (phys) at 0xd8000000
(--) fglrx(0): MMIO registers at 0xd7fe0000
(--) fglrx(0): ROM-BIOS at 0xd7fc0000
(--) fglrx(0): ChipExtRevID = 0x00
(--) fglrx(0): ChipIntRevID = 0x02
(--) fglrx(0): VideoRAM: 131072 kByte (64-bit SDR SDRAM)
(WW) fglrx(0): board is an unknown third party board, chipset is supported
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        ABI class: X.Org Video Driver, version 0.7
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Loading /usr/X11R6/lib/modules/libi2c.a
(II) Module i2c: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.2.0
        ABI class: X.Org Video Driver, version 0.7
(II) fglrx(0): I2C bus "DDC" initialized.
(II) fglrx(0): Connector Layout from BIOS --------
(II) fglrx(0): Connector1: DDCType-3, DACType-0, TMDSType-0, ConnectorType-3
(II) fglrx(0): All-In-Wonder card detected
(**) fglrx(0): MonitorLayout Option:
        Monitor1--Type AUTO, Monitor2--Type AUTO

(II) fglrx(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) fglrx(0): I2C device "DDC:ddc2" removed.
(II) fglrx(0): DDC detected on DDCType 3 with Monitor Type 3
(II) fglrx(0): Primary head:
 Monitor   -- TMDS
 Connector -- DVI-I
 DAC Type  -- Primary
 TMDS Type -- Internal
 DDC Type  -- VGA_DDC
(II) fglrx(0): Secondary head:
 Monitor   -- NONE
 Connector -- None
 DAC Type  -- Unknown
 TMDS Type -- NONE
 DDC Type  -- NONE
(II) fglrx(0): EDID data from the display on Primary head ----------------
(II) fglrx(0): Manufacturer: VSC  Model: c11  Serial#: 16843009
(II) fglrx(0): Year: 2004  Week: 17
(II) fglrx(0): EDID Version: 1.3
(II) fglrx(0): Digital Display Input
(II) fglrx(0): Max H-Image Size [cm]: horiz.: 34  vert.: 27
(II) fglrx(0): Gamma: 2.20
(II) fglrx(0): DPMS capabilities: Off; RGB/Color Display
(II) fglrx(0): First detailed timing is preferred mode
(II) fglrx(0): redX: 0.640 redY: 0.340   greenX: 0.290 greenY: 0.610
(II) fglrx(0): blueX: 0.140 blueY: 0.070   whiteX: 0.310 whiteY: 0.330
(II) fglrx(0): Supported VESA Video Modes:
(II) fglrx(0): 720x400@70Hz
(II) fglrx(0): 640x480@60Hz
(II) fglrx(0): 640x480@67Hz
(II) fglrx(0): 640x480@72Hz
(II) fglrx(0): 640x480@75Hz
(II) fglrx(0): 800x600@56Hz
(II) fglrx(0): 800x600@60Hz
(II) fglrx(0): 800x600@72Hz
(II) fglrx(0): 800x600@75Hz
(II) fglrx(0): 832x624@75Hz
(II) fglrx(0): 1024x768@60Hz
(II) fglrx(0): 1024x768@70Hz
(II) fglrx(0): 1024x768@75Hz
(II) fglrx(0): 1280x1024@75Hz
(II) fglrx(0): 1152x870@75Hz
(II) fglrx(0): Manufacturer's mask: 0
(II) fglrx(0): Supported Future Video Modes:
(II) fglrx(0): #0: hsize: 1280  vsize 1024  refresh: 60  vid: 32897
(II) fglrx(0): #1: hsize: 1152  vsize 864  refresh: 75  vid: 20337
(II) fglrx(0): #2: hsize: 1024  vsize 768  refresh: 85  vid: 22881
(II) fglrx(0): #3: hsize: 800  vsize 600  refresh: 85  vid: 22853
(II) fglrx(0): #4: hsize: 640  vsize 480  refresh: 85  vid: 22833
(II) fglrx(0): #5: hsize: 640  vsize 640  refresh: 70  vid: 2609
(II) fglrx(0): Supported additional Video Mode:
(II) fglrx(0): clock: 108.0 MHz   Image Size:  338 x 270 mm
(II) fglrx(0): h_active: 1280  h_sync: 1328  h_sync_end 1440 h_blank_end 
1688 h_border: 0
(II) fglrx(0): v_active: 1024  v_sync: 1025  v_sync_end 1028 v_blanking: 
1066 v_border: 0
(II) fglrx(0): Serial No: A1U041701379
(II) fglrx(0): Ranges: V min: 50  V max: 85 Hz, H min: 30  H max: 82 
kHz, PixClock max 140 MHz
(II) fglrx(0): Monitor name: VP171b
(II) fglrx(0):
(II) fglrx(0): DesktopSetup 0x0000
(**) fglrx(0):  PseudoColor visuals disabled
(**) fglrx(0): Overlay disabled
(**) fglrx(0): Overlay disabled
(II) fglrx(0): PLL parameters: rf=2700 rd=12 min=20000 max=40000
(==) fglrx(0): Using gamma correction (1.0, 1.0, 1.0)
(**) fglrx(0): Center Mode is disabled
(==) fglrx(0): TMDS coherent mode is enabled
(II) fglrx(0): Panel size found from DDC: 1280x1024
(II) fglrx(0): Total 6 valid mode(s) found.
(--) fglrx(0): Virtual size is 1280x1024 (pitch 1280)
(**) fglrx(0): *Default mode "1280x1024": 135.0 MHz (scaled from 0.0 
MHz), 80.0 kHz, 75.0 Hz
(II) fglrx(0): Modeline "1280x1024"  135.00  1280 1296 1440 1688  1024 
1025 1028 1066 +hsync +vsync
(**) fglrx(0): *Default mode "1152x864": 108.0 MHz (scaled from 0.0 
MHz), 67.5 kHz, 75.0 Hz
(II) fglrx(0): Modeline "1152x864"  108.00  1152 1216 1344 1600  864 865 
868 900 +hsync +vsync
(**) fglrx(0): *Default mode "1024x768": 94.5 MHz (scaled from 0.0 MHz), 
68.7 kHz, 85.0 Hz
(II) fglrx(0): Modeline "1024x768"   94.50  1024 1072 1168 1376  768 769 
772 808 +hsync +vsync
(**) fglrx(0):  Default mode "832x624": 57.3 MHz (scaled from 0.0 MHz), 
49.7 kHz, 74.6 Hz
(II) fglrx(0): Modeline "832x624"   57.28  832 864 928 1152  624 625 628 
667 -hsync -vsync
(**) fglrx(0): *Default mode "800x600": 56.3 MHz (scaled from 0.0 MHz), 
53.7 kHz, 85.1 Hz
(II) fglrx(0): Modeline "800x600"   56.30  800 832 896 1048  600 601 604 
631 +hsync +vsync
(**) fglrx(0): *Default mode "640x480": 36.0 MHz (scaled from 0.0 MHz), 
43.3 kHz, 85.0 Hz
(II) fglrx(0): Modeline "640x480"   36.00  640 696 752 832  480 481 484 
509 -hsync -vsync
(**) fglrx(0): Display dimensions: (340, 270) mm
(**) fglrx(0): DPI set to (95, 96)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        ABI class: X.Org ANSI C Emulation, version 0.2
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 0.1.0
        ABI class: X.Org Video Driver, version 0.7
(**) fglrx(0): NoAccel = NO
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.2.0
        ABI class: X.Org Video Driver, version 0.7
(==) fglrx(0): HPV inactive
(==) fglrx(0): FSAA enabled: NO
(**) fglrx(0): FSAA Gamma enabled
(**) fglrx(0): FSAA Multisample Position is fix
(**) fglrx(0): NoDRI = NO
(II) Loading sub module "fglrxdrm"
(II) LoadModule: "fglrxdrm"
(II) Loading /usr/X11R6/lib/modules/linux/libfglrxdrm.a
(II) Module fglrxdrm: vendor="FireGL - ATI Technologies Inc."
        compiled for 4.3.99.902, module version = 8.10.19
        ABI class: X.Org Server Extension, version 0.2
(II) fglrx(0): Depth moves disabled by default
(**) fglrx(0): Capabilities: 0x00000000
(**) fglrx(0): cpuFlags: 0x8000001d
(**) fglrx(0): cpuSpeedMHz: 0x00000c8c
(==) fglrx(0): OpenGL ClientDriverName: "fglrx_dri.so"
(**) fglrx(0): UseFastTLS=0
(**) fglrx(0): BlockSignalsOnLock=1
(==) fglrx(0): EnablePrivateBackZ = NO
(--) Depth 24 pixmap format is 32 bpp
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
        [0] 0        0        0xd7fe0000 - 0xd7feffff (0x10000) MX[B]
        [1] 0        0        0xd8000000 - 0xdfffffff (0x8000000) MX[B]
        [2] -1        0        0xffe00000 - 0xffffffff (0x200000) MX[B](B)
        [3] -1        0        0x00100000 - 0x3fffffff (0x3ff00000) 
MX[B]E(B)
        [4] -1        0        0x000f0000 - 0x000fffff (0x10000) MX[B]
        [5] -1        0        0x000c0000 - 0x000effff (0x30000) MX[B]
        [6] -1        0        0x00000000 - 0x0009ffff (0xa0000) MX[B]
        [7] -1        0        0xd7efc000 - 0xd7efffff (0x4000) MX[B]
        [8] -1        0        0xd7dffc00 - 0xd7dfffff (0x400) MX[B]
        [9] -1        0        0xd7dff800 - 0xd7dffbff (0x400) MX[B]
        [10] -1        0        0xd7df4000 - 0xd7df7fff (0x4000) MX[B]
        [11] -1        0        0xd7ff0000 - 0xd7ffffff (0x10000) MX[B](B)
        [12] -1        0        0xd7fc0000 - 0xd7fdffff (0x20000) MX[B](B)
        [13] -1        0        0xd7fe0000 - 0xd7feffff (0x10000) MX[B](B)
        [14] -1        0        0xd8000000 - 0xdfffffff (0x8000000) MX[B](B)
        [15] 0        0        0x000a0000 - 0x000affff (0x10000) MS[B]
        [16] 0        0        0x000b0000 - 0x000b7fff (0x8000) MS[B]
        [17] 0        0        0x000b8000 - 0x000bffff (0x8000) MS[B]
        [18] 0        0        0x0000e000 - 0x0000e0ff (0x100) IX[B]
        [19] -1        0        0x0000ffff - 0x0000ffff (0x1) IX[B]
        [20] -1        0        0x00000000 - 0x000000ff (0x100) IX[B]
        [21] -1        0        0x0000c800 - 0x0000c8ff (0x100) IX[B]
        [22] -1        0        0x00000400 - 0x0000041f (0x20) IX[B]
        [23] -1        0        0x0000a400 - 0x0000a40f (0x10) IX[B]
        [24] -1        0        0x0000a480 - 0x0000a483 (0x4) IX[B]
        [25] -1        0        0x0000a800 - 0x0000a807 (0x8) IX[B]
        [26] -1        0        0x0000a880 - 0x0000a883 (0x4) IX[B]
        [27] -1        0        0x0000ac00 - 0x0000ac07 (0x8) IX[B]
        [28] -1        0        0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
        [29] -1        0        0x0000a080 - 0x0000a09f (0x20) IX[B]
        [30] -1        0        0x0000a000 - 0x0000a01f (0x20) IX[B]
        [31] -1        0        0x00009c00 - 0x00009c1f (0x20) IX[B]
        [32] -1        0        0x00009880 - 0x0000989f (0x20) IX[B]
        [33] -1        0        0x0000e000 - 0x0000e0ff (0x100) IX[B](B)
        [34] 0        0        0x000003b0 - 0x000003bb (0xc) IS[B]
        [35] 0        0        0x000003c0 - 0x000003df (0x20) IS[B]
(II) fglrx(0): UMM area:     0xd8701000 (size=0x078ef000)
(II) fglrx(0): driver needs XFree86 version: 4.3.x
(WW) fglrx(0): could not detect XFree86 version (query_status=-3)
(II) Loading extension ATIFGLRXDRI
(II) fglrx(0): doing DRIScreenInit
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: Open failed
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: Open failed
drmOpenByBusid: Searching for BusID PCI:4:0:0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 5, (OK)
drmOpenByBusid: drmOpenMinor returns 5
drmOpenByBusid: drmGetBusid reports
drmOpenDevice: node name is /dev/dri/card1
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenByBusid: drmOpenMinor returns -1023
drmOpenDevice: node name is /dev/dri/card2
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenByBusid: drmOpenMinor returns -1023
drmOpenDevice: node name is /dev/dri/card3
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenByBusid: drmOpenMinor returns -1023
drmOpenDevice: node name is /dev/dri/card4
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenByBusid: drmOpenMinor returns -1023
drmOpenDevice: node name is /dev/dri/card5
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenByBusid: drmOpenMinor returns -1023
drmOpenDevice: node name is /dev/dri/card6
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenByBusid: drmOpenMinor returns -1023
drmOpenDevice: node name is /dev/dri/card7
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenByBusid: drmOpenMinor returns -1023
drmOpenDevice: node name is /dev/dri/card8
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenByBusid: drmOpenMinor returns -1023
drmOpenDevice: node name is /dev/dri/card9
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenByBusid: drmOpenMinor returns -1023
drmOpenDevice: node name is /dev/dri/card10
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenByBusid: drmOpenMinor returns -1023
drmOpenDevice: node name is /dev/dri/card11
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenByBusid: drmOpenMinor returns -1023
drmOpenDevice: node name is /dev/dri/card12
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenByBusid: drmOpenMinor returns -1023
drmOpenDevice: node name is /dev/dri/card13
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenByBusid: drmOpenMinor returns -1023
drmOpenDevice: node name is /dev/dri/card14
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: open result is -1, (No such device)
drmOpenDevice: Open failed
drmOpenByBusid: drmOpenMinor returns -1023
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 5, (OK)
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 5, (OK)
drmGetBusid returned ''
(II) fglrx(0): [drm] loaded kernel module for "fglrx" driver
(II) fglrx(0): [drm] DRM interface version 1.0
(II) fglrx(0): [drm] created "fglrx" driver at busid "PCI:4:0:0"
(II) fglrx(0): [drm] added 8192 byte SAREA at 0xf087e000
(II) fglrx(0): [drm] mapped SAREA 0xf087e000 to 0xb7eaf000
(II) fglrx(0): [drm] framebuffer handle = 0xd8000000
(II) fglrx(0): [drm] added 1 reserved context for kernel
(II) fglrx(0): DRIScreenInit done
(II) fglrx(0): Kernel Module Version Information:
(II) fglrx(0):     Name: fglrx
(II) fglrx(0):     Version: 8.10.19
(II) fglrx(0):     Date: Feb  9 2005
(II) fglrx(0):     Desc: ATI FireGL DRM kernel module
(II) fglrx(0): Kernel Module version matches driver.
(II) fglrx(0): Kernel Module Build Time Information:
(II) fglrx(0):     Build-Kernel UTS_RELEASE:        2.6.10
(II) fglrx(0):     Build-Kernel MODVERSIONS:        no
(II) fglrx(0):     Build-Kernel __SMP__:            no
(II) fglrx(0):     Build-Kernel PAGE_SIZE:          0x1000
(II) fglrx(0): [drm] register handle = 0xd7fe0000
(II) fglrx(0): [drm] ATIGART Table handle = 0xdfff0000
(II) fglrx(0): [pcie] 65536 kB allocated with handle 0x00000000
(II) fglrx(0): [drm] ringbuffer size = 0x00100000 bytes
(WW) fglrx(0): [drm] using DRM defaults (QS_ID=9650ffff)
(II) fglrx(0): [drm] DRM buffer queue setup: nbufs = 100 bufsize = 28672
(II) fglrx(0): [drm] texture shared area handle = 0xf8eaf000
(II) fglrx(0): shared FSAAScale=1
(II) fglrx(0): DRI initialization successfull!
(II) fglrx(0): FBADPhys: 0xd8000000 FBMappedSize: 0x00701000
(II) fglrx(0): ----------------------------------
(II) fglrx(0): | panel native mode is 1280x1024 |
(II) fglrx(0): ----------------------------------
(II) fglrx(0): FBMM initialized for area (0,0)-(1280,1434)
(II) fglrx(0): FBMM auto alloc for area (0,0)-(1280,1024) (front color 
buffer - assumption)
(==) fglrx(0): Backing store disabled
(==) fglrx(0): Silken mouse enabled
(II) fglrx(0): Using hardware cursor (scanline 1024)
(II) fglrx(0): Largest offscreen area available: 1280 x 402
(**) Option "dpms"
(**) fglrx(0): DPMS enabled
(II) fglrx(0): Using XFree86 Acceleration Architecture (XAA)
        Screen to screen bit blits
        Solid filled rectangles
        8x8 mono pattern filled rectangles
        Solid Lines
        Dashed Lines
        Offscreen Pixmaps
        Setting up tile and stipple cache:
                30 128x128 slots
(II) fglrx(0): Acceleration enabled
(II) fglrx(0): X context handle = 0x00000001
(II) fglrx(0): [DRI] installation complete
(II) fglrx(0): Direct rendering enabled
(**) fglrx(0): Video overlay enabled on CRTC1
(II) Loading extension FGLRXEXTENSION
(II) Loading extension ATITVOUT
(==) RandR enabled
(II) Setting vga for screen 0.
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFIXES
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) Initializing built-in extension RANDR
(II) Initializing built-in extension COMPOSITE
(II) Initializing built-in extension DAMAGE
(II) Initializing built-in extension XEVIE
(**) Option "Protocol" "IMPS/2"
(**) Mouse0: Device: "/dev/input/mice"
(**) Mouse0: Protocol: "IMPS/2"
(**) Option "CorePointer"
(**) Mouse0: Core Pointer
(**) Option "Device" "/dev/input/mice"
(**) Option "Emulate3Buttons" "yes"
(**) Mouse0: Emulate3Buttons, Emulate3Timeout: 50
(**) Option "ZAxisMapping" "4 5"
(**) Mouse0: ZAxisMapping: buttons 4 and 5
(**) Mouse0: Buttons: 5
(**) Option "CoreKeyboard"
(**) Keyboard0: Core Keyboard
(**) Option "Protocol" "standard"
(**) Keyboard0: Protocol: standard
(**) Option "AutoRepeat" "500 30"
(**) Option "XkbRules" "xfree86"
(**) Keyboard0: XkbRules: "xfree86"
(**) Option "XkbModel" "pc104"
(**) Keyboard0: XkbModel: "pc104"
(**) Option "XkbLayout" "ru(phonetic)"
(**) Keyboard0: XkbLayout: "ru(phonetic)"
(**) Option "XkbOptions" "grp:shift_toggle"
(**) Keyboard0: XkbOptions: "grp:shift_toggle"
(**) Option "XkbSymbols" "en_US(pc104)+ru(phonetic)+group(shift_toggle)"
(**) Keyboard0: XkbSymbols: "en_US(pc104)+ru(phonetic)+group(shift_toggle)"
(**) Option "CustomKeycodes" "off"
(**) Keyboard0: CustomKeycodes disabled
(II) XINPUT: Adding extended input device "Keyboard0" (type: KEYBOARD)
(II) XINPUT: Adding extended input device "Mouse0" (type: MOUSE)
(II) Mouse0: ps2EnableDataReporting: succeeded

The host OS is Fedora Core 3. Hardware is:
 - MB Asus P5GD1
 - CPU Intel P4 3.2 GHz
 - Video Asus EAX600XT/HTVD (PCIE)

According to http://kerneltrap.org/mailarchive/1/message/28472/thread, 
I've also
tried both built-in and modular versions with non-default 'default_dynclk'
(-1, 0 and 1), but this was a no-op in my case.

Dmitry

