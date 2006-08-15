Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752108AbWHOPYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbWHOPYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbWHOPYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:24:12 -0400
Received: from 125.14.cm.sunflower.com ([24.124.14.125]:54678 "EHLO
	mail.atipa.com") by vger.kernel.org with ESMTP id S1030344AbWHOPYL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:24:11 -0400
Message-ID: <44E1E719.6020005@atipa.com>
Date: Tue, 15 Aug 2006 10:24:09 -0500
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: What determines which interrupts are shared under Linux?
References: <44E1D760.6070600@atipa.com> <1155654379.24077.286.camel@localhost.localdomain>
In-Reply-To: <1155654379.24077.286.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Aug 2006 15:24:21.0531 (UTC) FILETIME=[E1EAC6B0:01C6C07E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Maw, 2006-08-15 am 09:17 -0500, ysgrifennodd Roger Heflin:
>> On Linux when interrupts are defined similar to below, what defines say
>> ide2, ide3 to be on the same interrupt?    The bios, linux, the driver using
>> the interrupt?    And can that be controlled/overrode at the 
>> kernel/driver level?
> 
> Only with a soldering iron. They are the way the system is wired. Moving
> boards between slots may change the IRQ allocation.
> 
>> I have identified that the disks that are shared on ide2, ide3 do funny
>> things when both are being heavily used (dma_expiry), this is an older 
>> driver versions
> 
> That could be occuring just through lack of PCI bus bandwidth.
> 
> 
> 

Right now, all controllers are part of the NVIDIA chipset which should
mean the are on the same PCI bandwidth.    The block diagram does indicate
the 4 sata channels as one unit, though I don't know exactly how things
were internally done, performance testing seems to indicate that all
3 I am using are independent hardware as they don't seem to affect each
others load.

I am currently retesting under 2.6.17.8 to see if I have similar issues
there, under that it show interrupts like below, different interrupt 
numbers,
but similar sharing as ata1/ata2, and ata3/ata4 are on the same interrupt.

ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 16
ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 16
ata1: SATA link up 3.0 Gbps (SStatus 123)
ata1: dev 0 cfg 49:2f00 82:706b 83:7e61 84:4023 85:7069 86:3e41 87:4023 
88:407f
ata1: dev 0 ATA-7, max UDMA/133, 321672960 sectors: LBA48
ata1: dev 0 configured for UDMA/133
ata2: SATA link up 3.0 Gbps (SStatus 123)
ata2: dev 0 cfg 49:2f00 82:706b 83:7e61 84:4023 85:7069 86:3e41 87:4023 
88:407f
ata2: dev 0 ATA-7, max UDMA/133, 321672960 sectors: LBA48
ata2: dev 0 configured for UDMA/133
ata3: SATA max UDMA/133 cmd 0xD800 ctl 0xD402 bmdma 0xC800 irq 17
ata4: SATA max UDMA/133 cmd 0xD000 ctl 0xCC02 bmdma 0xC808 irq 17
ata3: SATA link up 3.0 Gbps (SStatus 123)
ata3: dev 0 cfg 49:2f00 82:706b 83:7e61 84:4023 85:7069 86:3e41 87:4023 
88:407f
ata3: dev 0 ATA-7, max UDMA/133, 321672960 sectors: LBA48
ata3: dev 0 configured for UDMA/133
ata4: SATA link down (SStatus 0)

                                       Roger
