Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268485AbTANBgJ>; Mon, 13 Jan 2003 20:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268486AbTANBgJ>; Mon, 13 Jan 2003 20:36:09 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:50270
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268485AbTANBgH>; Mon, 13 Jan 2003 20:36:07 -0500
Date: Mon, 13 Jan 2003 20:44:10 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Adam Belay <ambx1@neo.rr.com>, Jaroslav Kysela <perex@suse.cz>,
       Greg KH <greg@kroah.com>, Shawn Starr <spstarr@sh0n.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnP update - drivers
In-Reply-To: <Pine.LNX.4.44.0301131454310.15429-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0301131915490.2102-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Linus Torvalds wrote:

> 
> On Mon, 13 Jan 2003, Adam Belay wrote:
> >
> > PnP IDE Conversion from Zwane Mwaikambo
> 
> This, btw, is _worse_ than the current conversion, as far as I can tell. 
> In particular:

I just had a look (and test booted), the current one definitely is better 
and less kludgy.

> > -/* Generic initialisation function for ISA PnP IDE interface */
> > +/* Barf bags at the ready! Enough to satisfy IDE core */
> > +static void pnp_to_pci(struct pnp_dev *pnp_dev, struct pci_dev *pci_dev)
> > +{
> > +	pci_dev->dev = pnp_dev->dev;
> > +	pci_set_drvdata(pci_dev, pnp_get_drvdata(pnp_dev));
> > +	pci_dev->irq = DEV_IRQ(pnp_dev, 0);
> > +	pci_set_dma_mask(pci_dev, 0x00ffffff);
> > +}
> 
> That "pci_dev->dev = pnp_dev->dev" looks totally bletcherous, and does a
> structure copy that potentially copies pointers that simply ARE NOT VALID
> after the copy.
> 
> Not good.

Hey, i did offer barf bags ;) I admit, that part is complete bollocks, due 
to my bending over for pci_dev.

	Zwane
-- 
function.linuxpower.ca



