Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314383AbSEHRfX>; Wed, 8 May 2002 13:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314449AbSEHRfW>; Wed, 8 May 2002 13:35:22 -0400
Received: from ns.neureal.com ([64.29.18.145]:516 "HELO mail2.neureal.com")
	by vger.kernel.org with SMTP id <S314383AbSEHRfV>;
	Wed, 8 May 2002 13:35:21 -0400
Message-ID: <001501c1f6b6$b3ba5b20$c264a8c0@hoytpub.com>
Reply-To: "Artur Jasowicz" <arturj@mousebusiness.com>
From: "Artur Jasowicz" <arturj@mousebusiness.com>
To: <linux-kernel@vger.kernel.org>
Subject: DriveReady SeekComplete problems
Date: Wed, 8 May 2002 12:34:52 -0500
Organization: Mouse Business
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mangalore.zipworld.com.au id DAA27857

I am building a file server with 5 drive software RAID5 array. I am using three IWill SIDE-100 (Highpoint 370A) controllers as my IDE interfaces, not using their RAID functionality. One Maxtor 160GB drive per channel, two channels per controller. I plan on adding hot spare as the sixth drive in the future. There's one 160GB partition on each drive. Linux version 2.4.19-pre7smp-020502b (root@production) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #6 SMP Thu May 2 12:15:34 CDT 2002
This is a dual Athlon 2000+ MP on Tyan Tiger S2466N-4 with 1GB RAM. OS and swap runs on separate drives and controllers. This array will be just for data once it is configured.

Below are the most relevant parts of my logs. I will post further details if anyone is willing to help, just let me know what info you need. Any suggestions greatly appreciated.

Artur

After issuing mkraid the system went to syncing RAID and following appeared in my syslog:

May  7 17:34:39 production kernel: RAID5 conf printout:
May  7 17:34:39 production kernel:  --- rd:5 wd:5 fd:0
May  7 17:34:39 production kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hde1
May  7 17:34:39 production kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdg1
May  7 17:34:39 production kernel:  disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdi1
May  7 17:34:39 production kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdk1
May  7 17:34:39 production kernel:  disk 4, s:0, o:1, n:4 rd:4 us:1 dev:hdm1
May  7 17:34:39 production kernel: md: updating md3 RAID superblock on device
May  7 17:34:39 production kernel: md: hdm1 [events: 00000001]<6>(write) hdm1's sb offset: 160079552
May  7 17:34:39 production kernel: md: syncing RAID array md3
May  7 17:34:39 production kernel: md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
May  7 17:34:39 production kernel: md: using maximum available idle IO bandwith (but not more than 100000 KB/sec) for reconstruction.
May  7 17:34:39 production kernel: md: using 124k window, over a total of 160079488 blocks.
May  7 17:34:39 production kernel: md: hdk1 [events: 00000001]<6>(write) hdk1's sb offset: 160079552
May  7 17:34:39 production kernel: hde: 0 bytes in FIFO
May  7 17:34:39 production kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
May  7 17:34:39 production kernel: hde: dma_intr: bad DMA status (dma_stat=1)
May  7 17:34:39 production kernel: hde: dma_intr: status=0x50 { DriveReady SeekComplete }
May  7 17:34:39 production kernel: hdi: 4 bytes in FIFO
May  7 17:34:39 production kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
May  7 17:34:39 production kernel: hdi: dma_intr: bad DMA status (dma_stat=1)
May  7 17:34:39 production kernel: hdi: dma_intr: status=0x50 { DriveReady SeekComplete }
May  7 17:34:39 production kernel: hdi: 192 bytes in FIFO
May  7 17:34:39 production kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
May  7 17:34:39 production kernel: hdi: dma_intr: bad DMA status (dma_stat=1)
May  7 17:34:39 production kernel: hdi: dma_intr: status=0x50 { DriveReady SeekComplete }
May  7 17:34:39 production kernel: md: hdi1 [events: 00000001]<6>(write) hdi1's sb offset: 160079552
May  7 17:34:39 production kernel: hdi: 128 bytes in FIFO
May  7 17:34:39 production kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
May  7 17:34:39 production kernel: hdi: dma_intr: bad DMA status (dma_stat=1)
May  7 17:34:39 production kernel: hdi: dma_intr: status=0x50 { DriveReady SeekComplete }
May  7 17:34:39 production kernel: hdk: 128 bytes in FIFO
[...snip...]
May  7 17:34:41 production kernel: hdk: 64 bytes in FIFO
May  7 17:34:41 production kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
May  7 17:34:41 production kernel: hdk: dma_intr: bad DMA status (dma_stat=1)
May  7 17:34:41 production kernel: hdk: dma_intr: status=0x50 { DriveReady SeekComplete }
May  7 17:34:41 production kernel: hdk: recal_intr: status=0xd0 { Busy }
May  7 17:34:41 production kernel: hdk: DMA disabled
May  7 17:34:41 production kernel: ide5: reset: success
May  7 17:34:50 production kernel: hdi: timeout waiting for DMA
May  7 17:34:50 production kernel: hdi: 12 bytes in FIFO
May  7 17:34:50 production kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
May  7 17:34:50 production kernel: hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May  7 17:34:50 production kernel: hdi: drive not ready for command

Simillar messages were reported for /dev/hdm, hdi, hde, hdk

I've mdstopped the process and disbled DMA for all RAID members with hdparm -d 0. Tried mdrun again and got following messages:

May  7 18:43:26 production kernel: hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May  7 18:43:26 production kernel: hdi: drive not ready for command
May  7 18:44:40 production kernel: hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May  7 18:44:40 production kernel: hdi: drive not ready for command
May  7 18:44:52 production kernel: hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May  7 18:44:52 production kernel: hdi: drive not ready for command
May  7 18:46:45 production kernel: hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May  7 18:46:45 production kernel: hdi: drive not ready for command
May  7 18:47:11 production kernel: hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May  7 18:47:11 production kernel: hdi: drive not ready for command
May  7 18:47:32 production kernel: hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May  7 18:47:32 production kernel: hdi: drive not ready for command
May  7 18:47:57 production kernel: hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May  7 18:47:57 production kernel: hdi: drive not ready for command
May  7 18:48:09 production kernel: hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May  7 18:48:09 production kernel: hdi: drive not ready for command
May  7 18:48:18 production kernel: hdk: write_intr error1: nr_sectors=128, stat=0xd0
May  7 18:48:18 production kernel: hdk: write_intr: status=0xd0 { Busy }
May  7 18:48:18 production kernel: ide5: reset: success
May  7 18:48:27 production kernel: hdi: status error: status=0x58 { DriveReady SeekComplete DataRequest }
May  7 18:48:27 production kernel: hdi: drive not ready for command
May  7 18:48:27 production kernel: hdi: status timeout: status=0xd0 { Busy }
May  7 18:48:27 production kernel: hdi: drive not ready for command
May  7 18:48:28 production kernel: ide4: reset: success
May  7 18:48:43 production kernel: raid5: parity resync was not fully finished, restarting next time.
May  7 18:48:43 production kernel: md: md_do_sync() got signal ... exiting
May  7 18:48:44 production kernel: raid5: resync aborted!


˝:.ûÀõ± ‚mÁÎ¢kaä…b≤ﬂÏzwmÖÈbùÔÓûÀõ± ‚mÈbûÏˇëÍÁz_‚ûÿ^nár°ˆ¶zÀÅÎhô®Ë≠⁄&£˚‡zø‰zπﬁó˙+Ä +zf£¢∑höàß~Ü≠Ü€iˇˇÔÅÍˇëÍÁz_ËÆÊj:+vâ®˛)ﬂ£¯möSÂy´≠Êù∂Ö≠Ü€iˇˇ√ÌªËÆÂíi
