Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbUDAJcZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 04:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbUDAJcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 04:32:25 -0500
Received: from pop.gmx.de ([213.165.64.20]:2007 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262274AbUDAJcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 04:32:07 -0500
X-Authenticated: #21910825
Message-ID: <406BE23F.3000802@gmx.net>
Date: Thu, 01 Apr 2004 11:34:55 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: libata problems on Promise SX4000 controller
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000002010400070307030007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000002010400070307030007
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I had problems getting my Promise SX4000 controller to run with libata.
First, I noticed libata refused to drive it (no associated PCI id). After
patching that (including the handler for the right chipset), a
"modprobe sata_promise" hung for about 15 minutes while initializing the
ECC RAM. It then recognized the one attached harddisk, but disk access was
not really possible (I gave up after waiting for half an hour or so).
Let me apologize for testing an older version of libata. At the time I had
the problems, it was the newest available version. I enabled debugging and
post the logs here in the hope that they might help supporting this
controller in the future.

A note about the controller itself: It has 4 Parallel ATA ports and no
Serial ATA ports. The controller sports the usual SoftRAID from Promise
(0,1,0+1 and 5). The RAID5 seems to be a new feature. I do not care about
the RAID (well, I do, I'm writing a dm configuration helper for it right
now), but I would like to access the drive.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

--------------000002010400070307030007
Content-Type: text/plain;
 name="satalogsx4000.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="satalogsx4000.txt"

[...]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L080AVVA07-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 >
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
ACPI: (supports S0 S1 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
found reiserfs format "3.6" with standard journal
reiserfs: using ordered data mode
Reiserfs journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda1) for (hda1)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 176k freed
[...]
SCSI subsystem initialized
libata version 1.01 loaded.
sata_promise version 0.91
pdc20621_dimm_init: Time Period Register (0x40): 0xffffffff
pdc20621_dimm_init: Time Counter Register (0x44): 0xf0ef5b6b
pdc20621_dimm_init: Num counters 0xf10a494 (252748948)
pdc20621_dimm_init: 10 * Internal clk = 0x34a (842)
pdc20621_dimm_init: 10 * Internal clk * 33 = 0x6c8a (27786)
pdc20621_dimm_init: PLL F Param: 0x30 (48)
pdc20621_dimm_init: pci_status: 0x8a301824
pdc20621_dimm_init: Local DIMM Speed = 100
pdc20621_dimm_init: Local DIMM Size = 128MB
Local DIMM ECC Enabled
0, 0, 
55, aa, Promise Not Yet Defined 1.1098
55, aa, Promise Not Yet Defined 1.1098
pdc20621_dimm_init: Start ECC initialization
pdc20621_dimm_init: Finish ECC initialization
ata_device_add: ENTER
ata_host_add: ENTER
ata_port_start: prd alloc, virt 000001000047e000, dma 47e000
ata1: SATA max UDMA/133 cmd 0xFFFFFF0000280200 ctl 0xFFFFFF0000280238 bmdma 0x0 irq 19
ata_host_add: ENTER
ata_thread_iter: ata1: thr_state THR_PROBE_START
ata_port_start: prd alloc, virt 000001000000c000, dma c000
ata2: SATA max UDMA/133 cmd 0xFFFFFF0000280280 ctl 0xFFFFFF00002802B8 bmdma 0x0 irq 19
ata_host_add: ENTER
ata_thread_iter: ata2: thr_state THR_PROBE_START
ata_port_start: prd alloc, virt 000001000000f000, dma f000
ata3: SATA max UDMA/133 cmd 0xFFFFFF0000280300 ctl 0xFFFFFF0000280338 bmdma 0x0 irq 19
ata_host_add: ENTER
ata_thread_iter: ata3: thr_state THR_PROBE_START
ata_port_start: prd alloc, virt 000001000045b000, dma 45b000
ata4: SATA max UDMA/133 cmd 0xFFFFFF0000280380 ctl 0xFFFFFF00002803B8 bmdma 0x0 irq 19
ata_device_add: probe begin
ata_device_add: ata1: probe begin
ata_device_add: ata1: probe-wait begin
ata_thread_iter: ata4: thr_state THR_PROBE_START
ata_thread_iter: ata1: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata1: thr_state THR_PORT_RESET
pdc_20621_phy_reset: ENTER
ata_bus_reset: ENTER, host 1, port 0
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 1, dev 0
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_dev_identify: do ATA identify
ata_exec: ata1: cmd 0xEC
ata_exec_command_mmio: ata1: cmd 0xEC
ata1: dev 0 cfg 49:2f00 82:74eb 83:4bea 84:4000 85:7469 86:0802 87:4003 88:203f
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0007  64==0x0003  75==0x001f  
ata_dump_id: 80==0x003c  81==0x0015  82==0x74eb  83==0x4bea  84==0x4000  
ata_dump_id: 88==0x203f  93==0x600b
ata1: dev 0 ATA, max UDMA/100, 120103200 sectors
ata_dev_identify: EXIT, drv_stat = 0x50
ata_dev_identify: ENTER/EXIT (host 1, dev 1) -- nodev
ata_host_set_udma: udma masks: host 0x7F, master 0x3F, slave 0xFF
ata_host_set_udma: mask 0x3F i 0x47 j 7
ata_host_set_udma: mask 0x3F i 0x46 j 6
ata_host_set_udma: mask 0x3F i 0x45 j 5
ata_dev_set_xfermode: set features - xfer mode
ata_tf_load_mmio: feat 0x3 nsect 0x45 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec: ata1: cmd 0xEF
ata_exec_command_mmio: ata1: cmd 0xEF
ata_dev_set_xfermode: EXIT
ata1: dev 0 configured for UDMA/100
ata_thread_iter: ata1: new thr_state THR_PROBE_SUCCESS, returning 0
ata_thread_iter: ata1: thr_state THR_PROBE_SUCCESS
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 0
ata_thread_iter: ata1: thr_state THR_IDLE
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 30000
ata_device_add: ata1: probe-wait end
scsi0 : sata_promise
ata_device_add: ata2: probe begin
ata_device_add: ata2: probe-wait begin
ata_thread_iter: ata2: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata2: thr_state THR_PORT_RESET
pdc_20621_phy_reset: ENTER
ata_bus_reset: ENTER, host 2, port 1
ata_bus_softreset: ata2: bus reset via SRST
ATA: abnormal status 0x8 on port 0xFFFFFF000028029C
ata_bus_reset: EXIT
ata_dev_identify: ENTER/EXIT (host 2, dev 0) -- nodev
ata_dev_identify: ENTER/EXIT (host 2, dev 1) -- nodev
ata_thread_iter: ata2: new thr_state THR_PROBE_FAILED, returning 0
ata_thread_iter: ata2: thr_state THR_PROBE_FAILED
ata_thread_iter: ata2: new thr_state THR_AWAIT_DEATH, returning 0
ata_thread_iter: ata2: thr_state THR_AWAIT_DEATH
ata_thread_iter: ata2: new thr_state THR_AWAIT_DEATH, returning -1
ata2: thread exiting
ata_device_add: ata2: probe-wait end
scsi1 : sata_promise
ata_device_add: ata3: probe begin
ata_device_add: ata3: probe-wait begin
ata_thread_iter: ata3: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata3: thr_state THR_PORT_RESET
pdc_20621_phy_reset: ENTER
ata_bus_reset: ENTER, host 3, port 2
ata_bus_softreset: ata3: bus reset via SRST
ATA: abnormal status 0x8 on port 0xFFFFFF000028031C
ata_bus_reset: EXIT
ata_dev_identify: ENTER/EXIT (host 3, dev 0) -- nodev
ata_dev_identify: ENTER/EXIT (host 3, dev 1) -- nodev
ata_thread_iter: ata3: new thr_state THR_PROBE_FAILED, returning 0
ata_thread_iter: ata3: thr_state THR_PROBE_FAILED
ata_thread_iter: ata3: new thr_state THR_AWAIT_DEATH, returning 0
ata_thread_iter: ata3: thr_state THR_AWAIT_DEATH
ata_thread_iter: ata3: new thr_state THR_AWAIT_DEATH, returning -1
ata3: thread exiting
ata_device_add: ata3: probe-wait end
scsi2 : sata_promise
ata_device_add: ata4: probe begin
ata_device_add: ata4: probe-wait begin
ata_thread_iter: ata4: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata4: thr_state THR_PORT_RESET
pdc_20621_phy_reset: ENTER
ata_bus_reset: ENTER, host 4, port 3
ata_bus_softreset: ata4: bus reset via SRST
ATA: abnormal status 0x8 on port 0xFFFFFF000028039C
ata_bus_reset: EXIT
ata_dev_identify: ENTER/EXIT (host 4, dev 0) -- nodev
ata_dev_identify: ENTER/EXIT (host 4, dev 1) -- nodev
ata_thread_iter: ata4: new thr_state THR_PROBE_FAILED, returning 0
ata_thread_iter: ata4: thr_state THR_PROBE_FAILED
ata_thread_iter: ata4: new thr_state THR_AWAIT_DEATH, returning 0
ata_thread_iter: ata4: thr_state THR_AWAIT_DEATH
ata_thread_iter: ata4: new thr_state THR_AWAIT_DEATH, returning -1
ata4: thread exiting
ata_device_add: ata4: probe-wait end
scsi3 : sata_promise
ata_device_add: probe begin
ata_scsi_queuecmd: CDB (1:0,0,0) 12 00 00 00 24 00 00 00 00
ata_scsiop_inq_std: ENTER
ata_scsi_queuecmd: CDB (1:0,0,0) 12 00 00 00 61 00 00 00 00
ata_scsiop_inq_std: ENTER
  Vendor: ATA       Model: IC35L060AVER07-0  Rev: 1.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata_scsi_queuecmd: CDB (1:0,0,0) a0 00 00 00 00 00 00 00 04
ata_scsiop_report_luns: ENTER
ata_scsi_queuecmd: CDB (1:0,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (1:0,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (2:0,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (2:0,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (3:0,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (3:0,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (4:0,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (4:0,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,15,0) 12 00 00 00 24 00 00 00 00
ata_device_add: EXIT, returning 4
ata_thread_iter: ata1: thr_state THR_IDLE
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata1: thr_state THR_IDLE
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata1: thr_state THR_IDLE
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 30000

--------------000002010400070307030007--

