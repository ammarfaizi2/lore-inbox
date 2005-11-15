Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVKOOCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVKOOCJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 09:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbVKOOCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 09:02:09 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:25575 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S932529AbVKOOCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 09:02:05 -0500
Date: Tue, 15 Nov 2005 15:01:55 +0100 (CET)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Marvell SATA fixes v2
In-Reply-To: <20051114050404.GA18144@havoc.gtf.org>
Message-ID: <Pine.LNX.4.63.0511151437320.3015@dingo.iwr.uni-heidelberg.de>
References: <20051114050404.GA18144@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2005, Jeff Garzik wrote:

> Finally got Marvell 50XX SATA to the point where it, too, complains
> about "ATA: abnormal status 0x80 on port ...11C"... which is progress :)

Thanks for picking up the sata_mv development, Jeff!

I can confirm your results on a 5041 controller:

sata_mv 0000:02:08.0: version 0.25
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 26 (level, low) -> IRQ 177
sata_mv 0000:02:08.0: 32 slots 4 ports SCSI mode IRQ via MSI
ata11: SATA max UDMA/133 cmd 0x0 ctl 0xF8C22120 bmdma 0x0 irq 177
ata12: SATA max UDMA/133 cmd 0x0 ctl 0xF8C24120 bmdma 0x0 irq 177
ata13: SATA max UDMA/133 cmd 0x0 ctl 0xF8C26120 bmdma 0x0 irq 177
ata14: SATA max UDMA/133 cmd 0x0 ctl 0xF8C28120 bmdma 0x0 irq 177
ATA: abnormal status 0x80 on port 0xF8C2211C
ata11: dev 0 cfg 49:2f00 82:74eb 83:7feb 84:4123 85:74e9 86:3c03 87:4123 88:007f
ata11: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48

(there is a 400GB Hitachi disk attached to the first port)

However, when running 'insmod ./sata_mv.ko' with a disk attched, 
insmod doesn't return, it gets blocked into "D" state (gdb says 
"ptrace: Operation not permitted." while strace attaches but doesn't 
show anything and cannot be detached). This is with the 2.6.15-rc1 
based FC devel kernel (2.6.14-1.1665), using up-to-date FC4 user 
space, if that helps... This is not an one-off, I was able to 
reproduce it three times out of three :-(

Another thing that I noticed and don't know if it's normal is that the 
ataXX ports remain "allocated" even after rmmod; I have two ICH6 ports 
(ata1 and 2) and then insmod-ed the sata_mv driver 2 times without 
disks attached (which took ata3-6 and ata7-10) and then the insmod 
shown above.

Thanks again!

--
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
