Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUBNL33 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 06:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUBNL33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 06:29:29 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:2067 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261779AbUBNL32
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 06:29:28 -0500
Date: Sat, 14 Feb 2004 12:42:25 +0100
To: Christian Borntraeger <kernel@borntraeger.net>
Cc: Mike Bell <kernel@mikebell.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040214114225.GA19349@hh.idb.hist.no>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040213211920.GH14048@kroah.com> <20040214085110.GG5649@tinyvaio.nome.ca> <200402141013.50633.kernel@borntraeger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402141013.50633.kernel@borntraeger.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 10:13:50AM +0100, Christian Borntraeger wrote:
> Mike Bell wrote:
> > On Fri, Feb 13, 2004 at 01:19:20PM -0800, Greg KH wrote:
> > > > That's a pretty minor difference, from the kernel's point of view.
> > > > It's basically putting the same numbers in different fields.
> > >
> > > Heh, that's a HUGE difference!
> >
> > Only from userspace's point of view. To the kernel, it's basically the
> > same thing.
> 
> No. Giving a major and minor number is simple. 
> Creating a device node means: you have to define a policy. Now the kernel 
> has to think about:
> - user id
> - group id
> - access rights
> - naming
> 
> These are the reasons why devfsd was/is necessary for devfs.
> A Kernel should only enforce a policy, it should not define it.
> 
There is one more security-related point:
We may decide to not make the device node at all, in order
to prevent use of some dangerous/experimental device or driver.
We can't do that if the device is auto-created.

Root is usually capable of running mknod of course,
but it can be prevented. For example with a fs that
starts out rw but is remounted ro with no option for going back.
Or /dev on cdrom . . .

Helge Hafting
