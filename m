Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312387AbSCYK0u>; Mon, 25 Mar 2002 05:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312382AbSCYK0l>; Mon, 25 Mar 2002 05:26:41 -0500
Received: from CPE-203-51-26-136.nsw.bigpond.net.au ([203.51.26.136]:63483
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S312387AbSCYK0Z>; Mon, 25 Mar 2002 05:26:25 -0500
Message-ID: <3C9EFB4E.8938BA3A@eyal.emu.id.au>
Date: Mon, 25 Mar 2002 21:26:22 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre3-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18: many IDE errors
In-Reply-To: <Pine.LNX.4.10.10203250143250.6920-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> On Sun, 24 Mar 2002, Eyal Lebedinsky wrote:
> 
> > If I understand correctly, the basic answer is that this is not
> > a driver issue, and not a general kernel (irq's etc.) either, but
> > a true hardware problem.
> >
> >
> > Andre Hedrick wrote:
> > >
> > > It is not a case of bad cables but maybe cable routing.
> >
> > I am not clear on what cable routing means. Can you elaborate?
> 
> If you have many cable (note there are random ways to construct, odd/even)
> You can get crosstalk (aka 0x51/0x84 kernel noise).  These messages are
> telling you the hardware checksum between the HOST and DEVICE failed.
> The solution is to retry, and the driver does.

[explanation of rate backoff trimmed]

Yes, I see this happening, and I agree it is a good idea.

> > I know they come up ATA-5. Here are the relevant bootup messages:
> >
> > Uniform Multi-Platform E-IDE driver Revision: 6.31
> > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx
> > VP_IDE: IDE controller on PCI bus 00 dev 39
> > VP_IDE: chipset revision 6
> > VP_IDE: not 100% native mode: will probe irqs later
> > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx
> > VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
> >     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
> >     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
> 
> First disable unmasking VIA it makes a mess. :-/
> 
> This (CMD649) is a good HOST and Linux can deal nicely.

You mean IRQ unmasking? This is interesting. After bootup I see hda/c
(on VP_IDE, ide0/1) having
	I/O support:	1
	unmasking:	1
but hde/g/i/k (on CMD649, ide2/3/4/5) have:
	I/O support:	0
	unmasking:	0
So VIA unmasking is NOT disabled (I will do so) but why is the CMD649
disabled if you say it is a good chipset?

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
