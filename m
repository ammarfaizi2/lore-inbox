Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTJGI3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 04:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTJGI3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 04:29:35 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:39754 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261893AbTJGI22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 04:28:28 -0400
Date: Tue, 7 Oct 2003 01:27:27 -0700
From: Jeremy Higdon <jeremy@SGI.COM>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Aniket Malatpure <aniket@SGI.COM>, akmp@osdl.org, gwh@SGI.COM,
       jbarnes@SGI.COM, aniket_m@hotmail.com, linux-kernel@vger.kernel.org
Subject: Re: Patch to add support for SGI's IOC4 chipset
Message-ID: <20031007082727.GA27934@sgi.com>
References: <3F7CB4A9.3C1F1237@sgi.com> <200310031645.57341.bzolnier@elka.pw.edu.pl> <3F7E1509.7D08EC2D@sgi.com> <200310041930.15385.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310041930.15385.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bartlomiej,

I have a few questions.  I'm going to be submitting the rest
of the patches that Aniket was working on, as he started at a new
company today (he was attempting to finish the submission before he
left).  Please forgive a lack of expertise on my part.

On Sat, Oct 04, 2003 at 07:30:15PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> > +       return p - buffer;
> > +}
> >
> > >Do you really need /proc/ide/sgiioc4?
> > >You can print revision number during init.
> >
> > It has been helpful to be able to see the firmware revision num anytime
> > during system operation.
> > So the new patch still creates the above entry.
> 
> I don't buy this, lspci can be used :-).

lspci gives the version number.
/proc/ide/sgiioc4 gives you:

        SGI IOC4 Chipset rev 79.
        Chipset has 1 IDE channel and supports 2 devices on that channel.
        Chipset supports DMA in MultiMode-2 data transfer protocol.

Is the # of IDE channels/devices and the DMA mode also available elsewhere?


> > +                                           int ddir);
> > +static unsigned int __init pci_init_sgiioc4(struct pci_dev
> > *dev,ide_pci_device_t *d);
> >
> > >Most of this declarations are not needed as sgiioc4.h is only included
> > > from shiioc4.c.
> >
> > The sgiioc4.h file has been removed in the new patch.
> 
> sgiioc4.h was removed, but declarations weren't.
> You can shuffle code around to get rid of them.

How important is this to you?  It seems more a style issue.  I agree with
you, by the way.  When I write code, I try to minimize forward declarations.
If I can get rid of some easily, will that be good enough?

> There are no .enablebits on SGI IOC4?  Please add a comment about it.

What are they used for (i.e. what are you looking for in the comment)?

> sgiioc4_init_one():
> +	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
> +	class_rev &= 0xff;
> 
> Access to PCI devices before pci_enable_device()
> (it is called later in pci_init_sgiioc4).

Is pci_enable_device required before a config space access?


I will make changes in accordance with the other comments and based on
your responses to this.

Thanks

jeremy
