Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTJEDyI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 23:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262968AbTJEDyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 23:54:08 -0400
Received: from mail.kroah.org ([65.200.24.183]:14766 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262965AbTJEDyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 23:54:04 -0400
Date: Sat, 4 Oct 2003 20:48:17 -0700
From: Greg KH <greg@kroah.com>
To: reg@dwf.com
Cc: linux-kernel@vger.kernel.org, reg@orion.dwf.com
Subject: Re: trying to get udev running with 2.6.0-test6
Message-ID: <20031005034816.GA9384@kroah.com>
References: <20031004213909.GA8566@kroah.com> <200310050209.h9529gSm002941@orion.dwf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310050209.h9529gSm002941@orion.dwf.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 08:09:42PM -0600, reg@dwf.com wrote:
> 
> I did a couple of greps of the code, found that there was some debugging
> support, changed the syslog to print this stuff out, and ran your two tests.
> 
> My problem is in the same place in both, probably 80 lines or so in, where
> I get the sequence:
> 
>     Oct  4 19:41:52 orion udev: udev_init: sysfs_path = /sysfs
>     Oct  4 19:41:52 orion udev: get_class_dev: looking at    
> /sysfs/class/tty/ttyUSB0
>     Oct  4 19:41:52 orion udev: get_class_dev: sysfs_open_class_device failed
> 
> And, yes your code is smart enough to find the sysfs, nomatter whare it is 
> mounted,
> be that /sys or /sysfs.  For the other test the middle line is replaced with
> 
>     Oct  4 19:57:35 orion udev: get_class_dev: looking at /sysfs/block/sda
> 
> In neither case does the LAST component of the name exist in the real /dev 
> filesystem.

Then the test wouldn't have helped you out any, as it needs those
devices present.  Those tests were what I used in debugging, I need to
build them up into some real test cases.

>     Oct  4 20:06:35 orion kernel: hub 3-0:1.0: new USB device on port 2, 
> assigned address 4
>     Oct  4 20:06:35 orion udev: main: looking at /devices/pci0000:00/0000:00:0d
> .0/usb3/3-2
>     Oct  4 20:06:35 orion udev: main: not block or class
>     Oct  4 20:06:35 orion udev: main: looking at /devices/pci0000:00/0000:00:0d
> .0/usb3/3-2/3-2:2.0
>     Oct  4 20:06:35 orion udev: main: not block or class

Hm, does this USB device actually work on your machine?  Do you have the
usb-storage driver and the scsi stuff loaded?  You need to have that
loaded for udev to be able to work.

> But just a REALLY dumb question, one that should be answered in the README or 
> INSTALL or something.  If this *were* working, where would I expect to
> see the new fs entry appear?  in /udev, in /dev, somewhare else?  Ive
> been looking everywhere, but with the above error, havent seen
> anything yet.

You should see the device node created in /udev.  But it should also
show up in sysfs too, and it doesn't seem like that is hapening, so udev
can't really work yet.

Thanks for putting up with some very rough code.

Hope this helps,

greg k-h
