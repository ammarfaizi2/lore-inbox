Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759816AbWLCXfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759816AbWLCXfx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 18:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759739AbWLCXfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 18:35:53 -0500
Received: from cas-mta3-fe.casema.nl ([83.80.1.28]:5351 "EHLO mta-fe.casema.nl")
	by vger.kernel.org with ESMTP id S1759316AbWLCXfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 18:35:52 -0500
From: Rudmer van Dijk <rudmer.van.dijk@casema.nl>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: pata_via report
Date: Mon, 4 Dec 2006 00:35:30 +0100
User-Agent: KMail/1.9.5
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rudolf Marek <r.marek@assembler.cz>
References: <4573353E.2060307@assembler.cz>
In-Reply-To: <4573353E.2060307@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612040035.30642.rudmer.van.dijk@casema.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 December 2006 21:36, Rudolf Marek wrote:
> Hello Alan,
>
> I would like to report my experience with new pata_via driver.
>
> Short version: works (no data were trashed, during the investigation), but
> the bits to detect the cable type are not set by BIOS.
> There is also a bug in my BIOS, which kills the UDMA register.

I have the same motherboard, but no SATA drives. I use the pata_via driver for 
a couple of months now and experienced no problems so far. now running 
2.6.19-rc6-mm2

> Long version:
> I have 80pin cable on primary master with western digital drive on it as
> slave. No other device on primary master. Secondary master is NEC DVDRW. I
> have two SATA drives, from which I boot the system.
>
> ata3: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xCC00 irq 14
> ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xCC08 irq 15
> scsi2 : pata_via
> DEBUG ATA66: 0x07e1e607
> ATA: abnormal status 0x8 on port 0x1F7
> ATA: abnormal status 0x8 on port 0x1F7

1 Maxtor 6Y080P0 on primary IDE and 2 optical drives on secundary IDE (DVD-RW 
master, CD-RW slave). all are connected with 80pin cables:

libata version 2.00 loaded.
pata_via 0000:00:0f.1: version 0.2.0
ata1: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFC00 irq 14
ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFC08 irq 15
scsi0 : pata_via
ata1.00: ATA-7, max UDMA/133, 160086528 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : pata_via
ata2.00: ATAPI, max UDMA/66
ata2.01: ATAPI, max UDMA/33
ata2.00: configured for UDMA/66
ata2.01: configured for UDMA/33


so as you can see, 80pin cable detection works for me.


> 00:0f.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 01 cc 00 00 00 00 00 00 00 00 00 00 43 10 ed 80
> 30: 00 00 00 00 c0 00 00 00 00 00 00 00 02 01 00 00
> 40: 3b f2 09 05 18 8c c0 00 5d 20 5d 20 ff 00 20 20
> 50: 07 e6 07 e1 0c 00 00 00 a8 a8 a8 a8 00 00 00 00
> 60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
> 70: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
> 80: 00 a0 b9 3f 00 00 00 00 00 50 b2 3f 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 06 00 71 05 43 10 ed 80 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 09 00 00 00 00 00 00 00 00 00

hexdump of my config space is different:

00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 fc 00 00 00 00 00 00 00 00 00 00 43 10 ed 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00
40: 3b f2 09 05 18 8c c0 00 20 20 a8 20 ff 00 20 20
50: e6 e2 17 e0 0c 00 00 00 a8 a8 a8 a8 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
80: 00 d0 63 3f 00 00 00 00 00 b0 63 3f 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 06 00 71 05 43 10 ed 80 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 09 00 00 00 00 00 00 00 00 00


hope this helps.

	Rudmer
