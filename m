Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWGSMuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWGSMuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 08:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWGSMuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 08:50:06 -0400
Received: from mx.dt.lt ([84.32.38.8]:9409 "EHLO mx.dtiltas.lt")
	by vger.kernel.org with ESMTP id S964809AbWGSMuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 08:50:04 -0400
Date: Wed, 19 Jul 2006 15:45:27 +0300
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re: [PATCH] SATA: Add PCI-ID
To: Adam Helms <helms.adam@gmail.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: INLINE
References: <c6e8b8d90607071019o22433ffch9ccc986c27c11ffa@mail.gmail.com>
In-Reply-To: <c6e8b8d90607071019o22433ffch9ccc986c27c11ffa@mail.gmail.com>
X-Mailer: Mahogany 0.66.0 'Clio', compiled for Linux 2.6.16-1.2080_3.rhfc5.cubbi_suspend2 i686
Message-Id: <20060719125001.24ED7BB06@mx.dtiltas.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 19:19:23 +0200 Adam Helms <helms.adam@gmail.com> wrote:

> Makes the AHCI driver detect the PCI ID 8086:27c0 (IDE interface:
> Intel Corporation 82801GB/GR/GH (ICH7 Family) Serial ATA Storage
> Controller IDE (rev 01)) as an AHCI chipset.
> 
> 8086:27c0 also works with ata_piix but it's much slower. 8086:27c0 is
> shipped with  - among others - new HP Proliant servers.

I have Intel d945psn motherboard with this controller. I patched
Fedora 2.6.17-1.2145 kernel with this patch, but I get when booting:

ahci 0000:00:1f.2: version 1.2
ACPI: PCI Interrupt 0000:00:1f:2[B] -> GSI 19 (level, low) -> IRQ 193
ahci: probe of 0000:00:1f.2 failed with error -12

Is it because it has IDE controller too?
dmesg:
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 185
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x40b0-0x40b7, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: ST3120026A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 512KiB

Regards,
Nerijus

> Signed-off-by: Adam Helms <helms.adam@gmail.com>
> ---------
> 
> --- /usr/src/linux-source-2.6.15/drivers/scsi/ahci.c.orig
> 2006-07-07 19:07:14.000000000 +0200
> +++ /usr/src/linux-source-2.6.15/drivers/scsi/ahci.c    2006-07-07
> 19:07:31.000000000 +0200
> @@ -261,6 +261,8 @@ static const struct pci_device_id ahci_p
>           board_ahci }, /* ICH6 */
>         { PCI_VENDOR_ID_INTEL, 0x2653, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>           board_ahci }, /* ICH6M */
> +       { PCI_VENDOR_ID_INTEL, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +         board_ahci }, /* ICH7 */
>         { PCI_VENDOR_ID_INTEL, 0x27c1, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>           board_ahci }, /* ICH7 */
>         { PCI_VENDOR_ID_INTEL, 0x27c5, PCI_ANY_ID, PCI_ANY_ID, 0, 0,

