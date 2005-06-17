Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVFQSl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVFQSl6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVFQSl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:41:58 -0400
Received: from usbb-lacimss2.unisys.com ([192.63.108.52]:10507 "EHLO
	usbb-lacimss2.unisys.com") by vger.kernel.org with ESMTP
	id S262053AbVFQSlw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:41:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:  nobody cared!"
Date: Fri, 17 Jun 2005 13:41:47 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04C02@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18:  nobody cared!"
Thread-Index: AcVzOiK9Mv+nPIo7S6WyIalL/tuztgAMWvzw
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Alexander Fieroch" <fieroch@web.de>
Cc: <bzolnier@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <axboe@suse.de>,
       "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
X-OriginalArrivalTime: 17 Jun 2005 18:41:48.0195 (UTC) FILETIME=[37EE3F30:01C5736C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Jun 17 12:07:49 orclex kernel: ICH6: 100% native mode on 
> irq 18 Jun 17 
> > 12:07:49 orclex kernel: ide0: BM-DMA at 0x5800-0x5807, BIOS 
> settings: 
> > hda:DMA, hdb:DMA Jun 17 12:07:49 orclex kernel: ide1: BM-DMA at 
> > 0x5808-0x580f, BIOS settings: hdc:pio, hdd:pio
> 
> This seems an unusual setup - the ICH6 is in native mode not 
> legacy as I'd have expected.
> 
> > Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The 
> drive appears 
> > confused (ireason = 0x01) Jun 17 12:07:49 orclex kernel: 
> irq 18: nobody cared (try booting with the "irqpoll" option.
> 
> Something failed to clear IRQ 18, that typically means there 
> are IRQ routing problems rather than IDE ones and would 
> explain your traces.
> 

This looks like a problem to me:

Jun 17 09:53:02 orclex kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2
Jun 17 09:53:02 orclex kernel: ide: Assuming 33MHz system bus speed for
PIO modes; override with idebus=xx
Jun 17 09:53:02 orclex kernel: ICH6: IDE controller at PCI slot
0000:00:1f.1
Jun 17 09:53:02 orclex kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] ->
GSI 18 (level, low) -> IRQ 217 <=== level IRQ
Jun 17 09:53:02 orclex kernel: ICH6: chipset revision 3
Jun 17 09:53:02 orclex kernel: ICH6: 100% native mode on irq 217
Jun 17 09:53:02 orclex kernel: ide0: BM-DMA at 0x5800-0x5807, BIOS
settings: hda:DMA, hdb:DMA
Jun 17 09:53:02 orclex kernel: ide1: BM-DMA at 0x5808-0x580f, BIOS
settings: hdc:pio, hdd:pio
Jun 17 09:53:02 orclex kernel: Probing IDE interface ide0...
Jun 17 09:53:02 orclex kernel: hda: IC35L060AVV207-0, ATA DISK drive
Jun 17 09:53:02 orclex kernel: hdb: SONY CD-RW CRX210E1, ATAPI
CD/DVD-ROM drive
Jun 17 09:53:02 orclex kernel: ide0 at 0x7000-0x7007,0x6802 on irq 217
<=========== here it's used for IDE
