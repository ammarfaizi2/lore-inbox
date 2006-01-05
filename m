Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWAEAzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWAEAzP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWAEAyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:54:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51167 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750964AbWAEAyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:54:36 -0500
Date: Thu, 5 Jan 2006 01:54:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC/RFT][PATCH -mm 2/5] swsusp: userland interface (rev. 2)
Message-ID: <20060105005403.GB1751@elf.ucw.cz>
References: <200601042340.42118.rjw@sisk.pl> <200601042351.58667.rjw@sisk.pl> <20060104234918.GA15983@kroah.com> <20060105001837.GA1751@elf.ucw.cz> <20060105002619.GA16714@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105002619.GA16714@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 04-01-06 16:26:19, Greg KH wrote:
> On Thu, Jan 05, 2006 at 01:18:37AM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > +static int __init snapshot_dev_init(void)
> > > > +{
> > > > +	int error;
> > > > +
> > > > +	error =  alloc_chrdev_region(&interface.devno, 0, 1, interface.name);
> > > > +	if (error)
> > > > +		return error;
> > > > +	cdev_init(&interface.cdev, &snapshot_fops);
> > > > +	interface.cdev.ops = &snapshot_fops;
> > > > +	error = cdev_add(&interface.cdev, interface.devno, 1);
> > > > +	if (error)
> > > > +		goto Unregister;
> > > > +	error = sysfs_create_file(&power_subsys.kset.kobj, &snapshot_attr.attr);
> > > 
> > > Heh, that's a neat hack, register a sysfs file that contains the
> > > major:minor (there is a function that will print that the correct way,
> > > if you really want to do that), in sysfs.  It's better to just register
> > > a misc character device with the name "snapshot", and then udev will
> > > create your userspace node with the proper major:minor all automatically
> > > for you.
> > > 
> > > Unless you want to turn these into syscalls :)
> > 
> > Well, I think we simply want to get static major/minor allocated for
> > this device. It really uses read/write, IIRC, so no, I do not think we
> > want to make it a syscall.
> 
> Ok, then I'd recommend using the misc device, dynamic for now, and
> reserve one when you get a bit closer to merging into mainline.

I'd say that "memory devices", character, major 1 is appropriate for
this. 13 seems to be free ("swsusp can be unlucky for your data"? :-).

								Pavel
-- 
Thanks, Sharp!
