Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWAEAtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWAEAtm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWAEAtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:49:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:52921 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750936AbWAEAtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:41 -0500
Date: Wed, 4 Jan 2006 16:26:19 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC/RFT][PATCH -mm 2/5] swsusp: userland interface (rev. 2)
Message-ID: <20060105002619.GA16714@kroah.com>
References: <200601042340.42118.rjw@sisk.pl> <200601042351.58667.rjw@sisk.pl> <20060104234918.GA15983@kroah.com> <20060105001837.GA1751@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105001837.GA1751@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 01:18:37AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > +static int __init snapshot_dev_init(void)
> > > +{
> > > +	int error;
> > > +
> > > +	error =  alloc_chrdev_region(&interface.devno, 0, 1, interface.name);
> > > +	if (error)
> > > +		return error;
> > > +	cdev_init(&interface.cdev, &snapshot_fops);
> > > +	interface.cdev.ops = &snapshot_fops;
> > > +	error = cdev_add(&interface.cdev, interface.devno, 1);
> > > +	if (error)
> > > +		goto Unregister;
> > > +	error = sysfs_create_file(&power_subsys.kset.kobj, &snapshot_attr.attr);
> > 
> > Heh, that's a neat hack, register a sysfs file that contains the
> > major:minor (there is a function that will print that the correct way,
> > if you really want to do that), in sysfs.  It's better to just register
> > a misc character device with the name "snapshot", and then udev will
> > create your userspace node with the proper major:minor all automatically
> > for you.
> > 
> > Unless you want to turn these into syscalls :)
> 
> Well, I think we simply want to get static major/minor allocated for
> this device. It really uses read/write, IIRC, so no, I do not think we
> want to make it a syscall.

Ok, then I'd recommend using the misc device, dynamic for now, and
reserve one when you get a bit closer to merging into mainline.

thanks,

greg k-h
