Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279438AbRJ2UJj>; Mon, 29 Oct 2001 15:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279444AbRJ2UJa>; Mon, 29 Oct 2001 15:09:30 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:1668 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S279442AbRJ2UJN>; Mon, 29 Oct 2001 15:09:13 -0500
Message-ID: <009e01c160b5$e48038c0$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Urban Widmark" <urban@teststation.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0110291847420.21339-100000@cola.teststation.com>
Subject: Re: via-rhine and MMIO
Date: Mon, 29 Oct 2001 21:11:27 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Urban Widmark" <urban@teststation.com>
To: "Martin Eriksson" <nitrax@giron.wox.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, October 29, 2001 7:13 PM
Subject: Re: via-rhine and MMIO


> On Mon, 29 Oct 2001, Martin Eriksson wrote:
>
> > I have done some changes to the via-rhine driver in 2.4.13 to be able to
run
> > with MMIO. I know it isn't really needed but I do it mainly for fun &
> > learning.
>
> Any measurable performance difference?

I don't think so, it would be slightly less latency, but as via-rhine needs
to copy the data anyway...

>
> Any important changes from the driver that used to be on
>     http://www.cs.umu.se/~c97men/linux ?
> (I have a copy of "v1.03a ME1.0 3/12/00")

Yes _I_ have matured a bit =) And the new driver does not choose between
MMIO/PORTIO at runtime, because most other drivers seem to select this via
CONFIG_ directives.

>
>
> > /* Reload the station address from the EEPROM. */
> > writeb(0x20, ioaddr + MACRegEEcsr);
> > /* Typically 2 cycles to reload. */
> > for (i = 0; i < 150; i++)
> >     if (! (readb(ioaddr + MACRegEEcsr) & 0x20))
> >         break;
> > ...
> >
> > If I run this code when I'm using MMIO, I get a hardware adress of
> > "ff:ff:ff:ff:ff:ff" instead of the right one (and everything craps up).
But
> > when I comment out this part all is fine. So what's it needed for
anyway?
>
> It is needed on some cards when rebooting from some other OSes that power
> down the card (eg vt6102 chips on win98). The writeb causes the chip
> itself to reload the hardware address from eeprom. Perhaps it no longer
> finds the eeprom and just reads 0xff from some unmapped memory space.
>
> Does it work to enable MMIO after the reset code?

I'll check that out, and if all works fine I'll release a patch. By the way,
how *do* you measure network performance the best way? What I have done now
is only to stress test the driver, by copying a 400MB file from my Windows
machine to /dev/null and at the same time recieving a 400MB file over FTP
from my Sun Sparc which is bridged on another via-rhine.

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden


