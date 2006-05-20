Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWETEzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWETEzq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 00:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWETEzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 00:55:45 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:61378 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1751231AbWETEzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 00:55:45 -0400
Date: Fri, 19 May 2006 22:55:44 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <greg@kroah.com>
Cc: Patrick Mansfield <patmans@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: dev_printk output
Message-ID: <20060520045544.GD2826@parisc-linux.org>
References: <20060511150015.GJ12272@parisc-linux.org> <20060512170854.GA11215@us.ibm.com> <20060513050059.GR12272@parisc-linux.org> <20060518183652.GM1604@parisc-linux.org> <20060518200957.GA29200@us.ibm.com> <20060519201142.GB2826@parisc-linux.org> <20060519202847.GB8865@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060519202847.GB8865@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 01:28:47PM -0700, Greg KH wrote:
> On Fri, May 19, 2006 at 02:11:42PM -0600, Matthew Wilcox wrote:
> > On Thu, May 18, 2006 at 01:09:57PM -0700, Patrick Mansfield wrote:
> > > Funky how loading sd after sg changes the output ... and using the driver
> > > name as a prefix sometimes messes this up for scsi.
> > > 
> > >  0:0:0:0: Attached scsi generic sg0 type 0
> > > sd 1:0:0:0: Attached scsi generic sg0 type 0
> > 
> > I find that a bit confusing too.  Obviously, we should distinguish
> > different kinds of bus_id from each other somehow -- but isn't the
> > obvious thing to use the bus name?  That must already be unique as sysfs
> > relies on it.  ie this patch:
> 
> Yes, not all devices are on a bus, so this will not work.  And we want
> to know the driver that controls the device too.  So how about adding
> the bus if it's not null?
> 
> Something like (untested):
> 	printk(level "%s %s %s: " format , (dev)->bus ? (dev)->bus->name : "", (dev)->driver ? (dev)->driver->name : "", (dev)->bus_id , ## arg)

Then we still get the inconsistency of device names changing as drivers
are loaded.  I think we should declare it a bug for devices to not be
on a bus.  The only example I have of devices not-on-a-bus are scsi
targets.  I would propose introducing a new scsi_target bus for them,
then removing the 'target' from the start of the bus_id.  Adding them to
the scsi bus looks like it'd be a lot of work.
