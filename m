Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316143AbSETRDP>; Mon, 20 May 2002 13:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316145AbSETRDO>; Mon, 20 May 2002 13:03:14 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:40462 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S316143AbSETRDM>; Mon, 20 May 2002 13:03:12 -0400
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: HPT366 hangs up at boot
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 21 May 2002 02:02:16 +0900
Message-ID: <87adquda7b.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using hpt366. 2.5.15 and 2.5.16 hangs up at the following message.

ATAL: Triones Technologies, Inc. HPT366 / HPT370: onboard version of chipset, pin1=1 pin2=2
ATA: Triones Technologies, Inc. HPT366 / HPT370: controller on PCI slot 00:13.0
ATA: chipset rev.: 1
ATA: non-legacy mode: IRQ probe delayed
    ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio
ATA: Triones Technologies, Inc. HPT366 / HPT370 (#2): controller on PCI slot 00:13.1
ATA: chipset rev.: 1
ATA: non-legacy mode: IRQ probe delayed
    ide3: BM-DMA at 0xe800-0xe807, BIOS settings: hdg:pio, hdh:pio
hda: IBM-DJNA-351520, ATA DISK drive
hdb: ATAPI 44X CDROM, ATAPI CD/DVD-ROM drive
hde: WDC WD800AB-00CBA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xd400-0xd407,0xd802 on irq 18
hda: 30033360 sectors w/430KiB Cache, CHS=29795/16/63, UDMA(33)
hde: 156301488 sectors w/2048KiB Cache, CHS=155061/16/63, UDMA(66)
Partition check:
 hda: [PTBL] [1869/255/63] hda1 hda2 hda3 hda4
 hda4: <bsd: hda5 hda6 hda7 hda8 >
 hde:

Then, I tried this and that. I don't know whether the following change
is right or not. However this works for me. Could you consider the
following?

diff -u /home/hirofumi/hpt366.c.orig /home/hirofumi/hpt366.c
--- /home/hirofumi/hpt366.c.orig	Tue May 21 01:48:58 2002
+++ /home/hirofumi/hpt366.c	Tue May 21 01:49:28 2002
@@ -863,7 +863,7 @@
 	byte ultra66		= eighty_ninty_three(drive);
 	int  rval;
 
-	config_chipset_for_pio(drive);
+//	config_chipset_for_pio(drive);
 	drive->init_speed = 0;
 
 	if ((drive->type != ATA_DISK) && (speed < XFER_SW_DMA_0))

Regards.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
