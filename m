Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUA3RYZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUA3RYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:24:24 -0500
Received: from mail.kroah.org ([65.200.24.183]:25308 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262960AbUA3RX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:23:28 -0500
Date: Fri, 30 Jan 2004 09:23:11 -0800
From: Greg KH <greg@kroah.com>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 015 release
Message-ID: <20040130172310.GB5265@kroah.com>
References: <20040126215036.GA6906@kroah.com> <401A8A35.1020105@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401A8A35.1020105@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 05:45:41PM +0100, Prakash K. Cheemplavam wrote:
> Hi Greg,
> 
> perhaps you remember me being a gentoo user wanting to switch to udev. 
> Well I did so, but am having some problems:
> 
> 1.) Minor one: Nodes for Nvidia (I am using binary display modules 
> 1.0.5328) ar not created. I have to do it by hand each start-up (written 
> into loacal.start.):
> mknod /dev/nvidia0 c 195 0
> mknod /dev/nvidiactl c 195 255

Heh, and you expect me to be able to modify a binary driver to work with
udev how?  :)

You're on your own here...

> 2.) More probelmatic: I am having some serious troubles with my Epson 
> Perfection USB scanner:
> a) I am to dumb to write a rule for it to map it to /dev/usb/scanner0
> 
> I don't exactly know which SYSFS_ field to use as the don't match the 
> lsusb descriptor. I tried various ones, but the scanner always gets 
> mapped to /dev/scanner0. I managed to get my HP printer to be mapped to 
> usb/lp0 by using its serial. This is my (latest non working )line for 
> the scanner:

What does:
	usbinfo -a -p /sys/class/usb/scanner0
say?

That should help you generate a proper rule.

> Now the serious issue: When rebooting or disconnecting the scanner I get 
> a kernel oops:

That's because you shouldn't be using the scanner driver at all :)
Please just use the latest xscane, it can talk to the scanner through
usbfs/libusb with no kernel module needed.  This is a well known bug if
you search the lkml archives...

Hope this helps.

greg k-h
