Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTFEIwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 04:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264523AbTFEIwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 04:52:54 -0400
Received: from granite.he.net ([216.218.226.66]:55561 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264515AbTFEIww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 04:52:52 -0400
Date: Thu, 5 Jun 2003 02:06:45 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
Message-ID: <20030605090645.GA2887@kroah.com>
References: <20030605013147.GA9804@kroah.com> <20030605021452.GA15711@kroah.com> <20030605083815.GA16879@suse.de> <20030605084933.GI2329@kroah.com> <20030605085938.GC16879@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605085938.GC16879@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 09:59:38AM +0100, Dave Jones wrote:
> On Thu, Jun 05, 2003 at 01:49:33AM -0700, Greg KH wrote:
> 
>  > > -	pci_for_each_dev(device)
>  > > +	while ((device = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, device)) != NULL)
>  > > 
>  > > when you could have just added whatever locking pci_find_device() does
>  > > to pci_for_each_dev()  You'd then not have had to touch any of these
>  > > drivers, and it'd look a damn sight better to look at IMO.
>  > 
>  > pci_for_each_dev() is currently a macro, not a function, and I'm trying
>  > to get rid of all public access to the pci lists.  The majority of pci
>  > drivers use the pci_find_device() function in just the way that I
>  > converted the few remaining users of pci_for_each_dev() to (yeah, "few"
>  > is a relative number, but check out how many people call
>  > pci_find_device()...)
>  > 
>  > I guess I could create this to clean it up a bit:
>  > #define pci_find_all_devices(dev)	pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)
>  > 
>  > but that's really not that much of a change...
> 
> so why not..
> 
> #define pci_for_each_dev(dev) \
> 	while ((device = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, device)) != NULL)
> 
> ?
> 
> Seems to be the same change you made tree-wide, with minimal
> interruption to drivers.

But that would have changed the way that pci_for_each_dev() works.  It
would require that dev=NULL before the function is called.  And having
the same function work subtly different on different kernel versions
would not be the best thing.  Getting rid of it entirely was the better
option, and now that Linus has pulled it, we don't have to worry about
it anymore :)

thanks,

greg k-h
