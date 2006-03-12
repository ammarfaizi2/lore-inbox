Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWCLPxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWCLPxa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 10:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWCLPxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 10:53:30 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:4751 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1751202AbWCLPx3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 10:53:29 -0500
Message-ID: <441443F5.1060603@bootc.net>
Date: Sun, 12 Mar 2006 15:53:25 +0000
From: Chris Boot <bootc@bootc.net>
User-Agent: Mail/News 1.5 (X11/20060114)
MIME-Version: 1.0
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE CDROM - No DMA
References: <200603101842.09251.kernel-stuff@comcast.net> <200603120128.44469.kernel-stuff@comcast.net>
In-Reply-To: <200603120128.44469.kernel-stuff@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar wrote:
> On Friday 10 March 2006 18:42, Parag Warudkar wrote:
>> I have a "TSSTCorp"  CD-RW/DVD Drive in my laptop
>> which is IDE1.  DMA is not enabled on this drive. (Copying from CDROM
>> stalls the machine - conforming that DMA is not really in use.)
>>
> Hmm.. Interestingly this seems to be a IDE layer problem not specific to the 
> drive in question. No matter what CD / DVD drive I put into my lapatop DMA is 
> not enabled. (I tried replacing this TSSTCorp drive with a  Pioneer drive 
> which was doing DMA fine with Linux on another machine, but with this laptop, 
> I can't set DMA on it.)
> 
> Any clues, workarounds, hint of a place to start debugging this?
> Some relevant snippets from dmesg -
> ------------------------------------------------------------------------
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ide0: I/O resource 0x1F0-0x1F7 not free.
> ide0: ports already in use, skipping probe
> Probing IDE interface ide1...
> ide1 at 0x170-0x177,0x376 on irq 15
> ata: 0x170 IDE port busy
> hdc: PIONEER DVD-RW DVR-K05, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache
> Uniform CD-ROM driver Revision: 3.20
> libata version 1.20 loaded.
> ata_piix 0000:00:1f.2: version 1.05
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 177
> ata: 0x170 IDE port busy
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
> ata1: dev 0 cfg 49:2f00 82:746b 83:7f09 84:6023 85:7469 86:3e09 87:6023 
> 88:203f
> ata1: dev 0 ATA-6, max UDMA/100, 153356490 sectors: LBA48
> ata1: dev 0 configured for UDMA/100
> scsi0 : ata_piix
>   Vendor: ATA       Model: TOSHIBA MK8032GS  Rev: AS11
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 153356490 512-byte hdwr sectors (78519 MB)
> SCSI device sda: drive cache: write back
> SCSI device sda: 153356490 512-byte hdwr sectors (78519 MB)
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2 sda3 sda4
> sd 0:0:0:0: Attached scsi disk sda
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> ieee1394: Initialized config rom entry `ip1394'
> 
> Thanks
> Parag 

You're using the generic ATA driver, not the one specific for your chipset, thus 
it's unlikely you'll get DMA on it at all. Judging by the fact you're using 
ata_piix for your SATA hard disk, try using the piix ATA driver for your 
on-board IDE. I assume you built your own kernel and forgot to enable this driver.

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
