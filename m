Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbULUUS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbULUUS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 15:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbULUUS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 15:18:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:39557 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261617AbULUUSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 15:18:41 -0500
Date: Tue, 21 Dec 2004 12:18:31 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export PCI resources in sysfs
Message-ID: <20041221201830.GA9693@kroah.com>
References: <200412210943.40101.jbarnes@engr.sgi.com> <20041221184355.GB8557@kroah.com> <200412211109.03826.jbarnes@engr.sgi.com> <200412211156.39491.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412211156.39491.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 11:56:39AM -0800, Jesse Barnes wrote:
> On Tuesday, December 21, 2004 11:09 am, Jesse Barnes wrote:
> > > How about wrapping these two #ifdef blocks into one function, and moving
> > > it up in the file under the other #ifdef.  Do that for the other cleanup
> > > function, and it will drop a bunch of #ifdefs.
> >
> > Yeah, that sounds good.  I really don't like adding these ifdefs, and
> > limiting their scope to a function somewhere up above would be nicer.  I'll
> > do that and respin.
> 
> Ok, here you go.
> 
> This patch exports PCI resources to userspace in the corresponding sysfs 
> device directory.  It depends on the platform HAVE_PCI_MMAP code, and is 
> #ifdef'd accordingly.  I've also added documentation describing the sysfs PCI 
> device file layout.
> 
> Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Looks good, I made one tiny change:

> +#else /* !HAVE_PCI_MMAP */
> +static void pci_create_resource_files(struct pci_dev *dev) { return; }
> +static void pci_remove_resource_files(struct pci_dev *dev) { return; }
> +#endif /* HAVE_PCI_MMAP */

I made these inline to have the compiler just "make them go away" for
when that define isn't enabled.

Applied to my trees,

thanks,

greg k-h
