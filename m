Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263017AbTCWOy3>; Sun, 23 Mar 2003 09:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263074AbTCWOy3>; Sun, 23 Mar 2003 09:54:29 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:59661 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263017AbTCWOy2>; Sun, 23 Mar 2003 09:54:28 -0500
Date: Sun, 23 Mar 2003 16:05:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg KH <greg@kroah.com>
cc: Andries.Brouwer@cwi.nl, <linux-kernel@vger.kernel.org>, <akpm@digeo.com>
Subject: Re: [PATCH] alternative dev patch
In-Reply-To: <20030323081956.GK26145@kroah.com>
Message-ID: <Pine.LNX.4.44.0303231557230.5042-100000@serv>
References: <UTC200303202150.h2KLoEl09978.aeb@smtp.cwi.nl>
 <Pine.LNX.4.44.0303202314210.5042-100000@serv> <20030321012455.GB10298@kroah.com>
 <Pine.LNX.4.44.0303210936590.5042-100000@serv> <20030322013800.GD18835@kroah.com>
 <Pine.LNX.4.44.0303221306350.5042-100000@serv> <20030323081956.GK26145@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 23 Mar 2003, Greg KH wrote:

> > There are a few options:
> > 1. Drivers can implement that themselves:
> 
> Yeah, but as I know, it's a big pain in the butt.  Let's make it easy to
> do this, don't make writing a driver tougher than it has to be (it's
> already much harder than it used to be.)  Andries's patch makes it easy,
> which is a good thing in my book.

Andries' patch doesn't help at all and only makes things worse. Only very 
few drivers should have to deal with the major/minor business. Most 
drivers should just do add_serial_device/add_tape_device/... and these 
function will do the right thing (e.g. announce the new device via sysfs).

> > register_usb_device(...)
> > {
> > 	...
> > 	cdev = cdget(dev);
> > 	down(&cdev->sem);
> > 	if (cdev->fops)
> > 		...;
> > 	cdev->fops = fops;
> > 	up(&cdev->sem);
> > }
> > (see the misc driver again for a detailed example.)
> 
> Look at drivers/usb/core/file.c::usb_open(), it does much the same
> thing.  Well, functionally the same, not identical in any way :)

No, with my patch usb_open() and usb_minors[] could go away completely, 
you just setup everything in usb_register_dev() and the rest is done for 
you.
With Andries' patch you will not get rid of this.

bye, Roman

