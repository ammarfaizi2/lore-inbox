Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbUDCAqA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 19:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUDCAp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 19:45:59 -0500
Received: from codepoet.org ([166.70.99.138]:33990 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S261460AbUDCApy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 19:45:54 -0500
Date: Fri, 2 Apr 2004 17:45:27 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [sata] libata update
Message-ID: <20040403004527.GA6148@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <406B31F3.1010702@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406B31F3.1010702@pobox.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Mar 31, 2004 at 04:02:43PM -0500, Jeff Garzik wrote:
> 
> Small update, to fix a couple important 2.4-only bugs:
> * SMP kernels would lock up during probing
> * Hardware delays were incorrect, due to HZ=100

I have a Soyo P4 motherboard with built in Intel ICH5, Sil, and I have
"IDE + SATA" enabled in the bios, presumably meaning the ICH5 is in
combined mode.  I usually boot with my rootfs on a ordinary IDE drive
(pata on ICH5 ide0), a cdrom (pata on ICH5 ide1) and a sata drive (sata1
on ICH5), which has all been working nicely.  Many thanks.  :-)  Here is
what I usually see from the ICH5:

    Uniform Multi-Platform E-IDE driver Revision: 7.00beta5-2.4
    ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    ICH5: IDE controller at PCI slot 00:1f.1
    ICH5: chipset revision 2
    ICH5: not 100% native mode: will probe irqs later
	ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
	ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
    hda: WDC WD2000JB-32EVA0, ATA DISK drive
    hdc: SONY DVD RW DRU-510A, ATAPI CD/DVD-ROM drive
    ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    ide1 at 0x170-0x177,0x376 on irq 15
    hda: attached ide-disk driver.
    hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
    Partition check:
     hda: hda1 hda2
    SCSI subsystem driver Revision: 1.00
    libata version 1.02 loaded.
    ata_piix version 1.02
    PCI: Setting latency timer of device 00:1f.2 to 64
    ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 18
    ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 18
    ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:207f
    ata1: dev 0 ATA, max UDMA/133, 398297088 sectors (lba48)
    ata1: dev 0 configured for UDMA/133
    ata2: SATA port has no device.
    ata2: thread exiting
    scsi0 : ata_piix
    scsi1 : ata_piix
      Vendor: ATA       Model: Maxtor 6Y200M0    Rev: 1.02
      Type:   Direct-Access                      ANSI SCSI revision: 05

Yesterday while doing some testing, I made a CD with the same kernel on
it as shown above, i.e. latest 2.4.26-rc1 + the current
2.4.26-rc1-libata3 patch.  I then unplugged the power connector to my
usual rootfs drive (the WDC WD2000JB on ide0) to make sure I wouldn't
screw it up ;-).  

Booting from CD (the SONY on ide1) with only the Maxtor 6Y200M0 (on the
ICH5 sata1), the libata driver wedged solid on bootup.  After printing

    ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 18
    ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 18

the box was dead dead dead.  I can't test this setup with the bios set
to SATA only, since I don't own any SATA cdrom drives.  Simply plugging
the WDC WD2000JB on ide0 back in allowed the system to boot normally.
As nearly as I can tell, one has to have a pata drive installed or the
ata_piix driver will wedge solid.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
