Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267808AbUG3WSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267808AbUG3WSE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 18:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267860AbUG3WSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 18:18:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:57229 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267808AbUG3WRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 18:17:46 -0400
Date: Fri, 30 Jul 2004 14:39:25 -0700
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040730213925.GA31789@kroah.com>
References: <200407301409.05638.jbarnes@engr.sgi.com> <20040730212930.GA30979@kroah.com> <200407301434.50373.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407301434.50373.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 02:34:50PM -0700, Jesse Barnes wrote:
> > > +void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
> > > +{
> > > +	/* Don't need to free config entries since they're static & global */
> >
> > What do you mean by this?  You should still remove all files we added in
> > the pci_create_sysfs_dev_files() function here, not just the rom file.
> 
> What will happen if we don't?

Then the driver core will clean them up, like it does today :)

But it's "not nice", and we should clean them up as we now have a
function in which we can do that, and based on changes we have planned
for the driver core in the future, it will be something that is required
to do later on.  Might as well do it now, as you are modifying the same
code...

thanks,

greg k-h
