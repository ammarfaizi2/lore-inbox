Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUEJJVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUEJJVo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 05:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbUEJJVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 05:21:44 -0400
Received: from smtpq2.home.nl ([213.51.128.197]:48619 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S264585AbUEJJVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 05:21:41 -0400
Message-ID: <409F4944.4090501@keyaccess.nl>
Date: Mon, 10 May 2004 11:20:04 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day.

The 2.6.6-rc3 -> 2.6.6-final changes to ide-disk.c unfortunately make my 
machine complain loudly both at boot and reboot:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7409: IDE controller at PCI slot 0000:00:07.1
AMD7409: chipset revision 7
AMD7409: not 100% native mode: will probe irqs later
AMD7409: 0000:00:07.1 (rev 07) UDMA66 controller
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 6Y120P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: PLEXTOR DVD-ROM PX-116A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63, 
UDMA(66)
  hda: hda1 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 > hda2 
hda3 hda4
  hda2: <bsd: hda14 hda15 hda16 hda17 hda18 >
  hda4: <minix: hda19 hda20 >
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: Write Cache FAILED Flushing!

The disk, 6Y120P0, is a new-ish Maxtor "DiamondMax Plus 9", 120G, 8M 
cache. Controller is an AMD756. Same complaints on reboot. Reverting the 
rc3->final changes to ide-disk.c fixes/supresses them again.

Rene.

