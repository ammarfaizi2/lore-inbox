Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752010AbWCBRON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbWCBRON (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbWCBRON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:14:13 -0500
Received: from colo.lackof.org ([198.49.126.79]:5299 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1752010AbWCBRON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:14:13 -0500
Date: Thu, 2 Mar 2006 10:24:36 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take4)
Message-ID: <20060302172436.GC22711@colo.lackof.org>
References: <44070B62.3070608@jp.fujitsu.com> <20060302155056.GB28895@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302155056.GB28895@flint.arm.linux.org.uk>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 03:50:57PM +0000, Russell King wrote:
> I've been wondering whether this "no_ioport" flag is the correct approach,
> or whether it's adding to complexity when it isn't really required.

I think it's the simplest solution to allowing a driver
to indicate which resources it wants to use. It solves
the problem of I/O Port resource allocation sufficiently
well.

> In the non-Intel world, the kernel itself sets up the PCI bus mappings,

mappings, yes. But many of the architectures depend on (or assume)
firmware will assign appropriate resources. The problem is firmware
runs out of I/O Port resources.

> and any IO bars which it can't satisfy might also need to be gracefully
> handled.  Currently, we just go 'printk("whoops, didn't allocate
> resource")' and leave the BAR containing whatever random junk it
> contained before, along with the resource containing whatever random
> junk pci_bus_alloc_resource() decided to leave in it.
> 
> In such cases, I would suggest that the method of signalling that IO
> should not be used is to have the IO resource structures cleared out -
> if the IO resources aren't valid, they should not contain something
> which could be interpreted as valid.

You want the arch PCI support to clobber the I/O port space resources?
How will the arch PCI support know that a particular device's driver
only uses MMIO resources?

> Maybe something like this should be done for the "legacy IO port" case
> as well?

Several people have already agreed the driver needs to indicate which
resource it wants to work with. I don't see how the arch PCI support
can provide that "knowledge".

hth,
grant

> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
