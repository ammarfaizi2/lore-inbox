Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVDEUEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVDEUEm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVDEUEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:04:41 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:54532 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261925AbVDEUCX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:02:23 -0400
Date: Tue, 5 Apr 2005 21:02:24 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Matthew Wilcox <matthew@wil.cx>,
       "David S. Miller" <davem@davemloft.net>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: iomapping a big endian area
In-Reply-To: <20050405195506.A16617@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61L.0504052041250.9632@blysk.ds.pg.gda.pl>
References: <1112475134.5786.29.camel@mulgrave>
 <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>
 <20050402183805.20a0cf49.davem@davemloft.net>
 <20050403031000.GC24234@parcelfarce.linux.theplanet.co.uk>
 <1112499639.5786.34.camel@mulgrave> <20050405084219.A21615@flint.arm.linux.org.uk>
 <1112709915.5764.4.camel@mulgrave> <20050405195506.A16617@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005, Russell King wrote:

> > > physical bus:	31...24	23...16	15...8	7...0
> > > 
> > > BE version 1 (word invariant)
> > >   byte access	byte 0	byte 1	byte 2	byte 3
> > >   word access	31-24	23-16	15-8	7-0
> > > 
> > > BE version 2 (byte invariant)
> > >   byte access	byte 3	byte 2	byte 1	byte 0
> > >   word access	7-0	15-8	23-16	31-24
> > 
> > These are just representations of the same thing.  However, I did
> > deliberately elect not to try to solve this problem in the accessors.  I
> > know all about the register relayout, because 53c700 has to do that on
> > parisc.
> 
> They aren't.  On some of our platforms, we have to exclusive-or the address
> for byte accesses with 3 to convert to the right endian-ness.

 The same with certain MIPS configurations.  And likewise you need to xor 
addresses with 2 for halfword accesses.

> Sure, from the point of view of which byte each byte of a word represents,
> it's true that they're indentical.  But as far as the hardware is concerned,
> they're definitely different.

 To clarify it a bit: both big and little endian representations are 
always the same -- it's going to a domain of the reverse endianness that 
can be done in two different ways, i.e. by preserving either bit or byte 
ordering (as described above).  Depending on the interpretation of data 
being passed you want one or the other.  That's why some systems provide 
ways of doing both kinds of accesses in hardware (e.g. the host bus to PCI 
bridge) to save CPU cycles needed for bit shuffling otherwise.

  Maciej
