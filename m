Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbTDCQBf>; Thu, 3 Apr 2003 11:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261306AbTDCQBf>; Thu, 3 Apr 2003 11:01:35 -0500
Received: from siaag2aa.compuserve.com ([149.174.40.131]:52453 "EHLO
	siaag2aa.compuserve.com") by vger.kernel.org with ESMTP
	id <S261206AbTDCQBc>; Thu, 3 Apr 2003 11:01:32 -0500
Date: Thu, 3 Apr 2003 11:08:30 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH][2.5.66] Better kobject debugging
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304031112_MC3-1-32D5-C8FE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  With the below patch applied to lib/kobject.c and a Zip disk
in the drive I get the following two traces on bootup.  A closer
look at the first one shows these are the first three kobjects
to attempt registration:

         "sysfs", parent:null, set:null fails
         "fs",    parent:null, set:null succeeds
         "sysfs", parent:null, set:"fs" succeeds

================================================================
Linux version 2.5.66 (meq) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-
110)) #11 Sat Mar 29 21:14:17 EST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 0000000000100000 - 000000000c000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
192MB LOWMEM available.
found SMP MP-table at 000fe710
hm, page 000fe000 reserved twice.
hm, page 000ff000 reserved twice.
hm, page 000f0000 reserved twice.
On node 0 totalpages: 49152
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 45056 pages, LIFO batch:11
  HighMem zone: 0 pages, LIFO batch:1
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: OPTIPLEXGX2  APIC at: 0xFEE00000
Processor #0 6:3 APIC version 17
I/O APIC #1 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Building zonelist for node : 0
Kernel command line: ro root=/dev/hde1 console=ttyS0
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 332.296 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 655.36 BogoMIPS
Memory: 191396k/196608k available (1590k kernel code, 4580k reserved, 518k data,
 312k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Badness name:sysfs, err:-14, set:<NULL>
Badness in create_dir at lib/kobject.c:64
Call Trace:
 [<c018831b>] create_dir+0x7b/0x90
 [<c0105000>] _stext+0x0/0x20
 [<c0188495>] kobject_add+0xa5/0xc0
 [<c01886d3>] subsystem_register+0x13/0x30
 [<c015370c>] register_filesystem+0x4c/0x60
================================================================
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX3: IDE controller at PCI slot 00:0d.1
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PDC20268: IDE controller at PCI slot 00:10.0
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ROM enabled at 0xfb000000
    ide2: BM-DMA at 0xdca0-0xdca7, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xdca8-0xdcaf, BIOS settings: hdg:pio, hdh:pio
hde: MAXTOR 4K060H3, ATA DISK drive
ide2 at 0xdcd8-0xdcdf,0xdcd2 on irq 16
hde: host protected area => 1
hde: 117266688 sectors (60041 MB) w/2000KiB Cache, CHS=116336/16/63, UDMA(100)
 hde: hde1 hde2 hde3 hde4 < hde5 hde6 hde7 >
ide-floppy driver 0.99.newide
hda: 98304kB, 196608 blocks, 512 sector size
hda: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
 hda: hda4
 hda: hda4
Badness name:hda4, err:-17, set:<NULL>
Badness in create_dir at lib/kobject.c:64
Call Trace:
 [<c018831b>] create_dir+0x7b/0x90
 [<c0188495>] kobject_add+0xa5/0xc0
 [<c01884c5>] kobject_register+0x15/0x30
 [<c01632e9>] register_disk+0xf9/0x150
 [<c01ae4be>] blk_register_region+0x3e/0xd0
 [<c01ae645>] add_disk+0x35/0x50
 [<c01ae5e0>] exact_match+0x0/0x10
 [<c01ae5f0>] exact_lock+0x0/0x20
 [<c01dc312>] idefloppy_attach+0x162/0x170
 [<c01d685d>] ata_attach+0x2d/0xa0
 [<c01d7472>] ide_register_driver+0x92/0xd0
 [<c01dc334>] idefloppy_init+0x14/0x20
 [<c0105030>] init+0x0/0x160
 [<c0105051>] init+0x21/0x160
 [<c0105030>] init+0x0/0x160
 [<c0107021>] kernel_thread_helper+0x5/0x14
================================================================
diff -ur --exclude-from=/home/me/exclude linux-2.5.66-ref/lib/kobject.c linux-2.5.66-uni/lib/kobject.c
--- linux-2.5.66-ref/lib/kobject.c	Tue Mar  4 22:29:36 2003
+++ linux-2.5.66-uni/lib/kobject.c	Sat Mar 29 20:43:26 2003
@ -57,10 +57,15 @
 				sysfs_remove_dir(kobj);
 		}
 	}
+	if (error) {
+		printk("Badness name:%s, err:%d, set:%s\n",
+		       kobj->name, error,
+		       kobj->kset ? kobj->kset->kobj.name : "<NULL>");
+		WARN_ON(1);
+	}
 	return error;
 }
 
-
 static inline struct kobject * to_kobj(struct list_head * entry)
 {
 	return container_of(entry,struct kobject,entry);
@ -149,7 +154,6 @
 	if (kobj) {
 		kobject_init(kobj);
 		error = kobject_add(kobj);
-		WARN_ON(error);
 	} else
 		error = -EINVAL;
 	return error;

