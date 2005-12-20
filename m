Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVLTVzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVLTVzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVLTVzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:55:44 -0500
Received: from bay101-f33.bay101.hotmail.com ([64.4.56.43]:44245 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932152AbVLTVzl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:55:41 -0500
Message-ID: <BAY101-F33B48301330A7FFF7849A4DF3E0@phx.gbl>
X-Originating-IP: [70.150.153.162]
X-Originating-Email: [jtreubig@hotmail.com]
From: "John Treubig" <jtreubig@hotmail.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: ATA Write Error and Time-out Notification in User Space
Date: Tue, 20 Dec 2005 15:55:41 -0600
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_3cc1_7032_3571"
X-OriginalArrivalTime: 20 Dec 2005 21:55:41.0459 (UTC) FILETIME=[1EBAF630:01C605B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_3cc1_7032_3571
Content-Type: text/plain; format=flowed

Where would I look in the LibATA/SCSI chain to permit Write Error and 
Time-out notification to be passed back to user space without hanging the 
system?

BACKGROUND:  We've implemented a disk drive testing system under 2.6 using 
LibATA to access the ATA devices.  During testing, we attach additional 
"test" drives to the system and perform reads and writes to these drives.  
The system drive is not part of the test environment.  During testing we 
expect to see errors reported (read, write and time-out) from the "test" 
drives.  When a SCSI disks report errors, the SCSI handlers perform as 
expected, reporting the error and recovering.  When ATA drives report 
errors, only read errors recover and we are able to capture the error.  
Write and time-out errors hang the system.

Hardware tested:
Promise Ultra133 TX2 (PDC20269 chip; pata_pdc2027x driver)

Kernel versions tested:
2.6.11
2.6.14 rc2
2.6.15 rc5

RECREATING THE PROBLEM: In our situation, we see the write and time-out 
failures when we screen drives beyond their commercial temperature limits 
for military applications using a custom application to read and write to 
the "test" drives.  Rather than having to have a drive in a special 
temperature environment, the easiest way to simulate the failures is to 
unplug power to a test drive while it is under test.  The resulting errors 
and time-outs will hang the system.  Under this scenario, any type of read 
or write to the "test" drive will fail the same as with our application.  
I've attached copies of the system messages and startup-log to give further 
details into the hangs.

---
Best wishes,
John Treubig
VT Miltope
Senior Test Engineer
(334) 613-6495


------=_NextPart_000_3cc1_7032_3571
Content-Type: text/plain; name="dmesg.txt"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="dmesg.txt"

write back
[  115.889416] ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 24
[  115.916707] ata_scsiop_noop: ENTER
[  115.943552] ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
[  115.970878] ata_scsiop_read_cap: ENTER
[  115.997800] SCSI device sdc: 78138047 512-byte hdwr sectors (40007 MB)
[  116.025414] ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 08
[  116.053090] ata_scsiop_mode_sense: ENTER
[  116.080352] ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 24
[  116.108002] ata_scsiop_mode_sense: ENTER
[  116.135220] SCSI device sdc: drive cache: write back
[  116.162352]  sdc:<3>ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 00 00 00 00 
00 08
[  116.189890] ata_scsi_translate: ENTER
[  116.217022] scsi_10_lba_len: ten-byte command
[  116.244166] ata_sg_setup: ENTER, ata2
[  116.271090] ata_sg_setup: 1 sg elements mapped
[  116.297906] ata_fill_sg: PRD[0] = (0xFD0A000, 0x1000)
[  116.324556] ata_dev_select: ENTER, ata2: device 0, wait 1
[  116.351065] ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
[  116.377858] ata_tf_load_mmio: device 0xE0
[  116.404290] ata_exec_command_mmio: ata2: cmd 0xC8
[  116.431008] ata_scsi_translate: EXIT
[  116.835832] ata_host_intr: ata2: host_stat 0x4
[  116.862205] ata_host_intr: ata2: protocol 4 (dev_stat 0x50)
[  116.888452] ata_sg_clean: unmapping 1 sg elements
[  116.914752] ata_qc_complete: EXIT
[  116.940787]  unknown partition table
[  116.966767] sd 4:0:0:0: Attached scsi disk sdc
[  116.994509] sr0: scsi-1 drive
[  117.020498] Uniform CD-ROM driver Revision: 3.20
[  117.046702] sr 2:0:0:0: Attached scsi CD-ROM sr0
[  117.046756] sd 0:0:6:0: Attached scsi generic sg0 type 0
[  117.073246] sr 2:0:0:0: Attached scsi generic sg1 type 5
[  117.099473] sd 3:0:0:0: Attached scsi generic sg2 type 0
[  117.125325] sd 4:0:0:0: Attached scsi generic sg3 type 0
[  117.150525] Fusion MPT base driver 3.03.04
[  117.175476] Copyright (c) 1999-2005 LSI Logic Corporation
[  117.200672] Fusion MPT SPI Host driver 3.03.04
[  117.225785] Fusion MPT FC Host driver 3.03.04
[  117.250437] Fusion MPT SAS Host driver 3.03.04
[  117.274695] Fusion MPT misc device (ioctl) driver 3.03.04
[  117.298994] mptctl: Registered with Fusion MPT base driver
[  117.323331] mptctl: /dev/mptctl @ (major,minor=10,220)
[  117.348061] ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
[  117.372545] ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 22 
(level, high) -> IRQ 20
[  117.397705] PCI: Setting latency timer of device 0000:00:02.2 to 64
[  117.397709] ehci_hcd 0000:00:02.2: EHCI Host Controller
[  117.422670] ehci_hcd 0000:00:02.2: debug port 1
[  117.447214] PCI: cache line size of 64 is not supported by device 
0000:00:02.2
[  117.447282] ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus 
number 1
[  117.472256] ehci_hcd 0000:00:02.2: irq 20, io mem 0xe0005000
[  117.496766] ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 
Dec 2004
[  117.521393] hub 1-0:1.0: USB hub found
[  117.545622] hub 1-0:1.0: 6 ports detected
[  117.670136] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) 
Driver (PCI)
[  117.670519] ACPI: PCI Interrupt Link [APCF] enabled at IRQ 21
[  117.694783] ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 21 
(level, high) -> IRQ 21
[  117.719857] PCI: Setting latency timer of device 0000:00:02.0 to 64
[  117.719861] ohci_hcd 0000:00:02.0: OHCI Host Controller
[  117.744608] ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus 
number 2
[  117.769437] ohci_hcd 0000:00:02.0: irq 21, io mem 0xe0003000
[  117.846898] hub 2-0:1.0: USB hub found
[  117.871420] hub 2-0:1.0: 3 ports detected
[  117.996976] ACPI: PCI Interrupt Link [APCG] enabled at IRQ 20
[  118.021855] ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 20 
(level, high) -> IRQ 22
[  118.047521] PCI: Setting latency timer of device 0000:00:02.1 to 64
[  118.047524] ohci_hcd 0000:00:02.1: OHCI Host Controller
[  118.072995] ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus 
number 3
[  118.098933] ohci_hcd 0000:00:02.1: irq 22, io mem 0xe0004000
[  118.177418] hub 3-0:1.0: USB hub found
[  118.203101] hub 3-0:1.0: 3 ports detected
[  118.329153] USB Universal Host Controller Interface driver v2.3
[  118.355385] usbcore: registered new driver usblp
[  118.381437] drivers/usb/class/usblp.c: v0.13: USB Printer Device Class 
driver
[  118.408307] Initializing USB Mass Storage driver...
[  118.435370] usbcore: registered new driver usb-storage
[  118.462560] USB Mass Storage support registered.
[  118.489815] usbcore: registered new driver usbhid
[  118.517024] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[  118.544622] mice: PS/2 mouse device common for all mice
[  118.573058] NET: Registered protocol family 2
[  118.609747] IP route cache hash table entries: 4096 (order: 2, 16384 
bytes)
[  118.639384] TCP established hash table entries: 16384 (order: 4, 65536 
bytes)
[  118.669324] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[  118.699306] TCP: Hash tables configured (established 16384 bind 16384)
[  118.729249] TCP reno registered
[  118.759060] ip_conntrack version 2.4 (2047 buckets, 16376 max) - 212 
bytes per conntrack
[  118.798121] input: AT Translated Set 2 keyboard as /class/input/input0
[  118.845373] ip_tables: (C) 2000-2002 Netfilter core team
[  118.918268] ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  
http://snowman.net/projects/ipt_recent/
[  118.951157] arp_tables: (C) 2002 David S. Miller
[  118.992131] TCP bic registered
[  119.024260] NET: Registered protocol family 1
[  119.056060] NET: Registered protocol family 17
[  119.087602] Using IPI Shortcut mode
[  119.341785] input: ImPS/2 Generic Wheel Mouse as /class/input/input1
[  119.543784] VFS: Mounted root (ext2 filesystem) readonly.
[  119.575808] Freeing unused kernel memory: 216k freed
[  124.822183] Adding 1188800k swap on /dev/hda3.  Priority:-1 extents:1 
across:1188800k
[  125.145728] radDIO: module license 'unspecified' taints kernel.
[  125.152977] RAD-DIO driver for NuDAQ PCI-7224 V1.0
[  125.152982] Developed for Miltope Corp. by Radical Systems, Inc.
[  125.152984] http://www.radicalsystems.com
[  125.152986] Copyright (c) 2004, Radical Systems, Inc.
[  125.152988] All rights reserved.
[  125.159787] Probing...
[  125.159808] ACPI: PCI Interrupt 0000:01:06.0[A] -> Link [APC3] -> GSI 18 
(level, high) -> IRQ 19
[  125.159819] Found Device:
[  125.159821] Name:     0000:01:06.0
[  125.159823] InitFlag: 0x7248
[  125.159824] BusNo:    0x1
[  125.159826] DevFunc:  0x30
[  125.159827] LCRBase:  0x7000
[  125.159829] BaseAddr: 0x7400
[  125.159830] IRQ No:   0x5
[  125.218473] sata_promise 0000:01:0a.0: version 1.03
[  125.218503] ACPI: PCI Interrupt 0000:01:0a.0[A] -> Link [APC3] -> GSI 18 
(level, high) -> IRQ 19
[  125.228953] ata_device_add: ENTER
[  125.228955] ata_host_add: ENTER
[  125.228996] ata_port_start: prd alloc, virt cf01a000, dma f01a000
[  125.229001] ata5: SATA max UDMA/133 cmd 0xD086A200 ctl 0xD086A238 bmdma 
0x0 irq 19
[  125.229006] ata_host_add: ENTER
[  125.229023] ata_port_start: prd alloc, virt cf195000, dma f195000
[  125.229027] ata6: SATA max UDMA/133 cmd 0xD086A280 ctl 0xD086A2B8 bmdma 
0x0 irq 19
[  125.229032] ata_host_add: ENTER
[  125.229049] ata_port_start: prd alloc, virt cf025000, dma f025000
[  125.229053] ata7: SATA max UDMA/133 cmd 0xD086A300 ctl 0xD086A338 bmdma 
0x0 irq 19
[  125.229058] ata_host_add: ENTER
[  125.229076] ata_port_start: prd alloc, virt cf21d000, dma f21d000
[  125.229080] ata8: SATA max UDMA/133 cmd 0xD086A380 ctl 0xD086A3B8 bmdma 
0x0 irq 19
[  125.229087] ata_device_add: probe begin
[  125.229089] ata_device_add: ata5: probe begin
[  125.429660] ata5: no device found (phy stat 00000000)
[  125.429663] ata_device_add: ata5: probe end
[  125.429666] scsi7 : sata_promise
[  125.436545] ata_device_add: ata6: probe begin
[  125.637365] ata_bus_reset: ENTER, host 6, port 1
[  125.637377] ata_bus_softreset: ata6: bus reset via SRST
[  125.893001] ata_dev_classify: found ATA device by sig
[  125.893022] ata_bus_reset: EXIT
[  125.893024] ata_dev_identify: ENTER, host 6, dev 0
[  125.893027] ata_dev_select: ENTER, ata6: device 0, wait 1
[  125.893054] ata_dev_identify: do ATA identify
[  125.893057] pdc_qc_prep: ENTER
[  125.893059] ata_dev_select: ENTER, ata6: device 0, wait 1
[  125.893110] ata_exec_command_mmio: ata6: cmd 0xEC
[  125.895981] ata_pio_sector: data read
[  125.896332] ata_qc_complete: EXIT
[  125.896346] ata6: dev 0 cfg 49:2f00 82:346b 83:5b01 84:4003 85:3469 
86:1801 87:4003 88:407f
[  125.896350] ata_dump_id: 49==0x2f00  53==0x0007  63==0x0007  64==0x0003  
75==0x0000
[  125.896353] ata_dump_id: 80==0x007e  81==0x001b  82==0x346b  83==0x5b01  
84==0x4003
[  125.896356] ata_dump_id: 88==0x407f  93==0x604f
[  125.896360] ata6: dev 0 ATA-6, max UDMA/133, 234441648 sectors: LBA
[  125.896364] ata_dev_identify: EXIT, drv_stat = 0x50
[  125.896366] ata6(0): applying bridge limits
[  125.896369] ata_dev_identify: ENTER/EXIT (host 6, dev 1) -- nodev
[  125.896373] ata_host_set_pio: base 0x8 xfer_mode 0xc mask 0x1f x 4
[  125.896378] ata_dev_set_xfermode: set features - xfer mode
[  125.896380] pdc_qc_prep: ENTER
[  125.896383] pdc_packet_start: ENTER, ap cf6ca284
[  125.896514] pdc_interrupt: ENTER
[  125.896517] pdc_interrupt: port 0
[  125.896519] pdc_interrupt: port 1
[  125.896533] ata_qc_complete: EXIT
[  125.896535] pdc_interrupt: port 2
[  125.896536] pdc_interrupt: port 3
[  125.896538] pdc_interrupt: EXIT
[  125.896540] ata_dev_set_xfermode: EXIT
[  125.896543] ata_dev_set_mode: idx=5 xfer_shift=0, xfer_mode=0x45, 
base=0x40, offset=5
[  125.896546] ata6: dev 0 configured for UDMA/100
[  125.896548] ata_device_add: ata6: probe end
[  125.896550] scsi8 : sata_promise
[  125.903442] ata_device_add: ata7: probe begin
[  126.103668] ata7: no device found (phy stat 00000000)
[  126.103671] ata_device_add: ata7: probe end
[  126.103674] scsi9 : sata_promise
[  126.110431] ata_device_add: ata8: probe begin
[  126.310364] ata8: no device found (phy stat 00000000)
[  126.310367] ata_device_add: ata8: probe end
[  126.310370] scsi10 : sata_promise
[  126.317094] ata_device_add: probe begin
[  126.317175] ata_scsi_dump_cdb: CDB (6:0,0,0) 12 00 00 00 24 00 00 00 00
[  126.317179] ata_scsiop_inq_std: ENTER
[  126.317216] ata_scsi_dump_cdb: CDB (6:0,0,0) 12 00 00 00 60 00 00 00 00
[  126.317219] ata_scsiop_inq_std: ENTER
[  126.317233]   Vendor: ATA       Model: ST3120023AS       Rev: 3.01
[  126.317241]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[  126.324097] ata_scsi_dump_cdb: CDB (6:0,0,0) 00 00 00 00 00 00 00 00 00
[  126.324103] ata_scsiop_noop: ENTER
[  126.324133] ata_scsi_dump_cdb: CDB (6:0,0,0) 25 00 00 00 00 00 00 00 00
[  126.324136] ata_scsiop_read_cap: ENTER
[  126.324146] SCSI device sdd: 234441648 512-byte hdwr sectors (120034 MB)
[  126.324154] ata_scsi_dump_cdb: CDB (6:0,0,0) 5a 00 08 00 00 00 00 00 08
[  126.324157] ata_scsiop_mode_sense: ENTER
[  126.324168] ata_scsi_dump_cdb: CDB (6:0,0,0) 5a 00 08 00 00 00 00 00 24
[  126.324171] ata_scsiop_mode_sense: ENTER
[  126.324176] SCSI device sdd: drive cache: write back
[  126.330966] ata_scsi_dump_cdb: CDB (6:0,0,0) 00 00 00 00 00 00 00 00 24
[  126.330972] ata_scsiop_noop: ENTER
[  126.331003] ata_scsi_dump_cdb: CDB (6:0,0,0) 25 00 00 00 00 00 00 00 00
[  126.331006] ata_scsiop_read_cap: ENTER
[  126.331016] SCSI device sdd: 234441648 512-byte hdwr sectors (120034 MB)
[  126.331023] ata_scsi_dump_cdb: CDB (6:0,0,0) 5a 00 08 00 00 00 00 00 08
[  126.331026] ata_scsiop_mode_sense: ENTER
[  126.331037] ata_scsi_dump_cdb: CDB (6:0,0,0) 5a 00 08 00 00 00 00 00 24
[  126.331040] ata_scsiop_mode_sense: ENTER
[  126.331045] SCSI device sdd: drive cache: write back
[  126.331048]  sdd:<3>ata_scsi_dump_cdb: CDB (6:0,0,0) 28 00 00 00 00 00 00 
00 08
[  126.331079] ata_scsi_translate: ENTER
[  126.331083] scsi_10_lba_len: ten-byte command
[  126.331087] ata_sg_setup: ENTER, ata6
[  126.331090] ata_sg_setup: 1 sg elements mapped
[  126.331093] pdc_qc_prep: ENTER
[  126.331096] ata_fill_sg: PRD[0] = (0xF74E000, 0x1000)
[  126.331099] pdc_packet_start: ENTER, ap cf6ca284
[  126.331104] ata_scsi_translate: EXIT
[  126.352866] pdc_interrupt: ENTER
[  126.352870] pdc_interrupt: port 0
[  126.352872] pdc_interrupt: port 1
[  126.352888] ata_sg_clean: unmapping 1 sg elements
[  126.352890] ata_qc_complete: EXIT
[  126.352892] pdc_interrupt: port 2
[  126.352894] pdc_interrupt: port 3
[  126.352895] pdc_interrupt: EXIT
[  126.352906]  unknown partition table
[  126.352939] sd 8:0:0:0: Attached scsi disk sdd
[  126.366494] sd 8:0:0:0: Attached scsi generic sg4 type 0
[  126.366520] ata_device_add: EXIT, returning 4
[  126.830077] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  126.830291] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  126.830583] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  126.830829] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  126.880736] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  126.880757] ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 80 00 60 00 00 00 24
[  126.880780] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  126.880788] ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 60 00 00 00 24
[  126.880791] ata_scsiop_inq_std: ENTER
[  126.880826] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  126.880834] ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 83 00 60 00 00 00 24
[  126.880857] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  126.880864] ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 80 00 60 00 00 00 24
[  126.914346] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  126.914367] ata_scsi_dump_cdb: CDB (2:0,0,0) 12 01 80 00 60 00 00 00 24
[  126.914391] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  126.914398] ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 60 00 00 00 24
[  126.914401] ata_scsiop_inq_std: ENTER
[  126.914435] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  126.914443] ata_scsi_dump_cdb: CDB (2:0,0,0) 12 01 83 00 60 00 00 00 24
[  126.914486] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  126.914493] ata_scsi_dump_cdb: CDB (2:0,0,0) 12 01 80 00 60 00 00 00 24
[  126.947093] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  126.947114] ata_scsi_dump_cdb: CDB (6:0,0,0) 12 01 80 00 60 00 00 00 24
[  126.947137] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  126.947145] ata_scsi_dump_cdb: CDB (6:0,0,0) 12 00 00 00 60 00 00 00 24
[  126.947148] ata_scsiop_inq_std: ENTER
[  126.947182] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  126.947189] ata_scsi_dump_cdb: CDB (6:0,0,0) 12 01 83 00 60 00 00 00 24
[  126.947213] program scsi_unique_id is using a deprecated SCSI ioctl, 
please convert it to SG_IO
[  126.947221] ata_scsi_dump_cdb: CDB (6:0,0,0) 12 01 80 00 60 00 00 00 24
[  127.560220] kjournald starting.  Commit interval 5 seconds
[  127.560297] EXT3 FS on hda1, internal journal
[  127.560303] EXT3-fs: mounted filesystem with ordered data mode.
[  139.382882] r8169: eth0: link up


------=_NextPart_000_3cc1_7032_3571
Content-Type: application/x-gzip; name="messages1.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="messages1.gz"

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


------=_NextPart_000_3cc1_7032_3571--
