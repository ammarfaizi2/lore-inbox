Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUH3Gp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUH3Gp0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 02:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUH3Gp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 02:45:26 -0400
Received: from relay.inway.cz ([212.24.128.3]:20461 "EHLO relay.inway.cz")
	by vger.kernel.org with ESMTP id S265970AbUH3GpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 02:45:19 -0400
Message-ID: <4132CCD8.80405@scssoft.com>
Date: Mon, 30 Aug 2004 08:44:40 +0200
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, petter.sundlof@findus.dhs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Cannot enable DMA on SATA drive (SCSI-libsata, VIA SATA)
References: <7076215DFAA4574099E5CD59FE42226204F6C364@pcssrv42.pcs.pc.ome.toshiba.co.jp>
In-Reply-To: <7076215DFAA4574099E5CD59FE42226204F6C364@pcssrv42.pcs.pc.ome.toshiba.co.jp>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Alan wrote> Make sure you enable the SCSI later, SATA drivers and VIA SATA driver
Alan wrote> otherwise you may end up using PIO with the PCI generic IDE driver.

Yes, this is up and running, no problem here:

libata version 1.02 loaded.
sata_via version 0.20
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 185
sata_via(0000:00:0f.0): routed to hard irq line 11
ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 185
ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 185
ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 88:203f
ata1: dev 0 ATA, max UDMA/100, 488397168 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_via
ata2: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 88:407f
ata2: dev 0 ATA, max UDMA/133, 72303840 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_via
  Vendor: ATA       Model: WDC WD2500JD-00F  Rev: 02.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD360GD-00FN  Rev: 35.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 72303840 512-byte hdwr sectors (37020 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0


Tomita, Haruo wrote:

>Hi all,
>
>
>VIA/KT800 chipset is not checking.
>
>It seems that it cannot perform in combine mode 
>at the ata_piix driver of a version 1.02.
>In this case, although a piix driver should work, 
>ESB_3 is not recognized in a piix driver.
>Therefore, it can work only by PIO mode.
>
>Petr, I think that it is necessary to check a setup of BIOS parameters.
>Or how about making this patch reference?
>
>      http://marc.theaimsgroup.com/?l=linux-ide&m=109290653905964&w=2
>
>Best regards,
>Haruo
>  
>
Haruo,

I am not using the combine mode on the sata drives (or at least, I don't 
know about it). I was implying that
when I connect another pure IDE drive to the motherboard, then the 
situation gets better.

Whats wrong here (or ... what feels wrong) is that the system slows down 
noticeably when transferring data
to/from the sata drives. It 'feels' like using an old ide disk with pio 
mode only. I am not saying that the transfer rates
are low though... hdparm -t on the sata drives gives me following:

/dev/sda:
 Timing buffered disk reads:  140 MB in  3.01 seconds =  46.46 MB/sec

/dev/sdb:
 Timing buffered disk reads:  164 MB in  3.00 seconds =  54.60 MB/sec

this is not the best, but I think it is acceptable for SATA/PATA drives 
and onboard SATA controller.

It is quite hard to describe what is going wrong here... It might not be 
even related to the sata itself...

One example of the 'slow' system is that when I run 'top -d 1' (top with 
1 second updates), it sometimes
takes ~4 seconds for the screen to update when the disk io is on action.
(on dual processor opteron x86_64 machine :-) .Kernel vanilla 2.6.8.

Best Regards,
Petr

