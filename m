Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbUL1CpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbUL1CpC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 21:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbUL1CpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 21:45:01 -0500
Received: from smtpout3.uol.com.br ([200.221.4.194]:16270 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S262023AbUL1Cox
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 21:44:53 -0500
Date: Tue, 28 Dec 2004 00:44:48 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-ac1
Message-ID: <20041228024447.GB13559@ime.usp.br>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1104103881.16545.2.camel@localhost.localdomain> <58cb370e04122616577e1bd33@mail.gmail.com> <1104157999.20952.40.camel@localhost.localdomain> <20041227203146.GA27615@ime.usp.br> <41D073E6.3050207@stud.feec.vutbr.cz> <1104194716.20898.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1104194716.20898.60.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 28 2004, Alan Cox wrote:
> Correct - IDE lacks "disconnect" so when the bus is locked during
> something like a CD verify during a burn you don't get access to the
> other device.

Yes, that was the problem that I was trying to circumvent.

> > > As it was a nuisance, I decided to put the CD-Writer on the Promise
> > > controller, which is an UDMA100 controller and, thus, I thought
> > > things would only get better.
> > 
> > I remember reading somewhere that one should not connect ATAPI devices
> > to the Promise controller.
> 
> Again exactly right - some promise controllers don't support ATAPI DMA.

Is there any way to circumvent the limitations via software? I have already
upgraded the firmware of my motherboard (and, if I understood it correctly,
it also upgraded the firmware of the Promise controller).

The funny thing is that right after the Power On Self Test, the devices are
probed and then the Promise controller says that the drive supports UDMA2.
Then, when Linux boots, I see this:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PDC20265: IDE controller at PCI slot 0000:00:11.0
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:11.0[A] -> GSI 10 (level, low) -> IRQ 10
PDC20265: chipset revision 2
PDC20265: 100%% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:pio, hdh:pio
hdf: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

> As a general rule:
>   Put disks on the host first so they avoid the PCI bus overhead and
> dont fill it
>   Put CD burners on host if you can
>   Use external controllers for slower stuff

Ok, so if this is indeed buggy hardware, one way to make the system not
slow to a crawl would be to have:

	* on ide0 the first HD and the DVD reader;
	* on ide1 the second HD and the CD-Writer.

Since both ide0 and ide1 are VIA controllers, they would be able to cope
with DMA. It will be really a deception with this motherboard if I can't
use the Promise controller (which claimed to be ATA/100 when I bought it
and paid a good deal of money). :-(


Thanks for all your feedback and suggestions, Rogério Brito.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
