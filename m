Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278471AbRJOWto>; Mon, 15 Oct 2001 18:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278472AbRJOWtf>; Mon, 15 Oct 2001 18:49:35 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:15260 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S278471AbRJOWtX>; Mon, 15 Oct 2001 18:49:23 -0400
Message-Id: <m15tIR9-005ZFZC@andiunx.t-online.de>
Content-Type: text/plain; charset=US-ASCII
From: andikies@t-online.de (Andreas Kies)
To: linux-kernel@vger.kernel.org
Subject: Hard lockup with 2.4.19 and ide-scsi
Date: Tue, 16 Oct 2001 00:50:26 +0000
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reading a CD with somewhat "slight" defects causes my machine to lock up
solidly ( No keyboard, no more disk activity ) . The bug is totally 
reproducible if you manage to cause a timeout during reading.

CDs with hard surface defects do not cause a timeout and therefore do not
provoke the bug.

Used kernel :
  2.4.9 ( no extra patches, no unofficial modules )
  ide-scsi module is used instead of ide-cd.
  No automount, no user space programs like autorun that access the cd drive.

Used Hardware :

SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: Memorex   Model: SixteenMAXX 1040  Rev: TWS1
  Type:   CD-ROM                             ANSI SCSI revision: 02


The syslog only shows some IDE errors, which are not unusual in this 
situation.

Using ide-cd instead of ide-scsi works fine, no more lockups, the read
operation even completes successful after some time.

Using kernel 2.2.19 also works fine.

Any important information missing ?

Thanks

Andreas.

Crash 1 :

Sep 24 23:02:04 au kernel: scsi : aborting command due to timeout : pid 0,
scsi1, channel 0, id 0, lun 0 Read (10) 00 00 03 d2 83 00 00 3f 00
Sep 24 23:02:04 au kernel: hdc: timeout waiting for DMA
Sep 24 23:02:04 au kernel: ide_dmaproc: chipset supported ide_dma_timeout 
func only: 14
Sep 24 23:02:04 au kernel: hdc: status timeout: status=0xd0 { Busy }
Sep 24 23:02:04 au kernel: hdc: drive not ready for command
Sep 24 23:02:04 au kernel: scsi : aborting command due to timeout : pid 0,
scsi1, channel 0, id 0, lun 0 Read (10) 00 00 03 d2 c2 00 00 01 00
Sep 24 23:02:04 au kernel: hdc: ATAPI reset complete
# crash occurs here

------
Crash 2 :

Oct 12 22:08:21 au kernel: scsi : aborting command due to timeout : pid 0,
scsi0, channel 0, id 0, lun 0 Read (10) 00 00 04 83 82 00 00 08 00
Oct 12 22:08:21 au kernel: hdc: timeout waiting for DMA
Oct 12 22:08:21 au kernel: ide_dmaproc: chipset supported ide_dma_timeout 
func only: 14
Oct 12 22:08:21 au kernel: hdc: status timeout: status=0xd0 { Busy }
Oct 12 22:08:21 au kernel: hdc: drive not ready for command
Oct 12 22:08:21 au kernel: hdc: ATAPI reset complete
Oct 12 22:08:21 au kernel: hdc: irq timeout: status=0x80 { Busy }

# crash occurs here
