Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbSL3XGT>; Mon, 30 Dec 2002 18:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267101AbSL3XGS>; Mon, 30 Dec 2002 18:06:18 -0500
Received: from havoc.daloft.com ([64.213.145.173]:16869 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267102AbSL3XGR>;
	Mon, 30 Dec 2002 18:06:17 -0500
Date: Mon, 30 Dec 2002 18:14:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jaroslav Kysela <perex@suse.cz>,
       Adam Belay <ambx1@neo.rr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pnp & pci structure cleanups
Message-ID: <20021230231436.GA20810@gtf.org>
References: <Pine.LNX.4.33.0212291228200.532-100000@pnote.perex-int.cz> <20021230221212.GE32324@kroah.com> <1041289960.13684.180.camel@irongate.swansea.linux.org.uk> <20021230225012.GA19633@gtf.org> <20021230225134.GD814@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021230225134.GD814@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 02:51:34PM -0800, Greg KH wrote:
> On Mon, Dec 30, 2002 at 05:50:12PM -0500, Jeff Garzik wrote:
> > On Mon, Dec 30, 2002 at 11:12:40PM +0000, Alan Cox wrote:
> > > On Mon, 2002-12-30 at 22:12, Greg KH wrote:
> > > > Yeah!  Thanks for taking these fields out of pci.h, I really appreciate
> > > > it.  I'll send this on to Linus in a bit.
> > > 
> > > Argh I was using those to implement a test "pci_compatible" driver so
> > > that you could feed new pci idents to old drivers. Oh well 
> > 
> > Note that we need a way to do field replacement of PCI id tables.
> > 
> > I've been harping on that to various ears for years :)
> 
> And USB id tables.  A number of usb drivers are slowly adding module
> paramater hacks to get around this, but it would be really nice to do
> this "correctly" for all drivers.  Somehow...

Surely there is a sysfs path we can devise to do

	echo "add <pci_device_id line>" > /sys/pci/driver/tulip

(or replace that with a file-oriented interface that inputs an entire
table)

and internally just refer to, and update, a kmalloc'd copy of the
original driver's pci (or usb) table.


> > <tangent>
> > I also want to add PCI revision id and mask to struct pci_device_id.
> > </tangent>
> 
> Do any drivers need that today?  It shouldn't be that hard to do it, and
> now is the time :)

Yes.  tulip driver could find this useful, but that's currently a small
case worked around in the driver.

The big and annoying case is 8139C+ (8139cp.c), which has the same
PCI id as old 8139 boards, but additionally includes dramatically new
and better functionality.  The distinguishing characteristic at the
probe phase is the PCI revision id, as the PCI id is the same as another
driver.

	Jeff


