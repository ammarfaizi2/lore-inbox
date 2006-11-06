Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbWKFGiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbWKFGiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 01:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbWKFGiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 01:38:16 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:13928 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932645AbWKFGiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 01:38:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AmL5UVSfktoEkx4Per6V05jbcAACZegDJBDQg4r9BPaD51uCpJ4E/Yp2dH9BNCMIO8hD7F9I0qMIuq+HWcBBLm0XL0ku0a1iK8BV2y86OlJEYbS6Q7lh/2jUA8SQRv7qGpExFE8vv1jePrddWyMZVnB0i7fR0ZlRgMaMGf1YACQ=
Message-ID: <233976e40611052238u4dfa9bdek83c74494b7163b39@mail.gmail.com>
Date: Mon, 6 Nov 2006 07:38:14 +0100
From: "Jean-Baptiste BUTET" <ashashiwa@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Promise PDC20375 (SATA150 TX2plus) doesn't work with last kernels.
Cc: ashashiwa@gmail.com
In-Reply-To: <233976e40611040503m2a4bf449k78f84b0768d1f14e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <233976e40611040503m2a4bf449k78f84b0768d1f14e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, Hi Jeff,

> My pb : I have a
> 00:09.0 Mass storage controller: Promise Technology, Inc. PDC20375
> (SATA150 TX2plus) (rev 02) that worked (under kubuntu) and here
> doesn't work with new install.
>
> I've a 160 Gb IDE disk on it. (My mother card don't accept such huge
> disk without this card)

So, I've investigated to see why UBUNTU Dapper see my IDE disk and why
newer kernels doesn't. There's some big changes in dmesg : a
sata_promise PATA port is found. Or it's on this port IDE disk is
plugged.
---------------------- ubuntu's dmesg
[17179580.780000] SCSI subsystem initialized
[17179580.792000] ACPI: bus type scsi registered
[17179580.792000] libata version 1.20 loaded.
[17179580.800000] sata_promise 0000:00:09.0: version 1.03
[17179580.800000] **** SET: Misaligned resource pointer: d6a7d1e2 Type 07 Len 0
[17179580.804000] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
[17179580.804000] PCI: setting IRQ 9 as level-triggered
[17179580.804000] ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD]
-> GSI 9 (level, low) -> IRQ 9
[17179580.804000] sata_promise PATA port found
[17179580.820000] ata1: SATA max UDMA/133 cmd 0xD8880200 ctl
0xD8880238 bmdma 0x0 irq 9
[17179580.820000] ata2: SATA max UDMA/133 cmd 0xD8880280 ctl
0xD88802B8 bmdma 0x0 irq 9
[17179580.820000] ata3: PATA max UDMA/133 cmd 0xD8880300 ctl
0xD8880338 bmdma 0x0 irq 9
[17179581.024000] ata1: no device found (phy stat 00000000)
[17179581.024000] scsi0 : sata_promise
[17179581.228000] ata2: no device found (phy stat 00000000)
[17179581.228000] scsi1 : sata_promise
[17179581.392000] ata3: dev 0 cfg 00:0040 49:2f00 82:7c6b 83:7f09
84:4003 85:7c68 86:3e01 87:4003 88:407f 93:600b
[17179581.392000] ata3: dev 0 ATA-7, max UDMA/133, 320173056 sectors: LBA48
[17179581.392000] ata3: dev 0 configured for UDMA/133
[17179581.392000] sata_get_dev_handle: SATA dev addr=0x90000, handle=0x00000000
[17179581.392000] scsi2 : sata_promise
[17179581.392000]   Vendor: ATA       Model: Maxtor 6Y160P0    Rev: YAR4
[17179581.392000]   Type:   Direct-Access                      ANSI
SCSI revision: 05
[17179581.420000] Driver 'sd' needs updating - please use bus_type methods
[17179581.424000] SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
[17179581.424000] SCSI device sda: drive cache: write back
[17179581.432000] SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
[17179581.436000] SCSI device sda: drive cache: write back
[17179581.436000]  sda: sda1 sda2
---------------------

Dmesg on 2.6.18.1 :
scsi_mod: exports duplicate symbol scsi_logging_level (owned by kernel)
libata version 2.00 loaded.
sata_promise 0000:00:09.0: version 1.04
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 9 (level,
low) -> IRQ 9
ata1: SATA max UDMA/133 cmd 0xD8876200 ctl 0xD8876238 bmdma 0x0 irq 9
ata2: SATA max UDMA/133 cmd 0xD8876280 ctl 0xD88762B8 bmdma 0x0 irq 9
scsi0 : sata_promise
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : sata_promise
ata2: SATA link down (SStatus 0 SControl 300)

---------------------


Is there any PATA support broken in new sata_promise/libata stuff ? Is
there any good kernel configuration in order to make it works?

Thanks a lot.

Jean-Baptiste
