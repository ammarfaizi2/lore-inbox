Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUJBGt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUJBGt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 02:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267323AbUJBGt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 02:49:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:60342 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267324AbUJBGtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 02:49:49 -0400
Subject: Re: [RFC][PATCH] Way for platforms to alter built-in serial ports
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200410010858.27390.bjorn.helgaas@hp.com>
References: <200409301014.00725.bjorn.helgaas@hp.com>
	 <1096588409.3083.34.camel@gaston> <200410010858.27390.bjorn.helgaas@hp.com>
Content-Type: text/plain
Message-Id: <1096699550.11996.24.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 02 Oct 2004 16:45:50 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-02 at 00:58, Bjorn Helgaas wrote:

> My main point is that I think the early init stuff (i.e.,
> serial8250_isa_init_ports()) should go away, so we don't have the
> dichotomy of having the compiled-in stuff handled differently than
> the run-time enumerated stuff.

Right. But that's a long term goal ;)

> It really doesn't matter for ia64, since we discover all the ports
> via either PCI enumeration or ACPI.  We don't put anything in
> old_serial_port[] at all.  For platforms that can't do that,
> there'd still have to be compiled-in tables, but the entries
> should be added using the standard register_serial() interface
> just like everything else.

I discover everything at boot time via Open Firmware, though on
ppc32, embedded platforms have gazillion different ways of getting
to them.

> > In the meantime, that patch would fix urgent problems for ppc now so
> > I'd appreciate if Russell would consider it for inclusion asap. This
> > is the kind of subject on which everybody comes up with a different
> > "better" way to do it and no code, and nothign ever gets implemented
> > and we end up with no progress...
> 
> We've both posted working code that are at least baby steps toward
> a better solution, so I hope we can make some progress.

Yes. Well, I suppose having a 8250_ppc{64}.c where I do the discovery
a bit like it's done with ACPI would be ok for everything but serial
console... I can do an OF plaform device that gets probed a bit late
though, and that wouldn't help for embedded stuffs, but then, those
people can always still use the hard coded table for a while ... :)

That would mean though having the kernel serial console for early boot
be separate from the 8250 driver... like you proposed. That would work
too... I have to ponder this approach, indeed probably better than
my patch provided you get your early uart stuff upstream :)

Ben.


