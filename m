Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbWIGNCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWIGNCP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 09:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWIGNCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 09:02:15 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:14095 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751784AbWIGNCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 09:02:13 -0400
Date: Thu, 7 Sep 2006 14:02:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Tejun Heo <htejun@gmail.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: question regarding cacheline size
Message-ID: <20060907130204.GB29532@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Wilcox <matthew@wil.cx>,
	Tejun Heo <htejun@gmail.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
References: <44FFD8C6.8080802@gmail.com> <20060907111120.GL2558@parisc-linux.org> <45000076.4070005@gmail.com> <20060907120756.GA29532@flint.arm.linux.org.uk> <20060907122311.GM2558@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907122311.GM2558@parisc-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 06:23:11AM -0600, Matthew Wilcox wrote:
> On Thu, Sep 07, 2006 at 01:07:56PM +0100, Russell King wrote:
> > I've often wondered why we don't set the cache line size when we set the
> > bus master bit - ISTR when I read the PCI spec (2.1 or 2.2) it implied
> > that this should be set for bus master operations.
> 
> It's not required ... 3.2.1 of pci 2.3 says:
> 
> While Memory Write and Invalidate is the only command that requires
> implementation of the Cacheline Size register, it is strongly suggested
> the memory read commands use it as well. A bridge that prefetches is
> responsible for any latent data not consumed by the master.
> 
> (obviously this is talking about requirements placed on the device, not
> on the OS, but it'd behoove us to help the device out here).
> 
> It's also useful to implement it for slave devices.  PCI 2.3 has the
> concept of cacheline wrap transactions -- eg with a cacheline size of
> 0x10, it can transfer data to 0x108, then 0x10C, 0x100, 0x104, then
> 0x118, etc

As does v2.2 and v2.1.

> So I think we should redo the PCI subsystem to set cacheline size during
> the buswalk rather than waiting for drivers to ask for it to be set.

Agreed, and this is something I'm already doing on ARM in my
pcibios_fixup_bus().

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
