Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267821AbUG3UUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267821AbUG3UUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267819AbUG3UUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:20:06 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:29891 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267821AbUG3URH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:17:07 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Exposing ROM's though sysfs
Date: Fri, 30 Jul 2004 13:16:14 -0700
User-Agent: KMail/1.6.2
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Matthew Wilcox <willy@debian.org>,
       Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <20040730165339.76945.qmail@web14929.mail.yahoo.com> <200407301149.39256.jbarnes@engr.sgi.com> <20040730195539.GA30466@kroah.com>
In-Reply-To: <20040730195539.GA30466@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301316.14836.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 30, 2004 12:55 pm, Greg KH wrote:
> On Fri, Jul 30, 2004 at 11:49:39AM -0700, Jesse Barnes wrote:
> > +
> > +	/* If the device has a ROM, map it */
> > +	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
> > +		pci_rom_attr.size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
> > +		sysfs_create_bin_file(&pdev->dev.kobj, &pci_rom_attr);
> > +	}
>
> Doesn't this code cause _all_ rom sizes to be the same, as you only have
> 1 pci_rom_attr variable?  You should create a new one for every pci
> device (making sure to clean it up when the device is removed.)

Yep, that's pretty broken.  I guess I need to allocate a pci_rom_attr every 
time we see a ROM...  Where would the cleanup code go though?  In one of the 
hotplug remove paths?

Jesse
