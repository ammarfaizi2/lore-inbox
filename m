Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWEWE0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWEWE0k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 00:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWEWE0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 00:26:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:50877 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751248AbWEWE0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 00:26:40 -0400
Date: Mon, 22 May 2006 21:19:58 -0700
From: Greg KH <gregkh@suse.de>
To: Brice Goglin <brice@myri.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
Message-ID: <20060523041958.GA8415@suse.de>
References: <4468EE85.4000500@myri.com> <20060518155441.GB13334@suse.de> <20060521101656.GM30211@mellanox.co.il> <447047F2.2070607@myri.com> <20060521121726.GQ30211@mellanox.co.il> <44705DA4.2020807@myri.com> <20060521131025.GR30211@mellanox.co.il> <447069F7.1010407@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447069F7.1010407@myri.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 03:24:07PM +0200, Brice Goglin wrote:
> Michael S. Tsirkin wrote:
> >> @@ -925,8 +926,9 @@
> >>  	if (dev->no_msi)
> >>  		return status;
> >>  
> >> -	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
> >> -		return -EINVAL;
> >> +	for (bus = dev->bus; bus; bus = bus->parent)
> >> +		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
> >> +			return -EINVAL;
> >>  
> >>  	temp = dev->irq;
> >>     
> >
> > It seems we must add this loop to pci_enable_msix as well.
> >   
> 
> Right, thanks. Greg, what do you think of putting the attached patch in
> 2.6.17 ?

Ok, does everyone agree that this patch fixes the issues for them?  I've
had a few other private emails saying that the current code doesn't work
properly and hadn't been able to determine what was happening.  Thanks
for these patches.

> By the way, do we need to check dev->no_msi in pci_enable_msix() too ?

Yes, good catch, care to respin the patch and give it a good changelog
entry?

thanks,

greg k-h
