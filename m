Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbVA1SrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVA1SrQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbVA1Sop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:44:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:25238 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262623AbVA1SmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:42:00 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Date: Fri, 28 Jan 2005 10:41:41 -0800
User-Agent: KMail/1.7.2
Cc: Jon Smirl <jonsmirl@gmail.com>, Greg KH <greg@kroah.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
References: <9e47339105011719436a9e5038@mail.gmail.com> <200501270828.43879.jbarnes@sgi.com> <20050128173222.GC30791@colo.lackof.org>
In-Reply-To: <20050128173222.GC30791@colo.lackof.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501281041.42016.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 28, 2005 9:32 am, Grant Grundler wrote:
> On Thu, Jan 27, 2005 at 08:28:43AM -0800, Jesse Barnes wrote:
> > But then again,
> > I suppose if a platform supports more than one legacy I/O space,
>
> Eh?! there can only be *one* legacy I/O space.
> We can support multipl IO port spaces, but only one can be the "legacy".

What do you mean?  If you define legacy I/O space to be 
0x0000000000000000-0x000000000000ffff, then yes of course you're right.  But 
if you mean being able to access legacy ports at all, then no.  On SGI 
machines, there's a per-bus base address that can be used as the base for 
port I/O, which is what I was getting at.

> Moving the VGA device can only function within that legacy space
> the way the code is written now (using hard coded addresses).
> If it is intended to work with multiple IO Port address spaces,
> then it needs to use the pci_dev->resource[] and mangle that appropriately.

There is no resource for some of the I/O port space that cards respond to.  I 
can set the I/O BAR of my VGA card to 0x400 and it'll still respond to 
accesses at 0x3bc for example.  That's what I mean by legacy space--space 
that cards respond to but don't report in their PCI resources.

Jesse
