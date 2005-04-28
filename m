Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVD1XgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVD1XgD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 19:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVD1XgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 19:36:02 -0400
Received: from colo.lackof.org ([198.49.126.79]:21909 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262336AbVD1Xfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 19:35:55 -0400
Date: Thu, 28 Apr 2005 17:38:28 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       "David S. Miller" <davem@davemloft.net>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, bjorn.helgaas@hp.com,
       "David S. Miller" <davem@redhat.com>
Subject: Re: pci-sysfs resource mmap broken (and PATCH)
Message-ID: <20050428233828.GI10171@colo.lackof.org>
References: <1114493609.7183.55.camel@gaston> <20050426163042.GE2612@colo.lackof.org> <1114555655.7183.81.camel@gaston> <1114643616.7183.183.camel@gaston> <20050428053311.GH21784@colo.lackof.org> <20050427223702.21051afc.davem@davemloft.net> <1114670353.7182.246.camel@gaston> <20050427235056.0bd09a94.davem@davemloft.net> <20050428151117.GB10171@colo.lackof.org> <1114728447.7182.262.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114728447.7182.262.camel@gaston>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 08:47:27AM +1000, Benjamin Herrenschmidt wrote:
> > Well, if it's a device driver decision, I guess that's ok.
> > And the primary device driver happens to live in user space in X.org case.
> 
> Agreed, but 1) Do you have an idea on how to expose this capability with
> the sysfs interface ? Adding ioctl's to it would suck big time :) and

I don't know enough about VM/TLB stuff to know the right answer.

I suspect the MAP_* attribute/hint needs to be passed in together
with the mmap call if any arch (ia64?) would return a different
virtual address depending the attribute (e.g cached vs uncached).

And write combining might be done in a "layer" below the CPU in
the HW hierarchy. e.g. PCI Host bus controller might combine writes
for some MMIO regions. I don't know if arch specific mmap support
can figure out which HW is the right one to enable write combining
in for a particular MMIO region or PCI device.

I generally don't work with graphics devices and only recently
started poking at infiniband support (128-512MB BAR depending
on card option) to understand really well how BAR is accessed/used.

> 2) It's still nice to have a "workaround" for existing X since the
> performance benefit is significant, but then, it's in arch code, so
> that's fine (and I could indeed limit it to VGA class devices as David
> suggests).

Yup.

thanks,
grant

> 
> Ben.
> 
