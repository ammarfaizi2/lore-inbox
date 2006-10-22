Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422870AbWJVCl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422870AbWJVCl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 22:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422838AbWJVCl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 22:41:26 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35210 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751762AbWJVClZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 22:41:25 -0400
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] sata_nv ADMA/NCQ support for nForce4 (updated)
References: <45397D22.4030200@shaw.ca>
From: Andi Kleen <ak@suse.de>
Date: 22 Oct 2006 04:41:19 +0200
In-Reply-To: <45397D22.4030200@shaw.ca>
Message-ID: <p73iridm5rk.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock <hancockr@shaw.ca> writes:

> Here's the latest version of this patch. Changes since the last version I posted: fix to actually use the legacy interface for ATAPI as was intended, set the proper sg_tablesize for legacy and ADMA mode, some message and formatting cleanups, and ADMA is now enabled by default.
> 
> This patch is against 2.6.19-rc2.
> 
> As before, testing by people with this hardware would be appreciated. Also, it would be nice to get this into libata-dev or -mm to get some more exposure..

I tested it on a NF4-Professional system with 8GB RAM and a single 
SATA disk. It first did nicely in LTP and some other tests,
but during a bonnie++ run it eventually blocked with all
IO hanging forever. No output either. I did a full backtrace
and it just showed the processes waiting for a IO wakeup.

-Andi


sata_nv 0000:00:07.0: Using ADMA mode
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0xFFFFC2000003C480 ctl 0xFFFFC2000003C4A0 bmdma 0x1C10 irq 22
ata2: SATA max UDMA/133 cmd 0xFFFFC2000003C580 ctl 0xFFFFC2000003C5A0 bmdma 0x1C18 irq 22
scsi0 : sata_nv
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : sata_nv
ata2: SATA link down (SStatus 0 SControl 300)
ACPI: PCI Interrupt Link [LSI1] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LSI1] -> GSI 21 (level, high) -> IRQ 21
sata_nv 0000:00:08.0: Using ADMA mode
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0xFFFFC2000003E480 ctl 0xFFFFC2000003E4A0 bmdma 0x1C20 irq 21
ata4: SATA max UDMA/133 cmd 0xFFFFC2000003E580 ctl 0xFFFFC2000003E5A0 bmdma 0x1C28 irq 21
scsi2 : sata_nv
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-6, max UDMA/133, 312581808 sectors: LBA48 
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/133
scsi3 : sata_nv
ata4: SATA link down (SStatus 0 SControl 300)
scsi 2:0:0:0: Direct-Access     ATA      ST3160023AS      3.18 PQ: 0 ANSI: 5
ata3: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
