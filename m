Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267171AbSLRPUz>; Wed, 18 Dec 2002 10:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbSLRPUz>; Wed, 18 Dec 2002 10:20:55 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:48612 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267171AbSLRPUy>; Wed, 18 Dec 2002 10:20:54 -0500
Date: Wed, 18 Dec 2002 10:30:54 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Bjorn Helgaas <bjorn_helgaas@hp.com>, "" <mj@ucw.cz>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: disable decoding while sizing BARs
In-Reply-To: <20021217172925.A15754@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.50L.0212181029580.16430-100000@freak.distro.conectiva>
References: <200212161741.53287.bjorn_helgaas@hp.com>
 <20021217172925.A15754@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Ivan Kokshaysky wrote:

> On Mon, Dec 16, 2002 at 05:41:53PM -0700, Bjorn Helgaas wrote:
> > +	/* Disable I/O & memory decoding while we size the BARs. */
> > +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> > +	pci_write_config_word(dev, PCI_COMMAND,
> > +		cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY));
>
> It's fatal for certain x86 northbridges, that's why the code was
> removed 2 years ago.
>
> Maybe it would be ok with this modification:
>
> 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> 	/* Don't touch northbridges or devices with devfn 0:0 */
> 	if ((dev->class >> 8) != PCI_CLASS_BRIDGE_HOST && dev->devfn)
> 		pci_write_config_word(dev, PCI_COMMAND,
> 			cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY));

Ok, I've reverted this one.
