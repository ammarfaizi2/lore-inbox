Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290495AbSAaXJS>; Thu, 31 Jan 2002 18:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291389AbSAaXJA>; Thu, 31 Jan 2002 18:09:00 -0500
Received: from net128-053.mclink.it ([195.110.128.53]:31972 "EHLO
	mail.mclink.it") by vger.kernel.org with ESMTP id <S291388AbSAaXIp>;
	Thu, 31 Jan 2002 18:08:45 -0500
Message-ID: <3C59CE77.7090401@arpacoop.it>
Date: Fri, 01 Feb 2002 00:08:39 +0100
From: Carlo Scarfoglio <scarfoglio@arpacoop.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020129
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.3-pre2 task_out_intr: should not trigger
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Few days ago I used this kernel extensively. I was working with a large 
X application doing a lot of disk I/O. I noticed that disk performance 
was low. After a few hours of work the app caused a memory error, 
starting a swap storm and finally was OOM killed. This has happened in 
the past too. I had heard some strange noises from the disks, so I 
looked into /var/log/messages and I found a lot of kernel error 
messages, mostly the one above, followed by - hdc (or hdh): status 
timeout: status=0xd0 (Busy) - and - hdc: drive not ready for command. I 
tried to reboot, but nothing happened. I issued a halt, the same result. 
So I synced, etc, rebooted with the magick button. At boot, the 
supermount block was gone. fsck was able to recover the disk and correct 
lots of errors. Some files were gone, among them /etc/passwd and 
/etc/group (why not mozilla's cache files ?). I had to play some tricks 
to get access to the system.
I thought some hw failure has occurred (cables, low voltage, who knows), 
but since then I went back to kernel 2.5.2-pre11, without a single 
problem. Today I gave kernel 2.5.3-pre6 a try, I heard some clicks from 
the disks, and the above messages were there again. Now I am back to 
2.5.2-pre11.

The mainboard is an Asus A7V first version (200Mhz FSB), SuSE 6.3 with 
several updates (glibc 2.1.3), gcc 2.95.3 (now), binutils 2.11.2. 
/dev/hdh is not connected now, it is an IBM ATA-100.

Below I attached an excerpt from /var/log/messages and boot.msg

Regards,
		Carlo Scarfoglio


  Jan 24 12:41:23 carlocasa kernel: task_out_intr: should not trigger
Jan 24 12:41:23 carlocasa kernel: task_out_intr: should not trigger
Jan 24 12:42:00 carlocasa kernel: EXT2-fs warning: mounting unchecked 
fs, running e2fsck is recommended
Jan 24 12:53:41 carlocasa kernel: VFS: Disk change detected on device 
sr(11,0)
Jan 24 12:53:43 carlocasa kernel: ISO 9660 Extensions: Microsoft Joliet 
Level 3
Jan 24 12:53:43 carlocasa kernel: ISOFS: changing to secondary root
Jan 24 13:20:55 carlocasa -- MARK --
Jan 24 13:34:04 carlocasa kernel: task_out_intr: should not trigger
Jan 24 13:35:14 carlocasa kernel: task_out_intr: should not trigger
Jan 24 13:35:14 carlocasa kernel: hdc: status error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Jan 24 13:35:14 carlocasa kernel: hdc: drive not ready for command
Jan 24 13:41:33 carlocasa kernel: hdh: status error: status=0x00 { }
Jan 24 13:41:33 carlocasa kernel: hdh: drive not ready for command
Jan 24 13:41:33 carlocasa kernel: hdh: status error: status=0x00 { }
Jan 24 13:41:33 carlocasa kernel: hdh: drive not ready for command
Jan 24 13:41:33 carlocasa kernel: hdh: status error: status=0x00 { }
Jan 24 13:41:33 carlocasa kernel: hdh: drive not ready for command
Jan 24 13:41:33 carlocasa kernel: hdh: status error: status=0x00 { }
Jan 24 13:41:33 carlocasa kernel: hdg: DMA disabled
Jan 24 13:41:33 carlocasa kernel: hdh: DMA disabled
Jan 24 13:41:33 carlocasa kernel: PDC202XX: Secondary channel reset.
Jan 24 13:41:33 carlocasa kernel: hdh: drive not ready for command
Jan 24 13:41:35 carlocasa kernel: ide3: reset: success
Jan 24 13:41:40 carlocasa kernel: task_out_intr: should not trigger
Jan 24 13:42:05 carlocasa kernel: task_out_intr: should not trigger
Jan 24 13:43:00 carlocasa last message repeated 2 times
Jan 24 13:44:10 carlocasa last message repeated 2 times
Jan 24 13:44:50 carlocasa last message repeated 2 times
Jan 24 13:46:05 carlocasa last message repeated 3 times
Jan 24 13:47:17 carlocasa last message repeated 3 times
Jan 24 13:48:13 carlocasa last message repeated 3 times
Jan 24 13:48:28 carlocasa kernel: task_out_intr: should not trigger
Jan 24 13:48:54 carlocasa kernel: hdh: status error: status=0x01 { Error }
Jan 24 13:48:54 carlocasa kernel: hdh: status error: error=0x01 { 
AddrMarkNotFound }, CHS=257/1/1, sector=5872159
Jan 24 13:48:54 carlocasa kernel: hdh: drive not ready for command
Jan 24 13:48:54 carlocasa kernel: hdh: status error: status=0x01 { Error }
Jan 24 13:48:54 carlocasa kernel: hdh: status error: error=0x01 { 
AddrMarkNotFound }, CHS=257/1/1, sector=5872159
Jan 24 13:48:54 carlocasa kernel: hdh: drive not ready for command
Jan 24 13:48:54 carlocasa kernel: hdh: status error: status=0x01 { Error }
Jan 24 13:48:54 carlocasa kernel: hdh: status error: error=0x01 { 
AddrMarkNotFound }, CHS=257/1/1, sector=5872159
Jan 24 13:48:54 carlocasa kernel: hdh: drive not ready for command
Jan 24 13:48:54 carlocasa kernel: hdh: status error: status=0x01 { Error }
Jan 24 13:48:54 carlocasa kernel: hdh: status error: error=0x01 { 
AddrMarkNotFound }, CHS=257/1/1, sector=5872159
Jan 24 13:48:54 carlocasa kernel: PDC202XX: Secondary channel reset.
Jan 24 13:48:54 carlocasa kernel: hdh: drive not ready for command
Jan 24 13:48:56 carlocasa kernel: ide3: reset: success
Jan 24 13:48:58 carlocasa kernel: task_out_intr: should not trigger
Jan 24 13:49:02 carlocasa kernel: hde: timeout waiting for DMA
Jan 24 13:49:02 carlocasa kernel: PDC202XX: Primary channel reset.
Jan 24 13:49:02 carlocasa kernel: ide_dmaproc: chipset supported 
ide_dma_timeout func only: 14
Jan 24 13:49:02 carlocasa kernel: blk: queue c0381884, I/O limit 4095Mb 
(mask 0xffffffff)
Jan 24 13:49:12 carlocasa kernel: hde: timeout waiting  ready for command
Jan 24 13:48:56 carlocasa kernel: ide3: reset: success
Jan 24 13:48:58 carlocasa kernel: task_out_intr: should not trigger
Jan 24 13:49:02 carlocasa kernel: hde: timeout waiting for DMA
Jan 24 13:49:02 carlocasa kernel: PDC202XX: Primary channel reset.
Jan 24 13:49:02 carlocasa kernel: ide_dmaproc: chipset supported 
ide_dma_timeout func only: 14
Jan 24 13:49:02 carlocasa kernel: blk: queue c0381884, I/O limit 4095Mb 
(mask 0xffffffff)
Jan 24 13:49:12 carlocasa kernel: hde: timeout waiting should not trigger
Jan 24 13:49:28 carlocasa kernel: task_out_intr: should not trigger
Jan 24 13:49:32 carlocasa kernel: hde: timeout waiting for DMA
Jan 24 13:49:32 carlocasa kernel: PDC202XX: Primary channel reset.
Jan 24 13:49:32 carlocasa kernel: ide_dmaproc: chipset supported 
ide_dma_timeout func only: 14
Jan 24 13:49:33 carlocasa kernel: task_out_intr: should not trigger
Jan 24 13:49:58 carlocasa last message repeated 2 times
Jan 24 13:53:08 carlocasa kernel: task_out_intr: should not trigger
Jan 24 13:55:03 carlocasa kernel: task_out_intr: should not trigger
Jan 24 13:56:15 carlocasa last message repeated 3 times
Jan 24 13:56:42 carlocasa last message repeated 3 times
Jan 24 13:58:03 carlocasa last message repeated 2 times
Jan 24 13:59:15 carlocasa last message repeated 4 times
Jan 24 14:01:15 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:03:35 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:03:51 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:07:56 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:09:08 carlocasa last message repeated 5 times
Jan 24 14:10:08 carlocasa last message repeated 4 times
Jan 24 14:13:29 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:14:39 carlocasa last message repeated 2 times
Jan 24 14:15:09 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:16:29 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:19:59 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:24:04 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:25:34 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:28:59 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:30:14 carlocasa last message repeated 3 times
Jan 24 14:34:39 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:35:34 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:40:29 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:44:19 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:46:34 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:48:24 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:52:14 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:53:09 carlocasa last message repeated 2 times
Jan 24 14:53:34 carlocasa kernel: task_out_intr: should not trigger
Jan 24 14:53:59 carlocasa kernel: hdh: status timeout: status=0xd0 { Busy }
Jan 24 14:53:59 carlocasa kernel: PDC202XX: Secondary channel reset.
Jan 24 14:53:59 carlocasa kernel: hdh: drive not ready for command
Jan 24 14:53:59 carlocasa kernel: ide3: reset: success
Jan 24 14:57:24 carlocasa kernel: task_out_intr: should not trigger
Jan 24 15:00:59 carlocasa kernel: task_out_intr: should not trigger
Jan 24 15:05:44 carlocasa kernel: task_out_intr: should not trigger
Jan 24 15:20:19 carlocasa kernel: task_out_intr: should not trigger
Jan 24 15:21:59 carlocasa kernel: task_out_intr: should not trigger
Jan 24 15:25:44 carlocasa kernel: task_out_intr: should not trigger
Jan 24 15:32:04 carlocasa kernel: task_out_intr: should not trigger
Jan 24 15:32:16 carlocasa kernel: task_out_intr: should not trigger
Jan 24 15:34:00 carlocasa last message repeated 2 times
Jan 24 15:34:56 carlocasa kernel: task_out_intr: should not trigger
Jan 24 15:36:16 carlocasa last message repeated 2 times
Jan 24 15:36:22 carlocasa kernel: hdh: status timeout: status=0xd0 { Busy }
Jan 24 15:36:22 carlocasa kernel: PDC202XX: Secondary channel reset.
Jan 24 15:36:22 carlocasa kernel: hdh: drive not ready for command
Jan 24 15:36:22 carlocasa kernel: ide3: reset: success
Jan 24 15:36:23 carlocasa kernel: hdh: status timeout: status=0xd0 { Busy }
Jan 24 15:36:23 carlocasa kernel: PDC202XX: Secondary channel reset.
Jan 24 15:36:23 carlocasa kernel: hdh: drive not ready for command
Jan 24 15:36:23 carlocasa kernel: ide3: reset: success
Jan 24 15:36:23 carlocasa kernel: hdh: status timeout: status=0xd0 { Busy }
Jan 24 15:36:23 carlocasa kernel: PDC202XX: Secondary channel reset.
Jan 24 15:36:23 carlocasa kernel: hdh: drive not ready for command
Jan 24 15:36:23 carlocasa kernel: ide3: reset: success
Jan 24 15:36:33 carlocasa kernel: task_out_intr: should not trigger
Jan 24 15:37:10 carlocasa last message repeated 4 times
Jan 24 15:38:04 carlocasa last message repeated 7 times
Jan 24 15:39:09 carlocasa kernel: task_out_intr: should not trigger
Jan 24 15:39:15 carlocasa kernel: hdh: status timeout: status=0xd0 { Busy }
Jan 24 15:39:15 carlocasa kernel: PDC202XX: Secondary channel reset.
Jan 24 15:39:15 carlocasa kernel: hdh: drive not ready for command
Jan 24 15:39:15 carlocasa kernel: ide3: reset: success
Jan 24 15:39:15 carlocasa kernel: hdh: status timeout: status=0xd0 { Busy }
Jan 24 15:39:15 carlocasa kernel: PDC202XX: Secondary channel reset.
Jan 24 15:39:15 carlocasa kernel: hdh: drive not ready for command
Jan 24 15:39:15 carlocasa kernel: ide3: reset: success
Jan 24 15:39:37 carlocasa kernel: hdh: status timeout: status=0xd0 { Busy }
Jan 24 15:39:37 carlocasa kernel: PDC202XX: Secondary channel reset.
Jan 24 15:39:37 carlocasa kernel: hdh: drive not ready for command
Jan 24 15:39:37 carlocasa kernel: ide3: reset: success
Jan 24 15:39:55 carlocasa kernel: task_out_intr: should not trigger
Jan 24 15:40:05 carlocasa kernel: task_out_intr: should not trigger
Jan 24 15:41:10 carlocasa last message repeated 5 times
Jan 24 15:41:46 carlocasa last message repeated 2 times
Jan 24 15:51:25 carlocasa kernel: task_out_intr: should not trigger
Jan 24 15:52:08 carlocasa kernel: hdc: status timeout: status=0xd0 { Busy }
Jan 24 15:52:08 carlocasa kernel: hdc: drive not ready for command
Jan 24 15:52:08 carlocasa kernel: ide1: reset: success
Jan 24 15:52:13 carlocasa kernel: Out of Memory: Killed process 666 
(tntmenu).
Jan 24 15:53:50 carlocasa kernel: Out of Memory: Killed process 456 
(tntmenu).
Jan 24 15:55:02 carlocasa kernel: Out of Memory: Killed process 243 (bash).
Jan 24 15:55:02 carlocasa kernel: VM: killing process bash
Jan 24 15:55:06 carlocasa kernel: Out of Memory: Killed process 243 (bash).
Jan 24 15:55:06 carlocasa last message repeated 5 times
Jan 24 15:56:04 carlocasa init: PANIC: segmentation violation! giving up..
Jan 24 15:56:59 carlocasa kernel: task_out_intr: should not trigger
Jan 24 15:58:39 carlocasa kernel: task_out_intr: should not trigger
Jan 24 15:58:44 carlocasa kernel: task_out_intr: should not trigger
Jan 24 16:00:39 carlocasa last message repeated 2 times
Jan 24 16:05:29 carlocasa kernel: task_out_intr: should not trigger
Jan 24 16:06:54 carlocasa last message repeated 4 times
Jan 24 16:07:15 carlocasa kernel: task_out_intr: should not trigger
Jan 24 16:09:00 carlocasa kernel: task_out_intr: should not trigger
Jan 24 16:10:00 carlocasa kernel: task_out_intr: should not trigger
Jan 24 16:10:50 carlocasa kernel: task_out_intr: should not trigger
Jan 24 16:13:46 carlocasa /usr/sbin/gpm[120]: No data
Jan 24 16:14:10 carlocasa kernel: SysRq : Emergency Sync
Jan 24 16:14:10 carlocasa kernel: Syncing device 16:07 ... OK
Jan 24 16:14:10 carlocasa kernel: Syncing device 16:09 ... OK
Jan 24 16:14:10 carlocasa kernel: Syncing device 03:01 ... OK
Jan 24 16:14:10 carlocasa kernel: Syncing device 03:05 ... OK
Jan 24 16:14:10 carlocasa kernel: Syncing device 03:06 ... OK
Jan 24 16:14:10 carlocasa kernel: Syncing device 16:05 ... OK
Jan 24 16:14:10 carlocasa kernel: Syncing device 16:06 ... OK
Jan 24 16:14:10 carlocasa kernel: Syncing device 21:02 ... OK
Jan 24 16:14:10 carlocasa kernel: Syncing device 21:01 ... OK
Jan 24 16:14:10 carlocasa kernel: Syncing device 22:41 ... OK
Jan 24 16:14:10 carlocasa kernel: Syncing device 0b:00 ... OK
Jan 24 16:14:10 carlocasa kernel: Done.


Inspecting /boot/System.map
Loaded 17719 symbols from /boot/System.map.
Symbols match kernel version 2.5.2.
No module symbols loaded.
klogd 1.3-3, log source = ksyslog started.
<4>Linux version 2.5.2-pre11 (root@carlocasa) (gcc version 2.95.2 
19991024 (release)) #12 Sun Jan 13 21:51:50 CET 2002
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
<4> BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000000ffec000 (usable)
<4> BIOS-e820: 000000000ffec000 - 000000000ffef000 (ACPI data)
<4> BIOS-e820: 000000000ffef000 - 000000000ffff000 (reserved)
<4> BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
<4>On node 0 totalpages: 65516
<4>zone(0): 4096 pages.
<4>zone(1): 61420 pages.
<4>zone(2): 0 pages.
<4>Local APIC disabled by BIOS -- reenabling.
<4>Found and enabled local APIC!
<4>Kernel command line: BOOT_IMAGE=linux25211 ro root=1607 aic7xxx=seltime:0
<6>Initializing CPU#0
<4>Detected 807.198 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 1608.90 BogoMIPS
<4>Memory: 254976k/262064k available (1581k kernel code, 6696k reserved, 
510k data, 236k init, 0k highmem)
<4>Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
<4>Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
<4>Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
<4>Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
<4>Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
<7>CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
<6>CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
<6>CPU: L2 Cache: 256K (64 bytes/line)
<7>CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
<7>CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
<4>CPU: AMD Athlon(tm) Processor stepping 02
<6>Enabling fast FPU save and restore... done.
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 807.2414 MHz.
<4>..... host bus clock speed is 201.8104 MHz.
<4>cpu: 0, clocks: 2018104, slice: 1009052
<4>CPU0<T0:2018096,T1:1009040,D:4,S:1009052,C:2018104>
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<4>PCI: PCI BIOS revision 2.10 entry at 0xf10f0, last bus=1
<4>PCI: Using configuration type 1
<4>PCI: Probing PCI hardware
<4>Disabling broken memory write queue.
<3>Unknown bridge resource 0: assuming transparent
<6>PCI: Using IRQ router VIA [1106/0686] at 00:04.0
<6>PCI: Disabling Via external APIC routing
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<6>IA-32 Microcode Update Driver: v1.09 <tigran@veritas.com>
<4>Starting kswapd
<4>BIO: pool of 256 setup, 14Kb (56 bytes/bio)
<4>biovec: init pool 0, 1 entries, 12 bytes
<4>biovec: init pool 1, 4 entries, 48 bytes
<4>biovec: init pool 2, 16 entries, 192 bytes
<4>biovec: init pool 3, 64 entries, 768 bytes
<4>biovec: init pool 4, 128 entries, 1536 bytes
<4>biovec: init pool 5, 256 entries, 3072 bytes
<5>NTFS driver v1.1.21 [Flags: R/O]
<6>parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
<7>parport0: Found 1 daisy-chained devices
<7>parport0: device reported incorrect length field (61, should be 62)
<6>parport0 (addr 0): SCSI adapter, IMG VP1
<6>parport_pc: Via 686A parallel port: io=0x378
<4>i2c-core.o: i2c core module
<4>i2c-dev.o: i2c /dev entries driver module
<4>i2c-core.o: driver i2c-dev dummy driver registered.
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
<6>ttyS01 at 0x02f8 (irq = 3) is a 16550A
<6>lp0: using parport0 (polling).
<6>Real Time Clock Driver v1.10e
<6>ppdev: user-space parallel port driver
<4>block: 256 slots per queue, batch=32
<6>Uniform Multi-Platform E-IDE driver Revision: 6.32
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
<4>VP_IDE: IDE controller on PCI slot 00:04.1
<4>VP_IDE: chipset revision 16
<4>VP_IDE: not 100% native mode: will probe irqs later
<4> ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
<4> ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
<4>PDC20265: IDE controller on PCI slot 00:11.0
<6>PCI: Found IRQ 10 for device 00:11.0
<4>PDC20265: chipset revision 2
<4>PDC20265: not 100% native mode: will probe irqs later
<4>PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
<4> ide2: BM-DMA at 0x8000-0x8007, BIOS settings: hde:DMA, hdf:pio
<4> ide3: BM-DMA at 0x8008-0x800f, BIOS settings: hdg:DMA, hdh:pio
<4>hda: QUANTUM FIREBALL_TM2550A, ATA DISK drive
<4>hdc: IBM-DHEA-38451, ATA DISK drive
<4>hde: IBM-DPTA-372050, ATA DISK drive
<4>hdg: IBM-DTLA-307030, ATA DISK drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide1 at 0x170-0x177,0x376 on irq 15
<4>ide2 at 0x9400-0x9407,0x9002 on irq 10
<4>ide3 at 0x8800-0x8807,0x8402 on irq 10
<6>hda: 5008752 sectors (2564 MB) w/76KiB Cache, CHS=621/128/63
<6>hdc: 16514064 sectors (8455 MB) w/472KiB Cache, CHS=16383/16/63
<4>blk: queue c037c6f4, I/O limit 4095Mb (mask 0xffffffff)
<6>hde: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=39770/16/63, 
UDMA(66)
<4>blk: queue c037ca8c, I/O limit 4095Mb (mask 0xffffffff)
<6>hdg: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, 
UDMA(100)
<6>Partition check:
<6> hda: hda1 hda2 < hda5 hda6 > hda3
<6> hdc: [PTBL] [1027/255/63] hdc1 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 >
<6> hde: hde1 hde2
<6> hdg: hdg1
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a post-1991 82077
<6>loop: loaded (max 8 devices)
<6>ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
<6> http://www.scyld.com/network/ne2k-pci.html
<6>PCI: Found IRQ 5 for device 00:0a.0
<4>eth0: RealTek RTL-8029 found at 0xa000, IRQ 5, 00:20:18:39:CF:17.
<6>PPP generic driver version 2.4.1
<6>PPP Deflate Compression module registered
<6>Linux agpgart interface v0.99 (c) Jeff Hartmann
<6>agpgart: Maximum main memory to use for agp memory: 203M
<6>agpgart: Detected Via Apollo Pro KT133 chipset
<6>agpgart: AGP aperture is 64M @ 0xe4000000
<6>[drm] AGP 0.99 on VIA Apollo KT133 @ 0xe4000000 64MB
<6>[drm] Initialized mga 3.0.2 20010321 on minor 0
<6>SCSI subsystem driver Revision: 1.00
<6>PCI: Found IRQ 11 for device 00:0c.0
<4>ahc_pci:0:12:0: Host Adapter Bios disabled.  Using default SCSI 
device parameters
<6>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.4
<4> <Adaptec 2902/04/10/15/20/30C SCSI adapter>
<4> aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs
<4>
<4> Vendor: SCSI-CD   Model: ReWritable-2x2x6  Rev: 2.00
<4> Type:   CD-ROM                             ANSI SCSI revision: 02
<4> Vendor: SCANNER   Model:                   Rev: 2.00
<4> Type:   Scanner                            ANSI SCSI revision: 01 CCS
<4>Attached scsi CD-ROM sr0 at scsi0, channel 0, id 2, lun 0
<4>(scsi0:A:2): 10.000MB/s transfers (10.000MHz, offset 15)
<4>sr0: scsi3-mmc drive: 2x/6x writer cd/rw xa/form2 cdda tray
<6>Uniform CD-ROM driver Revision: 3.12
<4>Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 6
<6>es1371: version v0.30 time 13:42:28 Jan 13 2002
<6>PCI: Found IRQ 9 for device 00:09.0
<6>PCI: Sharing IRQ 9 with 00:04.2
<6>PCI: Sharing IRQ 9 with 00:04.3
<6>es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x08
<6>es1371: found es1371 rev 8 at io 0xa400 irq 9
<6>es1371: features: joystick 0x0
<6>ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
<6>usb.c: registered new driver usbfs
<6>usb.c: registered new driver hub
<6>usb-uhci.c: $Revision: 1.268 $ time 13:42:39 Jan 13 2002
<6>usb-uhci.c: High bandwidth mode enabled
<6>PCI: Found IRQ 9 for device 00:04.2
<6>PCI: Sharing IRQ 9 with 00:04.3
<6>PCI: Sharing IRQ 9 with 00:09.0
<6>usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
<4>usb-uhci.c: Detected 2 ports
<6>usb.c: new USB bus registered, assigned bus number 1
<6>hub.c: USB hub found at /
<6>hub.c: 2 ports detected
<6>PCI: Found IRQ 9 for device 00:04.3
<6>PCI: Sharing IRQ 9 with 00:04.2
<6>PCI: Sharing IRQ 9 with 00:09.0
<6>usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 9
<4>usb-uhci.c: Detected 2 ports
<6>usb.c: new USB bus registered, assigned bus number 2
<6>hub.c: USB hub found at /
<6>hub.c: 2 ports detected
<6>usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
<6>usb.c: registered new driver hid
<6>hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
<6>hid-core.c: USB HID support drivers
<6>mice: PS/2 mouse device common for all mice
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP
<4>IP: routing cache hash table of 2048 buckets, 16Kbytes
<4>TCP: Hash tables configured (established 16384 bind 16384)
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<4>VFS: Mounted root (ext2 filesystem) readonly.
<4>Freeing unused kernel memory: 236k freed
<6>hub.c: new USB device on bus 1 path /2, assigned address 2
<4>usb-uhci.c: interrupt, status 3, frame# 784
<6>input0: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse ® with 
IntelliEye] on usb1:2.0
<6>hub.c: new USB device on bus 2 path /2, assigned address 2
<6>hub.c: USB hub found at /2
<6>hub.c: 4 ports detected
<4>spurious 8259A interrupt: IRQ7.
<6>Adding Swap: 136512k swap-space (priority -1)
<6>Adding Swap: 128484k swap-space (priority -2)
<4>HPFS: filesystem error: improperly stopped; remounting read-only
<4>HPFS: filesystem error: improperly stopped; remounting read-only
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.



