Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263256AbTJaMOp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 07:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTJaMOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 07:14:45 -0500
Received: from kokytos.rz.informatik.uni-muenchen.de ([141.84.214.13]:59336
	"EHLO kokytos.rz.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S263256AbTJaMO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 07:14:27 -0500
Date: Fri, 31 Oct 2003 13:14:25 +0100
From: "Oliver M. Bolzer" <oliver@gol.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH #2] Re: SATA and 2.6.0-test9
Message-ID: <20031031121425.GA6404@magi.fakeroot.net>
References: <20031027141531.GD15558@vic20.blipp.com> <20031027165809.GD19711@gtf.org> <20031027181052.GG32168@vic20.blipp.com> <3FA14F2F.1080700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA14F2F.1080700@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 30, 2003 at 12:49:35PM -0500, Jeff Garzik <jgarzik@pobox.com> wrote...

> >>Does it improve things, if you change ATA_FLAG_SRST to
> >>ATA_FLAG_SATA_RESET, in drivers/scsi/sata_via.c ?
 
> Actually, attached is a better patch...


I've tried the patch on my Promise FastTrak S150 TX4 and it improves
things a lot. The drives and even the partitions are corretly
recognized, at least for the first 3 ports. The 4th port seems to
hang after sending it the ATA_CMD_READ_EXT (0x25) command, resulting
in a DMA timeout and the same endless loop that occured when the ports
could not be resetted (vanilla 2.6.0-test9 without SRST flag).

Would it be useful if I unhook the 4th drive to see how much further
the driver can proceed with the first 3 drives?

Below the dmesg output with ATA_DEBUG and ATA_VERBOSE_DEBUG
defined.

Linux version 2.6.0-test9 (bolzer@ravioli) (gcc version 3.2) #17 Fri Oct 31 11:49:53 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009cc00 (usable)
 BIOS-e820: 000000000009cc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f7f0000 (usable)
 BIOS-e820: 000000003f7f0000 - 000000003f800000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
119MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f9bf0
hm, page 000f9000 reserved twice.
hm, page 000fa000 reserved twice.
hm, page 000ed000 reserved twice.
hm, page 000ee000 reserved twice.
On node 0 totalpages: 260080
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 30704 pages, LIFO batch:7
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: COMPAQ   Product ID:              APIC at: 0xFEE00000
Processor #0 15:2 APIC version 16
I/O APIC #8 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Building zonelist for node : 0
Kernel command line: console=ttyS0 console=tty0 log_buf_len=128k nfsroot=XXX.XXX.XXX.XXX:/var/cipinstall,rsize=8192,wsize=8192 ip=::::::dhcp BOOT_IMAGE=vmlinuz.install-2.6.0t9-silo 
log_buf_len: 131072
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2525.454 MHz processor.
Console: colour VGA+ 80x25
Memory: 1025360k/1040320k available (2222k kernel code, 14008k reserved, 925k data, 156k init, 122816k highmem)
Calibrating delay loop... 4980.73 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.53GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 8 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 8 ... ok.
..TIMER: vector=0x31 pin1=-1 pin2=-1
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2524.0906 MHz.
..... host bus clock speed is 132.0889 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.20 entry at 0xeca48, last bus=5
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fefe0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x6627, dseg 0xf0000
PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX [8086/24c0] at 0000:00:1f.0
PCI->APIC IRQ transform: (B0,I2,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B5,I4,P0) -> 16
PCI->APIC IRQ transform: (B5,I8,P0) -> 20
PCI->APIC IRQ transform: (B5,I10,P0) -> 21
Machine check exception polling timer started.
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
hw_random: RNG not detected
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
tg3.c:v2.2 (August 24, 2003)
eth1: Tigon3 [partno(AC91002A1) rev 0105 PHY(5701)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:09:5b:60:df:a3
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x24c0-0x24c7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x24c8-0x24cf, BIOS settings: hdc:pio, hdd:pio
ata_device_add: ENTER
ata_host_add: ENTER
ata_host_add: prd alloc, virt f7de8000, dma 37de8000
ata1: SATA max UDMA/133 cmd 0xF8813200 ctl 0xF8813238 bmdma 0x0 irq 16
ata_host_add: ENTER
ata_thread_iter: ata1: thr_state THR_PROBE_START
ata_host_add: prd alloc, virt f7de7000, dma 37de7000
ata2: SATA max UDMA/133 cmd 0xF8813280 ctl 0xF88132B8 bmdma 0x0 irq 16
ata_host_add: ENTER
ata_thread_iter: ata2: thr_state THR_PROBE_START
ata_host_add: prd alloc, virt f7de6000, dma 37de6000
ata3: SATA max UDMA/133 cmd 0xF8813300 ctl 0xF8813338 bmdma 0x0 irq 16
ata_host_add: ENTER
ata_thread_iter: ata3: thr_state THR_PROBE_START
ata_host_add: prd alloc, virt f7de5000, dma 37de5000
ata4: SATA max UDMA/133 cmd 0xF8813380 ctl 0xF88133B8 bmdma 0x0 irq 16
ata_device_add: probe begin
ata_device_add: ata1: probe begin
ata_device_add: ata1: probe-wait begin
ata_thread_iter: ata1: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata1: thr_state THR_PORT_RESET
ata_thread_iter: ata4: thr_state THR_PROBE_START
ata_bus_reset: ENTER, host 1, port 0
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 1, dev 0
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_dev_identify: do ATA identify
ata_exec: ata1: cmd 0xEC
ata_exec_command_mmio: ata1: cmd 0xEC
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407  64==0x0003  75==0x0000  
ata_dump_id: 80==0x00fe  81==0x001e  82==0x7c6b  83==0x7f09  84==0x4003  
ata_dump_id: 88==0x207f  93==0x0000
ata1: dev 0 ATA, max UDMA/133, 398297088 sectors (lba48)
ata_dev_identify: EXIT, drv_stat = 0x50
ata_dev_identify: ENTER/EXIT (host 1, dev 1) -- nodev
ata_host_set_udma: udma masks: host 0x7F, master 0x7F, slave 0xFF
ata_host_set_udma: mask 0x7F i 0x47 j 7
ata_host_set_udma: mask 0x7F i 0x46 j 6
ata_dev_set_xfermode: set features - xfer mode
ata_tf_load_mmio: feat 0x3 nsect 0x46 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec: ata1: cmd 0xEF
ata_exec_command_mmio: ata1: cmd 0xEF
ata_dev_set_xfermode: EXIT
ata1: dev 0 configured for UDMA/133
ata_thread_iter: ata1: new thr_state THR_PROBE_SUCCESS, returning 0
ata_thread_iter: ata1: thr_state THR_PROBE_SUCCESS
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 0
ata_device_add: ata1: probe-wait end
scsi0 : sata_promise
ata_device_add: ata2: probe begin
ata_device_add: ata2: probe-wait begin
ata_thread_iter: ata2: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata2: thr_state THR_PORT_RESET
ata_thread_iter: ata1: thr_state THR_IDLE
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 30000
ata_bus_reset: ENTER, host 2, port 1
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 2, dev 0
ata_dev_select: ENTER, ata2: device 0, wait 1
ata_dev_identify: do ATA identify
ata_exec: ata2: cmd 0xEC
ata_exec_command_mmio: ata2: cmd 0xEC
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407  64==0x0003  75==0x0000  
ata_dump_id: 80==0x00fe  81==0x001e  82==0x7c6b  83==0x7f09  84==0x4003  
ata_dump_id: 88==0x207f  93==0x0000
ata2: dev 0 ATA, max UDMA/133, 398297088 sectors (lba48)
ata_dev_identify: EXIT, drv_stat = 0x50
ata_dev_identify: ENTER/EXIT (host 2, dev 1) -- nodev
ata_host_set_udma: udma masks: host 0x7F, master 0x7F, slave 0xFF
ata_host_set_udma: mask 0x7F i 0x47 j 7
ata_host_set_udma: mask 0x7F i 0x46 j 6
ata_dev_set_xfermode: set features - xfer mode
ata_tf_load_mmio: feat 0x3 nsect 0x46 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec: ata2: cmd 0xEF
ata_exec_command_mmio: ata2: cmd 0xEF
ata_dev_set_xfermode: EXIT
ata2: dev 0 configured for UDMA/133
ata_thread_iter: ata2: new thr_state THR_PROBE_SUCCESS, returning 0
ata_thread_iter: ata2: thr_state THR_PROBE_SUCCESS
ata_thread_iter: ata2: new thr_state THR_IDLE, returning 0
ata_device_add: ata2: probe-wait end
scsi1 : sata_promise
ata_device_add: ata3: probe begin
ata_device_add: ata3: probe-wait begin
ata_thread_iter: ata3: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata3: thr_state THR_PORT_RESET
ata_thread_iter: ata2: thr_state THR_IDLE
ata_thread_iter: ata2: new thr_state THR_IDLE, returning 30000
ata_bus_reset: ENTER, host 3, port 2
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 3, dev 0
ata_dev_select: ENTER, ata3: device 0, wait 1
ata_dev_identify: do ATA identify
ata_exec: ata3: cmd 0xEC
ata_exec_command_mmio: ata3: cmd 0xEC
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407  64==0x0003  75==0x0000  
ata_dump_id: 80==0x00fe  81==0x001e  82==0x7c6b  83==0x7f09  84==0x4003  
ata_dump_id: 88==0x207f  93==0x0000
ata3: dev 0 ATA, max UDMA/133, 398297088 sectors (lba48)
ata_dev_identify: EXIT, drv_stat = 0x50
ata_dev_identify: ENTER/EXIT (host 3, dev 1) -- nodev
ata_host_set_udma: udma masks: host 0x7F, master 0x7F, slave 0xFF
ata_host_set_udma: mask 0x7F i 0x47 j 7
ata_host_set_udma: mask 0x7F i 0x46 j 6
ata_dev_set_xfermode: set features - xfer mode
ata_tf_load_mmio: feat 0x3 nsect 0x46 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec: ata3: cmd 0xEF
ata_exec_command_mmio: ata3: cmd 0xEF
ata_dev_set_xfermode: EXIT
ata3: dev 0 configured for UDMA/133
ata_thread_iter: ata3: new thr_state THR_PROBE_SUCCESS, returning 0
ata_thread_iter: ata3: thr_state THR_PROBE_SUCCESS
ata_thread_iter: ata3: new thr_state THR_IDLE, returning 0
ata_device_add: ata3: probe-wait end
scsi2 : sata_promise
ata_device_add: ata4: probe begin
ata_device_add: ata4: probe-wait begin
ata_thread_iter: ata4: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata4: thr_state THR_PORT_RESET
ata_thread_iter: ata3: thr_state THR_IDLE
ata_thread_iter: ata3: new thr_state THR_IDLE, returning 30000
ata_bus_reset: ENTER, host 4, port 3
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 4, dev 0
ata_dev_select: ENTER, ata4: device 0, wait 1
ata_dev_identify: do ATA identify
ata_exec: ata4: cmd 0xEC
ata_exec_command_mmio: ata4: cmd 0xEC
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407  64==0x0003  75==0x0000  
ata_dump_id: 80==0x00fe  81==0x001e  82==0x7c6b  83==0x7f09  84==0x4003  
ata_dump_id: 88==0x207f  93==0x0000
ata4: dev 0 ATA, max UDMA/133, 398297088 sectors (lba48)
ata_dev_identify: EXIT, drv_stat = 0x50
ata_dev_identify: ENTER/EXIT (host 4, dev 1) -- nodev
ata_host_set_udma: udma masks: host 0x7F, master 0x7F, slave 0xFF
ata_host_set_udma: mask 0x7F i 0x47 j 7
ata_host_set_udma: mask 0x7F i 0x46 j 6
ata_dev_set_xfermode: set features - xfer mode
ata_tf_load_mmio: feat 0x3 nsect 0x46 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec: ata4: cmd 0xEF
ata_exec_command_mmio: ata4: cmd 0xEF
ata_dev_set_xfermode: EXIT
ata4: dev 0 configured for UDMA/133
ata_thread_iter: ata4: new thr_state THR_PROBE_SUCCESS, returning 0
ata_thread_iter: ata4: thr_state THR_PROBE_SUCCESS
ata_thread_iter: ata4: new thr_state THR_IDLE, returning 0
ata_device_add: ata4: probe-wait end
scsi3 : sata_promise
ata_device_add: probe begin
ata_scsi_queuecmd: CDB (1:0,0,0) 12 00 00 00 24 00 dd f7 00
ata_scsiop_inq_std: ENTER
ata_scsi_queuecmd: CDB (1:0,0,0) 12 00 00 00 61 00 dd f7 00
ata_scsiop_inq_std: ENTER
  Vendor: ATA       Model: Maxtor 6Y200M0    Rev: 0.75
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
ata_scsiop_inq_std: ENTER
ata_scsi_queuecmd: CDB (2:0,0,0) 12 00 00 00 61 00 00 00 00
ata_scsiop_inq_std: ENTER
  Vendor: ATA       Model: Maxtor 6Y200M0    Rev: 0.75
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata_scsi_queuecmd: CDB (2:0,0,0) a0 00 00 00 00 00 00 00 04
ata_scsiop_report_luns: ENTER
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
ata_scsiop_inq_std: ENTER
ata_scsi_queuecmd: CDB (3:0,0,0) 12 00 00 00 61 00 00 00 00
ata_scsiop_inq_std: ENTER
  Vendor: ATA       Model: Maxtor 6Y200M0    Rev: 0.75
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata_scsi_queuecmd: CDB (3:0,0,0) a0 00 00 00 00 00 00 00 04
ata_scsiop_report_luns: ENTER
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
ata_scsiop_inq_std: ENTER
ata_scsi_queuecmd: CDB (4:0,0,0) 12 00 00 00 61 00 00 00 00
ata_scsiop_inq_std: ENTER
  Vendor: ATA       Model: Maxtor 6Y200M0    Rev: 0.75
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata_scsi_queuecmd: CDB (4:0,0,0) a0 00 00 00 00 00 00 00 04
ata_scsiop_report_luns: ENTER
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
ata_scsi_queuecmd: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_queuecmd: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
ata_scsi_queuecmd: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_queuecmd: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 17
ata_scsiop_mode_sense: ENTER
SCSI device sda: drive cache: write through
 sda:<3>ata_scsi_queuecmd: CDB (1:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_rw_queue: ENTER
ata_scsi_rw_xlat: reading
ata_scsi_rw_xlat: ten-byte command
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_sg_setup: ENTER, ata1, use_sg 1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x37DA7000, 0x1000)
ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xE0
pdc_dma_start: ENTER, ap f7dec9a8, mmio f8813000
pdc_dma_start: val == 80008001
pdc_dma_start: val == 80008001
ata_exec_command_mmio: ata1: cmd 0x25
pdc_dma_start: FIVE
ata_scsi_rw_queue: EXIT
pdc_interrupt: ENTER
pdc_interrupt: port 0
ata_sg_clean: unmapping 1 sg elements
pdc_interrupt: port 1
pdc_interrupt: port 2
pdc_interrupt: port 3
pdc_interrupt: EXIT
 sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
ata_scsi_queuecmd: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_queuecmd: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
ata_scsi_queuecmd: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_queuecmd: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 17
ata_scsiop_mode_sense: ENTER
SCSI device sdb: drive cache: write through
 sdb:<3>ata_scsi_queuecmd: CDB (2:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_rw_queue: ENTER
ata_scsi_rw_xlat: reading
ata_scsi_rw_xlat: ten-byte command
ata_dev_select: ENTER, ata2: device 0, wait 1
ata_sg_setup: ENTER, ata2, use_sg 1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x37DA6000, 0x1000)
ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xE0
pdc_dma_start: ENTER, ap f7dec1a8, mmio f8813000
pdc_dma_start: val == 80008002
pdc_dma_start: val == 80008002
ata_exec_command_mmio: ata2: cmd 0x25
pdc_dma_start: FIVE
ata_scsi_rw_queue: EXIT
pdc_interrupt: ENTER
pdc_interrupt: port 0
pdc_interrupt: port 1
ata_sg_clean: unmapping 1 sg elements
pdc_interrupt: port 2
pdc_interrupt: port 3
pdc_interrupt: EXIT
ata_thread_iter: ata4: thr_state THR_IDLE
ata_thread_iter: ata4: new thr_state THR_IDLE, returning 30000
 sdb1 sdb2 sdb3
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
ata_scsi_queuecmd: CDB (3:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_queuecmd: CDB (3:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sdc: 398297088 512-byte hdwr sectors (203928 MB)
ata_scsi_queuecmd: CDB (3:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_queuecmd: CDB (3:0,0,0) 5a 00 08 00 00 00 00 00 17
ata_scsiop_mode_sense: ENTER
SCSI device sdc: drive cache: write through
 sdc:<3>ata_scsi_queuecmd: CDB (3:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_rw_queue: ENTER
ata_scsi_rw_xlat: reading
ata_scsi_rw_xlat: ten-byte command
ata_dev_select: ENTER, ata3: device 0, wait 1
ata_sg_setup: ENTER, ata3, use_sg 1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x37DA5000, 0x1000)
ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xE0
pdc_dma_start: ENTER, ap f7fed9a8, mmio f8813000
pdc_dma_start: val == 80008003
pdc_dma_start: val == 80008003
ata_exec_command_mmio: ata3: cmd 0x25
pdc_dma_start: FIVE
ata_scsi_rw_queue: EXIT
pdc_interrupt: ENTER
pdc_interrupt: port 0
pdc_interrupt: port 1
pdc_interrupt: port 2
ata_sg_clean: unmapping 1 sg elements
pdc_interrupt: port 3
pdc_interrupt: EXIT
 sdc1 sdc2 sdc3
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
ata_scsi_queuecmd: CDB (4:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_queuecmd: CDB (4:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sdd: 398297088 512-byte hdwr sectors (203928 MB)
ata_scsi_queuecmd: CDB (4:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_queuecmd: CDB (4:0,0,0) 5a 00 08 00 00 00 00 00 17
ata_scsiop_mode_sense: ENTER
SCSI device sdd: drive cache: write through
 sdd:<3>ata_scsi_queuecmd: CDB (4:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_rw_queue: ENTER
ata_scsi_rw_xlat: reading
ata_scsi_rw_xlat: ten-byte command
ata_dev_select: ENTER, ata4: device 0, wait 1
ata_sg_setup: ENTER, ata4, use_sg 1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x37DA4000, 0x1000)
ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xE0
pdc_dma_start: ENTER, ap f7fed1a8, mmio f8813000
pdc_dma_start: val == 80008004
pdc_dma_start: val == 80008004
ata_exec_command_mmio: ata4: cmd 0x25
pdc_dma_start: FIVE
ata_scsi_rw_queue: EXIT
pdc_interrupt: ENTER
pdc_interrupt: QUICK EXIT 3
ata_thread_iter: ata1: thr_state THR_IDLE
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata2: thr_state THR_IDLE
ata_thread_iter: ata2: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata3: thr_state THR_IDLE
ata_thread_iter: ata3: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata4: thr_state THR_IDLE
ata_thread_iter: ata4: new thr_state THR_IDLE, returning 30000
ata_scsi_error: ENTER
pdc_eng_timeout: ENTER
ata4: DMA timeout
ata_sg_clean: unmapping 1 sg elements
pdc_eng_timeout: EXIT
ata_scsi_error: EXIT
ata_thread_iter: ata1: thr_state THR_IDLE
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata2: thr_state THR_IDLE
ata_thread_iter: ata2: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata3: thr_state THR_IDLE
ata_thread_iter: ata3: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata4: thr_state THR_IDLE
ata_thread_iter: ata4: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata1: thr_state THR_IDLE
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata2: thr_state THR_IDLE
ata_thread_iter: ata2: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata3: thr_state THR_IDLE
ata_thread_iter: ata3: new thr_state THR_IDLE, returning 30000
[endless loop]
-- 
	Oliver M. Bolzer
	oliver@gol.com

GPG (PGP) Fingerprint = 621B 52F6 2AC1 36DB 8761  018F 8786 87AD EF50 D1FF
