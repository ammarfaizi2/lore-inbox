Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754501AbWKHKA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501AbWKHKA7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 05:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754502AbWKHKA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 05:00:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:9691 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1754501AbWKHKA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 05:00:57 -0500
Subject: Re: DMA APIs gumble grumble
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20061108092150.GB3405@rhun.haifa.ibm.com>
References: <1162950877.28571.623.camel@localhost.localdomain>
	 <20061108082536.GA3405@rhun.haifa.ibm.com>
	 <1162975653.28571.723.camel@localhost.localdomain>
	 <20061108092150.GB3405@rhun.haifa.ibm.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 21:00:33 +1100
Message-Id: <1162980033.28571.732.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 11:21 +0200, Muli Ben-Yehuda wrote:
> On Wed, Nov 08, 2006 at 07:47:33PM +1100, Benjamin Herrenschmidt wrote:
> 
> > I agree, though, device_ext sucks as a name, you are welcome to propose
> > something better, I'm no good at finding names :-)
> 
> Seems a lot like `pci_sysdata' on x86-64 and i386 with Jeff's PCI
> domains support. dev_sysdata? naming is not my strong suit :-)
> 
> struct pci_sysdata {
> 	int		domain;    /* PCI domain */
> 	int		node;	   /* NUMA node */
> 	void*           iommu;	   /* IOMMU private data */
> };

Interesting... It looks a _lot_ like my device_ext :-)

The reason we don't use PCI sysdata is that currently, our PCI layer
already hijacks it with something else (ugh, I know, it sucks). I'm
pondering consolidating all of this though, but since I need that for
more than PCI, it cannot be just sysdata. Also, as I explained, I'd
prefer having it directly in struct device to avoid one more pointer
indirection in the DMA hot path.

But it looks like if we get that, x86 might be able to move their
sysdata to there.

You might be bad at naming, but I'm worse. Your dev_sysdata wins over my
device_ext imho :-)

So unless I get some better proposal, I'll do a patch introducing that
as an empty struct on all archs, possibly tonmorrow, and then start
migrating things to it.

Cheers,
Ben.


