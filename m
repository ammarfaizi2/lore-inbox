Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132471AbRD0XH6>; Fri, 27 Apr 2001 19:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132502AbRD0XHt>; Fri, 27 Apr 2001 19:07:49 -0400
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:31757 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S132471AbRD0XH3>;
	Fri, 27 Apr 2001 19:07:29 -0400
Date: Sat, 28 Apr 2001 00:47:43 +0200 (CEST)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IDE reset and DMA disabled after CD read error
Message-ID: <Pine.LNX.4.30.0104280042240.23701-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When reading a bad CD, Linux 2.4.4-pre5 decided to turn off DMA when
trying to read a bad sector.  It also decided to reset the drive.  Is that
the expected behaviour?  I'm certanly not an ATAPI expert, but it does
seem a bit drastic to me.  The drive is in UDMA33 mode on a VIA vt82c686a,
with no (U)DMA problems detected (so far).

Isn't it possible to recogise a read error and treat it more gently?

/Tobias, fumbling in the dark


Here is the dmesg output:

Apr 27 23:32:31 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:31 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:31 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:31 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:32 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:32 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:33 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:33 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:33 igor kernel: hda: DMA disabled
Apr 27 23:32:33 igor kernel: hda: ATAPI reset complete
Apr 27 23:32:33 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:33 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:34 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:34 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:35 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:35 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:35 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:35 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:35 igor kernel: hda: ATAPI reset complete
Apr 27 23:32:36 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:36 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:36 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:36 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:37 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:37 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:37 igor kernel: hda: ATAPI reset complete
Apr 27 23:32:37 igor kernel: end_request: I/O error, dev 03:00 (hda), sector 651222
Apr 27 23:32:38 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:38 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:38 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:38 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:39 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:39 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:40 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:40 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:40 igor kernel: hda: ATAPI reset complete
Apr 27 23:32:40 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:40 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:41 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:41 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:42 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:42 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:42 igor kernel: hda: ATAPI reset complete
Apr 27 23:32:42 igor kernel: end_request: I/O error, dev 03:00 (hda), sector 651222
Apr 27 23:32:42 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:42 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:43 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:43 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:44 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:44 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:44 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:44 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:44 igor kernel: hda: ATAPI reset complete
Apr 27 23:32:45 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:45 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:46 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:46 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:46 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:46 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:46 igor kernel: hda: ATAPI reset complete
Apr 27 23:32:46 igor kernel: end_request: I/O error, dev 03:00 (hda), sector 651224
Apr 27 23:32:47 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:47 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:47 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:47 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:48 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:48 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:49 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:49 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:49 igor kernel: hda: ATAPI reset complete
Apr 27 23:32:49 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:49 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:50 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:50 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:51 igor kernel: hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
Apr 27 23:32:51 igor kernel: hda: cdrom_decode_status: error=0x34
Apr 27 23:32:51 igor kernel: hda: ATAPI reset complete
Apr 27 23:32:51 igor kernel: end_request: I/O error, dev 03:00 (hda), sector 651226



