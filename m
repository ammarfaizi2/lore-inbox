Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312382AbSCYKdA>; Mon, 25 Mar 2002 05:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312389AbSCYKcu>; Mon, 25 Mar 2002 05:32:50 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:48645
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312382AbSCYKcq>; Mon, 25 Mar 2002 05:32:46 -0500
Date: Mon, 25 Mar 2002 02:32:11 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
cc: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18: many IDE errors
In-Reply-To: <3C9EFB4E.8938BA3A@eyal.emu.id.au>
Message-ID: <Pine.LNX.4.10.10203250227540.6920-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2002, Eyal Lebedinsky wrote:

> Andre Hedrick wrote:
> > 
> > On Sun, 24 Mar 2002, Eyal Lebedinsky wrote:
> > 
> > > If I understand correctly, the basic answer is that this is not
> > > a driver issue, and not a general kernel (irq's etc.) either, but
> > > a true hardware problem.
> > >
> > >
> > > Andre Hedrick wrote:
> > > >
> > > > It is not a case of bad cables but maybe cable routing.
> > >
> > > I am not clear on what cable routing means. Can you elaborate?
> > 
> > If you have many cable (note there are random ways to construct, odd/even)
> > You can get crosstalk (aka 0x51/0x84 kernel noise).  These messages are
> > telling you the hardware checksum between the HOST and DEVICE failed.
> > The solution is to retry, and the driver does.
> 
> [explanation of rate backoff trimmed]
> 
> Yes, I see this happening, and I agree it is a good idea.
> 
> > > I know they come up ATA-5. Here are the relevant bootup messages:
> > >
> > > Uniform Multi-Platform E-IDE driver Revision: 6.31
> > > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > > idebus=xx
> > > VP_IDE: IDE controller on PCI bus 00 dev 39
> > > VP_IDE: chipset revision 6
> > > VP_IDE: not 100% native mode: will probe irqs later
> > > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > > idebus=xx
> > > VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
> > >     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
> > >     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
> > 
> > First disable unmasking VIA it makes a mess. :-/
> > 
> > This (CMD649) is a good HOST and Linux can deal nicely.
> 
> You mean IRQ unmasking? This is interesting. After bootup I see hda/c
> (on VP_IDE, ide0/1) having
> 	I/O support:	1
> 	unmasking:	1
> but hde/g/i/k (on CMD649, ide2/3/4/5) have:
> 	I/O support:	0
> 	unmasking:	0
> So VIA unmasking is NOT disabled (I will do so) but why is the CMD649
> disabled if you say it is a good chipset?

Because not all drivers are safe and have interrupt parser to claim or
reject ownership of the interrupt.

In the past the adaptec was the worst interrupt eater on the planet, but
things have changed in that driver.

General paranoia from the past.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

