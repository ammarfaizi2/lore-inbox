Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262983AbVDBDd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbVDBDd5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 22:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbVDBDdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 22:33:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:60581 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262983AbVDBDcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 22:32:03 -0500
Date: Fri, 1 Apr 2005 19:31:41 -0800
From: Greg KH <gregkh@suse.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       greg@kroah.com, prarit@sgi.com
Subject: Re: PCI: fix an oops in some pci devices on hotplug remove when their resources are being freed.
Message-ID: <20050402033141.GA16556@kroah.com>
References: <11123992702166@kroah.com> <11123992703458@kroah.com> <20050402011023.GG21986@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050402011023.GG21986@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2005 at 02:10:23AM +0100, Matthew Wilcox wrote:
> On Fri, Apr 01, 2005 at 03:47:50PM -0800, Greg KH wrote:
> > PCI: fix an oops in some pci devices on hotplug remove when their resources are being freed.
> > 
> > As reported by Prarit Bhargava <prarit@sgi.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > diff -Nru a/drivers/pci/remove.c b/drivers/pci/remove.c
> >  	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> >  		struct resource *res = dev->resource + i;
> > -		if (res->parent)
> > +		if (res && res->parent)
> >  			release_resource(res);
> 
> I can't believe this fixes anything.  How can res possibly be NULL here?
> It's a pointer into a pci_dev.

I agree.  However, SGI seems to have some majorly <insert expletive here>
hardware and drivers that cause this line to release a already released
resource.  See the other part of this patch for the part where this
resource is supposedly freed up.

I took the patch as it doesn't hurt anyone, and it gets them off of my
back.  But if you so much as think this patch isn't needed, I'll gladly
revert it, as I'm really not trusting any PCI hotplug patches coming out
from them anymore...

thanks,

greg k-h
