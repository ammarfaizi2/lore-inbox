Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBIAhR>; Thu, 8 Feb 2001 19:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRBIAg7>; Thu, 8 Feb 2001 19:36:59 -0500
Received: from battlejitney.wdhq.scyld.com ([216.254.93.178]:37366 "EHLO
	vaio.greennet") by vger.kernel.org with ESMTP id <S129093AbRBIAgr>;
	Thu, 8 Feb 2001 19:36:47 -0500
Date: Thu, 8 Feb 2001 19:44:24 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Alan Cox <alan@redhat.com>,
        linux-kernel@vger.kernel.org, jes@linuxcare.com
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.30.0102081406020.31024-100000@age.cs.columbia.edu>
Message-ID: <Pine.LNX.4.10.10102081924330.7141-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Ion Badulescu wrote:

> On Thu, 8 Feb 2001, Donald Becker wrote:
> 
> > > > The align-copy should *never* be required because the alignment differs
> > > > between DIX and E-II encapsulated packets.  The machine shouldn't crash
> > > > because someone sends you a different encapsulation type!
> > 
> > This is true for a number of drivers -- triggering the copy-align code
> > might eliminate the misaligned traps on your local network, but it's not
> > a solution.
> 
> Ok, so what *is* a good solution then? I'm not arguing that unaligned 
> memory access traps should be avoided because they are deadly (they 
> shouldn't be), but because they are costly.
> 
> Or we can just tell people, "hey, don't use this 64-bit PCI card on a real 
> 64-bit system, it's broken by design"? I don't think that's a good 
> solution either.

This is not a 64 bit PCI issue.  It is an issue with the protocol
stack.  The IP protocol handling code must expect that the header words
will be misaligned in some circumstances.

It's amusing that a full receive copy is added without any concern, in
the same discussion where zero-copy transmit is treated as a holy grail!

> >    The MII read code is no longer reliable.  I spent twenty minutes at
> >    the show, but couldn't figure out the problem.  I haven't been able
> >    reproduce the problem locally with my 2.2 code and somewhat older
> >    hardware.
> 
> Yes, I've noticed this too, the PHY doesn't seem to get detected in all 
> cases, and it's pretty random at that. Other times the same PHY gets 
> detected multiple times at different addresses.

This might be a transceiver preamble issue with the specific
transceivers on the recent cards.  Debugging this type of problem
sometimes requires a D-Oscope on the MII data pins.

Normally I would suspect a timing problem with a very fast machine, but
the Starfire hardware generates its own preamble and clock signals, not
the driver code.

> The good news is that the same code behaves the same on 2.4 and 2.2, so 
> I think it's not a core kernel issue. I'll try to track it down; 

It's likely easier to use the starfire-diag program from
  http://www.scyld.com/diag/index.html

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
