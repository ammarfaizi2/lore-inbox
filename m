Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275053AbTHLFkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 01:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275050AbTHLFkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 01:40:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:9925 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275053AbTHLFkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 01:40:33 -0400
Date: Mon, 11 Aug 2003 22:38:27 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Robert Love <rml@tech9.net>, CaT <cat@zip.com.au>,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030812053826.GA1488@kroah.com>
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost> <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 03:39:36AM +0100, Matthew Wilcox wrote:
> On Mon, Aug 11, 2003 at 07:18:53PM -0700, Robert Love wrote:
> > Convert GNU-style to C99-style.  I think converting unnamed initializers
> > to named initializers is a Good Thing, too.
> 
> By and large ... here's a counterexample:
> 
> static struct pci_device_id tg3_pci_tbl[] __devinitdata = {
>         { PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5700,
>           PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
>         { PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5701,
>           PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
> ...
> 
> I don't think anyone would appreciate you converting that to:
> 
> static struct pci_device_id tg3_pci_tbl[] __devinitdata = {
> 	{
> 		.vendor		= PCI_VENDOR_ID_BROADCOM,
> 		.device		= PCI_DEVICE_ID_TIGON3_5700,
> 		.subvendor	= PCI_ANY_ID,
> 		.subdevice	= PCI_ANY_ID,
> 		.class		= 0,
> 		.class_mask	= 0,
> 		.driver_data	= 0,
> 	},

I sure would.  Oh, you can drop the .class, .class_mask, and
.driver_data lines, and then it even looks cleaner.

I would love to see that kind of change made for pci drivers.

thanks,

greg k-h
