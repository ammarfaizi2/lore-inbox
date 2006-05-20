Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWETVjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWETVjv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 17:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWETVjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 17:39:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:62888 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932384AbWETVju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 17:39:50 -0400
Date: Sat, 20 May 2006 14:21:35 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Patrick Mansfield <patmans@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: dev_printk output
Message-ID: <20060520212135.GB24672@kroah.com>
References: <20060511150015.GJ12272@parisc-linux.org> <20060512170854.GA11215@us.ibm.com> <20060513050059.GR12272@parisc-linux.org> <20060518183652.GM1604@parisc-linux.org> <20060518200957.GA29200@us.ibm.com> <20060519201142.GB2826@parisc-linux.org> <20060519202847.GB8865@kroah.com> <20060520045544.GD2826@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520045544.GD2826@parisc-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 10:55:44PM -0600, Matthew Wilcox wrote:
> On Fri, May 19, 2006 at 01:28:47PM -0700, Greg KH wrote:
> > On Fri, May 19, 2006 at 02:11:42PM -0600, Matthew Wilcox wrote:
> > > On Thu, May 18, 2006 at 01:09:57PM -0700, Patrick Mansfield wrote:
> > > > Funky how loading sd after sg changes the output ... and using the driver
> > > > name as a prefix sometimes messes this up for scsi.
> > > > 
> > > >  0:0:0:0: Attached scsi generic sg0 type 0
> > > > sd 1:0:0:0: Attached scsi generic sg0 type 0
> > > 
> > > I find that a bit confusing too.  Obviously, we should distinguish
> > > different kinds of bus_id from each other somehow -- but isn't the
> > > obvious thing to use the bus name?  That must already be unique as sysfs
> > > relies on it.  ie this patch:
> > 
> > Yes, not all devices are on a bus, so this will not work.  And we want
> > to know the driver that controls the device too.  So how about adding
> > the bus if it's not null?
> > 
> > Something like (untested):
> > 	printk(level "%s %s %s: " format , (dev)->bus ? (dev)->bus->name : "", (dev)->driver ? (dev)->driver->name : "", (dev)->bus_id , ## arg)
> 
> Then we still get the inconsistency of device names changing as drivers
> are loaded.

The bus id doesn't change, just the "hint" as to who is controling it at
that point in time.  Which is something that is needed/wanted by a lot
of people.

> I think we should declare it a bug for devices to not be on a bus.

No!  We have a few places already that are devices with no related bus,
and are only getting more and more with the shift away from class_device
to device (see a patch in my quilt tree that allows this.)

thanks,

greg k-h
