Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135322AbRALFYw>; Fri, 12 Jan 2001 00:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135378AbRALFYn>; Fri, 12 Jan 2001 00:24:43 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:43529
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S135322AbRALFYa>; Fri, 12 Jan 2001 00:24:30 -0500
Date: Thu, 11 Jan 2001 21:23:52 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: dep <dennispowell@earthlink.net>, James Brents <James@nistix.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE DMA problems on 2.4.0 with vt82c686a driver
In-Reply-To: <E14Gj32-0002ND-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10101112111040.31644-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001, Alan Cox wrote:

> > us who have via chipset motherboards, suggesting that it is limited 
> > to that chipset, that chipset is ubiquitous, or via chipset 
> > motherboard owners are generally the complaining type. no idea which 
> > applies there, either.

Sheesh, when you can reprogram the chipset identity so that you can make
it appear to be mimic older chipsets that have current support, well you
get the headache!

> Or there are a lot of them. 90% of scsi bug reports I get are adaptec 29xx
> driver. Thats not because the adaptec 29xx is the most sucky driver 8)

It is not so much the chipset of the drivers, it is the jokers making
mainboards.  At the last meeting in Irvine there were issues about PCB
lane designs and chipset that cause problems in crosstalk or create bad
timing skews.  The problem is so wide spread in the industry that T13 is
looking at drafting a possible design annex for defined how to test and
create good hardware.  (I do not need the noise, I know this is what we
should be doing and not screwing up/down hardware) ;-)

> Firstly there are numerous reasons for CRC errors. At ATA100 even the track
> length and the capacitance of the connectors becomes an issue. It is quite
> possibly a driver issue. It could even be that specific combination of drives
> and ide controller is right on the edge of the spec limits and just slightly
> dipping over. It might be the odd power spike.

The 2.4.0 kernels now have the very first created in the software industry
of ATA an auto-dma-crc transfer rate recovery callback.  Thus if you get
only the 0x84/0x51 errors and there are no other problems and you chipset
code is full-featured to have a hwif->speedproc callback, it will auto set
the transfer-rate down until the iCRC errors stop.

> Providing the code is working sanely the odd CRC error shouldnt be a 
> problem and should be causing a command retry. The CRC checking used in ATA
> is very robust so unlike scsi parity errors which couldnt be ignored ATA
> ones on occassion are probably fine

(off to mark calender, a positive comment about ATA)

> ATA100 is another testimony to the fact that pigs can be made to fly given 
> sufficient thrust (to borrow an RFC)

But the price to pay is SCSI noise in ATA devices, or was that pig lips
flapping in the breeze...?


Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
