Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbTKYUA6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 15:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbTKYUA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 15:00:58 -0500
Received: from host1.orm.mipt.ru ([81.5.88.53]:30216 "EHLO host1.orm.mipt.ru")
	by vger.kernel.org with ESMTP id S262991AbTKYUAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 15:00:39 -0500
Message-ID: <3FC3B4DC.4070802@orm.mipt.ru>
Date: Tue, 25 Nov 2003 23:00:28 +0300
From: Eugene Savelov <eugene@orm.mipt.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: ru, en-us
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_host1.orm.mipt.ru-16815-1069789554-0001-2"
To: linux-kernel@vger.kernel.org
Subject: [BUG] HPT302  IDE controller in linux 2.4.22 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_host1.orm.mipt.ru-16815-1069789554-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hello!

We have an HPT302 IDE controller with two channels - primary/secondary


linux-2.4.22 IDE driver recognizes this controller, but fails to 
properly work with two channels simultaneously.



Nov 25 19:35:00 server kernel: hdg: dma_intr: status=0xe0 { Busy } Nov 
25 19:35:00 server kernel: hdg: DMA disabled
Nov 25 19:35:13 server kernel: hdg: set_geometry_intr: status=0x51 { 
DriveReady
SeekComplete Error }
Nov 25 19:35:13 server kernel: hdg: set_geometry_intr: error=0x6e { 
DriveStatusError UncorrectableError TrackZeroNotFound }, CHS=0/0/1, 
sector=466136
Nov 25 19:35:13 server kernel: end_request: I/O error, dev 22:01 (hdg), 
sector 466136
Nov 25 19:35:13 server kernel: raid1: Disk failure on hdg1, disabling 
device. Nov 25 19:35:13 server kernel: hdg: status timeout: status=0xe0 
{ Busy } Nov 25 19:35:13 server kernel: hdg: drive not ready for command 
Nov 25 19:37:21 server kernel: md: (skipping faulty hdg1 )
Nov 25 19:37:21 server kernel: hdg: lost interrupt
Nov 25 19:37:21 server kernel: hdg: set_geometry_intr: status=0x51 { 
DriveReady
SeekComplete Error }
Nov 25 19:37:21 server kernel: hdg: set_geometry_intr: error=0x04 { 
DriveStatusError }
Nov 25 19:37:21 server kernel: hdg: lost interrupt
Nov 25 19:37:21 server kernel: hdg: status timeout: status=0xd0 { Busy } 
Nov 25 19:37:21 server kernel: hdg: no DRQ after issuing WRITE
Nov 25 19:37:21 server kernel: hdg: lost interrupt
Nov 25 19:37:21 server kernel: hdg: set_geometry_intr: status=0x51 { 
DriveReady
SeekComplete Error }
Nov 25 19:37:21 server kernel: hdg: set_geometry_intr: error=0x04 { 
DriveStatusError }
Nov 25 19:37:21 server kernel: end_request: I/O error, dev 22:01 (hdg), 
sector 57413880
Nov 25 19:37:21 server kernel: hdg: lost interrupt
Nov 25 19:37:21 server kernel: hdg: status timeout: status=0xd0 { Busy } 
Nov 25 19:37:21 server kernel: hdg: no DRQ after issuing WRITE
Nov 25 19:37:21 server kernel: end_request: I/O error, dev 22:01 (hdg), 
sector 65536040


Full dmesg included

