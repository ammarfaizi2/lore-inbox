Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318209AbSIJXEc>; Tue, 10 Sep 2002 19:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318211AbSIJXEb>; Tue, 10 Sep 2002 19:04:31 -0400
Received: from cats-mx1.ucsc.edu ([128.114.129.36]:27532 "EHLO cats.ucsc.edu")
	by vger.kernel.org with ESMTP id <S318209AbSIJXE3>;
	Tue, 10 Sep 2002 19:04:29 -0400
Subject: Re: 3 ultra100 controllers
From: "T. Ryan Halwachs" <halwachs@cats.ucsc.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>,
       kernel mailing list <linux-kernel@vger.kernel.org>,
       ataraid mailing list <ataraid-list@redhat.com>,
       Jeff Nguyen <jeff@aslab.com>
In-Reply-To: <1031182589.2796.141.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.10.10209041245300.3440-100000@master.linux-ide.org>
	 <1031182589.2796.141.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Sep 2002 16:05:41 -0700
Message-Id: <1031699162.1213.52.camel@m700-wireless>
Mime-Version: 1.0
X-UCSC-CATS-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel: 2.4.29-ac4
mobo: intel WS440BX (gateway OEM)
bios: 4W4SB0X0.15A.0019.P14
cpu: celeron 400
mem: 288MB
power: powmax LP6100 500W

controllers:
PDC20267(ultra100 PCI)	 PCI slot 1 
PDC20267(ultra100 PCI)   PCI slot 2
CMD649(ultraATA 100 PCI) PCI slot 3

drives:
1 WD1200AB 120G drive on card 1 primary channel
1 IC35L120AVVA07-0 120G drive on card 1 secondary channel
2 WD1200AB 120G drives on card 2 (each on a separate channel)
2 WD1200AB 120G drives on card 3 (each on a separate channel)

problem:
I cannot get these drives to work reliably in a software raid5 array. I
was able to partition, mkraid, mke2fs, fsck, mount, and unmount.

I mounted the array locally on machine#0, then via nfs onto machine#1. I
started copying files from machine#1's local drive(s) to the array on
machine#0 via nfs.


I got these errors:

