Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTILM43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 08:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbTILM42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 08:56:28 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:44418 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261539AbTILM41
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 08:56:27 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [OOPS] 2.4.22 / HPT372N
Date: Fri, 12 Sep 2003 14:58:25 +0200
User-Agent: KMail/1.5
Cc: Ronny Buchmann <ronny-lkml@vlugnet.org>, Marko Kreen <marko@l-t.ee>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200309091406.56334.ronny-lkml@vlugnet.org> <200309121141.45776.ronny-lkml@vlugnet.org> <1063363684.5409.8.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1063363684.5409.8.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309121458.25327.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 of September 2003 12:48, Alan Cox wrote:
> On Gwe, 2003-09-12 at 10:41, Ronny Buchmann wrote:
> > I will test with cdrom attached later today.
> > Currently I have one disk on each channel.
> >
> > I had another look at hpt.c(from highpoint) and hpt366.c and found this:
> > --- linux-2.4.22-ac1/drivers/ide/pci/hpt366.c.orig	2003-09-11
> > 21:29:06.000000000 +0200
> > +++ linux-2.4.22-ac1/drivers/ide/pci/hpt366.c	2003-09-12
> > 01:05:44.000000000 +0200
> > @@ -713,7 +713,7 @@
> >
> >  	/* Reconnect channels to bus */
> >  	outb(0x00, hwif->dma_base+0x73);
> > -	outb(0x00, hwif->dma_base+0x79);
> > +	outb(0x00, hwif->dma_base+0x77);
> >  }
>
> Which piece of documentation makes you think that ? So I can double
> check it.
>
> > -	d->channels = 1;
> > +	d->channels = 2;
>
> Need to work out which 372N and others are dual channel but yes

No, "d->channels = 1" is only executed for orginal HPT366 which has separate
PCI configurations for first and second channel.  For HPT372N you have correct
value in hpt366.h - ".channels = 2".

--bartlomiej

