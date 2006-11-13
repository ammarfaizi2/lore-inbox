Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755083AbWKMPUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083AbWKMPUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755137AbWKMPUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:20:20 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:58768 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1755083AbWKMPUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:20:19 -0500
Message-ID: <1163431218.45588d325eddf@imp4-g19.free.fr>
Date: Mon, 13 Nov 2006 16:20:18 +0100
From: Remi <remi.colinet@free.fr>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5-mm1 : probe of 0000:00:1f.2 failed with error -16
References: <1163425477.455876c5637f6@imp4-g19.free.fr> <200611131452.13234.cova@ferrara.linux.it>
In-Reply-To: <200611131452.13234.cova@ferrara.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 81.255.27.251
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Selon Fabio Coatti <cova@ferrara.linux.it>:

> > ata_piix: probe of 0000:00:1f.2 failed with error -16
> > Kernel panic - not syncing: Attempted to kill init!
> >
> > I disabled most options in my .config file just keeping ata_piix enabled.
> > 2.6.19-rc5 still boots fine but 2.6.19-rc-mm1 gives the same previous
> > message.
>
>
> It seems exactly the same problem that is hitting me:
>
> http://lkml.org/lkml/2006/11/13/37
>
> If some patch comes out, I'll be willing to try it asap ;)
>

You are getting the same message

ata_piix 0000:00:1f.2: MAP [ P0 P1 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
ata_piix: probe of 0000:00:1f.2 failed with error -16

But, your drives are driven by the sata_sil driver, which seems to be ok.
See your partition tables displayed below.

ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 19 (level, low) -> IRQ 18
ata1: SATA max UDMA/100 cmd 0xF8804080 ctl 0xF880408A bmdma 0xF8804000 irq 18
ata2: SATA max UDMA/100 cmd 0xF88040C0 ctl 0xF88040CA bmdma 0xF8804008 irq 18
scsi1 : sata_sil
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 0
ata1.00: configured for UDMA/100
scsi2 : sata_sil
ata2: SATA link down (SStatus 0 SControl 310)
scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6V320F0   VA11 PQ: 0 ANSI: 5
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 >

-- cut

VFS: Cannot open root device "821" or unknown-block(8,33)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(8,33)

Your root device seems to be wrong. Append the correct root=/dev/sda1 if it is
this partition.

Anyway, the first message indicates the same trouble as mine when trying to
reserve the I/O ports.

Remi
