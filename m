Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272333AbTHNMfA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 08:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272338AbTHNMfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 08:35:00 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:49344 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S272333AbTHNMe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 08:34:58 -0400
Date: Thu, 14 Aug 2003 14:34:54 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: jw schultz <jw@pegasys.ws>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: C99 Initialisers
In-Reply-To: <20030814105216.GA26892@pegasys.ws>
Message-ID: <Pine.GSO.4.21.0308141433240.12289-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003, jw schultz wrote:
> On Thu, Aug 14, 2003 at 12:05:28PM +0200, Geert Uytterhoeven wrote:
> > On Wed, 13 Aug 2003, Jeff Garzik wrote:
> > > > On Wed, Aug 13, 2003 at 03:44:44PM -0400, Jeff Garzik wrote:
> > > >>enums are easy  putting direct references would be annoying, but I also 
> > > >>argue it's potentially broken and wrong to store and export that 
> > > >>information publicly anyway.  The use of enums instead of pointers is 
> > > >>practically required because there is a many-to-one relationship of ids 
> > > >>to board information structs.
> > > > 
> > > > The hard part is that it's actually many-to-many.  The same card can have
> > > > multiple drivers.  one driver can support many cards.
> > > 
> > > pci_device_tables are (and must be) at per-driver granularity.  Sure the 
> > > same card can have multiple drivers, but that doesn't really matter in 
> > > this context, simply because I/we cannot break that per-driver 
> > > granularity.  Any solution must maintain per-driver granularity.
> > 
> > Aren't there any `hidden multi-function in single-function' PCI devices out
> > there? E.g. cards with a serial and a parallel port?
> > 
> > At least for the Zorro bus, these exist. E.g. the Ariadne card contains both
> > Ethernet and 2 parallel ports, so the Ariadne Ethernet driver and the (still to
> > be written) Ariadne parallel port driver are both drivers for the same Zorro
> > device.
> 
> I'm not sure but i think most of those look like multiple
> pci devices rather than one device with multiple functions.
> I've got an Initio 9520UW: One PCI card with two ini9x00 UW
> SCSI HBAs sharing one interrupt and one EEPro100 on another
> interrupt.  During scan it seems to me to be three devices
> sitting behind a bridge.

In most cases it is.

Just found a PCI example myself: there exists iDTV chips that connect to a PCI
bus. It's one device, but internally it has graphics, video, USB, IDE, ...
So you'll have different drivers.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

