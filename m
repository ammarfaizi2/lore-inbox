Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSFXPTN>; Mon, 24 Jun 2002 11:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSFXPTM>; Mon, 24 Jun 2002 11:19:12 -0400
Received: from crack.them.org ([65.125.64.184]:59916 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S314101AbSFXPTM>;
	Mon, 24 Jun 2002 11:19:12 -0400
Date: Mon, 24 Jun 2002 11:18:24 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Lars Magne Ingebrigtsen <larsi@gnus.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALI15X3 (was: Problems with Maxtor 4G160J8 and 2.4.19-* +/- ac*)
Message-ID: <20020624151824.GA5902@branoic.them.org>
Mail-Followup-To: Lars Magne Ingebrigtsen <larsi@gnus.org>,
	linux-kernel@vger.kernel.org
References: <m3ofe2vpa4.fsf@quimbies.gnus.org> <m3hejurrez.fsf@quimbies.gnus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3hejurrez.fsf@quimbies.gnus.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 23, 2002 at 04:38:44PM +0200, Lars Magne Ingebrigtsen wrote:
> Lars Magne Ingebrigtsen <larsi@gnus.org> writes:
> 
> > I've tried quite a few of the 2.4.19-pre patches, with or without
> > various -ac patches, including pre10 + ac2, and they all basically
> > display one of two behaviors: The machine either hangs just before
> > detecting the disk, or when doing the partition check for the disk.
> 
> [...]
> 
> > ALI15X3: IDE controller on PCI bus 00 dev 20
> > PCI: No IRQ known for interrupt pin A of device 00:04.0. Please try using pci=biosirq.
> > ALI15X3: chipset revision 196
> > ALI15X3: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:pio
> >     ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:pio, hdd:DMA
> 
> After poking around a bit, it seems like the real problem might be
> with the ALI15X3 driver.  I disabled that driver, and now I can boot
> using 2.4.19-pre10-ac2.  Of course, that leaves me with no DMA...
> 
> So -- is this a general problem with this driver, or does it only
> show up when using disks bigger than 128GiB?

I've had a lot of problems with ALI15x3; the patch that let me boot
(found somewhere on the net, do not remember the original author)
commented out the pci_read_config_byte and two pci_write_config_byte
calls right below the comment that says "set south-bridge's enable
bit".  Recent -ac kernels have this in two places.  DMA still works
after doing that; does this work for you?

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
