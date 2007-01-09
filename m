Return-Path: <linux-kernel-owner+w=401wt.eu-S1751126AbXAIHN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbXAIHN6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 02:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbXAIHN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 02:13:57 -0500
Received: from cantor2.suse.de ([195.135.220.15]:55731 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbXAIHN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 02:13:57 -0500
Date: Mon, 8 Jan 2007 23:13:21 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kay Sievers <kay.sievers@novell.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Driver core: fix refcounting bug
Message-ID: <20070109071321.GA5679@kroah.com>
References: <Pine.LNX.4.44L0.0701081103530.4249-100000@iolanthe.rowland.org> <20070108202359.1e7a6670.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108202359.1e7a6670.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 08:23:59PM -0800, Andrew Morton wrote:
> On Mon, 8 Jan 2007 11:06:44 -0500 (EST)
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > This patch (as832) fixes a newly-introduced bug in the driver core.
> > When a kobject is assigned to a kset, it must acquire a reference to
> > the kset.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > ---
> > 
> > The bug was introduced in Kay's "unify /sys/class and /sys/bus at 
> > /sys/subsystem" patch.
> > 
> > I left the assignment of class_dev->kobj.parent as it was, although it is 
> > not needed.  The following call to kobject_add() will end up doing the 
> > same thing.
> > 
> > Alan Stern
> > 
> > P.S.: Tracking down refcounting bugs is a real pain!  I spent an entire 
> > afternoon on this one...  :-(
> > 
> > 
> > Index: usb-2.6/drivers/base/class.c
> > ===================================================================
> > --- usb-2.6.orig/drivers/base/class.c
> > +++ usb-2.6/drivers/base/class.c
> > @@ -648,7 +648,7 @@ int class_device_add(struct class_device
> >  		class_dev->kobj.parent = &parent_class_dev->kobj;
> >  	else {
> >  		/* assign parent kset for uevent hook */
> > -		class_dev->kobj.kset = &parent_class->devices_dir;
> > +		class_dev->kobj.kset = kset_get(&parent_class->devices_dir);
> >  		/* the device directory in /sys/subsystem/<name>/devices */
> >  		class_dev->kobj.parent = &parent_class->devices_dir.kobj;
> >  	}
> 
> OK, I give up.  What kernel is this against?

I think this is against my private tree, with the "driver-class" patches
that are not in -mm (for good reason at this point in time.)  Right
Alan?

thanks,

greg k-h
