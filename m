Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTDGGhJ (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 02:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTDGGhJ (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 02:37:09 -0400
Received: from granite.he.net ([216.218.226.66]:12044 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263279AbTDGGhA (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 02:37:00 -0400
Date: Sun, 6 Apr 2003 23:51:01 -0700
From: Greg KH <greg@kroah.com>
To: Jens Ansorg <jens@ja-web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB devices in 2.5.xx do not show in /dev
Message-ID: <20030407065101.GA20257@kroah.com>
References: <1049632582.3405.0.camel@lisaserver> <20030406201638.GC18279@kroah.com> <1049696485.3321.16.camel@lisaserver>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049696485.3321.16.camel@lisaserver>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 08:21:26AM +0200, Jens Ansorg wrote:
> On Sun, 2003-04-06 at 22:16, Greg KH wrote:
> > You have to have an actual device for the /dev node to show up.  Do you
> > have any USB devices plugged in?  What does:
> > 	tree /sys/bus/usb/
> > show?
> > 
> 
> yes, I have both, a scanner and a printer plugged into the computer
> 
> but there is nothing under /proc/bus/usb, it's empty

Please see:
	http://www.linux-usb.org/FAQ.html#gs3

You probably have to mount usbfs yourself, as some distro's startup
scripts seem to not like 2.5 and don't do it for you.

> (there is no /sys/ on my PC?)

Make the directory:
	mkdir /sys
and then mount sysfs there:
	mount -t sysfs none /sys

Edit your /etc/fstab to add it so that it is always mounted at startup.

> the usbview application also complains that there is no usbfs although
> it gets registered by the core usb driver

Sounds like you don't have a USB host controller driver getting loaded,
right?  What does lsmod show?

thanks,

greg k-h
