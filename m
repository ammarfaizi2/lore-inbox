Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145136AbRA2FfZ>; Mon, 29 Jan 2001 00:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145160AbRA2FfO>; Mon, 29 Jan 2001 00:35:14 -0500
Received: from isunix.it.ilstu.edu ([138.87.124.103]:12307 "EHLO
	isunix.it.ilstu.edu") by vger.kernel.org with ESMTP
	id <S145136AbRA2FfE>; Mon, 29 Jan 2001 00:35:04 -0500
From: Tim Hockin <thockin@isunix.it.ilstu.edu>
Message-Id: <200101290511.XAA21997@isunix.it.ilstu.edu>
Subject: Re: PCI IRQ routing problem in 2.4.0
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 28 Jan 2001 23:11:13 -0600 (CST)
Cc: siemer@panorama.hadiko.de (Robert Siemer), jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101282050180.5079-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 28, 2001 08:58:57 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Device 00:01.0 (slot 0): ISA bridge
> >   INTA: link 0x01, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
> >   INTB: link 0x02, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
> >   INTC: link 0x03, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
> >   INTD: link 0x04, irq mask 0x1eb8 [3,4,5,7,9,10,11,12]
> 
> Your "link" values are in the range 1-4. Which makes perfect sense, but
> that's absolutely _not_ what the Linux SiS routing code expects (the code 
> seems to expect them to be ASCII 'A' - 'D').


In reading the PIRQ specs, and making it work for our board, I thought
about this.  PIRQ states that link is chipset-dependant.  No chipset that I
have seen specifies what link should be.  So, as this case demonstrates, it
may be 'A' - the value the chipset expects, or 1, the logical index.
Either one makes sense, assuming the PIRQ routing code knows what link
means.  Here we see two BIOS vendors/versions that apparently do it
differently for the same chipset.    Grrr.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
