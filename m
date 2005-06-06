Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVFFXnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVFFXnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVFFXSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:18:32 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:45654 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261269AbVFFW6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:58:33 -0400
Date: Mon, 6 Jun 2005 15:58:26 -0700
From: Greg KH <gregkh@suse.de>
To: Roland Dreier <roland@topspin.com>
Cc: tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: pci_enable_msi() for everyone?
Message-ID: <20050606225826.GB11184@suse.de>
References: <20050603224551.GA10014@kroah.com> <524qcft3m6.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524qcft3m6.fsf@topspin.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 04:36:17PM -0700, Roland Dreier wrote:
>     Greg> In talking with a few people about the MSI kernel code, they
>     Greg> asked why we can't just do the pci_enable_msi() call for
>     Greg> every pci device in the system (at somewhere like
>     Greg> pci_enable_device() time or so).  That would let all drivers
>     Greg> and devices get the MSI functionality without changing their
>     Greg> code, and probably make the api a whole lot simpler.
> 
>     Greg> Now I know the e1000 driver would have to specifically
>     Greg> disable MSI for some of their broken versions, and possibly
>     Greg> some other drivers might need this, but the downside seems
>     Greg> quite small.
> 
> This was discussed the first time around when MSI patches were first
> posted, and the consensus then was that it should be an "opt in"
> system for drivers.  However, perhaps things has matured enough now
> with PCI Express catching on, etc.

Yeah, that's what I'm trying to find out.

> I think the number of devices truly compliant with the MSI spec is
> quite tiny.  Probably just about every driver for a device that
> actually has an MSI capability in its PCI header will need code to
> work around some breakage, or will just end up disabling MSI entirely
> because it never works.  Also I don't know how many PCI host bridges
> implement MSI correctly.  For example we have a quirk for AMD 8131,
> but who knows how many other chipsets are broken (and some bugs may be
> much more subtle than the way the AMD 8131 breaks, which is to never
> deliver interrupts).

Motherboard quirks are one thing.  Broken devices are a totally
different thing.  If there are too many of them, then the current
situation is acceptable to me.  Does ib have devices that will break
with MSI?

> Also, there needs to be a way for drivers to ask for multiple MSI-X
> vectors.  For example the mthca InfiniBand driver gets a nice
> performance boost by using separate interrupts for different types of
> events.  I'm also planning on adding support for having one completion
> interrupt per CPU, to help SMP scalability.

In looking at that, I don't see a way to get rid of the msix stuff.  So
that's probably just going to stay the same.

thanks,

greg k-h
