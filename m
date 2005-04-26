Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVDZQb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVDZQb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVDZQ3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:29:23 -0400
Received: from colo.lackof.org ([198.49.126.79]:2524 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261680AbVDZQ2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:28:15 -0400
Date: Tue, 26 Apr 2005 10:30:42 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, bjorn.helgaas@hp.com
Subject: Re: pci-sysfs resource mmap broken
Message-ID: <20050426163042.GE2612@colo.lackof.org>
References: <1114493609.7183.55.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114493609.7183.55.camel@gaston>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 03:33:29PM +1000, Benjamin Herrenschmidt wrote:
...
> The problem is that can only work ... on architectures where the
> resources contain the same thing as the BAR values. On ppc, where this
> is not the case, it will not work. On ppc, resources are "fixed up" in
> various ways (for example, PReP adds a fixed offset to all memory
> resources to match the HW translation since PCI isn't 1:1 on those, and
> all PPCs with more than one domain play tricks with IO resources).

IIRC, alpha, sparc, and parisc also are broken then.

> In a similar vein, the "resource" is exposing directly to userland the
> content of "struct resource". This doesn't mean anything. The kernel is
> internally playing all sort of offset tricks on these values, so they
> can't be used for anything useful, either via /dev/mem, or for io port
> accesses, or whatever.

There are two "views" of a PCI resource and the names I've used in
the past are "IO View" and "CPU View". The raw BAR value is the "IO View"
since that's what that devices on that PCI bus need to use for Peer-to-Peer
reads/writes. IIRC, sym2 driver directly reads the BAR for telling the scripts
engine where onboard RAM lives. The "CPU View" is what drivers/user space
needs to use when accessing the device. This is what we should be
exporting to user space and I'm pretty sure that's what X.org/XF86
should be using too. Bjorn, have I got that right?

> Shouldn't we expose the BAR values & size rather here ? That is,
> reconsitutes non-offset'd resources, possibly with arch help, or just
> reading BAR to get base, and apply resource size & flags ?
> 
> Unless you are on x86 of course ...
> 
> There is some serious brokenness in there, it needs to be fixed if we
> want things like X.org to be ever properly adapted (and we'll have to
> deal with existing broken kernels, gack).

ISTR Bjorn was looking at this and the VGA routing issues.

thanks,
grant
