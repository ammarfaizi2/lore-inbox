Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263546AbTKFNaM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 08:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTKFNaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 08:30:12 -0500
Received: from mail.gmx.de ([213.165.64.20]:10896 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263546AbTKFNaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 08:30:03 -0500
X-Authenticated: #4512188
Message-ID: <3FAA4D48.6040709@gmx.de>
Date: Thu, 06 Nov 2003 14:31:52 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031102
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <3FA8D17D.3060204@gmx.de> <20031105123923.GP1477@suse.de> <3FA945DD.8030105@gmx.de> <20031106091746.GA1379@suse.de> <3FAA41C3.9060601@gmx.de> <3FAA45A9.20707@cyberone.com.au> <20031106130030.GC1145@suse.de> <3FAA4737.3060906@cyberone.com.au> <20031106130553.GD1145@suse.de> <3FAA4880.8090600@cyberone.com.au> <20031106131141.GE1145@suse.de>
In-Reply-To: <20031106131141.GE1145@suse.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Nov 07 2003, Nick Piggin wrote:
> 
>>
>>Jens Axboe wrote:
>>
>>
>>>On Fri, Nov 07 2003, Nick Piggin wrote:
>>>
>>>
>>>>Jens Axboe wrote:
>>>>
>>>>
>>>>
>>>>>sys time is usually pretty high if that is the case, and it's hovering
>>>>>around 5% here... Prakash, are you sure that dma is enabled on the
>>>>>drive? When you see the problem, do a vmstat 1 for 10 seconds so you are
>>>>>absolutely sure you are sending the info from when the problem occurs.
>>>>>
>>>>>
>>>>
>>>>Although have a look at the interrupts field in vmstat 1255, 725, 736 ...
>>>>
>>>
>>>Yeah that is pretty high for just doing a burn, maybe something else is
>>>
>>
>>;) you are forgetting 2.6 should give 1000 timer interrupts per second!
> 
> 
> Heh indeed, maybe because the archs I use are still at 100. Looks
> suspiciously like it's loosing timer interrupts, which would indeed
> point to PIO.
> 
bash-2.05b# hdparm -I /dev/hdc

/dev/hdc:

ATAPI CD-ROM, with removable media
         Model Number:       LITE-ON LTR-16102B
         Serial Number:
         Firmware Revision:  OS0K
Standards:
         Used: ATAPI for CD-ROMs, SFF-8020i, r2.5
         Supported: CD-ROM ATAPI-2
Configuration:
         DRQ response: 50us.
         Packet size: 12 bytes
Capabilities:
         LBA, IORDY(cannot be disabled)
         DMA: mdma0 mdma1 *mdma2
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=227ns  IORDY flow control=120ns

For me it looks as though multiword dma 2 is being used, isnt it?

Another question: When doing dmesg, I see this:

...
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 10
ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LAPU] enabled at IRQ 10
...

Is it normal that SCSI subsystem gets init'ed, even though nothing of it 
is activated in the kernel?

Prakash

