Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbTFEIgw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 04:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTFEIgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 04:36:52 -0400
Received: from granite.he.net ([216.218.226.66]:7943 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264514AbTFEIgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 04:36:48 -0400
Date: Thu, 5 Jun 2003 01:49:33 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
Message-ID: <20030605084933.GI2329@kroah.com>
References: <20030605013147.GA9804@kroah.com> <20030605021452.GA15711@kroah.com> <20030605083815.GA16879@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605083815.GA16879@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 09:38:15AM +0100, Dave Jones wrote:
> On Wed, Jun 04, 2003 at 07:14:52PM -0700, Greg KH wrote:
> 
>  > > p.s. I'll send these as patches in response to this email to lkml for
>  > > those who want to see them.
>  > 
>  > I don't think everyone really wants to see all 63 different
>  > pci_for_each_dev() removal patches
> 
> I'm puzzled why you did..
> 
> -	pci_for_each_dev(device)
> +	while ((device = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, device)) != NULL)
> 
> when you could have just added whatever locking pci_find_device() does
> to pci_for_each_dev()  You'd then not have had to touch any of these
> drivers, and it'd look a damn sight better to look at IMO.

pci_for_each_dev() is currently a macro, not a function, and I'm trying
to get rid of all public access to the pci lists.  The majority of pci
drivers use the pci_find_device() function in just the way that I
converted the few remaining users of pci_for_each_dev() to (yeah, "few"
is a relative number, but check out how many people call
pci_find_device()...)

I guess I could create this to clean it up a bit:
#define pci_find_all_devices(dev)	pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)

but that's really not that much of a change...

thanks,

greg k-h
