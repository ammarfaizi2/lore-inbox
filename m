Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276639AbRJ2SNW>; Mon, 29 Oct 2001 13:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276646AbRJ2SNC>; Mon, 29 Oct 2001 13:13:02 -0500
Received: from fungus.teststation.com ([212.32.186.211]:62730 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S276639AbRJ2SM7>; Mon, 29 Oct 2001 13:12:59 -0500
Date: Mon, 29 Oct 2001 19:13:25 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Martin Eriksson <nitrax@giron.wox.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: via-rhine and MMIO
In-Reply-To: <04b801c1607a$947dbef0$0201a8c0@HOMER>
Message-ID: <Pine.LNX.4.30.0110291847420.21339-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Martin Eriksson wrote:

> I have done some changes to the via-rhine driver in 2.4.13 to be able to run
> with MMIO. I know it isn't really needed but I do it mainly for fun &
> learning.

Any measurable performance difference?

Any important changes from the driver that used to be on
    http://www.cs.umu.se/~c97men/linux ?
(I have a copy of "v1.03a ME1.0 3/12/00")


> /* Reload the station address from the EEPROM. */
> writeb(0x20, ioaddr + MACRegEEcsr);
> /* Typically 2 cycles to reload. */
> for (i = 0; i < 150; i++)
>     if (! (readb(ioaddr + MACRegEEcsr) & 0x20))
>         break;
> ...
> 
> If I run this code when I'm using MMIO, I get a hardware adress of
> "ff:ff:ff:ff:ff:ff" instead of the right one (and everything craps up). But
> when I comment out this part all is fine. So what's it needed for anyway?

It is needed on some cards when rebooting from some other OSes that power
down the card (eg vt6102 chips on win98). The writeb causes the chip
itself to reload the hardware address from eeprom. Perhaps it no longer
finds the eeprom and just reads 0xff from some unmapped memory space.

Does it work to enable MMIO after the reset code?

/Urban

