Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281269AbRKES3b>; Mon, 5 Nov 2001 13:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281272AbRKES3W>; Mon, 5 Nov 2001 13:29:22 -0500
Received: from ns-3.dglnet.com.br ([200.246.42.67]:1512 "HELO
	ns-3.dglnet.com.br") by vger.kernel.org with SMTP
	id <S281269AbRKES3M>; Mon, 5 Nov 2001 13:29:12 -0500
Date: Mon, 5 Nov 2001 16:29:09 -0200
To: linux-kernel@vger.kernel.org
Subject: aic7xxx lockup kernel, but aic7xxx_old works
Message-ID: <20011105162909.A30843@dglnet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: edson@dglnet.com.br (Edson Y. Fugio)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an old adaptec 2940:

# lspci
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 620 Host (rev 02)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev b3)
00:01.1 Class ff00: Silicon Integrated Systems [SiS] ACPI
00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 11)
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:09.0 SCSI storage controller: Adaptec AHA-294x / AIC-7871
00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:0f.1 Communication controller: C-Media Electronics Inc CM8738 (rev 10)
00:10.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 02)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 6306 3D-AGP (rev 2a)

If I try to load aic7xxx_old first, rmmod aic7xxx_old and modprobe aic7xxx it works.
But with poweron and modprobe aic7xxx the system completely frozen with "Kernel panic: Loop 1" message.

This is the cold boot with modprobe aic7xxx and kernel panic log:

Nov  5 15:21:19 potato kernel: Inspecting /boot/System.map-2.4.14-pre8
Nov  5 15:21:19 potato kernel: Loaded 14369 symbols from /boot/System.map-2.4.14-pre8.
Nov  5 15:21:19 potato kernel: Symbols match kernel version 2.4.14.
Nov  5 15:21:19 potato kernel: Loaded 93 symbols from 3 modules.
Nov  5 15:21:58 potato kernel: SCSI subsystem driver Revision: 1.00
Nov  5 15:21:58 potato kernel: PCI: Found IRQ 10 for device 00:09.0
Nov  5 15:21:58 potato kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
Nov  5 15:21:58 potato kernel:         <Adaptec 2940 SCSI adapter>
Nov  5 15:21:58 potato kernel:         aic7870: Single Channel A, SCSI Id=7, 16/253 SCBs
Nov  5 15:21:58 potato kernel:
Nov  5 15:22:13 potato kernel: scsi0: brkadrint, PCI Error detected at seqaddr = 0x1
Nov  5 15:22:13 potato kernel: scsi0: Dumping Card State while idle, at SEQADDR 0x1
Nov  5 15:22:13 potato kernel: ACCUM = 0x3, SINDEX = 0x20, DINDEX = 0xc0, ARG_2 = 0x0
Nov  5 15:22:13 potato kernel: HCNT = 0x0
Nov  5 15:22:13 potato kernel: SCSISEQ = 0x12, SBLKCTL = 0x0
Nov  5 15:22:13 potato kernel:  DFCNTRL = 0x4, DFSTATUS = 0x6d
Nov  5 15:22:13 potato kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x80
Nov  5 15:22:13 potato kernel: SSTAT0 = 0x5, SSTAT1 = 0x0
Nov  5 15:22:13 potato kernel: STACK == 0x17, 0x186, 0x0, 0x0
Nov  5 15:22:13 potato kernel: SCB count = 4
Nov  5 15:22:13 potato kernel: Kernel NEXTQSCB = 2
Nov  5 15:22:13 potato kernel: Card NEXTQSCB = 2
Nov  5 15:22:13 potato kernel: QINFIFO entries:
Nov  5 15:22:13 potato kernel: Waiting Queue entries:
Nov  5 15:22:13 potato kernel: Disconnected Queue entries:
Nov  5 15:22:13 potato kernel: QOUTFIFO entries:
Nov  5 15:22:13 potato kernel: Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
Nov  5 15:22:13 potato kernel: Pending list:
Nov  5 15:22:13 potato kernel: Kernel Free SCB list: 3 1 0
Nov  5 15:22:19 potato kernel: scsi0:0:1:0: Attempting to queue an ABORT message
Nov  5 15:22:19 potato kernel: scsi0: Dumping Card State while idle, at SEQADDR 0x18
Nov  5 15:22:19 potato kernel: ACCUM = 0x0, SINDEX = 0x0, DINDEX = 0x0, ARG_2 = 0x0
Nov  5 15:22:19 potato kernel: HCNT = 0x0                             
Nov  5 15:22:19 potato kernel: SCSISEQ = 0x0, SBLKCTL = 0xc0
Nov  5 15:22:19 potato kernel:  DFCNTRL = 0x0, DFSTATUS = 0x29
Nov  5 15:22:19 potato kernel: LASTPHASE = 0x1, SCSISIGI = 0x0, SXFRCTL0 = 0x0
Nov  5 15:22:19 potato kernel: SSTAT0 = 0x0, SSTAT1 = 0x8
Nov  5 15:22:19 potato kernel: STACK == 0x17, 0x0, 0x0, 0x0
Nov  5 15:22:19 potato kernel: SCB count = 4
Nov  5 15:22:19 potato kernel: Kernel NEXTQSCB = 3
Nov  5 15:22:19 potato kernel: Card NEXTQSCB = 0
Nov  5 15:22:19 potato kernel: QINFIFO entries: 3 2 
Nov  5 15:22:19 potato kernel: Waiting Queue entries: 0:255 1:255 2:255 3:255 4:255 5:255 6:255 7:255 8:255 9:255 10:255 11:255 12:255 13:255 
14:255 15:255 
Nov  5 15:22:19 potato kernel: Disconnected Queue entries: 0:255 1:255 2:255 3:255 4:255 5:255 6:255 7:255 8:255 9:255 10:255 11:255 12:255 13
:255 14:255 15:255 
Nov  5 15:22:19 potato kernel: QOUTFIFO entries: 
Nov  5 15:22:19 potato kernel: Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Nov  5 15:22:19 potato kernel: Pending list: 2
Nov  5 15:22:19 potato kernel: Kernel Free SCB list: 1 0 
Nov  5 15:22:19 potato kernel: Untagged Q(1): 2 
Nov  5 15:22:19 potato kernel: DevQ(0:1:0): 0 waiting
Nov  5 15:22:19 potato kernel: qinpos = 0, SCB index = 3
Nov  5 15:22:19 potato kernel: Kernel panic: Loop 1
Nov  5 15:22:19 potato kernel: 



This is the modprobe aic7xxx_old, rmmod and modprobe aic7xxx with full log:

Nov  5 15:16:04 potato Linux version 2.4.14-pre8 (root@potato) (gcc version 2.95.4 20011006 (Debian prerelease)) #1 Mon Nov 5 13:57:42 BRST 20
01
Nov  5 15:16:04 potato BIOS-provided physical RAM map:
Nov  5 15:16:04 potato BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Nov  5 15:16:04 potato BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Nov  5 15:16:04 potato BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Nov  5 15:16:04 potato BIOS-e820: 0000000000100000 - 0000000007bf0000 (usable)
Nov  5 15:16:04 potato BIOS-e820: 0000000007bf0000 - 0000000007bf8000 (ACPI data)
Nov  5 15:16:04 potato BIOS-e820: 0000000007bf8000 - 0000000007c00000 (ACPI NVS)
Nov  5 15:16:04 potato BIOS-e820: 00000000ffef0000 - 00000000fff00000 (reserved)
Nov  5 15:16:04 potato BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Nov  5 15:16:04 potato On node 0 totalpages: 31728
Nov  5 15:16:04 potato zone(0): 4096 pages.
Nov  5 15:16:04 potato zone(1): 27632 pages.
Nov  5 15:16:04 potato zone(2): 0 pages.
Nov  5 15:16:04 potato Local APIC disabled by BIOS -- reenabling.
Nov  5 15:16:04 potato Found and enabled local APIC!
Nov  5 15:16:04 potato Kernel command line: BOOT_IMAGE=Linux ro root=302
Nov  5 15:16:04 potato Initializing CPU#0
Nov  5 15:16:04 potato Detected 601.363 MHz processor.
Nov  5 15:16:04 potato Console: colour VGA+ 80x25
Nov  5 15:16:04 potato Calibrating delay loop... 1199.30 BogoMIPS
Nov  5 15:16:04 potato Memory: 122788k/126912k available (998k kernel code, 3736k reserved, 342k data, 192k init, 0k highmem)
Nov  5 15:16:04 potato Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Nov  5 15:16:04 potato Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Nov  5 15:16:04 potato Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Nov  5 15:16:04 potato Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Nov  5 15:16:04 potato Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Nov  5 15:16:04 potato CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
Nov  5 15:16:04 potato CPU: L1 I cache: 16K, L1 D cache: 16K
Nov  5 15:16:04 potato CPU: L2 cache: 128K
Nov  5 15:16:04 potato Intel machine check architecture supported.
Nov  5 15:16:04 potato Intel machine check reporting enabled on CPU#0.
Nov  5 15:16:04 potato CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Nov  5 15:16:04 potato CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Nov  5 15:16:04 potato CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Nov  5 15:16:04 potato CPU: Intel Celeron (Coppermine) stepping 03
Nov  5 15:16:04 potato Enabling fast FPU save and restore... done.
Nov  5 15:16:04 potato Enabling unmasked SIMD FPU exception support... done.
Nov  5 15:16:04 potato Checking 'hlt' instruction... OK.
Nov  5 15:16:04 potato POSIX conformance testing by UNIFIX
Nov  5 15:16:04 potato enabled ExtINT on CPU#0
Nov  5 15:16:04 potato ESR value before enabling vector: 00000040
Nov  5 15:16:04 potato ESR value after enabling vector: 00000000
Nov  5 15:16:04 potato Using local APIC timer interrupts.
Nov  5 15:16:04 potato calibrating APIC timer ...
Nov  5 15:16:04 potato ..... CPU clock speed is 601.3647 MHz.
Nov  5 15:16:04 potato ..... host bus clock speed is 66.8180 MHz.
Nov  5 15:16:04 potato cpu: 0, clocks: 668180, slice: 334090
Nov  5 15:16:04 potato CPU0<T0:668176,T1:334080,D:6,S:334090,C:668180>
Nov  5 15:16:04 potato PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=1
Nov  5 15:16:04 potato PCI: Using configuration type 1
Nov  5 15:16:04 potato PCI: Probing PCI hardware
Nov  5 15:16:04 potato PCI: Using IRQ router SIS [1039/0008] at 00:01.0
Nov  5 15:16:04 potato Linux NET4.0 for Linux 2.4
Nov  5 15:16:04 potato Based upon Swansea University Computer Society NET3.039
Nov  5 15:16:04 potato Initializing RT netlink socket
Nov  5 15:16:04 potato Starting kswapd
Nov  5 15:16:04 potato tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Nov  5 15:16:04 potato Parsing Methods:......................................................................................................
Nov  5 15:16:04 potato 102 Control Methods found and parsed (303 nodes total)
Nov  5 15:16:04 potato ACPI Namespace successfully loaded at root c0291500
Nov  5 15:16:04 potato ACPI: Core Subsystem version [20011018]
Nov  5 15:16:04 potato evxfevnt-0081 [02] Acpi_enable           : Transition to ACPI mode successful
Nov  5 15:16:04 potato Executing device _INI methods:............ exfldio-0102 [21] Ex_setup_field        : Field access width (4 bytes) too l
arge for region size (1)
Nov  5 15:16:04 potato exfldio-0113 [21] Ex_setup_field        : Field base+offset+width 0+0+4 exceeds region size (1 bytes) field=c7b6cf48 re
gion=c7b6cdc8
Nov  5 15:16:04 potato Ps_execute: method failed - \_SB_.PCI0.SBRG.PS2M._STA (c7b7aa88)
Nov  5 15:16:04 potato uteval-0337 [05] Ut_execute_STA        : _STA on PS2M failed AE_AML_REGION_LIMIT
Nov  5 15:16:04 potato ...................
Nov  5 15:16:04 potato 31 Devices found: 30 _STA, 1 _INI
Nov  5 15:16:04 potato Completing Region and Field initialization:...............
Nov  5 15:16:04 potato 15/20 Regions, 0/0 Fields initialized (303 nodes total)
Nov  5 15:16:04 potato ACPI: Subsystem enabled
Nov  5 15:16:04 potato exfldio-0102 [20] Ex_setup_field        : Field access width (4 bytes) too large for region size (1)
Nov  5 15:16:04 potato exfldio-0113 [20] Ex_setup_field        : Field base+offset+width 0+0+4 exceeds region size (1 bytes) field=c7b6cf48 re
gion=c7b6cdc8
Nov  5 15:16:04 potato Ps_execute: method failed - \_SB_.PCI0.SBRG.PS2M._STA (c7b7aa88)
Nov  5 15:16:04 potato uteval-0337 [04] Ut_execute_STA        : _STA on PS2M failed AE_AML_REGION_LIMIT
Nov  5 15:16:04 potato exfldio-0102 [22] Ex_setup_field        : Field access width (4 bytes) too large for region size (1)
Nov  5 15:16:04 potato exfldio-0113 [22] Ex_setup_field        : Field base+offset+width 0+0+4 exceeds region size (1 bytes) field=c7b6cf48 re
gion=c7b6cdc8
Nov  5 15:16:04 potato Ps_execute: method failed - \_SB_.PCI0.SBRG.PS2M._STA (c7b7aa88)
Nov  5 15:16:04 potato Power Resource: found
Nov  5 15:16:04 potato Power Resource: found
Nov  5 15:16:04 potato Power Resource: found
Nov  5 15:16:04 potato Power Resource: found
Nov  5 15:16:04 potato ACPI: System firmware supports S0 S1 S5
Nov  5 15:16:04 potato Processor[0]: C0 C1
Nov  5 15:16:04 potato pty: 256 Unix98 ptys configured
Nov  5 15:16:04 potato Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Nov  5 15:16:04 potato ttyS00 at 0x03f8 (irq = 4) is a 16550A
Nov  5 15:16:04 potato Real Time Clock Driver v1.10e
Nov  5 15:16:04 potato block: 128 slots per queue, batch=32
Nov  5 15:16:04 potato Uniform Multi-Platform E-IDE driver Revision: 6.31
Nov  5 15:16:04 potato ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov  5 15:16:04 potato SIS5513: IDE controller on PCI bus 00 dev 01
Nov  5 15:16:04 potato PCI: No IRQ known for interrupt pin A of device 00:00.1. Please try using pci=biosirq.
Nov  5 15:16:04 potato SIS5513: chipset revision 208
Nov  5 15:16:04 potato SIS5513: not 100% native mode: will probe irqs later
Nov  5 15:16:04 potato SiS620
Nov  5 15:16:04 potato ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
Nov  5 15:16:04 potato ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Nov  5 15:16:04 potato hda: SAMSUNG SV1021H, ATA DISK drive
Nov  5 15:16:04 potato hdc: IDE/ATAPI CD-ROM 50XS, ATAPI CD/DVD-ROM drive
Nov  5 15:16:04 potato ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov  5 15:16:04 potato ide1 at 0x170-0x177,0x376 on irq 15
Nov  5 15:16:04 potato hda: 19932192 sectors (10205 MB) w/426KiB Cache, CHS=1240/255/63, UDMA(66)
Nov  5 15:16:04 potato hdc: ATAPI 11X CD-ROM drive, 128kB Cache, UDMA(33)
Nov  5 15:16:04 potato Uniform CD-ROM driver Revision: 3.12
Nov  5 15:16:04 potato Partition check:
Nov  5 15:16:04 potato hda: hda1 hda2 hda3 hda4 < hda5 >
Nov  5 15:16:04 potato Floppy drive(s): fd0 is 1.44M
Nov  5 15:16:04 potato FDC 0 is a post-1991 82077
Nov  5 15:16:04 potato sis900.c: v1.08.01  9/25/2001
Nov  5 15:16:04 potato PCI: Found IRQ 9 for device 00:10.0
Nov  5 15:16:04 potato eth0: SiS 900 Internal MII PHY transceiver found at address 1.
Nov  5 15:16:04 potato eth0: Using transceiver found at address 1 as default
Nov  5 15:16:04 potato eth0: SiS 900 PCI Fast Ethernet at 0xd800, IRQ 9, 00:d0:09:4c:5d:4f.
Nov  5 15:16:04 potato NET4: Linux TCP/IP 1.0 for NET4.0
Nov  5 15:16:04 potato IP Protocols: ICMP, UDP, TCP, IGMP
Nov  5 15:16:04 potato IP: routing cache hash table of 512 buckets, 4Kbytes
Nov  5 15:16:04 potato TCP: Hash tables configured (established 8192 bind 8192)
Nov  5 15:16:04 potato NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Nov  5 15:16:04 potato VFS: Mounted root (ext2 filesystem) readonly.
Nov  5 15:16:04 potato Freeing unused kernel memory: 192k freed
Nov  5 15:16:04 potato Adding Swap: 128516k swap-space (priority -1)
Nov  5 15:16:04 potato cmpci: version $Revision: 5.64 $ time 14:19:43 Nov  5 2001
Nov  5 15:16:04 potato PCI: Found IRQ 12 for device 00:0f.0
Nov  5 15:16:04 potato cmpci: found CM8738 adapter at io 0xda00 irq 12
Nov  5 15:16:04 potato cmpci: chip version = 033
Nov  5 15:16:04 potato eth0: Media Link On 100mbps full-duplex 
Nov  5 15:16:04 potato kernel: Inspecting /boot/System.map-2.4.14-pre8
Nov  5 15:16:04 potato kernel: Loaded 14369 symbols from /boot/System.map-2.4.14-pre8.
Nov  5 15:16:04 potato kernel: Symbols match kernel version 2.4.14.
Nov  5 15:16:04 potato kernel: Loaded 93 symbols from 3 modules.
Nov  5 15:17:30 potato kernel: SCSI subsystem driver Revision: 1.00
Nov  5 15:17:30 potato kernel: PCI: Found IRQ 10 for device 00:09.0
Nov  5 15:17:30 potato kernel: (scsi0) <Adaptec AHA-294X SCSI host adapter> found at PCI 0/9/0
Nov  5 15:17:30 potato kernel: (scsi0) Narrow Channel, SCSI ID=7, 16/255 SCBs
Nov  5 15:17:30 potato kernel: (scsi0) Downloading sequencer code... 415 instructions downloaded
Nov  5 15:17:30 potato kernel: scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.4/5.2.0
Nov  5 15:17:30 potato kernel:        <Adaptec AHA-294X SCSI host adapter>
Nov  5 15:17:35 potato kernel:   Vendor: OnStream  Model: SC-50             Rev: 1.09
Nov  5 15:17:35 potato kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
Nov  5 15:17:40 potato kernel: osst :I: Tape driver with OnStream support version 0.9.8
Nov  5 15:17:40 potato kernel: osst :I: $Id: osst.c,v 1.61 2001/06/03 21:55:12 riede Exp $
Nov  5 15:17:40 potato kernel: osst :I: Attached OnStream SC-50 tape at scsi0, channel 0, id 4, lun 0 as osst0
Nov  5 15:17:52 potato kernel: (scsi0:0:4:0) Synchronous at 10.0 Mbyte/sec, offset 7.
Nov  5 15:18:18 potato kernel: osst :I: Unloaded.
Nov  5 15:18:23 potato kernel: scsi : 0 hosts left.
Nov  5 15:18:28 potato kernel: PCI: Found IRQ 10 for device 00:09.0
Nov  5 15:18:28 potato kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
Nov  5 15:18:28 potato kernel:         <Adaptec 2940 SCSI adapter>
Nov  5 15:18:28 potato kernel:         aic7870: Single Channel A, SCSI Id=7, 16/253 SCBs
Nov  5 15:18:28 potato kernel: 
Nov  5 15:18:44 potato kernel:   Vendor: OnStream  Model: SC-50             Rev: 1.09
Nov  5 15:18:44 potato kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
Nov  5 15:18:49 potato kernel: osst :I: Tape driver with OnStream support version 0.9.8
Nov  5 15:18:49 potato kernel: osst :I: $Id: osst.c,v 1.61 2001/06/03 21:55:12 riede Exp $
Nov  5 15:18:49 potato kernel: osst :I: Attached OnStream SC-50 tape at scsi0, channel 0, id 4, lun 0 as osst0
Nov  5 15:19:07 potato kernel: (scsi0:A:4): 10.000MB/s transfers (10.000MHz, offset 7)


Edson Fugio
