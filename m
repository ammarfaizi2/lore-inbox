Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTFZWAk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 18:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTFZWAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 18:00:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:57031 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263183AbTFZWAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 18:00:19 -0400
Date: Fri, 27 Jun 2003 00:15:50 +0200
From: Arne Brutschy <abrutschy@xylon.de>
X-Mailer: The Bat! (v1.62r) Personal
Reply-To: Arne Brutschy <abrutschy@xylon.de>
Organization: Xylon
X-Priority: 3 (Normal)
Message-ID: <1396499038.20030627001550@xylon.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: RAID/IDE driver kernel panic (as usual ICH4 problems)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm still having problems with the ICH4 and my PDC20276.

I'm trying to find a stable setup fro the ICH4 since 2.4.18, but
nothing worked till 2.4.21. I always had the resource collisions
and lost interrupts all the others users reported. With this
kernel release (and the ide driver backport), the lost interrupts
vanished. So I recreated my Raid5 and put hapily all data on it.
Now, the lost interrupts are back again. :(

I had serveral lost interrups on some of the ICH4 disks, and this
evening the PDC crashed completely (for the first time). Before that,
the PDC was pretty stable.

More about my hardware setup:

PCI SCSI Controller
   System on /dev/md0-4
onboard ICH4
   2x Maxtor 96147H6, ATA DISK drive, 60GB, /dev/md6
   2x SAMSUNG SV1204H, ATA DISK drive, 120GB
onboard PDC 20276
   4x Maxtor 4G120J6, ATA DISK drive, 120GB

The 120GB drives are /dev/md5, raid level 5. All other raid devices
are raid level 1.

See the thread "[PATCH] ide driver 2.4.21-rc6" starting at 2nd june
about my problems with the PDC20276 and bootorder.

I will include two logs here, sorry for the long mail.

After the crash, I cannot mount the raid 5 disks anymore, it complains
about different superblocks on /dev/hdf5 and /dev/hde5:

Jun 27 00:08:09 gonzo kernel: md: running: <hdh5><hdg5><hdf5><hde5><hdd5><hdc5>
Jun 27 00:08:09 gonzo kernel: md: hdh5's event counter: 00000022
Jun 27 00:08:09 gonzo kernel: md: hdg5's event counter: 00000022
Jun 27 00:08:09 gonzo kernel: md: hdf5's event counter: 0000001f
Jun 27 00:08:09 gonzo kernel: md: hde5's event counter: 0000001f
Jun 27 00:08:09 gonzo kernel: md: hdd5's event counter: 00000022
Jun 27 00:08:09 gonzo kernel: md: hdc5's event counter: 00000022
Jun 27 00:08:09 gonzo kernel: md: superblock update time inconsistency -- using the most recent one
Jun 27 00:08:09 gonzo kernel: md: freshest: hdh5
Jun 27 00:08:09 gonzo kernel: md: kicking non-fresh hdf5 from array!
Jun 27 00:08:09 gonzo kernel: md: unbind<hdf5,5>
Jun 27 00:08:09 gonzo kernel: md: export_rdev(hdf5)
Jun 27 00:08:09 gonzo kernel: md: kicking non-fresh hde5 from array!
Jun 27 00:08:09 gonzo kernel: md: unbind<hde5,4>
Jun 27 00:08:09 gonzo kernel: md: export_rdev(hde5)
Jun 27 00:08:09 gonzo kernel: md5: removing former faulty hde5!
Jun 27 00:08:09 gonzo kernel: md5: removing former faulty hdf5!


I hope somebody can help me, and I hope I can get the data back.

My questions are:

1) how can I get the IDE drives stable?
2) how can I get the array (and my data) back?


Regards,
Arne

******LOGS*****

booting:

