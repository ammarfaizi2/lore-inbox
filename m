Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWBHPo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWBHPo4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWBHPo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:44:56 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:46821 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1030359AbWBHPoz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:44:55 -0500
Message-ID: <43EA11F5.4000205@bootc.net>
Date: Wed, 08 Feb 2006 15:44:53 +0000
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata PATA status report on 2.6.16-rc1-mm5
References: <33D367D1-870E-46AE-A7EC-C938B51E816F@bootc.net> <1139400278.26270.10.camel@localhost.localdomain> <43E9F41C.30204@bootc.net>
In-Reply-To: <43E9F41C.30204@bootc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Boot wrote:
> Alan Cox wrote:
>> On Mer, 2006-02-08 at 09:58 +0000, Chris Boot wrote:
>>> and everything seems to work fine. I notice PATA CD-ROMs still 
>>> aren't  being recognised (with libata.atapi_enabled=1) which is a 
>>> bit of a  shame, but fortunately I won't be needing to use the 
>>> CD-ROM on this  machine at all. In fact this machine has so little 
>>> use that I'm quite  happy to surrender it to testing.
>>
>> What ports are the CDROM devices attached to. I'd expect to see them
>> found and reported as "being ignored" so it may indicate a bigger
>> problem.
>>
>>
>
> The HDD (that works) is Primary Master, the CD-RW is Secondary Master. 
> I'll give -rc2-mm1 a shot later today, and maybe even -rc2 with your 
> separate patches and let you know.
2.6.16-rc2-mm1 behaved the same way as 2.6.16-rc1-mm5.

2.6.16-rc2-ide2 detects the drive properly:

[   17.263614] libata version 1.20 loaded.
[   17.263689] pata_via 0000:00:07.1: version 0.1.3
[   17.263725] PCI: Via IRQ fixup for 0000:00:07.1, from 255 to 0
[   17.263936] ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 
irq 14
[   17.426003] ata1: dev 0 cfg 49:2f00 82:74eb 83:43ea 84:4000 85:7469 
86:0002 87:4000 88:203f
[   17.426016] ata1: dev 0 ATA-5, max UDMA/100, 60036480 sectors: LBA
[   17.426115] via_do_set_mode: Mode=12 ast broken=N udma=100 mul=3
[   17.426210] via_do_set_mode: Mode=69 ast broken=N udma=100 mul=3
[   17.426536] ata1: dev 0 configured for UDMA/100
[   17.426597] scsi0 : pata_via
[   17.426991]   Vendor: ATA       Model: IBM-DTLA-307030   Rev: TX4O
[   17.427230]   Type:   Direct-Access                      ANSI SCSI 
revision: 05
[   17.430290] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xFFA8 
irq 15
[   17.749845] ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 
86:0000 87:0000 88:0000
[   17.749855] ata2: dev 0 ATAPI, max MWDMA2
[   17.752637] via_do_set_mode: Mode=12 ast broken=N udma=100 mul=3
[   17.755464] via_do_set_mode: Mode=34 ast broken=N udma=100 mul=3
[   17.758726] ata2: dev 0 configured for MWDMA2
[   17.761523] scsi1 : pata_via
[   17.765617]   Vendor: HL-DT-ST  Model: CD-RW GCE-8240B   Rev: 1.07
[   17.768613]   Type:   CD-ROM                             ANSI SCSI 
revision: 05
[   17.771861] SCSI device sda: 60036480 512-byte hdwr sectors (30739 MB)
[   17.774809] sda: Write Protect is off
[   17.777649] sda: Mode Sense: 00 3a 00 00
[   17.777676] SCSI device sda: drive cache: write back
[   17.780665] SCSI device sda: 60036480 512-byte hdwr sectors (30739 MB)
[   17.783570] sda: Write Protect is off
[   17.786433] sda: Mode Sense: 00 3a 00 00
[   17.786459] SCSI device sda: drive cache: write back
[   17.789322]  sda: sda1 sda2
[   17.802723] sd 0:0:0:0: Attached scsi disk sda
[   17.886602] sr0: scsi3-mmc drive: 24x/40x writer cd/rw xa/form2 cdda tray
[   17.889558] Uniform CD-ROM driver Revision: 3.20
[   17.892641] sr 1:0:0:0: Attached scsi CD-ROM sr0
[   17.892737] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   17.895786] sr 1:0:0:0: Attached scsi generic sg1 type 5

My next step will be to play with the CD drive. Any hints on 
stress-testing the drive? Obviously writing a CD then comparing to the 
ISO will be one step, but any others?

HTH,
Chris

