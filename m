Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129253AbRBIArs>; Thu, 8 Feb 2001 19:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129505AbRBIAri>; Thu, 8 Feb 2001 19:47:38 -0500
Received: from cs.columbia.edu ([128.59.16.20]:59525 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129253AbRBIAr0>;
	Thu, 8 Feb 2001 19:47:26 -0500
Date: Thu, 8 Feb 2001 16:47:17 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Donald Becker <becker@scyld.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Alan Cox <alan@redhat.com>,
        <linux-kernel@vger.kernel.org>, <jes@linuxcare.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.10.10102081924330.7141-100000@vaio.greennet>
Message-ID: <Pine.LNX.4.30.0102081640550.31024-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Donald Becker wrote:

> > Or we can just tell people, "hey, don't use this 64-bit PCI card on a real 
> > 64-bit system, it's broken by design"? I don't think that's a good 
> > solution either.
> 
> This is not a 64 bit PCI issue.  

I know. It was just an ironic comment: we have a card with a 64-bit PCI 
bus, we have a 64-bit system which very likely has some 64-bit PCI slots 
on its motherboard, perfect match, right? Well, au contraire, the 
performance is going to suck big-time, at least for Rx.

> It is an issue with the protocol
> stack.  The IP protocol handling code must expect that the header words
> will be misaligned in some circumstances.

I won't get into this...

> It's amusing that a full receive copy is added without any concern, in
> the same discussion where zero-copy transmit is treated as a holy grail!

Amusing? Maybe. Zerocopy will still help with Tx, and with Rx we're just 
trying to contain the damage, *with the existent stack*.

> This might be a transceiver preamble issue with the specific
> transceivers on the recent cards.  Debugging this type of problem
> sometimes requires a D-Oscope on the MII data pins.
> 
> Normally I would suspect a timing problem with a very fast machine, but
> the Starfire hardware generates its own preamble and clock signals, not
> the driver code.

See my previous mail. It turned out to be just a confused chipset.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
