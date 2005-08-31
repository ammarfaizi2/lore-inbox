Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbVHaVDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbVHaVDm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 17:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbVHaVDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 17:03:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41740 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964958AbVHaVDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 17:03:42 -0400
Date: Wed, 31 Aug 2005 22:03:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 04/16] I/O driver for 8250-compatible UARTs
Message-ID: <20050831220333.D6385@flint.arm.linux.org.uk>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <resend.3.2982005.trini@kernel.crashing.org> <1.2982005.trini@kernel.crashing.org> <resend.4.2982005.trini@kernel.crashing.org> <200508311338.52225.bjorn.helgaas@hp.com> <20050831201039.GM3966@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050831201039.GM3966@smtp.west.cox.net>; from trini@kernel.crashing.org on Wed, Aug 31, 2005 at 01:10:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 01:10:39PM -0700, Tom Rini wrote:
> On Wed, Aug 31, 2005 at 01:38:52PM -0600, Bjorn Helgaas wrote:
> > On Monday 29 August 2005 10:09 am, Tom Rini wrote:
> > >  linux-2.6.13-trini/drivers/serial/kgdb_8250.c  |  594 +++++++++++++++++++++
> > 
> > The existing stuff in drivers/serial is named "8250_*"; is
> > there a reason you're using "kgdb_8250" rather than "8250_kgdb"?
> 
> All the other kgdb stuff tends to be prefixed, not suffixed.  But I
> don't really care either way.

I'd prefer it was 8250_kgdb.c actually - that keeps it along side the
other 8250 files.

> > > +	switch (CURRENTPORT.iotype) {
> > > +	case UPIO_MEM:
> > > +		if (CURRENTPORT.mapbase)
> > > +			kgdb8250_needs_request_mem_region = 1;
> > > +		if (CURRENTPORT.flags & UPF_IOREMAP) {
> > > +			CURRENTPORT.membase = ioport_map(CURRENTPORT.mapbase,
> > > +						      8 << KGDB8250_REG_SHIFT);
> > 
> > Shouldn't this be ioremap instead of ioport_map?
> 
> If I remember right from the testing, no.  Or if my memory is wrong and
> that's retorihcal, sure.

ioport_map() is supposed to be used to map the IO range for the ioread/
iowrite operations.  IOW, it takes something compatible with inb() and
friends and converts it to something compatible with ioread8() and
friends.

It does not take a MMIO cookie, so the code above appears to be
conceptually wrong.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