Jun 26 23:22:12 gonzo kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jun 26 23:22:12 gonzo kernel: ICH4: IDE controller at PCI slot 00:1f.1
Jun 26 23:22:12 gonzo kernel: ICH4: chipset revision 1
Jun 26 23:22:13 gonzo kernel: ICH4: not 100%% native mode: will probe irqs later
Jun 26 23:22:13 gonzo kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
Jun 26 23:22:13 gonzo kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Jun 26 23:22:13 gonzo kernel: PDC20276: IDE controller at PCI slot 02:02.0
Jun 26 23:22:13 gonzo kernel: PDC20276: chipset revision 1
Jun 26 23:22:13 gonzo kernel: PDC20276: not 100%% native mode: will probe irqs later
Jun 26 23:22:13 gonzo kernel:     ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
Jun 26 23:22:13 gonzo kernel:     ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
Jun 26 23:22:13 gonzo kernel: hda: Maxtor 96147H6, ATA DISK drive
Jun 26 23:22:13 gonzo kernel: hdb: Maxtor 96147H6, ATA DISK drive
Jun 26 23:22:13 gonzo kernel: blk: queue c033fb60, I/O limit 4095Mb (mask 0xffffffff)
Jun 26 23:22:13 gonzo kernel: blk: queue c033fc9c, I/O limit 4095Mb (mask 0xffffffff)
Jun 26 23:22:14 gonzo kernel: hdc: SAMSUNG SV1204H, ATA DISK drive
Jun 26 23:22:14 gonzo kernel: hdd: SAMSUNG SV1204H, ATA DISK drive
Jun 26 23:22:14 gonzo kernel: blk: queue c033ffb4, I/O limit 4095Mb (mask 0xffffffff)
Jun 26 23:22:14 gonzo kernel: blk: queue c03400f0, I/O limit 4095Mb (mask 0xffffffff)
Jun 26 23:22:14 gonzo kernel: hde: Maxtor 4G120J6, ATA DISK drive
Jun 26 23:22:14 gonzo kernel: hdf: Maxtor 4G120J6, ATA DISK drive
Jun 26 23:22:14 gonzo kernel: blk: queue c0340408, I/O limit 4095Mb (mask 0xffffffff)
Jun 26 23:22:14 gonzo kernel: blk: queue c0340544, I/O limit 4095Mb (mask 0xffffffff)
Jun 26 23:22:14 gonzo kernel: hdg: Maxtor 4G120J6, ATA DISK drive
Jun 26 23:22:14 gonzo kernel: hdh: Maxtor 4G120J6, ATA DISK drive
Jun 26 23:22:14 gonzo kernel: blk: queue c034085c, I/O limit 4095Mb (mask 0xffffffff)
Jun 26 23:22:15 gonzo kernel: blk: queue c0340998, I/O limit 4095Mb (mask 0xffffffff)
Jun 26 23:22:15 gonzo kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jun 26 23:22:15 gonzo kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jun 26 23:22:15 gonzo kernel: ide2 at 0x9000-0x9007,0x9402 on irq 18
Jun 26 23:22:15 gonzo kernel: ide3 at 0x9800-0x9807,0x9c02 on irq 18
Jun 26 23:22:15 gonzo kernel: hda: attached ide-disk driver.
Jun 26 23:22:15 gonzo kernel: hda: host protected area => 1
Jun 26 23:22:15 gonzo kernel: hda: 120064896 sectors (61473 MB) w/2048KiB Cache, CHS=7473/255/63, UDMA(100)
Jun 26 23:22:15 gonzo kernel: hdb: attached ide-disk driver.
Jun 26 23:22:15 gonzo kernel: hdb: host protected area => 1
Jun 26 23:22:16 gonzo kernel: hdb: 120064896 sectors (61473 MB) w/2048KiB Cache, CHS=7473/255/63, UDMA(100)
Jun 26 23:22:16 gonzo kernel: hdc: attached ide-disk driver.
Jun 26 23:22:16 gonzo kernel: hdc: host protected area => 1
Jun 26 23:22:16 gonzo kernel: hdc: 234493056 sectors (120060 MB) w/2048KiB Cache, CHS=232632/16/63, UDMA(100)
Jun 26 23:22:16 gonzo kernel: hdd: attached ide-disk driver.
Jun 26 23:22:16 gonzo kernel: hdd: host protected area => 1
Jun 26 23:22:16 gonzo kernel: hdd: 234493056 sectors (120060 MB) w/2048KiB Cache, CHS=232632/16/63, UDMA(100)
Jun 26 23:22:16 gonzo kernel: hde: attached ide-disk driver.
Jun 26 23:22:16 gonzo kernel: hde: host protected area => 1
Jun 26 23:22:16 gonzo kernel: hde: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(133)
Jun 26 23:22:16 gonzo kernel: hdf: attached ide-disk driver.
Jun 26 23:22:16 gonzo kernel: hdf: host protected area => 1
Jun 26 23:22:17 gonzo kernel: hdf: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(133)
Jun 26 23:22:17 gonzo kernel: hdg: attached ide-disk driver.
Jun 26 23:22:17 gonzo kernel: hdg: host protected area => 1
Jun 26 23:22:17 gonzo kernel: hdg: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(133)
Jun 26 23:22:17 gonzo kernel: hdh: attached ide-disk driver.
Jun 26 23:22:17 gonzo kernel: hdh: host protected area => 1
Jun 26 23:22:17 gonzo kernel: hdh: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(133)
Jun 26 23:22:17 gonzo kernel: Partition check:
Jun 26 23:22:18 gonzo kernel:  hda: unknown partition table
Jun 26 23:22:18 gonzo kernel:  hdb: unknown partition table
Jun 26 23:22:18 gonzo kernel:  hdc: hdc1 < hdc5 >
Jun 26 23:22:19 gonzo kernel:  hdd: hdd1 < hdd5 >
Jun 26 23:22:19 gonzo kernel:  hde: hde1 < hde5 >
Jun 26 23:22:19 gonzo kernel:  hdf: hdf1 < hdf5 >
Jun 26 23:22:19 gonzo kernel:  hdg: hdg1 < hdg5 >
Jun 26 23:22:20 gonzo kernel:  hdh: hdh1 < hdh5 >

