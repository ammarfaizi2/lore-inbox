Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268394AbTAMWvk>; Mon, 13 Jan 2003 17:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268396AbTAMWvk>; Mon, 13 Jan 2003 17:51:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36363 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268394AbTAMWvi>; Mon, 13 Jan 2003 17:51:38 -0500
Date: Mon, 13 Jan 2003 14:58:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Adam Belay <ambx1@neo.rr.com>
cc: Jaroslav Kysela <perex@suse.cz>, Greg KH <greg@kroah.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>, Shawn Starr <spstarr@sh0n.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnP update - drivers
In-Reply-To: <20030113173906.GA605@neo.rr.com>
Message-ID: <Pine.LNX.4.44.0301131454310.15429-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Jan 2003, Adam Belay wrote:
>
> PnP IDE Conversion from Zwane Mwaikambo

This, btw, is _worse_ than the current conversion, as far as I can tell. 
In particular:

> -/* Generic initialisation function for ISA PnP IDE interface */
> +/* Barf bags at the ready! Enough to satisfy IDE core */
> +static void pnp_to_pci(struct pnp_dev *pnp_dev, struct pci_dev *pci_dev)
> +{
> +	pci_dev->dev = pnp_dev->dev;
> +	pci_set_drvdata(pci_dev, pnp_get_drvdata(pnp_dev));
> +	pci_dev->irq = DEV_IRQ(pnp_dev, 0);
> +	pci_set_dma_mask(pci_dev, 0x00ffffff);
> +}

That "pci_dev->dev = pnp_dev->dev" looks totally bletcherous, and does a
structure copy that potentially copies pointers that simply ARE NOT VALID
after the copy.

Not good.

		Linus

