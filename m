Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbUL0Ub4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUL0Ub4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 15:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbUL0Ub4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 15:31:56 -0500
Received: from smtpout6.uol.com.br ([200.221.4.197]:29405 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261979AbUL0Ubv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 15:31:51 -0500
Date: Mon, 27 Dec 2004 18:31:47 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-ac1
Message-ID: <20041227203146.GA27615@ime.usp.br>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1104103881.16545.2.camel@localhost.localdomain> <58cb370e04122616577e1bd33@mail.gmail.com> <1104157999.20952.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1104157999.20952.40.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 27 2004, Alan Cox wrote:
> A whole range of quirky systems, probably in most cases buggy hardware,
> BIOS firmware setup bugs and the like but they are there and end users
> use them. Its __init code so it is free.

This discussion is highly interesting in light of the behaviour that I'm
seeing in my system.

I have an Asus A7V motherboard with chipset VIA KT133 and it has 2 VIA IDE
(vt82c686a) controllers and 2 Promise PDC20265 controllers.

I'm seeing an strange behaviour. Until yesterday I had a DVD reader (hdc)
and an HP CD-Writer 9100 (hdd) both on the same VIA ide controller (ide1 in
my system).

Unfortunately, with this setup, I could not burn a CD and read a CD-ROM of
archived files at the same time. As it was a nuisance, I decided to put the
CD-Writer on the Promise controller, which is an UDMA100 controller and,
thus, I thought things would only get better.

Both drives, when connected on the VIA controller, were able to use UDMA33.
Unfortunately, to my surprise, now only the drive on the VIA controller is
able to use UDMA -- in other words, the drive connected to the Promise
controller is not able to use DMA.

Right after booting Linux 2.6.10, I see the following, regarding the HP
CD-Writer:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
dumont:~# hdparm /dev/hdf

/dev/hdf:
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 HDIO_GETGEO failed: Invalid argument
dumont:~# 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

On the other hand, here is what hdparm -i says about the drive:
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
dumont:~# hdparm -I /dev/hdf

/dev/hdf:

ATAPI CD-ROM, with removable media
        Model Number:       Hewlett-Packard CD-Writer Plus 9100     
        Serial Number:      YM5950LDU4
        Firmware Revision:  1.0c    
Standards:
        Likely used CD-ROM ATAPI-1
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(can be disabled)
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=180ns  IORDY flow control=120ns
dumont:~# 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

In fact, things are so strange that if I disable the Promise controller
from the BIOS, the CD-Writer is completely ignored by Linux (like it were
not there -- no traces of it in the dmesg log and no access to it).

I would welcome any help to these problems. Right now, I am compiling the
2.6.10-ac1 kernel in the hope that it solves this problem (my computer is
very slow and it takes about 30min to compile a new kernel). I'm using
Debian's testing/sarge distribution.

Oh, BTW, trying to substitute (on the Promise Controller) the HP CD-Writer
with a vanilla CD-ROM drive that supports mdma2 also gives me similar
behaviour to that of the HP CD-Writer: it can only use PIO mode 4 reliably.

Ripping audio with grip's built-in cdparanoia is painfully slow in this
case (and, unfortunately, my DVD reader is quite old right now and isn't
able to read some CD Audio discs that I have). :-(

Any help is welcome.


Thanks in advance, Rogério Brito.

P.S.: Please let me know what further information would be important for
chasing this strange situation.
-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