Workaround for this problem - either use highpoint scsi driver
(http://www.highpoint-tech.com/hpt302-opensource-v1.1.tgz)
 or move all hard disks to one channel (after that  linux driver works 
great)

Eugene



--=_host1.orm.mipt.ru-16815-1069789554-0001-2
Content-Type: text/plain; name=dmesg; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Nov 25 19:09:56 server syslogd 1.4.1: restart.
Nov 25 19:09:56 server syslog: syslogd startup succeeded
Nov 25 19:09:56 server kernel: klogd 1.4.1, log source = /proc/kmsg started.
Nov 25 19:09:56 server kernel: Linux version 2.4.22 (root@server) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #2 Tue Nov 25 18:21:55 MSK 2003
Nov 25 19:09:56 server kernel: BIOS-provided physical RAM map:
Nov 25 19:09:56 server kernel:  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
Nov 25 19:09:56 server kernel:  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
Nov 25 19:09:56 server kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Nov 25 19:09:56 server kernel:  BIOS-e820: 0000000000100000 - 0000000007ffd000 (usable)
Nov 25 19:09:56 server kernel:  BIOS-e820: 0000000007ffd000 - 0000000007fff000 (ACPI data)
Nov 25 19:09:56 server kernel:  BIOS-e820: 0000000007fff000 - 0000000008000000 (ACPI NVS)
Nov 25 19:09:56 server kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Nov 25 19:09:56 server kernel: 0MB HIGHMEM available.
Nov 25 19:09:56 server kernel: 127MB LOWMEM available.
Nov 25 19:09:56 server syslog: klogd startup succeeded
Nov 25 19:09:56 server kernel: On node 0 totalpages: 32765
Nov 25 19:09:56 server kernel: zone(0): 4096 pages.
Nov 25 19:09:56 server kernel: zone(1): 28669 pages.
Nov 25 19:09:56 server kernel: zone(2): 0 pages.
Nov 25 19:09:56 server kernel: Kernel command line: auto BOOT_IMAGE=2.4.22-hpt37x ro root=900 BOOT_FILE=/boot/vmlinuz-2.4.22
Nov 25 19:09:56 server kernel: Initializing CPU#0
Nov 25 19:09:56 server kernel: Detected 350.805 MHz processor.
Nov 25 19:09:56 server kernel: Console: colour VGA+ 80x25
Nov 25 19:09:56 server kernel: Calibrating delay loop... 699.59 BogoMIPS
Nov 25 19:09:56 server kernel: Memory: 126728k/131060k available (1423k kernel code, 3944k reserved, 519k data, 128k init, 0k highmem)
Nov 25 19:09:56 server kernel: Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Nov 25 19:09:56 server kernel: Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Nov 25 19:09:56 server kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Nov 25 19:09:56 server kernel: Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Nov 25 19:09:56 server kernel: Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Nov 25 19:09:56 server kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Nov 25 19:09:56 server kernel: CPU: L2 cache: 512K
Nov 25 19:09:56 server kernel: Intel machine check architecture supported.
Nov 25 19:09:56 server kernel: Intel machine check reporting enabled on CPU#0.
Nov 25 19:09:56 server kernel: CPU: Intel Pentium II (Deschutes) stepping 00
Nov 25 19:09:56 server kernel: Enabling fast FPU save and restore... done.
Nov 25 19:09:56 server kernel: Checking 'hlt' instruction... OK.
Nov 25 19:09:56 server kernel: POSIX conformance testing by UNIFIX
Nov 25 19:09:56 server kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Nov 25 19:09:56 server kernel: mtrr: detected mtrr type: Intel
Nov 25 19:09:56 server kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0750, last bus=1
Nov 25 19:09:56 server kernel: PCI: Using configuration type 1
Nov 25 19:09:56 server kernel: PCI: Probing PCI hardware
Nov 25 19:09:56 server kernel: PCI: Probing PCI hardware (bus 00)
Nov 25 19:09:56 server kernel: PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
Nov 25 19:09:56 server kernel: Limiting direct PCI/PCI transfers.
Nov 25 19:09:56 server kernel: isapnp: Scanning for PnP cards...
Nov 25 19:09:56 server kernel: isapnp: No Plug & Play device found
Nov 25 19:09:56 server kernel: Linux NET4.0 for Linux 2.4
Nov 25 19:09:56 server kernel: Based upon Swansea University Computer Society NET3.039
Nov 25 19:09:56 server kernel: Initializing RT netlink socket
Nov 25 19:09:56 server kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Nov 25 19:09:56 server portmap: portmap startup succeeded
Nov 25 19:09:56 server kernel: Starting kswapd
Nov 25 19:09:56 server kernel: VFS: Disk quotas vdquot_6.5.1
Nov 25 19:09:56 server kernel: Journalled Block Device driver loaded
Nov 25 19:09:56 server kernel: pty: 2048 Unix98 ptys configured
Nov 25 19:09:56 server kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
Nov 25 19:09:56 server kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Nov 25 19:09:56 server kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Nov 25 19:09:56 server kernel: ttyS02 at 0x03e8 (irq = 4) is a 16550A
Nov 25 19:09:56 server kernel: Real Time Clock Driver v1.10e
Nov 25 19:09:56 server kernel: Floppy drive(s): fd0 is 1.44M
Nov 25 19:09:56 server kernel: FDC 0 is a post-1991 82077
Nov 25 19:09:56 server kernel: NET4: Frame Diverter 0.46
Nov 25 19:09:56 server kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Nov 25 19:09:56 server kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
Nov 25 19:09:56 server kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov 25 19:09:56 server kernel: PIIX4: IDE controller at PCI slot 00:04.1
Nov 25 19:09:56 server kernel: PIIX4: chipset revision 1
Nov 25 19:09:56 server kernel: PIIX4: not 100%% native mode: will probe irqs later
Nov 25 19:09:56 server kernel:     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:pio
Nov 25 19:09:56 server kernel:     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
Nov 25 19:09:56 server kernel: HPT302: IDE controller at PCI slot 00:0c.0
Nov 25 19:09:56 server kernel: PCI: Found IRQ 11 for device 00:0c.0
Nov 25 19:09:56 server kernel: HPT302: chipset revision 1
Nov 25 19:09:56 server kernel: HPT302: not 100%% native mode: will probe irqs later
Nov 25 19:09:56 server kernel: HPT37X: using 33MHz PCI clock
Nov 25 19:09:56 server kernel:     ide2: BM-DMA at 0x9400-0x9407, BIOS settings: hde:DMA, hdf:pio
Nov 25 19:09:56 server kernel:     ide3: BM-DMA at 0x9408-0x940f, BIOS settings: hdg:DMA, hdh:pio
Nov 25 19:09:56 server kernel: hdc: NEC CD-ROM DRIVE:285, ATAPI CD/DVD-ROM drive
Nov 25 19:09:56 server kernel: hde: WDC WD400JB-00ENA0, ATA DISK drive
Nov 25 19:09:56 server kernel: blk: queue c033fe08, I/O limit 4095Mb (mask 0xffffffff)
Nov 25 19:09:56 server kernel: hdg: WDC WD400JB-00ENA0, ATA DISK drive
Nov 25 19:09:56 server nfslock: rpc.statd startup succeeded
Nov 25 19:09:56 server kernel: blk: queue c034025c, I/O limit 4095Mb (mask 0xffffffff)
Nov 25 19:09:56 server kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 25 19:09:56 server kernel: ide2 at 0xa800-0xa807,0xa402 on irq 11
Nov 25 19:09:56 server kernel: ide3 at 0xa000-0xa007,0x9802 on irq 11
Nov 25 19:09:56 server kernel: hde: attached ide-disk driver.
Nov 25 19:09:56 server kernel: hde: host protected area => 1
Nov 25 19:09:56 server kernel: hde: 78165360 sectors (40021 MB) w/8192KiB Cache, CHS=77545/16/63, UDMA(100)
Nov 25 19:09:56 server kernel: hdg: attached ide-disk driver.
Nov 25 19:09:56 server kernel: hdg: host protected area => 1
Nov 25 19:09:56 server kernel: hdg: 78165360 sectors (40021 MB) w/8192KiB Cache, CHS=77545/16/63, UDMA(100)
Nov 25 19:09:56 server kernel: Partition check:
Nov 25 19:09:56 server kernel:  hde: [PTBL] [4865/255/63] hde1 hde2
Nov 25 19:09:56 server rpc.statd[1762]: Version 1.0.1 Starting
Nov 25 19:09:56 server kernel:  hdg: [PTBL] [4865/255/63] hdg1 hdg2
Nov 25 19:09:56 server kernel: ide: late registration of driver.
Nov 25 19:09:56 server kernel: md: linear personality registered as nr 1
Nov 25 19:09:56 server kernel: md: raid0 personality registered as nr 2
Nov 25 19:09:56 server keytable: Loading keymap: 
Nov 25 19:09:56 server kernel: md: raid1 personality registered as nr 3
Nov 25 19:09:56 server kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Nov 25 19:09:56 server kernel: md: Autodetecting RAID arrays.
Nov 25 19:09:56 server kernel:  [events: 00000062]
Nov 25 19:09:56 server keytable: 
Nov 25 19:09:56 server kernel:  [events: 00000062]
Nov 25 19:09:56 server keytable: Loading system font: 
Nov 25 19:09:56 server kernel: md: autorun ...
Nov 25 19:09:56 server kernel: md: considering hdg1 ...
Nov 25 19:09:56 server kernel: md:  adding hdg1 ...
Nov 25 19:09:56 server kernel: md:  adding hde1 ...
Nov 25 19:09:56 server kernel: md: created md0
Nov 25 19:09:56 server kernel: md: bind<hde1,1>
Nov 25 19:09:56 server kernel: md: bind<hdg1,2>
Nov 25 19:09:56 server kernel: md: running: <hdg1><hde1>
Nov 25 19:09:56 server kernel: md: hdg1's event counter: 00000062
Nov 25 19:09:56 server kernel: md: hde1's event counter: 00000062
Nov 25 19:09:56 server kernel: md: device name has changed from [dev 08:11] to hdg1 since last import!
Nov 25 19:09:56 server kernel: md: device name has changed from [dev 08:01] to hde1 since last import!
Nov 25 19:09:56 server kernel: md: RAID level 1 does not need chunksize! Continuing anyway.
Nov 25 19:09:57 server kernel: md0: max total readahead window set to 124k
Nov 25 19:09:57 server keytable: 
Nov 25 19:09:57 server kernel: md0: 1 data-disks, max readahead per data-disk: 124k
Nov 25 19:09:57 server kernel: raid1: device hdg1 operational as mirror 1
Nov 25 19:09:57 server kernel: raid1: device hde1 operational as mirror 0
Nov 25 19:09:57 server kernel: raid1: raid set md0 active with 2 out of 2 mirrors
Nov 25 19:09:57 server kernel: md: updating md0 RAID superblock on device
Nov 25 19:09:57 server kernel: md: hdg1 [events: 00000063]<6>(write) hdg1's sb offset: 38820928
Nov 25 19:09:57 server kernel: md: hde1 [events: 00000063]<6>(write) hde1's sb offset: 38820928
Nov 25 19:09:57 server kernel: md: ... autorun DONE.
Nov 25 19:09:57 server kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Nov 25 19:09:57 server rc: Starting keytable:  succeeded
Nov 25 19:09:57 server kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Nov 25 19:09:57 server kernel: IP: routing cache hash table of 512 buckets, 4Kbytes
Nov 25 19:09:57 server kernel: TCP: Hash tables configured (established 8192 bind 16384)
Nov 25 19:09:57 server kernel: Linux IP multicast router 0.06 plus PIM-SM
Nov 25 19:09:57 server kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Nov 25 19:09:57 server kernel: kjournald starting.  Commit interval 5 seconds
Nov 25 19:09:57 server kernel: EXT3-fs: mounted filesystem with ordered data mode.
Nov 25 19:09:57 server kernel: VFS: Mounted root (ext3 filesystem) readonly.
Nov 25 19:09:57 server kernel: Freeing unused kernel memory: 128k freed
Nov 25 19:09:57 server random: Initializing random number generator:  succeeded
Nov 25 19:09:57 server kernel: usb.c: registered new driver usbdevfs
Nov 25 19:09:57 server kernel: usb.c: registered new driver hub
Nov 25 19:09:57 server kernel: usb-uhci.c: $Revision: 1.275 $ time 20:19:19 Nov  2 2003
Nov 25 19:09:57 server kernel: usb-uhci.c: High bandwidth mode enabled
Nov 25 19:09:57 server kernel: PCI: Found IRQ 9 for device 00:04.2
Nov 25 19:09:57 server kernel: PCI: Sharing IRQ 9 with 00:06.0
Nov 25 19:09:57 server kernel: PCI: Sharing IRQ 9 with 00:09.0
Nov 25 19:09:57 server kernel: usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
Nov 25 19:09:57 server kernel: usb-uhci.c: Detected 2 ports
Nov 25 19:09:57 server kernel: usb.c: new USB bus registered, assigned bus number 1
Nov 25 19:09:57 server kernel: hub.c: USB hub found
Nov 25 19:09:57 server kernel: hub.c: 2 ports detected
Nov 25 19:09:57 server kernel: usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
Nov 25 19:09:57 server kernel: usb.c: registered new driver hid
Nov 25 19:09:57 server kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
Nov 25 19:09:57 server kernel: hid-core.c: USB HID support drivers
Nov 25 19:09:57 server kernel: mice: PS/2 mouse device common for all mice
Nov 25 19:09:57 server kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,0), internal journal
Nov 25 19:09:57 server kernel: SCSI subsystem driver Revision: 1.00
Nov 25 19:09:57 server kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
Nov 25 19:09:57 server kernel: parport0: irq 7 detected
Nov 25 19:09:57 server kernel: ip_tables: (C) 2000-2002 Netfilter core team
Nov 25 19:09:57 server kernel: Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Nov 25 19:09:57 server kernel: Copyright (c) 2003 Intel Corporation
Nov 25 19:09:57 server kernel: 
Nov 25 19:09:57 server kernel: PCI: Found IRQ 9 for device 00:07.0
Nov 25 19:09:57 server kernel: PCI: Sharing IRQ 9 with 00:0a.0
Nov 25 19:09:57 server kernel: e100: eth0: Intel(R) PRO/100 Network Connection
Nov 25 19:09:57 server kernel: 
Nov 25 19:09:57 server kernel: ip_tables: (C) 2000-2002 Netfilter core team
Nov 25 19:09:57 server kernel: e100: eth0 NIC Link is Up 100 Mbps Full duplex
Nov 25 19:09:57 server kernel: ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
Nov 25 19:09:57 server rc: Starting pcmcia:  succeeded
Nov 25 19:09:57 server kernel:   http://www.scyld.com/network/ne2k-pci.html
Nov 25 19:09:57 server kernel: PCI: Found IRQ 9 for device 00:09.0
Nov 25 19:09:57 server kernel: PCI: Sharing IRQ 9 with 00:04.2
Nov 25 19:09:57 server kernel: PCI: Sharing IRQ 9 with 00:06.0
Nov 25 19:09:57 server kernel: eth1: RealTek RTL-8029 found at 0xb400, IRQ 9, 00:00:01:00:7C:44.
Nov 25 19:09:57 server kernel: ip_tables: (C) 2000-2002 Netfilter core team
Nov 25 19:09:57 server kernel: pcnet32.c:v1.27a 10.02.2002 tsbogend@alpha.franken.de
Nov 25 19:09:57 server kernel: PCI: Found IRQ 10 for device 00:0b.0
Nov 25 19:09:57 server kernel: pcnet32: PCnet/PCI II 79C970A at 0xb000, warning: CSR address invalid,
Nov 25 19:09:57 server kernel:     using instead PROM address of 00 00 01 36 92 67 assigned IRQ 10.
Nov 25 19:09:57 server kernel: eth2: registered as PCnet/PCI II 79C970A
Nov 25 19:09:57 server kernel: pcnet32: 1 cards_found.
Nov 25 19:09:57 server kernel: ip_tables: (C) 2000-2002 Netfilter core team
Nov 25 19:09:57 server mount: mount: /dev/sdc1 is not a valid block device
Nov 25 19:09:57 server netfs: Mounting other filesystems:  failed
Nov 25 19:09:57 server apmd[1831]: Version 3.0.2 (APM BIOS 1.2, Linux driver 1.16)
Nov 25 19:09:57 server apmd: apmd startup succeeded
Nov 25 19:09:58 server autofs: automount startup succeeded
Nov 25 19:09:55 server network: Bringing up interface eth2:  succeeded 
Nov 25 19:09:58 server sshd:  succeeded
Nov 25 19:09:58 server apmd[1831]: Charge: * * * (-1% unknown)

--=_host1.orm.mipt.ru-16815-1069789554-0001-2--
