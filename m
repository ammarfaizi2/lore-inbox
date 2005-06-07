Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVFGFQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVFGFQH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 01:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVFGFQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 01:16:07 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:45157 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261717AbVFGFQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 01:16:03 -0400
Date: Mon, 6 Jun 2005 22:15:51 -0700
From: Greg KH <gregkh@suse.de>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       tom.l.nguyen@intel.com, roland@topspin.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers
Message-ID: <20050607051551.GA17734@suse.de>
References: <20050607002045.GA12849@suse.de> <20050607010911.GA9869@plap.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607010911.GA9869@plap.qlogic.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 06:09:11PM -0700, Andrew Vasquez wrote:
> On Mon, 06 Jun 2005, Greg KH wrote:
> 
> > 
> > Ok, as it seems there is a bit of confusion, here's real code that
> > should help explain what I am proposing.  This works on my desktop, but
> > I don't think it supports MSI :)
> > 
> > I'll go dig out an old 4-way AMD box that has MSI to see if this still
> > works properly, but comments are welcome.
> 
> 
> Thanks for posting some sample code.  Some comments though:
> 
> * What if the driver writer does not want MSI enabled for their
>   hardware (even though there is an MSI capabilities entry)?  Reasons
>   include: overhead involved in initiating the MSI; no support in some
>   versions of firmware (QLogic hardware).

Yes, a very good point.  I guess I should keep the pci_enable_msi() and
pci_disable_msi() functions exported for this reason.

> * A device (notably, our 4gb PCIe fibre-channel products) can support
>   both MSI and MSI-X.  Since the driver has no way of 'disabling' MSI,
>   how would it enable MSI-X?

Agreed, let me respin the patches again, because I think I got the logic
wrong on some of these drivers because of this...

thanks,

greg k-h
