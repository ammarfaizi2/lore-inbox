Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbTE0WaP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbTE0WaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:30:15 -0400
Received: from pop.gmx.net ([213.165.64.20]:40048 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264383AbTE0WaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:30:07 -0400
Message-ID: <3ED3EA03.8070406@gmx.net>
Date: Wed, 28 May 2003 00:43:15 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: frahm@irsamc.ups-tlse.fr
CC: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.21-rc5: DMA disabled for IDE Cdrom, works with 2.4.20
References: <200305272133.h4RLXlN1000712@albireo.free.fr>
In-Reply-To: <200305272133.h4RLXlN1000712@albireo.free.fr>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

frahm@irsamc.ups-tlse.fr wrote:
> 2.4.21-rc5: DMA disabled for IDE Cdrom, works with 2.4.20
> 
> 
> I cannot use DMA for my IDE Cdrom (/dev/hdb) with kernel version 2.4.21-rc5 
> (same problem with 2.4.21-rc1, 2.4.21-rc2, 2.4.21-rc3, 2.4.21-rc4 and 
> 2.4.21-rc2-ac3). 
> When I activate DMA by "hdparm -d1 /dev/hdb" (or by using the appropriate 
> config-options for compiling the kernel) this seems to work but when I try to 
> mount a standard iso-cdrom the machine is blocked for about 15-20 seconds 
> and DMA on /dev/hdb is disabled (but the mount has succeeded). 
> The kernel provides the following messages (dmesg-output):
> 
> hdb: DMA interrupt recovery
> hdb: lost interrupt
> hdb: status timeout: status=0xd0 { Busy }
> hdb: status timeout: error=0x00
> hdb: DMA disabled
> hdb: drive not ready for command
> hdb: ATAPI reset complete
> ISO 9660 Extensions: RRIP_1991A
> 
> Sometimes the mount attempt may actually completely freeze the system 
> instead of only disabling DMA. I have the impression that this happens when 
> it coincides with some hard-disk activity. In principle, DMA for the 
> harddisk alone (on /dev/hda) seems to work properly. 
> 
> I have an ASUS-P3B-F motherboard with a PIII 500 Mhz and an Intel PIIX4 
> chipset (the manual gives PIIX4E chipset, more details in dmesg-output 
> appended below). I did NOT configure Local APIC and put PIIXn 
> chipset support in the kernel. I understand that there may be some 
> hardware-problem/bug but DMA for the cdrom (and harddisk) works correctly 
> with the latest stable kernel versions 2.4.20 / 2.2.25. 
> (I have also an SCSI CD-writer on an Adaptec AHA-7850 SCSI-adapter which 
> seems to work fine with the aic7xxx-driver.) 
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PIIX4: IDE controller at PCI slot 00:04.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
> hda: WDC WD136AA, ATA DISK drive
> hdb: SONY CDU4811, ATAPI CD/DVD-ROM drive
> blk: queue c038ec20, I/O limit 4095Mb (mask 0xffffffff)
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: attached ide-disk driver.
> hda: host protected area => 1
> hda: 26564832 sectors (13601 MB) w/2048KiB Cache, CHS=1653/255/63, UDMA(33)
> hdb: attached ide-cdrom driver.
> hdb: ATAPI 48X CD-ROM drive, 120kB Cache
> Uniform CD-ROM driver Revision: 3.12
> Partition check:
>  hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 >
[...]
> hdb: DMA interrupt recovery
> hdb: lost interrupt
> hdb: status timeout: status=0xd0 { Busy }
> hdb: status timeout: error=0x00
> hdb: DMA disabled
> hdb: drive not ready for command
> hdb: ATAPI reset complete
> ISO 9660 Extensions: RRIP_1991A

> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECS=m
> CONFIG_BLK_DEV_IDECD=y
> CONFIG_BLK_DEV_IDEFLOPPY=m
> CONFIG_BLK_DEV_IDESCSI=m
> CONFIG_BLK_DEV_CMD640=y
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_BLK_DEV_GENERIC=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y

> CONFIG_IDEDMA_PCI_AUTO=y

Please disable 'Use PCI DMA by default when available'
(CONFIG_IDEDMA_PCI_AUTO) in your kernel config, enable DMA with hdparm
after bootup and report back.

> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_BLK_DEV_ADMA100=y
> CONFIG_BLK_DEV_PIIX=y

The above should fix your hangs.


HTH,
Carl-Daniel

