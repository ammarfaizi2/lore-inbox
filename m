Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261794AbSJHMSg>; Tue, 8 Oct 2002 08:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261830AbSJHMSg>; Tue, 8 Oct 2002 08:18:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:37329 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261794AbSJHMSf>;
	Tue, 8 Oct 2002 08:18:35 -0400
Date: Tue, 8 Oct 2002 08:24:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Patrick Mochel <mochel@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IDE driver model update
In-Reply-To: <1034079668.26550.54.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0210080813030.2894-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 Oct 2002, Alan Cox wrote:

> On Tue, 2002-10-08 at 03:17, Alexander Viro wrote:
> > _ALL_ buses that have driverfs support (IDE, SCSI, USB, PCI) have their
> > own rules for lifetimes of their structures.  And that's not likely to
> > change - these objects belong to drivers and in some cases (IDE) are
> > not even allocated dynamically - they are reused if nothing is holding
> > them.
> 
> IDE objects can also outlast the hardware - consider an active mount on
> an ejected pcmcia card. Right now we don't do the right stuff to
> reconnect that on re-insert but one day we may need to. As it is we keep
> the instance around to avoid crashes

Ouch.  That (reconnects) may require interesting things from queue-related
code.  What behaviour do you want while card is disconnected?  All requests
getting errors / all requests getting blocked / reads failing, writes blocking?

