Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269808AbUJAO6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269808AbUJAO6k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 10:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269807AbUJAO6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 10:58:40 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:38557 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S269808AbUJAO6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 10:58:34 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH] Way for platforms to alter built-in serial ports
Date: Fri, 1 Oct 2004 08:58:27 -0600
User-Agent: KMail/1.7
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200409301014.00725.bjorn.helgaas@hp.com> <1096588409.3083.34.camel@gaston>
In-Reply-To: <1096588409.3083.34.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410010858.27390.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 September 2004 5:53 pm, Benjamin Herrenschmidt wrote:
> On Fri, 2004-10-01 at 02:14, Bjorn Helgaas wrote:
> 
> > This looks like a reasonable short-term fix, but I think the whole
> > serial8250_isa_init_ports() should go away.  I like dwmw2's suggestion
> > of an 8250_platform.c that could use register_serial() for each port
> > in some platform-supplied old_serial_port[] table, which is probably
> > what you mean by moving to a more dynamic allocation.
> 
> What would this file look like ? a bunch of platform #ifdef's with
> different implementations each time ? 

My main point is that I think the early init stuff (i.e.,
serial8250_isa_init_ports()) should go away, so we don't have the
dichotomy of having the compiled-in stuff handled differently than
the run-time enumerated stuff.

It really doesn't matter for ia64, since we discover all the ports
via either PCI enumeration or ACPI.  We don't put anything in
old_serial_port[] at all.  For platforms that can't do that,
there'd still have to be compiled-in tables, but the entries
should be added using the standard register_serial() interface
just like everything else.

> > AFAICS, the only reason for doing serial8250_isa_init_ports() early
> > is for early serial consoles, and I think those should be done along
> > the lines of this:
> >  http://www.ussg.iu.edu/hypermail/linux/kernel/0409.1/1034.html
> > where the platform can specify a device by its MMIO or IO port address,
> > and we automatically switch to the corresponding ttyS device later.
> 
> Eventually...
> 
> In the meantime, that patch would fix urgent problems for ppc now so
> I'd appreciate if Russell would consider it for inclusion asap. This
> is the kind of subject on which everybody comes up with a different
> "better" way to do it and no code, and nothign ever gets implemented
> and we end up with no progress...

We've both posted working code that are at least baby steps toward
a better solution, so I hope we can make some progress.
