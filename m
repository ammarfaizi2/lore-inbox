Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUJXS0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUJXS0X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 14:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbUJXS0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 14:26:23 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:2229 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261580AbUJXSZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 14:25:42 -0400
From: Jan Killius <jkillius@arcor.de>
To: Oliver Tennert <tennert@science-computing.de>
Subject: Re: libata and software RAID (fwd)
Date: Sun, 24 Oct 2004 22:25:55 +0200
User-Agent: KMail/1.7.1
References: <Pine.LNX.4.58.0410241942300.9382@picard.science-computing.de>
In-Reply-To: <Pine.LNX.4.58.0410241942300.9382@picard.science-computing.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410242225.55481.jkillius@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 October 2004 19:45, Oliver Tennert wrote:
> OK, I accept that I did not set BLK_DEV_IDE_SATA to yes. This is now
> allright with me, because libata works well.
>
> But two other issues remain:
>
> How do I
>
> - use smartctl on such pseudo-SCSI devices
I don't know whether the vanilla kernel support it, but Jeff Garzik have 
mailed a patch that implement it.
> - set DMA to other values?
I don't know how, but normally libata should select the fastest.
>
> Best regards
>
> Oliver
> __
> ________________________________________creating IT solutions
>
> Dr. Oliver Tennert   science + computing ag
> phone   +49(0)7071 9457-598  Hagellocher Weg 71-75
> fax     +49(0)7071 9457-411  D-72070 Tuebingen, Germany
> O.Tennert@science-computing.de  www.science-computing.de
>
>
>
> ---------- Forwarded message ----------
> Date: Fri, 22 Oct 2004 11:17:44 +0200
> From: Oliver Tennert <tennert@science-computing.de>
> To: linux-kernel@vger.kernel.org
> Subject: libata and software RAID
>
>
> Hello Jeff (and others),
>
> I am currently running a 2.6.9 kernel on my system, and everything's fine,
>  but for a little issue:
>
> I have an ASUS A7N8X Deluxe board with on-board nforce2-chipset and a SiS
> S-ATA controller.
>
> Previously, my two S-ATA drives had been driven by the IDE driver, and were
> assembled to a  RAID-1 MD device (via software RAID) on them.
>
> Now, with 2.6.9, the libata driver takes over, and my md device seems no
> longer present (booting to an older 2.6.5 kernel, however, makes them
> visible again). The IDE driver seems not to probe for the S-ATA drives in
> the first hand:
>
> <dmesg>
> NFORCE2: IDE controller at PCI slot 0000:00:09.0
> NFORCE2: chipset revision 162
> NFORCE2: not 100% native mode: will probe irqs later
> NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> Probing IDE interface ide0...
> Probing IDE interface ide1...
> ...
> ...
> libata version 1.02 loaded.
> sata_sil version 0.54
> ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 18 (level, high) -> IRQ 209
> ata1: SATA max UDMA/100 cmd 0xF909A080 ctl 0xF909A08A bmdma 0xF909A000 irq
>  209 ata2: SATA max UDMA/100 cmd 0xF909A0C0 ctl 0xF909A0CA bmdma 0xF909A008
>  irq 209 usb 1-2: new low speed USB device using address 3
> ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
> 88:207f
> ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
> ata1: dev 0 configured for UDMA/100
> scsi1 : sata_sil
> ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
> 88:207f
> ata2: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
> ata2: dev 0 configured for UDMA/100
> scsi2 : sata_sil
>   Vendor: ATA       Model: Maxtor 6Y200M0    Rev: YAR5
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sdc: 398297088 512-byte hdwr sectors (203928 MB)
> </dmesg>
>
> Can you tell me how I either
> a) am able to "import" the RAID-1 md device, the meta-information of which
> is now located on SCSI drives, or
> b) tell the IDE driver to probe the S-ATA bus and tell the libata driver to
> NOT drive my S-ATA drives?
>
> The other question is: libata seems to activate UDMA/100 for my S-ATA
> drives, although they are able to run with UDMA/133. "hdparm" does not work
> with SCSI drives, in this case. Can I tell libata to activate UDMA/133?
>
> Many thanks for your help and best regards
>
> Oliver Tennert
>
> __
> ________________________________________creating IT solutions
>
> Dr. Oliver Tennert   science + computing ag
> phone   +49(0)7071 9457-598  Hagellocher Weg 71-75
> fax     +49(0)7071 9457-411  D-72070 Tuebingen, Germany
> O.Tennert@science-computing.de  www.science-computing.de
>
> -------------------------------------------------------

-- 
        Jan
