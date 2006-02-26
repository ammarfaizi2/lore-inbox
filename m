Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWBZNI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWBZNI5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 08:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWBZNI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 08:08:56 -0500
Received: from mail.linicks.net ([217.204.244.146]:23247 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751104AbWBZNIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 08:08:55 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: hda: irq timeout: status=0xd0 DMA question
Date: Sun, 26 Feb 2006 13:08:47 +0000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602261308.47513.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Doing my housekeeping today I saw this in logs from last week on one of my 
boxes (2.4.32) with then about 92 days uptime:



Feb 19 14:05:31 quake kernel: hda: irq timeout: status=0xd0 { Busy }
Feb 19 14:05:31 quake kernel:
Feb 19 14:05:31 quake smartd[405]: Device: /dev/hda, not capable of SMART 
self-check
Feb 19 14:05:31 quake smartd[405]: Sending warning via  mail to 
root@localhost ...
Feb 19 14:05:31 quake kernel: hda: status timeout: status=0xd0 { Busy }
Feb 19 14:05:31 quake kernel:
Feb 19 14:05:31 quake kernel: hda: DMA disabled
Feb 19 14:05:31 quake kernel: hda: drive not ready for command
Feb 19 14:05:33 quake kernel: ide0: reset: success



and looking at drive saw DMA was indeed now off.


At boot:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DTTA-371010, ATA DISK drive
blk: queue c02a7560, I/O limit 4095Mb (mask 0xffffffff)
hdc: NEC CD-ROM DRIVE:28B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 19746720 sectors (10110 MB) w/465KiB Cache, CHS=1229/255/63, UDMA(33)


I dunno what happened to the drive that time (this is the only logs of the 
incident) and I turned DMA back on with hdparm - but my question is why is 
DMA turned off and then left off after a reset?

Thanks,

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
