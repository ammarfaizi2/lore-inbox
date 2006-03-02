Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752046AbWCBTes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbWCBTes (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbWCBTes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:34:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35080 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1752046AbWCBTer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:34:47 -0500
Date: Thu, 2 Mar 2006 19:34:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take4)
Message-ID: <20060302193441.GG28895@flint.arm.linux.org.uk>
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

I have another question (brought up by someone working on a series of
ARM machines which make heavy use of MMIO.)

Why isn't pci_enable_device_bars() sufficient - why do we have to
have another interface to say "we don't want BARs XXX" ?

Let's say that we have a device driver which does this sequence (with,
of course, error checking):

	pci_enable_device_bars(dev, 1<<1);
	pci_request_regions(dev);

(a) should PCI remember that only BAR 1 has been requested to be enabled,
    and as such shouldn't pci_request_regions() ignore BAR 0?

(b) should the PCI driver pass into pci_request_regions() (or even
    pci_request_regions_bars()) a bitmask of the BARs it wants to have
    requested, and similarly for pci_release_regions().

Basically, if BAR0 hasn't been enabled, has pci_request_regions() got
any business requesting it from the resource tree?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
