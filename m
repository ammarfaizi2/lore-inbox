Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965918AbWKNPMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965918AbWKNPMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 10:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965920AbWKNPMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 10:12:32 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:62546 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S965918AbWKNPMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 10:12:31 -0500
Date: Tue, 14 Nov 2006 10:12:11 -0500
From: Eric Buddington <ebuddington@verizon.net>
Subject: 2.6.19-rc5-mm1: failure to start raid0
To: linux-kernel@vger.kernel.org
Reply-to: eric@buddington.net
Message-id: <20061114151211.GA3824@pool-70-109-247-63.wma.east.verizon.net>
Organization: ECS Labs
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Eric-conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under 2.6.19-rc5-mm1, I can't start my raid0 array. I have no such
problem under 2.6.18-mm1.  It seems to be detecting the disks fine
(see dmesg below), but the md device doesn't show up. My 1-disk raid1
array starts fine.

When I try 'mdadm --assemble /dev/md1 /dev/hda1 /dev/hdc1', I am
surprised by the error:

mdadm: cannot open device /dev/hda1: Device or resource busy
mdadm: /dev/hda1 has no superblock - assembly aborted

This happens even after booting with 'init=/bin/bash', so I know
there's nothing else using the drive.

dmesg:
--------------------------------------------------
[   72.559233] SIS5513: chipset revision 0
[   72.559275] SIS5513: not 100% native mode: will probe irqs later
[   72.559332] SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
[   72.559392]     ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:DMA
[   72.559515]     ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:DMA, hdd:DMA
[   72.559635] Probing IDE interface ide0...
[   72.845775] hda: Maxtor 7L300R0, ATA DISK drive
[   73.125617] hdb: Maxtor 5T040H4, ATA DISK drive
[   73.183213] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   73.183394] Probing IDE interface ide1...
[   73.469425] hdc: Maxtor 6L300R0, ATA DISK drive
[   73.749268] hdd: WDC WD204BB, ATA DISK drive
[   73.807646] ide1 at 0x170-0x177,0x376 on irq 15
[   73.808878] pnp: the driver 'ide' has been registered
[   73.808988] hda: max request size: 512KiB
[   73.830742] hda: 586114704 sectors (300090 MB) w/16384KiB Cache, CHS=36483/255/63, UDMA(133)
[   73.832460] hda: cache flushes supported
[   73.832547]  hda: hda1
[   73.839034] hdb: max request size: 128KiB
[   73.840922] hdb: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
[   73.841095] hdb: cache flushes not supported
[   73.841156]  hdb: hdb1
[   73.847861] hdc: max request size: 512KiB
[   73.869336] hdc: 586114704 sectors (300090 MB) w/16384KiB Cache, CHS=36483/255/63, UDMA(133)
[   73.871032] hdc: cache flushes supported
[   73.871101]  hdc: hdc1
[   73.874723] hdd: max request size: 128KiB
[   73.893301] hdd: 39876480 sectors (20416 MB) w/2048KiB Cache, CHS=39560/16/63, UDMA(100)
[   73.893469] hdd: cache flushes not supported
[   73.893528]  hdd: hdd1
[   73.902434] libata version 2.00 loaded.
[   73.903436] pnp: the driver 'pata_isapnp' has been registered
[   73.904246] pnp: the driver 'i8042 kbd' has been registered
[   73.904288] pnp: match found with the PnP device '00:0c' and the driver 'i8042 kbd'
[   73.904296] pnp: the driver 'i8042 aux' has been registered
[   73.904346] pnp: match found with the PnP device '00:0b' and the driver 'i8042 aux'
[   73.904356] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   73.904630] serio: i8042 KBD port at 0x60,0x64 irq 1
[   73.904709] serio: i8042 AUX port at 0x60,0x64 irq 12
[   73.904927] mice: PS/2 mouse device common for all mice
[   73.904986] md: linear personality registered for level -1
[   73.905056] md: raid0 personality registered for level 0
[   73.905101] md: raid1 personality registered for level 1
[   73.905147] md: raid10 personality registered for level 10
[   73.973067] raid6: int32x1    562 MB/s
[   74.040940] raid6: int32x2    631 MB/s
[   74.109002] raid6: int32x4    565 MB/s
[   74.176917] raid6: int32x8    423 MB/s
[   74.244867] raid6: mmxx1     1321 MB/s
[   74.312788] raid6: mmxx2     1698 MB/s
[   74.380777] raid6: sse1x1    1258 MB/s
[   74.448746] raid6: sse1x2    1512 MB/s
[   74.448789] raid6: using algorithm sse1x2 (1512 MB/s)
[   74.448834] md: raid6 personality registered for level 6
[   74.448879] md: raid5 personality registered for level 5
[   74.448924] md: raid4 personality registered for level 4
[   74.448971] raid5: automatically using best checksumming function: pIII_sse
[   74.468695]    pIII_sse  :  3723.000 MB/sec
[   74.468738] raid5: using function: pIII_sse (3723.000 MB/sec)
[   74.468937] device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
[   74.469221] EISA: Probing bus 0 at eisa.0
[   74.469408] NET: Registered protocol family 1
[   74.469459] NET: Registered protocol family 17
[   74.469571] NET: Registered protocol family 8
[   74.469615] NET: Registered protocol family 20
[   74.469754] Using IPI Shortcut mode
[   74.469878] ACPI: (supports S0 S3 S4 S5)
[   74.472696] Time: acpi_pm clocksource has been installed.
[   74.472766] Clock event device pit disabled
[   74.472823] Clock event device lapic configured with caps set: 08
[   74.472874] Switched to high resolution mode on CPU 0
[   74.491123] input: AT Translated Set 2 keyboard as /class/input/input0
[   74.572823] md: Autodetecting RAID arrays.
[   74.657609] md: invalid raid superblock magic on hdd1
[   74.657655] md: hdd1 has invalid sb, not importing!
[   74.657711] md: autorun ...
[   74.657752] md: considering hdc1 ...
[   74.657810] md:  adding hdc1 ...
[   74.657853] md: hdb1 has different UUID to hdc1
[   74.657899] md:  adding hda1 ...
[   74.657988] md: created md1
[   74.658030] md: bind<hda1>
[   74.658079] md: bind<hdc1>
[   74.658136] md: running: <hdc1><hda1>
[   74.658275] md1: setting max_sectors to 16384, segment boundary to 4194303
[   74.658324] raid0: looking at hdc1
[   74.658365] raid0:   comparing hdc1(293044224) with hdc1(293044224)
[   74.658439] raid0:   END
[   74.658478] raid0:   ==> UNIQUE
[   74.658518] raid0: 1 zones
[   74.658559] raid0: looking at hda1
[   74.658600] raid0:   comparing hda1(293044224) with hdc1(293044224)
[   74.658674] raid0:   EQUAL
[   74.658713] raid0: FINAL 1 zones
[   74.658756] raid0: done.
[   74.658796] raid0 : md_size is 586088448 blocks.
[   74.658839] raid0 : conf->hash_spacing is 586088448 blocks.
[   74.658884] raid0 : nb_zone is 1.
[   74.658924] raid0 : Allocating 4 bytes for hash.
[   74.659001] md: considering hdb1 ...
[   74.659047] md:  adding hdb1 ...
[   74.659135] md: created md2
[   74.659176] md: bind<hdb1>
[   74.659224] md: running: <hdb1>
[   74.659433] raid1: raid set md2 active with 1 out of 1 mirrors
[   74.675896] md2: bitmap initialized from disk: read 10/10 pages, set 79 bits, status: 0
[   74.675956] created bitmap (153 pages) for device md2
[   74.676296] md: ... autorun DONE.
[   74.677038] ReiserFS: md2: found reiserfs format "3.6" with standard journal
[   74.677100] ReiserFS: md2: using ordered data mode
[   74.705180] ReiserFS: md2: journal params: device md2, size 8192, journal first block 18, max trans len 1024, max batch 90
0, max commit age 30, max trans age 30
[   74.707376] ReiserFS: md2: checking transaction log (md2)
[   85.954868] ReiserFS: md2: replayed 268 transactions in 11 seconds
[   85.962564] ReiserFS: md2: Using r5 hash to sort names
[   85.962777] VFS: Mounted root (reiserfs filesystem) readonly.
[   85.963358] Freeing unused kernel memory: 276k freed
