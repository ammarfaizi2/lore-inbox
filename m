Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbVHaWPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbVHaWPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 18:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVHaWPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 18:15:55 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:59534 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964925AbVHaWPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 18:15:53 -0400
Date: Wed, 31 Aug 2005 15:15:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [patch 04/16] I/O driver for 8250-compatible UARTs
Message-ID: <20050831221552.GO3966@smtp.west.cox.net>
References: <resend.3.2982005.trini@kernel.crashing.org> <200508311338.52225.bjorn.helgaas@hp.com> <20050831201039.GM3966@smtp.west.cox.net> <200508311519.37523.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508311519.37523.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 03:19:37PM -0600, Bjorn Helgaas wrote:
> On Wednesday 31 August 2005 2:10 pm, Tom Rini wrote:
> > On Wed, Aug 31, 2005 at 01:38:52PM -0600, Bjorn Helgaas wrote:
> > > On Monday 29 August 2005 10:09 am, Tom Rini wrote:
> > I've tried intentionally to not mention 'ttyS' anywhere (exposed to the
> > user) because it's really not 'ttySN' but it is the port registered to
> > us.
> 
> So kgdb's port N is different from ttySN?  That sounds really
> confusing.  And KGDB_SIMPLE_SERIAL does mention "ttyS".

It's not intentionally different, and really only might be different in
the we have ttySX case, but ttySX isn't registered to KGDB case.

> > There's really two cases we have to deal with.  The first case is a
> > known at compile time or can be registered at boot-time easily port (ie
> > dumb old PC or ARM boards).  The second case is "serial port over
> > there".  Perhaps we should change the kgdb8250 arg to be an override of
> > the default port, so:
> > kgdb8250={io,mmio},<irq>,<token>,<baud rate>
> 
> That makes sense.  But I'd make it {io,mmio},<token>,<baud>,<irq>
> so it's more like the existing "console=uart" argument.

ok.

> > > > +		printk(KERN_ERR "kgdb8250: argument error, usage: "
> > > > +		       "kgdb8250=<port number>,<baud rate>");
> > > > +#ifdef CONFIG_IA64
> > > > +		printk(",<irq>,<iomem base>");
> > > > +#endif
> > > 
> > > This isn't ia64-specific.
> > 
> > It is and it isn't.  Since no one's tried a PCI card uart for KGDB nor
> > had a case where we have to pass in the mmio addr except on ia64, it is
> > ia64-specific.
> 
> Maybe it's only been *tested* on ia64, but I don't think that's a
> reason to make it compiled only on ia64.

It's only been needed on ia64.  But it's moot since I've reworked things
for kgdb8250= is always a complete override.

> Actually, I think KGDB_SIMPLE_SERIAL, KGDB_*BAUD, KGDB_PORT_*,
> KGDB_PORT, and KGDB_IRQ are overkill.  Could they all be nuked
> in favor of a KGDB_8250_DEVICE that could be set to things like
> "ttyS0,115200" or "io,0x3f8,115200,49"?

Hmm.  I'll give that a shot momentarily... That sounds like a good idea
'tho..

-- 
Tom Rini
http://gate.crashing.org/~trini/