crash:

Jun 26 04:07:37 gonzo kernel: hdc: dma_timer_expiry: dma status == 0x64
Jun 26 04:07:37 gonzo kernel: hdc: lost interrupt
Jun 26 04:07:37 gonzo kernel: hdc: dma_intr: bad DMA status (dma_stat=70)
Jun 26 04:07:37 gonzo kernel: hdc: dma_intr: status=0x50 { DriveReady SeekComplete }
..
Jun 26 16:43:35 gonzo kernel: hdc: dma_timer_expiry: dma status == 0x64
Jun 26 16:43:35 gonzo kernel: hdc: lost interrupt
Jun 26 16:43:35 gonzo kernel: hdc: dma_intr: bad DMA status (dma_stat=70)
Jun 26 16:43:35 gonzo kernel: hdc: dma_intr: status=0x50 { DriveReady SeekComplete }
..
Jun 26 20:14:24 gonzo kernel: hde: dma_timer_expiry: dma status == 0x61
Jun 26 20:14:34 gonzo kernel: hde: timeout waiting for DMA
Jun 26 20:14:34 gonzo kernel: PDC202XX: Primary channel reset.
Jun 26 20:14:34 gonzo kernel: hde: timeout waiting for DMA
Jun 26 20:14:34 gonzo kernel: hde: (__ide_dma_test_irq) called while not waiting
Jun 26 20:14:59 gonzo kernel: hdf: dma_timer_expiry: dma status == 0x40
Jun 26 20:14:59 gonzo kernel: hdf: timeout waiting for DMA
Jun 26 20:14:59 gonzo kernel: PDC202XX: Primary channel reset.
Jun 26 20:14:59 gonzo kernel: hdf: timeout waiting for DMA
Jun 26 20:14:59 gonzo kernel: hdf: (__ide_dma_test_irq) called while not waiting
Jun 26 20:14:59 gonzo kernel: hde: status timeout: status=0xd0 { Busy }
Jun 26 20:14:59 gonzo kernel:
Jun 26 20:14:59 gonzo kernel: PDC202XX: Primary channel reset.
Jun 26 20:14:59 gonzo kernel: hde: drive not ready for command
Jun 26 20:15:34 gonzo kernel: ide2: reset timed-out, status=0xd0
Jun 26 20:15:34 gonzo kernel: hdf: status error: status=0x50 { DriveReady SeekComplete }
Jun 26 20:15:34 gonzo kernel:
Jun 26 20:15:34 gonzo kernel: hdf: no DRQ after issuing WRITE
Jun 26 20:15:34 gonzo kernel: hde: status timeout: status=0xd0 { Busy }
Jun 26 20:15:34 gonzo kernel:
Jun 26 20:15:34 gonzo kernel: PDC202XX: Primary channel reset.
Jun 26 20:15:34 gonzo kernel: hde: drive not ready for command
Jun 26 20:16:04 gonzo kernel: ide2: reset timed-out, status=0xd0
Jun 26 20:16:04 gonzo kernel: hdf: status error: status=0x50 { DriveReady SeekComplete }
Jun 26 20:16:04 gonzo kernel:
Jun 26 20:16:04 gonzo kernel: hdf: no DRQ after issuing WRITE
Jun 26 20:16:04 gonzo kernel: blk: queue c0340408, I/O limit 4095Mb (mask 0xffffffff)
Jun 26 20:16:04 gonzo kernel: end_request: I/O error, dev 21:05 (hde), sector 159991808
Jun 26 20:16:04 gonzo kernel: raid5: Disk failure on hde5, disabling device. Operation continuing on 5 devices
Jun 26 20:16:04 gonzo kernel: md: updating md5 RAID superblock on device
Jun 26 20:16:04 gonzo kernel: md: hdh5 [events: 00000020]<6>(write) hdh5's sb offset: 120060736
Jun 26 20:16:04 gonzo kernel: md: recovery thread got woken up ...
Jun 26 20:16:04 gonzo kernel: md5: no spare disk to reconstruct array! -- continuing in degraded mode
Jun 26 20:16:04 gonzo kernel: md: recovery thread finished ...
Jun 26 20:16:04 gonzo kernel: md: hdg5 [events: 00000020]<6>(write) hdg5's sb offset: 120053568
Jun 26 20:16:04 gonzo kernel: md: hdf5 [events: 00000020]<6>(write) hdf5's sb offset: 120060736
..
Jun 26 20:16:34 gonzo kernel: hdf: lost interrupt
Jun 26 20:16:34 gonzo kernel: hdf: status error: status=0x50 { DriveReady SeekComplete }
Jun 26 20:16:34 gonzo kernel:
Jun 26 20:16:34 gonzo kernel: hdf: no DRQ after issuing WRITE
Jun 26 20:16:34 gonzo kernel: end_request: I/O error, dev 21:05 (hde), sector 159991816
Jun 26 20:16:34 gonzo kernel: hdf: status error: status=0x50 { DriveReady SeekComplete }
Jun 26 20:16:34 gonzo kernel:
Jun 26 20:16:34 gonzo kernel: hde: DMA disabled
Jun 26 20:16:34 gonzo kernel: PDC202XX: Primary channel reset.
Jun 26 20:16:34 gonzo kernel: hdf: no DRQ after issuing WRITE
Jun 26 20:17:04 gonzo kernel: ide2: reset timed-out, status=0xd0
Jun 26 20:17:04 gonzo kernel: hdf: status error: status=0x50 { DriveReady SeekComplete }
Jun 26 20:17:04 gonzo kernel:
Jun 26 20:17:04 gonzo kernel: hdf: no DRQ after issuing WRITE
Jun 26 20:17:04 gonzo kernel: end_request: I/O error, dev 21:05 (hde), sector 159991824
Jun 26 20:17:04 gonzo kernel: hdf: status error: status=0x50 { DriveReady SeekComplete }
Jun 26 20:17:04 gonzo kernel:
Jun 26 20:17:04 gonzo kernel: hdf: no DRQ after issuing WRITE
Jun 26 20:17:34 gonzo kernel: hdf: lost interrupt
Jun 26 20:17:34 gonzo kernel: hdf: status error: status=0x50 { DriveReady SeekComplete }
Jun 26 20:17:34 gonzo kernel:
Jun 26 20:17:34 gonzo kernel: hdf: no DRQ after issuing WRITE
Jun 26 20:17:34 gonzo kernel: end_request: I/O error, dev 21:05 (hde), sector 159988056
Jun 26 20:17:34 gonzo kernel: hdf: status error: status=0x50 { DriveReady SeekComplete }
Jun 26 20:17:34 gonzo kernel:
Jun 26 20:17:34 gonzo kernel: PDC202XX: Primary channel reset.
Jun 26 20:17:34 gonzo kernel: hdf: no DRQ after issuing WRITE
Jun 26 20:18:04 gonzo kernel: ide2: reset timed-out, status=0xd0
Jun 26 20:18:04 gonzo kernel: blk: queue c0340544, I/O limit 4095Mb (mask 0xffffffff)
Jun 26 20:18:04 gonzo kernel: end_request: I/O error, dev 21:45 (hdf), sector 159991832
Jun 26 20:18:04 gonzo kernel: raid5: Disk failure on hdf5, disabling device. Operation continuing on 4 devices
Jun 26 20:18:04 gonzo kernel: end_request: I/O error, dev 21:05 (hde), sector 159988064
Jun 26 20:18:04 gonzo kernel: end_request: I/O error, dev 21:45 (hdf), sector 159991840
Jun 26 20:18:04 gonzo kernel: end_request: I/O error, dev 21:45 (hdf), sector 159991848
Jun 26 20:18:04 gonzo kernel: end_request: I/O error, dev 21:45 (hdf), sector 159991856
Jun 26 20:18:04 gonzo kernel: end_request: I/O error, dev 21:45 (hdf), sector 159991864
Jun 26 20:18:04 gonzo kernel: end_request: I/O error, dev 21:45 (hdf), sector 6976
Jun 26 20:18:04 gonzo kernel: end_request: I/O error, dev 21:45 (hdf), sector 240121472
Jun 26 20:18:04 gonzo kernel: md: recovery thread got woken up ...
Jun 26 20:18:04 gonzo kernel: md: updating md5 RAID superblock on device
Jun 26 20:18:04 gonzo kernel: md: hdh5 [events: 00000021]<6>(write) hdh5's sb offset: 120060736
Jun 26 20:18:04 gonzo kernel: md: write_disk_sb failed for device hdf5
Jun 26 20:18:04 gonzo kernel: md: (skipping faulty hde5 )
Jun 26 20:18:04 gonzo kernel: md: hdd5 [events: 00000021]<6>(write) hdd5's sb offset: 117246400
Jun 26 20:18:05 gonzo kernel: md: hdc5 [events: 00000021]<6>(write) hdc5's sb offset: 117246400
Jun 26 20:18:05 gonzo kernel: md: hdg5 [events: 00000021]<6>(write) hdg5's sb offset: 120053568
Jun 26 20:18:05 gonzo kernel: md: errors occurred during superblock update, repeating
Jun 26 20:18:05 gonzo kernel: md: updating md5 RAID superblock on device
Jun 26 20:18:05 gonzo kernel: md: hdh5 [events: 00000022]<6>(write) hdh5's sb offset: 120060736
Jun 26 20:18:05 gonzo kernel: md: (skipping faulty hdf5 )
Jun 26 20:18:05 gonzo kernel: md: (skipping faulty hde5 )
Jun 26 20:18:05 gonzo kernel: md: hdd5 [events: 00000022]<6>(write) hdd5's sb offset: 117246400
Jun 26 20:18:05 gonzo kernel: md: hdg5 [events: 00000022]<6>(write) hdg5's sb offset: 120053568
Jun 26 20:18:05 gonzo kernel: md: hdc5 [events: 00000022]<6>(write) hdc5's sb offset: 117246400
Jun 26 20:18:05 gonzo kernel: md: (skipping faulty hdf5 )
Jun 26 20:18:05 gonzo kernel: md: (skipping faulty hde5 )
Jun 26 20:18:05 gonzo kernel: md: hdd5 [events: 00000022]<6>(write) hdd5's sb offset: 117246400
Jun 26 20:18:05 gonzo kernel: md5: no spare disk to reconstruct array! -- continuing in degraded mode
Jun 26 20:18:05 gonzo kernel: md: recovery thread finished ...
Jun 26 20:18:05 gonzo kernel: md: hdc5 [events: 00000022]<6>(write) hdc5's sb offset: 117246400
Jun 26 20:18:05 gonzo kernel: journal-601, buffer write failed
Jun 26 20:18:05 gonzo kernel: kernel BUG at prints.c:334!
Jun 26 20:18:05 gonzo kernel: invalid operand: 0000
Jun 26 20:18:05 gonzo kernel: CPU:    0
Jun 26 20:18:05 gonzo kernel: EIP:    0010:[<c019fa58>]    Tainted: P
Jun 26 20:18:05 gonzo kernel: EFLAGS: 00010282
Jun 26 20:18:05 gonzo kernel: eax: 00000024   ebx: def60800   ecx: 00000001   edx: c02b5ffc
Jun 26 20:18:05 gonzo kernel: esi: 00000000   edi: def60800   ebp: 00000007   esp: c1591ec0
Jun 26 20:18:05 gonzo kernel: ds: 0018   es: 0018   ss: 0018
Jun 26 20:18:05 gonzo kernel: Process kupdated (pid: 7, stackpage=c1591000)
Jun 26 20:18:05 gonzo kernel: Stack: c027c8f5 c0327220 def60800 e0b1460c c01aadba def60800 c0289520 00001000
Jun 26 20:18:05 gonzo kernel:        da263780 0000000a 00000008 00000000 ceac7880 00000000 00000014 c9675000
Jun 26 20:18:05 gonzo kernel:        00000004 c01aeee1 def60800 e0b1460c 00000001 00000006 e0b1d1bc 00000004
Jun 26 20:18:05 gonzo kernel: Call Trace:    [<c01aadba>] [<c01aeee1>] [<c01ae095>] [<c019c8b0>] [<c013f64b>]
Jun 26 20:18:06 gonzo kernel:   [<c013eb2c>] [<c013ee21>] [<c0105000>] [<c0105000>] [<c010577e>] [<c013ed50>]
Jun 26 20:18:06 gonzo kernel:
Jun 26 20:18:06 gonzo kernel: Code: 0f 0b 4e 01 8e fa 27 c0 85 db 74 0e 0f b7 43 08 89 04 24 e8

