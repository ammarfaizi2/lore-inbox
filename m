Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268900AbUJFHdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268900AbUJFHdC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 03:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269050AbUJFHdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 03:33:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41482 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268915AbUJFHc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 03:32:58 -0400
Date: Wed, 6 Oct 2004 08:32:49 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Way for platforms to alter built-in serial ports
Message-ID: <20041006083249.C18379@flint.arm.linux.org.uk>
Mail-Followup-To: Bjorn Helgaas <bjorn.helgaas@hp.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200409301014.00725.bjorn.helgaas@hp.com> <1096588409.3083.34.camel@gaston> <200410010858.27390.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200410010858.27390.bjorn.helgaas@hp.com>; from bjorn.helgaas@hp.com on Fri, Oct 01, 2004 at 08:58:27AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 08:58:27AM -0600, Bjorn Helgaas wrote:
> On Thursday 30 September 2004 5:53 pm, Benjamin Herrenschmidt wrote:
> > On Fri, 2004-10-01 at 02:14, Bjorn Helgaas wrote:
> > 
> > > This looks like a reasonable short-term fix, but I think the whole
> > > serial8250_isa_init_ports() should go away.  I like dwmw2's suggestion
> > > of an 8250_platform.c that could use register_serial() for each port
> > > in some platform-supplied old_serial_port[] table, which is probably
> > > what you mean by moving to a more dynamic allocation.
> > 
> > What would this file look like ? a bunch of platform #ifdef's with
> > different implementations each time ? 
> 
> My main point is that I think the early init stuff (i.e.,
> serial8250_isa_init_ports()) should go away, so we don't have the
> dichotomy of having the compiled-in stuff handled differently than
> the run-time enumerated stuff.

You're always going to have this.  For instance, the standard ISA serial
ports may not show up in any "enumerated stuff" on an x86 box - and x86
people expect that the port at 0x3f8 is ttyS0, 2f8 is ttyS1 etc.

Change that order and they'll scream at you.

> It really doesn't matter for ia64, since we discover all the ports
> via either PCI enumeration or ACPI.  We don't put anything in
> old_serial_port[] at all.  For platforms that can't do that,
> there'd still have to be compiled-in tables, but the entries
> should be added using the standard register_serial() interface
> just like everything else.

See my previous mail why this doesn't work - x86 serial console
requirements.

I think you'll do better to discuss this problem with Alan so that
he can change his (and maybe others) points of view wrt when the
serial console is initialised.  Until then I'm going to continue
sitting on the fence on this point.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
