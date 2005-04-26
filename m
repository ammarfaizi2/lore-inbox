Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVDZWsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVDZWsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 18:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVDZWsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 18:48:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:14801 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261828AbVDZWsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 18:48:05 -0400
Subject: Re: pci-sysfs resource mmap broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, bjorn.helgaas@hp.com
In-Reply-To: <20050426163042.GE2612@colo.lackof.org>
References: <1114493609.7183.55.camel@gaston>
	 <20050426163042.GE2612@colo.lackof.org>
Content-Type: text/plain
Date: Wed, 27 Apr 2005 08:47:34 +1000
Message-Id: <1114555655.7183.81.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There are two "views" of a PCI resource and the names I've used in
> the past are "IO View" and "CPU View". The raw BAR value is the "IO View"
> since that's what that devices on that PCI bus need to use for Peer-to-Peer
> reads/writes. IIRC, sym2 driver directly reads the BAR for telling the scripts
> engine where onboard RAM lives. The "CPU View" is what drivers/user space
> needs to use when accessing the device. This is what we should be
> exporting to user space and I'm pretty sure that's what X.org/XF86
> should be using too. Bjorn, have I got that right?

No. I don't agree. userspace has no business understanding the kernel
resources content. All userspace need to care about is the resource
number, and _eventually_ match it to a BAR value (either for using the
old /proc interface -> existing code, or to use it with real inx/outx
instructions on x86).

> > Shouldn't we expose the BAR values & size rather here ? That is,
> > reconsitutes non-offset'd resources, possibly with arch help, or just
> > reading BAR to get base, and apply resource size & flags ?
> > 
> > Unless you are on x86 of course ...
> > 
> > There is some serious brokenness in there, it needs to be fixed if we
> > want things like X.org to be ever properly adapted (and we'll have to
> > deal with existing broken kernels, gack).
> 
> ISTR Bjorn was looking at this and the VGA routing issues.

OK, well, I'll come up with a patch in a few hours doing what I
described anyway, and we'll start from that.

The only thing I dislike a bit is that forces me to read the BAR on
every access to "un-offset" the kernel resource. We may be able to have
some arch hook do that properly, but for now, that would fix the problem
and make the whole stuff work again.

Ben.


