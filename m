Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWESCGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWESCGY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 22:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWESCGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 22:06:24 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:33684 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932176AbWESCGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 22:06:23 -0400
Message-ID: <446D281B.2060605@garzik.org>
Date: Thu, 18 May 2006 22:06:19 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org> <20060516190507.35c1260f.akpm@osdl.org> <446AAB3C.6050303@gmail.com> <20060516215610.2b822c00.akpm@osdl.org> <446AB12C.10001@gmail.com> <446AC418.4070704@gmail.com> <20060518160758.5911e4b7.akpm@osdl.org> <20060519011400.GA10058@htj.dyndns.org>
In-Reply-To: <20060519011400.GA10058@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> On Thu, May 18, 2006 at 04:07:58PM -0700, Andrew Morton wrote:
>> Yes it does.  I dropped it and got
>>
>> SCSI subsystem initialized
>> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
>> ACPI (acpi_bus-0191): Device is not power manageable [20060310]
>> ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 19
>> ata1: SATA max UDMA/133 cmd 0x2148 ctl 0x217E bmdma 0x2110 irq 19
>> ata2: SATA max UDMA/133 cmd 0x2140 ctl 0x217A bmdma 0x2118 irq 19
>> ata1: SATA port has no device.
>>
>> Then I undropped it and got
>>
>> SCSI subsystem initialized
>> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
>> ACPI (acpi_bus-0191): Device is not power manageable [20060310]
>> ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 19
>> ata1: SATA max UDMA/133 cmd 0x2148 ctl 0x217E bmdma 0x2110 irq 19
>> ata2: SATA max UDMA/133 cmd 0x2140 ctl 0x217A bmdma 0x2118 irq 19
>> ata1.00: ATA-7, max UDMA/133, 321672960 sectors: LBA48 NCQ (depth 0/32)
>> ata1.00: configured for UDMA/133
>> scsi0 : ata_piix
>>
>> and a computer which boots.
>>
>> Look closer, please ;)
> 
> Hello, Andrew.
> 
> I see.  It seems that you're reporting two separate problems - your
> PCS register doesn't report presence properly && the TF registers
> report ghost device if the first device is ATAPI.  I can reproduce the
> second here, but AFAIK the only controller which had problem with PCS
> persence bits was ESB6300 until now.
> 
> Can you post the result of 'lspci -n' and ata_piix boot probing
> messages with the following patch applied?  It would be helpful if you
> tell us how devices are actually connected.  Also, where did the patch
> come from?  With what comment?

At this point it may be relevant to note that Intel tells me that PCS 
has changed on -every- chip.  So, ICH8 PCS register behaves differently 
from ICH7 and prior.

	Jeff



