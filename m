Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265483AbTF3RN4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 13:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265538AbTF3RN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 13:13:56 -0400
Received: from ns.mock.com ([209.157.146.194]:52161 "EHLO mail.mock.com")
	by vger.kernel.org with ESMTP id S265483AbTF3RNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 13:13:43 -0400
Message-Id: <5.1.0.14.2.20030630101734.03daddc0@mail.mock.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 30 Jun 2003 10:28:03 -0700
To: linux-kernel@vger.kernel.org
From: Jeff Mock <jeff-ml@mock.com>
Subject: Re: PROBLEM: 2.4.21 ICH5 SATA related hang during boot
In-Reply-To: <5.1.0.14.2.20030629135412.03c1d940@mail.mock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-DCC-meer-Metrics: wobble.mock.com 1035; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried 2.4.21-ac4 to see if there were any ICH5-SATA related
changes.  2.4.21-ac4 does not seem to find the ICH5-SATA controller
or probe the SATA drives, (problems with ICH5-SATA on 2.4.21 are
described below).

Does anyone know what's up with SATA support on ICH5?

thanks,
jeff


At 03:37 PM 6/29/2003 -0700, Jeff Mock wrote:

>I'm running a 2.4.21 kernel on a redhat 9.0 system.
>
>I'm having a problem when using serial ATA drives on an Intel 875P/ICH5
>motherboard where the kernel will hang at approximately the same place
>in the boot process about 25% of the time.
>
>
>
>My system is an Intel P4 motherboard with 875P and an ICH5.  The BIOS
>setting for the disk drives is "enhanced" mode.  The /boot partition is
>on a parallel ATA drive (/dev/hda).
>
>There are two Maxtor SATA drives (6Y120M0) connected to the two SATA
>ports on the motherboard.  These are /dev/hde and /dev/hdg.
>
>The two SATA drives are a software raid0, the root filesystem is on
>/dev/md0 on the two SATA drives.
>
>So, about 75% percent of the time it works great, seems very reliable, but
>I've only been playing with these SATA drives for a few days.
>No anomalous behavior once it boots.
>
>About 25% of the time it will crash, no fatal message, console messages
>stop, and no response to keyboard input.  The crash happens like this:
>
>    Machine boots from grub on /boot partition of PATA drive
>
>    Kernel correctly identifies PATA drive and PATA CDROMs
>
>    Kernel correctly identifies ICH5 SATA drives and reads partition
>    information
>
>    Kernel starts md0
>
>    Kernel starts executing /etc/rc.d/rc.sysinit from root partition on
>    /dev/md0 using the two SATA drives.
>
>    The last console message is either
>         Checking filesystems (or)
>         Mounting local filesystems (or)
>         Enabling local filesystem quotas
>
>This seems kind of weird to me, because the SATA drives are working,
>the root filesystem is mounted and the startup shell script is running
>from it, but it hangs because of something going on at this point
>in rc.sysinit I think.
>
>It seems to get "stuck" in the non-working mode and a crashing boot is
>more likely to be followed by another crashing boot.
>
>It also seems that this crash happens if I boot with a root filesystem
>on the PATA drive.  The cause of the crash seems related to the kernel
>just finding an SATA drive.  If I remove the SATA drives, I don't see
>this crash.  For the crash to happen, the kernel has to find SATA
>drives:
>
>      ICH5-SATA: IDE controller at PCI slot 00:1f.2
>      ICH5-SATA: chipset revision 2
>      ICH5-SATA: 100% native mode on irq 18
>          ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:DMA, hdf:pio
>          ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:DMA, hdh:pio
>
>
>Below are the messages from a typical boot.
>
>thanks,
>
>jeff
>
>
>---------------------------------------------
>
>
>4): idx=8 mapped at ffff6000
>__va_range(0x7ff34450, 0x40): idx=8 mapped at ffff6000
>ACPI table found: WDDT v1 [INTEL  OEMWDDT  0.1]
>ACPI: Unsupported table WDDT
>Enabling the CPU's according to the ACPI table
>Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
>OEM ID:  Product ID: Canterwood-P APIC at: 0xFEE00000
>I/O APIC #2 Version 32 at 0xFEC00000.
>Enabling APIC mode: Flat.       Using 1 I/O APICs
>Processors: 2
>Kernel command line: ro root=/dev/md0 hdc=ide-scsi hdd=ide-scsi
>ide_setup: hdc=ide-scsi
>ide_setup: hdd=ide-scsi
>Initializing CPU#0
>Detected 2992.566 MHz processor.
>Console: colour VGA+ 80x25
>Calibrating delay loop... 5976.88 BogoMIPS
>Memory: 2068496k/2096320k available (1384k kernel code, 27436k reserved, 
>518k data, 148k init, 1178816k highmem)
>Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
>Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
>Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
>Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
>CPU: Trace cache: 12K uops, L1 D cache: 8K
>CPU: L2 cache: 512K
>CPU: Physical Processor ID: 0
>Intel machine check architecture supported.
>Intel machine check reporting enabled on CPU#0.
>CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
>CPU:             Common caps: bfebfbff 00000000 00000000 00000000
>Enabling fast FPU save and restore... done.
>Enabling unmasked SIMD FPU exception support... done.
>Checking 'hlt' instruction... OK.
>POSIX conformance testing by UNIFIX
>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
>mtrr: detected mtrr type: Intel
>CPU: Trace cache: 12K uops, L1 D cache: 8K
>CPU: L2 cache: 512K
>CPU: Physical Processor ID: 0
>Intel machine check reporting enabled on CPU#0.
>CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
>CPU:             Common caps: bfebfbff 00000000 00000000 00000000
>CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
>per-CPU timeslice cutoff: 1462.91 usecs.
>enabled ExtINT on CPU#0
>ESR value before enabling vector: 00000000
>ESR value after enabling vector: 00000000
>Booting processor 1/1 eip 2000
>Initializing CPU#1
>masked ExtINT on CPU#1
>ESR value before enabling vector: 00000000
>ESR value after enabling vector: 00000000
>Calibrating delay loop... 5976.88 BogoMIPS
>CPU: Trace cache: 12K uops, L1 D cache: 8K
>CPU: L2 cache: 512K
>CPU: Physical Processor ID: 0
>Intel machine check reporting enabled on CPU#1.
>CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
>CPU:             Common caps: bfebfbff 00000000 00000000 00000000
>CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
>Total of 2 processors activated (11953.76 BogoMIPS).
>cpu_sibling_map[0] = 1
>cpu_sibling_map[1] = 0
>ENABLING IO-APIC IRQs
>Setting 2 in the phys_id_present_map
>...changing IO-APIC physical APIC ID to 2 ... ok.
>init IO_APIC IRQs
>  IO-APIC (apicid-pin) 2-0, 2-20 not connected.
>..TIMER: vector=0x31 pin1=2 pin2=0
>number of MP IRQ sources: 26.
>number of IO-APIC #2 registers: 24.
>testing the IO APIC.......................
>
>IO APIC #2......
>.... register #00: 02000000
>.......    : physical APIC id: 02
>.......    : Delivery Type: 0
>.......    : LTS          : 0
>.... register #01: 00178020
>.......     : max redirection entries: 0017
>.......     : PRQ implemented: 1
>.......     : IO APIC version: 0020
>.... register #02: 00178020
>.......     : arbitration: 00
>An unexpected IO-APIC was found. If this kernel release is less than
>three months old please report this to linux-smp@vger.kernel.org
>.... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 000 00  1    0    0   0   0    0    0    00
>  01 003 03  0    0    0   0   0    1    1    39
>  02 003 03  0    0    0   0   0    1    1    31
>  03 003 03  0    0    0   0   0    1    1    41
>  04 003 03  0    0    0   0   0    1    1    49
>  05 003 03  0    0    0   0   0    1    1    51
>  06 003 03  0    0    0   0   0    1    1    59
>  07 003 03  0    0    0   0   0    1    1    61
>  08 003 03  0    0    0   0   0    1    1    69
>  09 003 03  1    1    0   0   0    1    1    71
>  0a 003 03  0    0    0   0   0    1    1    79
>  0b 003 03  0    0    0   0   0    1    1    81
>  0c 003 03  0    0    0   0   0    1    1    89
>  0d 003 03  0    0    0   0   0    1    1    91
>  0e 003 03  0    0    0   0   0    1    1    99
>  0f 003 03  0    0    0   0   0    1    1    A1
>  10 003 03  1    1    0   1   0    1    1    A9
>  11 003 03  1    1    0   1   0    1    1    B1
>  12 003 03  1    1    0   1   0    1    1    B9
>  13 003 03  1    1    0   1   0    1    1    C1
>  14 000 00  1    0    0   0   0    0    0    00
>  15 003 03  1    1    0   1   0    1    1    C9
>  16 003 03  1    1    0   1   0    1    1    D1
>  17 003 03  1    1    0   1   0    1    1    D9
>IRQ to pin mappings:
>IRQ0 -> 0:2
>IRQ1 -> 0:1
>IRQ3 -> 0:3
>IRQ4 -> 0:4
>IRQ5 -> 0:5
>IRQ6 -> 0:6
>IRQ7 -> 0:7
>IRQ8 -> 0:8
>IRQ9 -> 0:9
>IRQ10 -> 0:10
>IRQ11 -> 0:11
>IRQ12 -> 0:12
>IRQ13 -> 0:13
>IRQ14 -> 0:14
>IRQ15 -> 0:15
>IRQ16 -> 0:16
>IRQ17 -> 0:17
>IRQ18 -> 0:18
>IRQ19 -> 0:19
>IRQ21 -> 0:21
>IRQ22 -> 0:22
>IRQ23 -> 0:23
>.................................... done.
>Using local APIC timer interrupts.
>calibrating APIC timer ...
>..... CPU clock speed is 2992.4499 MHz.
>..... host bus clock speed is 199.4964 MHz.
>cpu: 0, clocks: 1994964, slice: 664988
>CPU0<T0:1994960,T1:1329968,D:4,S:664988,C:1994964>
>cpu: 1, clocks: 1994964, slice: 664988
>CPU1<T0:1994960,T1:664976,D:8,S:664988,C:1994964>
>checking TSC synchronization across CPUs: passed.
>Waiting on wait_init_idle (map = 0x2)
>All processors have done init_idle
>PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
>PCI: Using configuration type 1
>PCI: Probing PCI hardware
>PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
>Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
>PCI: Using IRQ router default [8086/24d0] at 00:1f.0
>PCI->APIC IRQ transform: (B0,I29,P0) -> 16
>PCI->APIC IRQ transform: (B0,I29,P1) -> 19
>PCI->APIC IRQ transform: (B0,I29,P2) -> 18
>PCI->APIC IRQ transform: (B0,I29,P0) -> 16
>PCI->APIC IRQ transform: (B0,I29,P3) -> 23
>PCI->APIC IRQ transform: (B0,I31,P0) -> 18
>PCI->APIC IRQ transform: (B0,I31,P0) -> 18
>PCI->APIC IRQ transform: (B0,I31,P1) -> 17
>PCI->APIC IRQ transform: (B1,I0,P0) -> 16
>PCI->APIC IRQ transform: (B2,I1,P0) -> 18
>PCI->APIC IRQ transform: (B3,I1,P0) -> 22
>PCI->APIC IRQ transform: (B3,I1,P1) -> 21
>isapnp: Scanning for PnP cards...
>isapnp: No Plug & Play device found
>Linux NET4.0 for Linux 2.4
>Based upon Swansea University Computer Society NET3.039
>Initializing RT netlink socket
>apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
>apm: disabled - APM is not SMP safe.
>Starting kswapd
>allocated 32 pages and 32 bhs reserved for the highmem bounces
>VFS: Diskquotas version dquot_6.4.0 initialized
>pty: 2048 Unix98 ptys configured
>Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT 
>SHARE_IRQ SERIAL_PCI ISAPNP enabled
>ttyS00 at 0x03f8 (irq = 4) is a 16550A
>Real Time Clock Driver v1.10e
>floppy0: no floppy controllers found
>NET4: Frame Diverter 0.46
>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
>Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>ICH5: IDE controller at PCI slot 00:1f.1
>PCI: Enabling device 00:1f.1 (0005 -> 0007)
>ICH5: chipset revision 2
>ICH5: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
>ICH5-SATA: IDE controller at PCI slot 00:1f.2
>ICH5-SATA: chipset revision 2
>ICH5-SATA: 100% native mode on irq 18
>     ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:DMA, hdf:pio
>     ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:DMA, hdh:pio
>hda: MAXTOR 4K080H4, ATA DISK drive
>blk: queue c03714c0, I/O limit 4095Mb (mask 0xffffffff)
>hdc: SONY DVD RW DRU-510A, ATAPI CD/DVD-ROM drive
>hdd: SONY DVD RW DRU-510A, ATAPI CD/DVD-ROM drive
>hde: Maxtor 6Y120M0, ATA DISK drive
>hdf: probing with STATUS(0x00) instead of ALTSTATUS(0x50)
>hdf: probing with STATUS(0x00) instead of ALTSTATUS(0x50)
>blk: queue c0371da8, I/O limit 4095Mb (mask 0xffffffff)
>hdg: Maxtor 6Y120M0, ATA DISK drive
>hdh: probing with STATUS(0x00) instead of ALTSTATUS(0x50)
>hdh: probing with STATUS(0x00) instead of ALTSTATUS(0x50)
>blk: queue c037221c, I/O limit 4095Mb (mask 0xffffffff)
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>ide1 at 0x170-0x177,0x376 on irq 15
>ide2 at 0xec00-0xec07,0xe802 on irq 18
>ide3 at 0xe400-0xe407,0xe002 on irq 18
>hda: attached ide-disk driver.
>hda: host protected area => 1
>hda: 156301487 sectors (80026 MB) w/2000KiB Cache, CHS=155060/16/63, UDMA(100)
>hde: attached ide-disk driver.
>hde: host protected area => 1
>hde: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=238216/16/63, UDMA(33)
>hdg: attached ide-disk driver.
>hdg: host protected area => 1
>hdg: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=238216/16/63, UDMA(33)
>ide-floppy driver 0.99.newide
>Partition check:
>  hda: [PTBL] [9729/255/63] hda1 hda2 hda3
>  hde: hde1 hde2 hde3
>  hdg: hdg1 hdg2 hdg3
>ide-floppy driver 0.99.newide
>md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
>md: Autodetecting RAID arrays.
>  [events: 00000018]
>  [events: 00000018]
>md: autorun ...
>md: considering hdg3 ...
>md:  adding hdg3 ...
>md:  adding hde3 ...
>md: created md0
>md: bind<hde3,1>
>md: bind<hdg3,2>
>md: running: <hdg3><hde3>
>md: hdg3's event counter: 00000018
>md: hde3's event counter: 00000018
>kmod: failed to exec /sbin/modprobe -s -k md-personality-2, errno = 2
>md: personality 2 is not loaded!
>md :do_md_run() returned -22
>md: md0 stopped.
>md: unbind<hdg3,1>
>md: export_rdev(hdg3)
>md: unbind<hde3,0>
>md: export_rdev(hde3)
>md: ... autorun DONE.
>NET4: Linux TCP/IP 1.0 for NET4.0
>IP Protocols: ICMP, UDP, TCP, IGMP
>IP: routing cache hash table of 16384 buckets, 128Kbytes
>TCP: Hash tables configured (established 262144 bind 65536)
>Linux IP multicast router 0.06 plus PIM-SM
>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>RAMDISK: Compressed image found at block 0
>Freeing initrd memory: 84k freed
>VFS: Mounted root (ext2 filesystem).
>md: raid0 personality registered as nr 2
>md: Autodetecting RAID arrays.
>  [events: 00000018]
>  [events: 00000018]
>md: autorun ...
>md: considering hde3 ...
>md:  adding hde3 ...
>md:  adding hdg3 ...
>md: created md0
>md: bind<hdg3,1>
>md: bind<hde3,2>
>md: running: <hde3><hdg3>
>md: hde3's event counter: 00000018
>md: hdg3's event counter: 00000018
>md0: max total readahead window set to 512k
>md0: 2 data-disks, max readahead per data-disk: 256k
>raid0: looking at hde3
>raid0:   comparing hde3(118962048) with hde3(118962048)
>raid0:   END
>raid0:   ==> UNIQUE
>raid0: 1 zones
>raid0: looking at hdg3
>raid0:   comparing hdg3(118962048) with hde3(118962048)
>raid0:   EQUAL
>raid0: FINAL 1 zones
>raid0: zone 0
>raid0: checking hde3 ... contained as device 0
>   (118962048) is smallest!.
>raid0: checking hdg3 ... contained as device 1
>raid0: zone->nb_dev: 2, size: 237924096
>raid0: current zone offset: 118962048
>raid0: done.
>raid0 : md_size is 237924096 blocks.
>raid0 : conf->smallest->size is 237924096 blocks.
>raid0 : nb_zone is 1.
>raid0 : Allocating 8 bytes for hash.
>md: updating md0 RAID superblock on device
>md: hde3 [events: 00000019]<6>(write) hde3's sb offset: 118962048
>md: hdg3 [events: 00000019]<6>(write) hdg3's sb offset: 118962048
>md: ... autorun DONE.
>Freeing unused kernel memory: 148k freed
>usb.c: registered new driver usbdevfs
>usb.c: registered new driver hub
>PCI: Setting latency timer of device 00:1d.7 to 64
>ehci-hcd 00:1d.7: PCI device 8086:24dd (Intel Corp.)
>ehci-hcd 00:1d.7: irq 23, pci mem f8831c00
>usb.c: new USB bus registered, assigned bus number 1
>ehci-hcd 00:1d.7: enabled 64bit PCI DMA
>PCI: 00:1d.7 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
>PCI: 00:1d.7 PCI cache line size corrected to 128.
>ehci-hcd 00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
>hub.c: USB hub found
>hub.c: 8 ports detected
>usb-uhci.c: $Revision: 1.275 $ time 10:20:34 Jun 28 2003
>usb-uhci.c: High bandwidth mode enabled
>PCI: Setting latency timer of device 00:1d.0 to 64
>usb-uhci.c: USB UHCI at I/O 0xcc00, IRQ 16
>usb-uhci.c: Detected 2 ports
>usb.c: new USB bus registered, assigned bus number 2
>hub.c: USB hub found
>hub.c: 2 ports detected
>PCI: Setting latency timer of device 00:1d.1 to 64
>usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 19
>usb-uhci.c: Detected 2 ports
>usb.c: new USB bus registered, assigned bus number 3
>hub.c: USB hub found
>hub.c: 2 ports detected
>PCI: Setting latency timer of device 00:1d.2 to 64
>usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 18
>usb-uhci.c: Detected 2 ports
>usb.c: new USB bus registered, assigned bus number 4
>hub.c: USB hub found
>hub.c: 2 ports detected
>PCI: Setting latency timer of device 00:1d.3 to 64
>usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 16
>usb-uhci.c: Detected 2 ports
>usb.c: new USB bus registered, assigned bus number 5
>hub.c: USB hub found
>hub.c: 2 ports detected
>usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
>usb.c: registered new driver hiddev
>usb.c: registered new driver hid
>hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
>hid-core.c: USB HID support drivers
>mice: PS/2 mouse device common for all mice
>Adding Swap: 2040244k swap-space (priority -1)
>hub.c: new USB device 00:1d.1-2, assigned address 2
>input0: USB HID v1.10 Mouse [Logitech USB Receiver] on usb3:2.0
>ohci1394: $Rev: 896 $ Ben Collins <bcollins@debian.org>
>ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[21]  MMIO=[feaff800-feafffff]  Max 
>Packet=[2048]
>ieee1394: Host added: Node[00:1023]  GUID[00023c00910588d4]  [Linux OHCI-1394]
>SCSI subsystem driver Revision: 1.00
>hdc: attached ide-scsi driver.
>hdd: attached ide-scsi driver.
>scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: SONY      Model: DVD RW DRU-510A   Rev: 1.0b
>   Type:   CD-ROM                             ANSI SCSI revision: 02
>   Vendor: SONY      Model: DVD RW DRU-510A   Rev: 1.0b
>   Type:   CD-ROM                             ANSI SCSI revision: 02
>parport0: PC-style at 0x378 [PCSPP,TRISTATE]
>Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
>Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
>sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
>Uniform CD-ROM driver Revision: 3.12
>sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
>ip_tables: (C) 2000-2002 Netfilter core team
>Intel(R) PRO/1000 Network Driver - version 5.1.11
>Copyright (c) 1999-2003 Intel Corporation.
>PCI: Setting latency timer of device 02:01.0 to 64
>divert: allocating divert_blk for eth0
>eth0: Intel(R) PRO/1000 Network Connection
>ip_tables: (C) 2000-2002 Netfilter core team
>e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex
>ip_tables: (C) 2000-2002 Netfilter core team
>parport0: PC-style at 0x378 [PCSPP,TRISTATE]
>lp0: using parport0 (polling).
>lp0: console ready
>1: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4363  Sat 
>Apr 19 17:46:46 PDT 2003
>Linux agpgart interface v0.99 (c) Jeff Hartmann
>agpgart: Maximum main memory to use for agp memory: 1919M
>agpgart: Unsupported Intel chipset (device id: 2578), you might want to 
>try agp_try_unsupported=1.
>agpgart: no supported devices found.
>1: NVRM: AGPGART: unable to retrieve symbol table
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

