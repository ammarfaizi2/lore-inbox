Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751612AbWCBSAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbWCBSAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWCBSAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:00:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2835 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751592AbWCBSAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:00:40 -0500
Date: Thu, 2 Mar 2006 18:00:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take4)
Message-ID: <20060302180025.GC28895@flint.arm.linux.org.uk>
Mail-Followup-To: Grant Grundler <grundler@parisc-linux.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-pci@atrey.karlin.mff.cuni.cz
References: <44070B62.3070608@jp.fujitsu.com> <20060302155056.GB28895@flint.arm.linux.org.uk> <20060302172436.GC22711@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302172436.GC22711@colo.lackof.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 10:24:36AM -0700, Grant Grundler wrote:
> On Thu, Mar 02, 2006 at 03:50:57PM +0000, Russell King wrote:
> > I've been wondering whether this "no_ioport" flag is the correct approach,
> > or whether it's adding to complexity when it isn't really required.
> 
> I think it's the simplest solution to allowing a driver
> to indicate which resources it wants to use. It solves
> the problem of I/O Port resource allocation sufficiently
> well.

It's not really "I/O port resource allocation" though - the resources
have already been allocated and potentially programmed into the BARs
well before the driver gets anywhere near the device.

> > In the non-Intel world, the kernel itself sets up the PCI bus mappings,
> 
> mappings, yes. But many of the architectures depend on (or assume)
> firmware will assign appropriate resources. The problem is firmware
> runs out of I/O Port resources.

Are you implying that somehow resources are allocated at pci_enable_device
time?  If so, shouldn't we be thinking of moving completely to that model
rather than having yet-another-pci-setup-model.

Let's see - we have the i386 method, the drivers/pci/setup-* method, and
it sounds like some pci_enable_device() method now.

The problem is that the "no_ioport" method is completely useless for the
drivers/pci/setup-* method since that information from the drivers comes
well after the PCI setup code has been run.

> Several people have already agreed the driver needs to indicate which
> resource it wants to work with. I don't see how the arch PCI support
> can provide that "knowledge".

What I'm saying is that we need to unify this stuff, rather than keep
bluring and overloading the interfaces.  Otherwise we'll end up with
drivers developed on one platform which have one expectation from the
PCI API, which could potentially be different from drivers developed
on some other platform.

Let's have some uniformity - and a solution which can fit everyone -
that's all I'm asking.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
