Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbVDGUcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVDGUcd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 16:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVDGUcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 16:32:33 -0400
Received: from pirx.hexapodia.org ([199.199.212.25]:62040 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S262590AbVDGUbk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 16:31:40 -0400
Date: Thu, 7 Apr 2005 13:31:39 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc1-mm1: e100 fails to resume from swsusp
Message-ID: <20050407203139.GA24995@hexapodia.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sorry for this poor bugreport, but I haven't had time to track it down
more carefully.

Hardware: Vaio r505te, i815, onboard e100
Kernel:   2.6.12-rc1-mm1 plus patch to fix GlidePoint resume hang

After a swsusp resume, the onboard e100 does not pass traffic.  When I
was running 2.6.11-rc2 (IIRC) the network worked fine after resume.  I
will try to verify this today.

Oddly enough, things are at least well-enough connected that the driver
does print "link up" messages when I connect the cat5.

doing a "rmmod e100; modprobe e100" brings it back to life.

/var/log/dmesg, current dmesg buffer, and lspci -vvx are attached.

I'm guessing an ACPI interrupt routing issue?

-andy

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=dmesg

[4294667.296000] Linux version 2.6.12-rc1-mm1 (adi@sart) (gcc version 3.3.4 (Debian 1:3.3.4-9ubuntu5)) #3 Tue Mar 29 19:02:39 PST 2005
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
[4294667.296000]  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 0000000013cf0000 (usable)
[4294667.296000]  BIOS-e820: 0000000013cf0000 - 0000000013cfc000 (ACPI data)
[4294667.296000]  BIOS-e820: 0000000013cfc000 - 0000000013d00000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 0000000013d00000 - 0000000013e80000 (usable)
[4294667.296000]  BIOS-e820: 0000000013e80000 - 0000000014000000 (reserved)
[4294667.296000]  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[4294667.296000] 318MB LOWMEM available.
[4294667.296000] On node 0 totalpages: 81536
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:1
[4294667.296000]   Normal zone: 77440 pages, LIFO batch:16
[4294667.296000]   HighMem zone: 0 pages, LIFO batch:1
[4294667.296000] DMI present.
[4294667.296000] ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7120
[4294667.296000] ACPI: RSDT (v001 SONY   U1       0x20010312 PTL  0x00000000) @ 0x13cf74cb
[4294667.296000] ACPI: FADT (v001   SONY       U1 0x20010312 PTL  0x01000000) @ 0x13cfbf64
[4294667.296000] ACPI: BOOT (v001   SONY       U1 0x20010312 PTL  0x00000001) @ 0x13cfbfd8
[4294667.296000] ACPI: DSDT (v001   SONY       U1 0x20010312 PTL  0x0100000b) @ 0x00000000
[4294667.296000] Allocating PCI resources starting at 14000000 (gap: 14000000:eb800000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[4294667.296000] mapped APIC to ffffd000 (0127f000)
[4294667.296000] Initializing CPU#0
[4294667.296000] Kernel command line: root=/dev/hda2 ro
[4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)
[    0.000000] Detected 596.455 MHz processor.
[   15.311856] Using tsc for high-res timesource
[   15.313642] Console: colour VGA+ 80x25
[   15.315287] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[   15.316679] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[   15.353760] Memory: 319712k/326144k available (1691k kernel code, 5800k reserved, 778k data, 160k init, 0k highmem)
[   15.353835] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   15.354093] Calibrating delay loop... 1175.55 BogoMIPS (lpj=587776)
[   15.374454] Security Framework v1.0.0 initialized
[   15.374531] Mount-cache hash table entries: 512
[   15.374833] CPU: After generic identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
[   15.374855] CPU: After vendor identify, caps: 0383f9ff 00000000 00000000 00000000 00000000 00000000 00000000
[   15.374882] CPU: L1 I cache: 16K, L1 D cache: 16K
[   15.374925] CPU: L2 cache: 256K
[   15.374959] CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
[   15.374975] CPU: Intel Pentium III (Coppermine) stepping 06
[   15.375030] Enabling fast FPU save and restore... done.
[   15.375071] Enabling unmasked SIMD FPU exception support... done.
[   15.375116] Checking 'hlt' instruction... OK.
[   15.411716] ACPI: setting ELCR to 0200 (from 0628)
[   15.446665] softlockup thread 0 started up.
[   15.447647] NET: Registered protocol family 16
[   15.448645] PCI: PCI BIOS revision 2.10 entry at 0xfd9b0, last bus=1
[   15.448698] PCI: Using configuration type 1
[   15.448734] mtrr: v2.0 (20020519)
[   15.449666] ACPI: Subsystem revision 20050309
[   15.486102] ACPI: Interpreter enabled
[   15.486152] ACPI: Using PIC for interrupt routing
[   15.489646] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   15.489692] PCI: Probing PCI hardware (bus 00)
[   15.492194] ACPI: Assume root bridge [\_SB_.PCI0] segment is 0
[   15.521604] Boot video device is 0000:00:02.0
[   15.522701] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   15.527935] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
[   15.531593] ACPI: Embedded Controller [EC0] (gpe 28)
[   15.573181] ACPI: PCI Interrupt Link [LNKA] (IRQs 9) *0
[   15.574234] ACPI: PCI Interrupt Link [LNKB] (IRQs 9) *0
[   15.575114] ACPI: PCI Interrupt Link [LNKC] (IRQs 9) *0, disabled.
[   15.576133] ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
[   15.577142] ACPI: PCI Interrupt Link [LNKE] (IRQs *9)
[   15.578157] ACPI: PCI Interrupt Link [LNKH] (IRQs 9) *0
[   15.578799] PCI: Using ACPI for IRQ routing
[   15.578842] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   15.584833] Simple Boot Flag at 0x36 set to 0x1
[   15.586072] inotify device minor=63
[   15.586132] VFS: Disk quotas dquot_6.5.1
[   15.586226] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   15.586376] devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
[   15.586448] devfs: boot_options: 0x0
[   15.586545] Initializing Cryptographic API
[   15.588138] ACPI: AC Adapter [ACAD] (off-line)
[   15.592996] ACPI: Battery Slot [BAT1] (battery present)
[   15.593075] ACPI: Lid Switch [LID]
[   15.593129] ACPI: Power Button (CM) [PWRB]
[   15.618724] ACPI: Video Device [GCH0] (multi-head: yes  rom: yes  post: no)
[   15.619174] ACPI: CPU0 (power states: C1[C1] C2[C2])
[   15.619227] ACPI: Processor [CPU0] (supports 8 throttling states)
[   15.624942] ACPI: Thermal Zone [ATF0] (31 C)
[   15.630117] ACPI: No ACPI bus support for i8042
[   15.631911] serio: i8042 AUX port at 0x60,0x64 irq 12
[   15.632112] serio: i8042 KBD port at 0x60,0x64 irq 1
[   15.632153] io scheduler noop registered
[   15.632219] io scheduler anticipatory registered
[   15.632264] io scheduler deadline registered
[   15.632325] io scheduler cfq registered
[   15.632612] ACPI: No ACPI bus support for serio0
[   15.632772] ACPI: No ACPI bus support for serio1
[   15.633599] RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
[   15.633782] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   15.633831] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   15.634097] ICH2M: IDE controller at PCI slot 0000:00:1f.1
[   15.634162] ICH2M: chipset revision 3
[   15.634196] ICH2M: not 100% native mode: will probe irqs later
[   15.634252]     ide0: BM-DMA at 0x1800-0x1807, BIOS settings: hda:DMA, hdb:pio
[   15.634341] Probing IDE interface ide0...
[   15.656608] hda: TOSHIBA MK4026GAX, ATA DISK drive
[   15.666965] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   15.667127] ACPI: No ACPI bus support for 0.0
[   15.667355] Probing IDE interface ide1...
[   15.678789] Probing IDE interface ide2...
[   15.690171] Probing IDE interface ide3...
[   15.711377] Probing IDE interface ide4...
[   15.732585] Probing IDE interface ide5...
[   15.753894] hda: max request size: 128KiB
[   15.764599] hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
[   15.764715] hda: cache flushes supported
[   15.764919]  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
[   15.772655] mice: PS/2 mouse device common for all mice
[   15.772795] NET: Registered protocol family 2
[   15.773844] IP: routing cache hash table of 2048 buckets, 16Kbytes
[   15.774324] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[   15.774918] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[   15.775257] TCP: Hash tables configured (established 16384 bind 16384)
[   15.775301] TCP reno registered
[   15.775602] NET: Registered protocol family 8
[   15.775644] NET: Registered protocol family 20
[   15.775791] PM: Checking swsusp image.
[   15.776166] swsusp: Resume From Partition /dev/hda3
[   15.794489] input: AT Translated Set 2 keyboard on isa0060/serio0
[   15.801827] swsusp: Suspend partition has wrong signature?
[   15.801947] swsusp: Error -22 check for resume file
[   15.801954] PM: Resume from disk failed.
[   15.802112] ACPI wakeup devices: 
[   15.802146] PWRB  LAN CRD0  EC0 COMA USB1 USB2 MODE 
[   15.802217] ACPI: (supports S0 S3 S4 S5)
[   15.804591] EXT3-fs: INFO: recovery required on readonly filesystem.
[   15.804649] EXT3-fs: write access will be enabled during recovery.
[   16.183349] kjournald starting.  Commit interval 5 seconds
[   16.183455] EXT3-fs: hda2: orphan cleanup on readonly fs
[   16.183507] ext3_orphan_cleanup: deleting unreferenced inode 2260997
[   16.184725] ext3_orphan_cleanup: deleting unreferenced inode 295965
[   16.184752] EXT3-fs: hda2: 2 orphan inodes deleted
[   16.184790] EXT3-fs: recovery complete.
[   16.188796] EXT3-fs: mounted filesystem with ordered data mode.
[   16.188956] VFS: Mounted root (ext3 filesystem) readonly.
[   16.189753] Freeing unused kernel memory: 160k freed
[   16.469620] NET: Registered protocol family 1
[   19.591842] Adding 987988k swap on /dev/hda3.  Priority:-1 extents:1
[   19.668025] EXT3 FS on hda2, internal journal
[   23.016667] SCSI subsystem initialized
[   23.619409] ieee1394: Initialized config rom entry `ip1394'
[   23.899885]   Enabling hardware tapping
[   23.948354] sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
[   24.009714] input: PS/2 Mouse on isa0060/serio1
[   24.102584] input: AlpsPS/2 ALPS GlidePoint on isa0060/serio1
[   25.801110] kjournald starting.  Commit interval 5 seconds
[   25.801270] EXT3 FS on hda1, internal journal
[   25.801319] EXT3-fs: mounted filesystem with ordered data mode.

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dmesg.out"
Content-Transfer-Encoding: quoted-printable

[  846.041049] swsusp: critical section:=20
[  846.041760] [nosave pfn 0x363]<7>[nosave pfn 0x364]swsusp: Need to copy =
19037 pages
[  846.080619] suspend: (pages needed: 19037 + 512 free: 62497)
[  846.080663] alloc_pagedir(): nr_pages =3D 19112
[  846.082296] create_pbe_list(): initialized 19112 PBEs
[  846.507724] copy_data_pages(): pages to copy: 19112
[  846.669478] [nosave pfn 0x363]<7>[nosave pfn 0x364]<7>[   23.788650] PM:=
 Image restored successfully.
[   24.533786] ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKC] -> GSI 9 =
(level, low) -> IRQ 9
[   27.535136] Restarting tasks... done
[   54.583473] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
[   55.531978] e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
[   55.531999] e100: Copyright(c) 1999-2004 Intel Corporation
[   55.621885] ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [LNKE] -> GSI 9 =
(level, low) -> IRQ 9
[   55.656851] e100: eth0: e100_probe: addr 0xf4104000, irq 9, MAC addr 08:=
00:46:17:7F:5D
[   56.354772] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
[   57.155232] eth0: no IPv6 routers present
[  230.781554] e100: eth0: e100_watchdog: link down
[  231.128438] PM: suspend-to-disk mode set to 'shutdown'
[  231.314093] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
[  231.315161] Freeing memory...  =08-=08\=08|=08done (51224 pages freed)
[  231.946356] PM: Attempting to suspend to disk.
[  231.946410] PM: snapshotting memory.
[  233.876405] swsusp: critical section:=20
[  233.877030] [nosave pfn 0x363]<7>[nosave pfn 0x364]swsusp: Need to copy =
11628 pages
[  233.916695] suspend: (pages needed: 11628 + 512 free: 69906)
[  233.916736] alloc_pagedir(): nr_pages =3D 11674
[  233.917140] create_pbe_list(): initialized 11674 PBEs
[  234.176706] copy_data_pages(): pages to copy: 11674
[  234.338384] [nosave pfn 0x363]<7>[nosave pfn 0x364]<7>[   22.588526] PM:=
 Image restored successfully.
[   22.637514] ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKC] -> GSI 9 =
(level, low) -> IRQ 9
[   26.552463] Restarting tasks... done
[  717.704483] PM: suspend-to-disk mode set to 'shutdown'
[  718.964516] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
[  718.965802] Freeing memory...  =08-=08\=08|=08/=08done (65354 pages free=
d)
[  730.866952] PM: Attempting to suspend to disk.
[  730.867006] PM: snapshotting memory.
[  732.089625] swsusp: critical section:=20
[  732.090582] [nosave pfn 0x363]<7>[nosave pfn 0x364]swsusp: Need to copy =
8756 pages
[  732.132550] suspend: (pages needed: 8756 + 512 free: 72778)
[  732.132590] alloc_pagedir(): nr_pages =3D 8791
[  732.132957] create_pbe_list(): initialized 8791 PBEs
[  732.326996] copy_data_pages(): pages to copy: 8791
[  732.487821] [nosave pfn 0x363]<7>[nosave pfn 0x364]<7>[   20.805752] PM:=
 Image restored successfully.
[   20.936752] ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKC] -> GSI 9 =
(level, low) -> IRQ 9
[   22.449044] Restarting tasks... done
[ 1127.080838] PM: suspend-to-disk mode set to 'shutdown'
[ 1127.145669] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
[ 1127.147206] Freeing memory...  =08-=08\=08|=08done (37556 pages freed)
[ 1127.398769] PM: Attempting to suspend to disk.
[ 1127.398817] PM: snapshotting memory.
[ 1129.006022] swsusp: critical section:=20
[ 1129.006884] [nosave pfn 0x363]<7>[nosave pfn 0x364]swsusp: Need to copy =
10961 pages
[ 1129.047418] suspend: (pages needed: 10961 + 512 free: 70573)
[ 1129.047459] alloc_pagedir(): nr_pages =3D 11004
[ 1129.047883] create_pbe_list(): initialized 11004 PBEs
[ 1129.291778] copy_data_pages(): pages to copy: 11004
[ 1129.451611] [nosave pfn 0x363]<7>[nosave pfn 0x364]<7>[   21.721925] PM:=
 Image restored successfully.
[   21.749771] ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKC] -> GSI 9 =
(level, low) -> IRQ 9
[   21.802486] Restarting tasks... done
[ 1420.473392] PM: suspend-to-disk mode set to 'shutdown'
[ 1420.547020] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D|
[ 1420.548410] Freeing memory...  =08-=08\=08|=08done (54441 pages freed)
[ 1420.939851] PM: Attempting to suspend to disk.
[ 1420.939902] PM: snapshotting memory.
[ 1422.901441] swsusp: critical section:=20
[ 1422.902349] [nosave pfn 0x363]<7>[nosave pfn 0x364]swsusp: Need to copy =
12919 pages
[ 1422.941840] suspend: (pages needed: 12919 + 512 free: 68615)
[ 1422.941880] alloc_pagedir(): nr_pages =3D 12970
[ 1422.942454] create_pbe_list(): initialized 12970 PBEs
[ 1423.229900] copy_data_pages(): pages to copy: 12970
[ 1423.392644] [nosave pfn 0x363]<7>[nosave pfn 0x364]<7>[   22.352799] PM:=
 Image restored successfully.
[   22.630182] ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKC] -> GSI 9 =
(level, low) -> IRQ 9
[   22.680059] Restarting tasks... done
[   24.103490] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
[   24.451775] e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
[   24.451795] e100: Copyright(c) 1999-2004 Intel Corporation
[   24.507057] ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [LNKE] -> GSI 9 =
(level, low) -> IRQ 9
[   24.559158] e100: eth0: e100_probe: addr 0xf4104000, irq 9, MAC addr 08:=
00:46:17:7F:5D
[   24.829245] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
[   25.490704] eth0: no IPv6 routers present
[  631.769606] PM: suspend-to-disk mode set to 'shutdown'
[  631.781623] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
[  631.782735] Freeing memory...  =08-=08\=08|=08/=08done (57761 pages free=
d)
[  638.141855] PM: Attempting to suspend to disk.
[  638.141909] PM: snapshotting memory.
[  639.393025] swsusp: critical section:=20
[  639.393719] [nosave pfn 0x363]<7>[nosave pfn 0x364]swsusp: Need to copy =
11306 pages
[  639.434496] suspend: (pages needed: 11306 + 512 free: 70228)
[  639.434540] alloc_pagedir(): nr_pages =3D 11351
[  639.435091] create_pbe_list(): initialized 11351 PBEs
[  639.686730] copy_data_pages(): pages to copy: 11351
[  639.849397] [nosave pfn 0x363]<7>[nosave pfn 0x364]<7>[   21.452547] PM:=
 Image restored successfully.
[   21.496003] ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKC] -> GSI 9 =
(level, low) -> IRQ 9
[   23.001811] Restarting tasks... done
[  167.204403] PM: suspend-to-disk mode set to 'shutdown'
[  167.668281] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D|
[  167.669491] Freeing memory...  =08-=08\=08|=08done (37084 pages freed)
[  168.521568] PM: Attempting to suspend to disk.
[  168.521602] PM: snapshotting memory.
[  170.466956] swsusp: critical section:=20
[  170.467590] [nosave pfn 0x363]<7>[nosave pfn 0x364]swsusp: Need to copy =
11049 pages
[  170.507329] suspend: (pages needed: 11049 + 512 free: 70485)
[  170.507356] alloc_pagedir(): nr_pages =3D 11093
[  170.507883] create_pbe_list(): initialized 11093 PBEs
[  170.750677] copy_data_pages(): pages to copy: 11093
[  170.913285] [nosave pfn 0x363]<7>[nosave pfn 0x364]<7>[   21.379147] PM:=
 Image restored successfully.
[   21.906809] ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKC] -> GSI 9 =
(level, low) -> IRQ 9
[   25.039637] Restarting tasks... done
[   29.133396] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
[   29.814175] e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
[   29.814196] e100: Copyright(c) 1999-2004 Intel Corporation
[   29.861288] ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [LNKE] -> GSI 9 =
(level, low) -> IRQ 9
[   29.900106] e100: eth0: e100_probe: addr 0xf4104000, irq 9, MAC addr 08:=
00:46:17:7F:5D
[   30.527782] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
[   31.396632] eth0: no IPv6 routers present
[  310.631713] PM: suspend-to-disk mode set to 'shutdown'
[  310.649216] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D|
[  310.652150] Freeing memory...  =08-=08\=08|=08/=08done (67553 pages free=
d)
[  318.134801] PM: Attempting to suspend to disk.
[  318.134858] PM: snapshotting memory.
[  319.947170] swsusp: critical section:=20
[  319.948075] [nosave pfn 0x363]<7>[nosave pfn 0x364]swsusp: Need to copy =
8871 pages
[  319.989898] suspend: (pages needed: 8871 + 512 free: 72663)
[  319.989938] alloc_pagedir(): nr_pages =3D 8906
[  319.990335] create_pbe_list(): initialized 8906 PBEs
[  320.187390] copy_data_pages(): pages to copy: 8906
[  320.351288] [nosave pfn 0x363]<7>[nosave pfn 0x364]<7>[   21.142088] PM:=
 Image restored successfully.
[   21.208334] ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKC] -> GSI 9 =
(level, low) -> IRQ 9
[   22.684357] Restarting tasks... done
[ 2415.611591] PM: suspend-to-disk mode set to 'shutdown'
[ 2417.733921] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
[ 2417.820990] Freeing memory...  =08-=08\=08|=08/=08done (51195 pages free=
d)
[ 2428.105777] PM: Attempting to suspend to disk.
[ 2428.105842] PM: snapshotting memory.
[ 2429.132813] swsusp: critical section:=20
[ 2429.133615] [nosave pfn 0x363]<7>[nosave pfn 0x364]swsusp: Need to copy =
9353 pages
[ 2429.175666] suspend: (pages needed: 9353 + 512 free: 72181)
[ 2429.175707] alloc_pagedir(): nr_pages =3D 9390
[ 2429.176184] create_pbe_list(): initialized 9390 PBEs
[ 2429.383217] copy_data_pages(): pages to copy: 9390
[ 2429.546628] [nosave pfn 0x363]<7>[nosave pfn 0x364]<7>[   21.647724] PM:=
 Image restored successfully.
[   21.681627] ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKC] -> GSI 9 =
(level, low) -> IRQ 9
[   23.158986] Restarting tasks... done
[   95.664284] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
[  121.454639] e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
[  121.454695] e100: Copyright(c) 1999-2004 Intel Corporation
[  121.584909] ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [LNKE] -> GSI 9 =
(level, low) -> IRQ 9
[  121.629068] e100: eth0: e100_probe: addr 0xf4104000, irq 9, MAC addr 08:=
00:46:17:7F:5D
[  124.368965] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
[  133.911396] eth0: no IPv6 routers present
[ 1576.338610] PM: suspend-to-disk mode set to 'shutdown'
[ 1576.445039] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D|
[ 1576.446301] Freeing memory...  =08-=08\=08|<6>e100: eth0: e100_watchdog:=
 link down
[ 1583.883934] =08/=08-=08done (58192 pages freed)
[ 1587.415959] PM: Attempting to suspend to disk.
[ 1587.416013] PM: snapshotting memory.
[ 1588.903085] swsusp: critical section:=20
[ 1588.904067] [nosave pfn 0x363]<7>[nosave pfn 0x364]swsusp: Need to copy =
9427 pages
[ 1588.945570] suspend: (pages needed: 9427 + 512 free: 72107)
[ 1588.945610] alloc_pagedir(): nr_pages =3D 9464
[ 1588.945942] create_pbe_list(): initialized 9464 PBEs
[ 1589.155185] copy_data_pages(): pages to copy: 9464
[ 1589.318386] [nosave pfn 0x363]<7>[nosave pfn 0x364]<7>[   20.814636] PM:=
 Image restored successfully.
[   20.831573] ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKC] -> GSI 9 =
(level, low) -> IRQ 9
[   22.347339] Restarting tasks... done
[  438.479991] PM: suspend-to-disk mode set to 'shutdown'
[  438.656197] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D|
[  438.683066] Freeing memory...  =08-=08\=08|=08/=08done (61029 pages free=
d)
[  446.571996] PM: Attempting to suspend to disk.
[  446.572049] PM: snapshotting memory.
[  447.713460] swsusp: critical section:=20
[  447.714388] [nosave pfn 0x363]<7>[nosave pfn 0x364]swsusp: Need to copy =
7847 pages
[  447.754814] suspend: (pages needed: 7847 + 512 free: 73687)
[  447.754855] alloc_pagedir(): nr_pages =3D 7878
[  447.755137] create_pbe_list(): initialized 7878 PBEs
[  447.929768] copy_data_pages(): pages to copy: 7878
[  448.091365] [nosave pfn 0x363]<7>[nosave pfn 0x364]<7>[   21.591273] PM:=
 Image restored successfully.
[   21.606711] ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKC] -> GSI 9 =
(level, low) -> IRQ 9
[   23.170911] Restarting tasks... done
[   26.941651] Trying to free free IRQ9
[   27.375962] e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
[   27.375981] e100: Copyright(c) 1999-2004 Intel Corporation
[   27.419356] ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [LNKE] -> GSI 9 =
(level, low) -> IRQ 9
[   27.463342] e100: eth0: e100_probe: addr 0xf4104000, irq 9, MAC addr 08:=
00:46:17:7F:5D
[   28.622013] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
[   29.844753] eth0: no IPv6 routers present
[  683.302184] e100: eth0: e100_watchdog: link down
[  683.522265] PM: suspend-to-disk mode set to 'shutdown'
[  684.096040] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D|
[  684.097189] Freeing memory...  =08-=08\=08|=08/=08done (57881 pages free=
d)
[  684.288655] PM: Attempting to suspend to disk.
[  684.288683] PM: snapshotting memory.
[  686.161581] swsusp: critical section:=20
[  686.162403] [nosave pfn 0x363]<7>[nosave pfn 0x364]swsusp: Need to copy =
16966 pages
[  686.202217] suspend: (pages needed: 16966 + 512 free: 64568)
[  686.202257] alloc_pagedir(): nr_pages =3D 17033
[  686.203245] create_pbe_list(): initialized 17033 PBEs
[  686.581844] copy_data_pages(): pages to copy: 17033
[  686.743686] [nosave pfn 0x363]<7>[nosave pfn 0x364]<7>[   23.124499] PM:=
 Image restored successfully.
[   23.172540] ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKC] -> GSI 9 =
(level, low) -> IRQ 9
[   26.271928] Restarting tasks... done
[  252.854412] PM: suspend-to-disk mode set to 'shutdown'
[  252.994006] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
[  253.021986] Freeing memory...  =08-=08\=08|=08/=08done (54995 pages free=
d)
[  268.385646] PM: Attempting to suspend to disk.
[  268.385704] PM: snapshotting memory.
[  270.345359] swsusp: critical section:=20
[  270.346151] [nosave pfn 0x363]<7>[nosave pfn 0x364]swsusp: Need to copy =
7859 pages
[  270.388301] suspend: (pages needed: 7859 + 512 free: 73675)
[  270.388342] alloc_pagedir(): nr_pages =3D 7890
[  270.388693] create_pbe_list(): initialized 7890 PBEs
[  270.562298] copy_data_pages(): pages to copy: 7890
[  270.725867] [nosave pfn 0x363]<7>[nosave pfn 0x364]<7>[   21.604214] PM:=
 Image restored successfully.
[   21.633041] ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKC] -> GSI 9 =
(level, low) -> IRQ 9
[   21.698522] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
[   23.150479] Restarting tasks... done
[   26.176682] e100: Intel(R) PRO/100 Network Driver, 3.3.6-k2-NAPI
[   26.176702] e100: Copyright(c) 1999-2004 Intel Corporation
[   26.223885] ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [LNKE] -> GSI 9 =
(level, low) -> IRQ 9
[   26.300034] e100: eth0: e100_probe: addr 0xf4104000, irq 9, MAC addr 08:=
00:46:17:7F:5D
[   26.786967] e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
[   27.193490] eth0: no IPv6 routers present
[ 1094.513955] PM: suspend-to-disk mode set to 'shutdown'
[ 1094.540794] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
[ 1094.542209] Freeing memory...  =08-=08\=08|<6>e100: eth0: e100_watchdog:=
 link down
[ 1106.619002] =08/=08done (55640 pages freed)
[ 1108.030041] PM: Attempting to suspend to disk.
[ 1108.030090] PM: snapshotting memory.
[ 1109.602250] swsusp: critical section:=20
[ 1109.603338] [nosave pfn 0x363]<7>[nosave pfn 0x364]swsusp: Need to copy =
8029 pages
[ 1109.645121] suspend: (pages needed: 8029 + 512 free: 73505)
[ 1109.645161] alloc_pagedir(): nr_pages =3D 8061
[ 1109.645456] create_pbe_list(): initialized 8061 PBEs
[ 1109.824025] copy_data_pages(): pages to copy: 8061
[ 1109.986898] [nosave pfn 0x363]<7>[nosave pfn 0x364]<7>[   20.855442] PM:=
 Image restored successfully.
[   20.915025] ACPI: PCI Interrupt 0000:01:02.0[A] -> Link [LNKC] -> GSI 9 =
(level, low) -> IRQ 9
[   22.452713] Restarting tasks... done

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="lspci.sart"

0000:00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 11)
	Subsystem: Sony Corporation: Unknown device 80e0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [88] #09 [f205]
00: 86 80 30 11 06 01 90 20 11 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e0 80
30: 00 00 00 00 88 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics Controller] (rev 11) (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 80e0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at f8000000 (32-bit, prefetchable)
	Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 32 11 07 00 b0 02 11 00 00 03 00 00 00 00
10: 08 00 00 f8 00 00 00 f4 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e0 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 03 01 00 00

0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f4100000-f41fffff
	Expansion ROM at 00003000 [disabled] [size=4K]
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
00: 86 80 48 24 07 01 80 00 03 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 30 30 80 22
20: 10 f4 10 f4 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00

0000:00:1f.0 ISA bridge: Intel Corp. 82801BAM ISA Bridge (LPC) (rev 03)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 86 80 4c 24 0f 00 80 02 03 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:1f.1 IDE interface: Intel Corp. 82801BAM IDE U100 (rev 03) (prog-if 80 [Master])
	Subsystem: Sony Corporation: Unknown device 80e0
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at 1800 [size=16]
00: 86 80 4a 24 05 00 80 02 03 80 01 01 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 18 00 00 00 00 00 00 00 00 00 00 4d 10 e0 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 80e0
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 1820 [size=32]
00: 86 80 42 24 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 18 00 00 00 00 00 00 00 00 00 00 4d 10 e0 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 04 00 00

0000:00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 03)
	Subsystem: Sony Corporation: Unknown device 80e0
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at 1810 [size=16]
00: 86 80 43 24 01 00 80 02 03 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 11 18 00 00 00 00 00 00 00 00 00 00 4d 10 e0 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

0000:00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 03) (prog-if 00 [UHCI])
	Subsystem: Sony Corporation: Unknown device 80e0
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 10
	Region 4: I/O ports at 1840 [size=32]
00: 86 80 44 24 05 00 80 02 03 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 18 00 00 00 00 00 00 00 00 00 00 4d 10 e0 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 03 00 00

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 03)
	Subsystem: Sony Corporation: Unknown device 80e0
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 1c00
	Region 1: I/O ports at 1880 [size=64]
00: 86 80 45 24 05 00 80 02 03 00 01 04 00 00 00 00
10: 01 1c 00 00 81 18 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e0 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

0000:00:1f.6 Modem: Intel Corp. Intel 537 [82801BA/BAM AC'97 Modem] (rev 03) (prog-if 00 [Generic])
	Subsystem: Sony Corporation: Unknown device 80e0
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 2400
	Region 1: I/O ports at 2000 [size=128]
00: 86 80 46 24 01 00 80 02 03 00 03 07 00 00 00 00
10: 01 24 00 00 01 20 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e0 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 02 00 00

0000:01:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AA22 IEEE-1394 Controller (PHY/Link Integrated) (rev 02) (prog-if 10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80e0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 1000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at f4105000 (32-bit, non-prefetchable)
	Region 1: Memory at f4100000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 4c 10 21 80 16 01 10 02 02 10 00 0c 08 40 00 00
10: 00 50 10 f4 00 00 10 f4 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 10 e0 80
30: 00 00 00 00 44 00 00 00 00 00 00 00 03 01 03 04

0000:01:02.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
	Subsystem: Sony Corporation: Unknown device 80e0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f4106000 (32-bit, non-prefetchable)
	Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: f4120000-f413f000 (prefetchable)
	Memory window 1: f4140000-f415f000
	I/O window 0: 00003400-000034ff
	I/O window 1: 00003800-000038ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 80 11 75 04 07 00 10 02 80 00 07 06 00 a8 02 00
10: 00 60 10 f4 dc 00 00 02 01 02 05 b0 00 00 12 f4
20: 00 f0 13 f4 00 00 14 f4 00 f0 15 f4 00 34 00 00
30: fc 34 00 00 00 38 00 00 fc 38 00 00 00 01 80 05
40: 4d 10 e0 80 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller (rev 03)
	Subsystem: Intel Corp. EtherExpress PRO/100 VE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f4104000 (32-bit, non-prefetchable)
	Region 1: I/O ports at 3000 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: 86 80 49 24 17 01 90 02 03 00 00 02 08 42 00 00
10: 00 40 10 f4 01 30 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 13 30
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 01 08 38


--FCuugMFkClbJLl1L--
