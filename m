Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273254AbRI3K1P>; Sun, 30 Sep 2001 06:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273255AbRI3K1F>; Sun, 30 Sep 2001 06:27:05 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:62219 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S273254AbRI3K06> convert rfc822-to-8bit; Sun, 30 Sep 2001 06:26:58 -0400
Date: Sun, 30 Sep 2001 12:21:50 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: Ookhoi <ookhoi@dds.nl>, "Justin T. Gibbs" <gibbs@scsiguy.com>,
        <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9-ac17 Adaptec AIC7XXX problems (new driver, old one works
 fine) (solved)
In-Reply-To: <20010930000327.F2665@one-eyed-alien.net>
Message-ID: <20010930113441.H624-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 30 Sep 2001, Matthew Dharm wrote:

> Hrm... this makes me wonder if the Byte Merge option is keeping the PCI
> consistancy rules, or perhaps the aic7xxx driver is making assumptions
> about when PCI writes are actually occuring, without doing a read cycle
> between critical writes to make sure they actually happen.

If the VIA PCI byte merging way is the one described by the PCI
specifications, then it may only happen when the data phase is targetted
to a _prefectchable_ address range (implied should never happen when
targetted to a non-prefetechable range). If some VIA chipsets perform byte
merging for non-prefetchable range then the are HIGHLY bogus in my opinion
and stink a LOT absolutely.

May-be, the old aic7xxx driver does enforce a read cycle after each MMIO
write shorter than a DWORD. This obviously prevents Bogus Byte Merging to
non-prefetchable from occurring, but also affects PCI performances of all
systems using this driver.

Should we blindly kill performances for good hardware due to a couple of
brain-damagedly designed ones? I think *NO*, and for example, the drivers
for SYMBIOS chips I maintain donnot do so, never did so and will never do
so.

> Matt
>
> On Sun, Sep 30, 2001 at 08:57:31AM +0200, Ookhoi wrote:
> > Hi Justin,
> >
> > > >The new driver for the Adaptec 7892B gives me the following problems
> > > >(see dmesg) on a asus a7v mobo with kernel 2.4.9-ac17.
> > > >
> > > >I have to run the system underclocked to make it boot at all. As soon
> > > >as I run it at 1000 or 1200 MHz, it does a Kernel panic: for safety
> > > >during the scsi boot part. It is a 1200MHz processor. The system runs
> > > >fine after the (long) boot.
> > >
> > > IIRC, the a7v is an AMD processor with VIA chipset. If you go into the
> > > MB BIOS and disable all of the "Make my PCI bus go as fast as possible
> > > even if this means violating the spec" options, the "new" aic7xxx
> > > driver should work fine. I wish VIA would get a clue.
> >
> > It is indeed an AMD system with the VIA KT133 chipset.
> >
> > I played with the bios settings to find out with which option it would
> > or would not give trouble. Under Advanced, CHIP Configuration the option
> > Byte Merge has to be disabled to make the kernel boot fine with the new
> > aic7xxx driver. This is with kernel 2.4.9-ac18
> >
> > The bios manual says:
> > Byte Merge [Enabled by default]
> > To optimize the data transfer on PCI, this merges a sequence of
> > individual memory writes (bytes or words) into a single 32-bit block of
> > data. However, byte merging may only be done when the bytes within a
> > data phase are in a prefetchable address range. Configuration options:
> > [Disabled] [Enabled]

The wording seems to indicate that VIA ingenieers read the specifications.
May-be they misunderstood the 'may only be done' statement.

> > Why does the old driver boot fine with this enabled, and has the new
> > driver troubles booting then? The system seemed to run fine after the
> > long boot with the new driver and byte merge enabled, so it seemes that
> > only the boot gives troubles. The system didn't always boot till the end
> > with the new kernel and byte merge enabled btw, as it sometimes stopped
> > with the message: Kernel panic: for safety
> >
> > Anyway, thank you for the hint! It all works fine now. :-)
> >
> > 	Ookhoi


  Gérard.