Sep  9 17:41:45 array kernel: hdi: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Sep  9 17:41:45 array kernel: hdi: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Sep  9 17:42:12 array kernel: hdi: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Sep  9 17:42:12 array kernel: hdi: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Sep  9 17:42:12 array kernel: hdi: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Sep  9 17:42:12 array kernel: hdi: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Sep  9 17:42:16 array kernel: hdi: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Sep  9 17:42:16 array kernel: hdi: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Sep  9 17:42:16 array kernel: hdi: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Sep  9 17:42:16 array kernel: hdi: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Sep  9 17:42:16 array kernel: hdi: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Sep  9 17:42:16 array kernel: hdi: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Sep  9 17:42:16 array kernel: hdi: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Sep  9 17:42:16 array kernel: hdi: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Sep  9 17:42:16 array kernel: PDC202XX: Primary channel reset.
Sep  9 17:42:16 array kernel: ide4: reset: success
Sep  9 17:42:36 array kernel: hdk: timeout waiting for DMA
Sep  9 17:42:36 array kernel: PDC202XX: Secondary channel reset.
Sep  9 17:42:36 array kernel: hdk: ide_dma_timeout: Lets do it
again!stat = 0x50, dma_stat = 0x20
Sep  9 17:42:36 array kernel: hdk: DMA disabled
Sep  9 17:42:36 array kernel: PDC202XX: Secondary channel reset.
Sep  9 17:42:36 array kernel: hdk: ide_set_handler: handler not null;
old=c01c0840, new=c01bdf30
Sep  9 17:42:36 array kernel: bug: kernel timer added twice at c01c06a8.
Sep  9 17:42:36 array kernel: hdk: ide_set_handler: handler not null;
old=c01bdf30, new=c01bdfa0
Sep  9 17:42:36 array kernel: bug: kernel timer added twice at c01c06a8.
Sep  9 17:42:36 array kernel: hdi: timeout waiting for DMA
Sep  9 17:42:36 array kernel: PDC202XX: Primary channel reset.
Sep  9 17:42:36 array kernel: hdi: ide_dma_timeout: Lets do it
again!stat = 0x50, dma_stat = 0x20
Sep  9 17:42:36 array kernel: hdi: DMA disabled
Sep  9 17:42:36 array kernel: PDC202XX: Primary channel reset.
Sep  9 17:42:36 array kernel: hdi: ide_set_handler: handler not null;
old=c01c0840, new=c01bdf30
Sep  9 17:42:36 array kernel: bug: kernel timer added twice at c01c06a8.
Sep  9 17:42:36 array kernel: hdi: ide_set_handler: handler not null;
old=c01bdf30, new=c01bdfa0
Sep  9 17:42:36 array kernel: bug: kernel timer added twice at c01c06a8.
Sep  9 17:43:06 array kernel: hdk: dma_intr: status=0x58 { DriveReady
SeekComplete DataRequest }
Sep  9 17:43:06 array kernel: 
Sep  9 17:43:06 array kernel: hdk: status timeout: status=0xd0 { Busy }
Sep  9 17:43:06 array kernel: 
Sep  9 17:43:06 array kernel: hdk: DMA disabled
Sep  9 17:43:06 array kernel: PDC202XX: Secondary channel reset.
Sep  9 17:43:06 array kernel: hdk: drive not ready for command
Sep  9 17:43:06 array kernel: ide5: reset: success
Sep  9 17:43:26 array kernel: hdi: dma_intr: status=0x58 { DriveReady
SeekComplete DataRequest }
Sep  9 17:43:26 array kernel: 
Sep  9 17:43:26 array kernel: hdi: status timeout: status=0xd0 { Busy }
Sep  9 17:43:26 array kernel: 
Sep  9 17:43:26 array kernel: hdi: DMA disabled
Sep  9 17:43:26 array kernel: PDC202XX: Primary channel reset.
Sep  9 17:43:26 array kernel: hdi: drive not ready for command
Sep  9 17:43:26 array kernel: ide4: reset: success
Sep  9 18:07:17 array kernel: hdk: status timeout: status=0xd0 { Busy }
Sep  9 18:07:17 array kernel: 
Sep  9 18:07:17 array kernel: PDC202XX: Secondary channel reset.
Sep  9 18:07:17 array kernel: hdk: no DRQ after issuing WRITE
Sep  9 18:07:17 array kernel: ide5: reset: success
Sep  9 19:29:16 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 19:29:16 array kernel: 
Sep  9 19:29:16 array kernel: hdi: drive not ready for command
Sep  9 19:36:37 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 19:36:37 array kernel: 
Sep  9 19:36:37 array kernel: hdi: drive not ready for command
Sep  9 19:39:18 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 19:39:18 array kernel: 
Sep  9 19:39:18 array kernel: hdi: drive not ready for command
Sep  9 19:42:41 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 19:42:41 array kernel: 
Sep  9 19:42:41 array kernel: hdi: drive not ready for command
Sep  9 19:42:46 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 19:42:46 array kernel: 
Sep  9 19:42:46 array kernel: hdi: drive not ready for command
Sep  9 19:43:09 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 19:43:09 array kernel: 
Sep  9 19:43:09 array kernel: hdi: drive not ready for command
Sep  9 19:43:09 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 19:43:09 array kernel: 
Sep  9 19:43:09 array kernel: hdi: drive not ready for command
Sep  9 19:44:37 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 19:44:37 array kernel: 
Sep  9 19:44:37 array kernel: hdi: drive not ready for command
Sep  9 19:45:01 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 19:45:01 array kernel: 
Sep  9 19:45:01 array kernel: hdi: drive not ready for command
Sep  9 19:48:29 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 19:48:29 array kernel: 
Sep  9 19:48:29 array kernel: hdi: drive not ready for command
Sep  9 19:48:34 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 19:48:34 array kernel: 
Sep  9 19:48:34 array kernel: hdi: drive not ready for command
Sep  9 19:48:39 array kernel: hdk: status timeout: status=0xd0 { Busy }
Sep  9 19:48:39 array kernel: 
Sep  9 19:48:39 array kernel: PDC202XX: Secondary channel reset.
Sep  9 19:48:39 array kernel: hdk: no DRQ after issuing WRITE
Sep  9 19:48:39 array kernel: ide5: reset: success
Sep  9 19:55:05 array kernel: hdk: status timeout: status=0xd0 { Busy }
Sep  9 19:55:05 array kernel: 
Sep  9 19:55:05 array kernel: PDC202XX: Secondary channel reset.
Sep  9 19:55:05 array kernel: hdk: no DRQ after issuing WRITE
Sep  9 19:55:05 array kernel: ide5: reset: success
Sep  9 19:55:47 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 19:55:47 array kernel: 
Sep  9 19:55:47 array kernel: hdi: drive not ready for command
Sep  9 20:04:01 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 20:04:01 array kernel: 
Sep  9 20:04:01 array kernel: hdi: drive not ready for command
Sep  9 20:04:08 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 20:04:08 array kernel: 
Sep  9 20:04:08 array kernel: hdi: drive not ready for command
Sep  9 20:04:13 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 20:04:13 array kernel: 
Sep  9 20:04:13 array kernel: hdi: drive not ready for command
Sep  9 20:04:24 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 20:04:24 array kernel: 
Sep  9 20:04:24 array kernel: hdi: drive not ready for command
Sep  9 20:04:42 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 20:04:42 array kernel: 
Sep  9 20:04:42 array kernel: hdi: drive not ready for command
Sep  9 20:04:53 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 20:04:53 array kernel: 
Sep  9 20:04:53 array kernel: hdi: drive not ready for command
Sep  9 20:05:11 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 20:05:11 array kernel: 
Sep  9 20:05:11 array kernel: hdi: drive not ready for command
Sep  9 20:05:39 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 20:05:39 array kernel: 
Sep  9 20:05:39 array kernel: hdi: drive not ready for command
Sep  9 20:05:46 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 20:05:46 array kernel: 
Sep  9 20:05:46 array kernel: hdi: drive not ready for command
Sep  9 20:06:38 array kernel: hdi: status error: status=0x58 {
DriveReady SeekComplete DataRequest }
Sep  9 20:06:38 array kernel: 
Sep  9 20:06:38 array kernel: hdi: drive not ready for command
Sep  9 20:24:13 array kernel: hdk: status timeout: status=0xd0 { Busy }
Sep  9 20:24:13 array kernel: 
Sep  9 20:24:13 array kernel: PDC202XX: Secondary channel reset.
Sep  9 20:24:13 array kernel: hdk: no DRQ after issuing WRITE
Sep  9 20:24:14 array kernel: ide5: reset: success
Sep  9 20:26:28 array kernel: hdk: status timeout: status=0xd0 { Busy }
Sep  9 20:26:28 array kernel: 
Sep  9 20:26:28 array kernel: PDC202XX: Secondary channel reset.
Sep  9 20:26:28 array kernel: hdk: no DRQ after issuing WRITE
Sep  9 20:26:28 array kernel: ide5: reset: success
Sep  9 21:02:28 array kernel: hdk: status timeout: status=0xd0 { Busy }
Sep  9 21:02:28 array kernel: 
Sep  9 21:02:28 array kernel: PDC202XX: Secondary channel reset.
Sep  9 21:02:28 array kernel: hdk: no DRQ after issuing WRITE
Sep  9 21:02:28 array kernel: ide5: reset: success
Sep  9 21:04:58 array kernel: hdk: status timeout: status=0xd0 { Busy }
Sep  9 21:04:58 array kernel: 
Sep  9 21:04:58 array kernel: PDC202XX: Secondary channel reset.
Sep  9 21:04:58 array kernel: hdk: no DRQ after issuing WRITE
Sep  9 21:04:58 array kernel: ide5: reset: success
Sep  9 21:55:05 array kernel: hdk: status timeout: status=0xd0 { Busy }
Sep  9 21:55:05 array kernel: 
Sep  9 21:55:05 array kernel: PDC202XX: Secondary channel reset.
Sep  9 21:55:05 array kernel: hdk: no DRQ after issuing WRITE
Sep  9 21:55:05 array kernel: ide5: reset: success

now machine#0 hangs at various places during boot.
I had tried other -ac kernels as well as some 2.5.xx. No joy.
Is there any work done lately that may address this(these) problems?

thanks a whole lot,
ryan



