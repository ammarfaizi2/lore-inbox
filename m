Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751221AbWFEQUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWFEQUw (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 12:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWFEQUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 12:20:52 -0400
Received: from mail.suse.de ([195.135.220.2]:7815 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751221AbWFEQUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 12:20:51 -0400
Date: Mon, 5 Jun 2006 09:18:07 -0700
From: Greg KH <greg@kroah.com>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: udev not called on USB disconnect
Message-ID: <20060605161807.GB26259@kroah.com>
References: <4483EC8C.6070507@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4483EC8C.6070507@rainbow-software.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 10:34:20AM +0200, Ondrej Zary wrote:
> Hello,
> I'm trying to do automount/umount for my Canon camera using udev. The 
> camera does not support mass storage so I'm using gphotofs+fuse to 
> access it.
> I created canon.rules file in /etc/udev/rules.d which contains:
> 
> BUS=="usb", SYSFS{idVendor}=="04a9", SYSFS{idProduct}=="306e", 
> ACTION=="add", RUN+="/usr/bin/gphotofs /mnt/camera -o allow_other"
> BUS=="usb", SYSFS{idVendor}=="04a9", SYSFS{idProduct}=="306e", 
> ACTION=="remove", RUN+="/sbin/umount -f /mnt/camera"

You can't read sysfs values when a device is removed, because those
sysfs files are not present anymore.  Try testing the environment
variables instead.

> (the file contains only two lines).
> When I plug in the camera, the first rule is executed and camera mounted 
> properly. However, disconnecting it does not do anything, the second 
> rule is never executed. I also tried rule as simple as:
> 
> BUS=="usb", RUN+="/bin/touch /123"
> 
> If I understand udev correctly, that should create /123 file on each USB 
> event. It works when connecting the camera but does not do anything on 
> disconnect.

Are you sure that no other rule ahead of this one stopped this rule from
ever being read?

Also, udev questions belong on the linux-hotplug-devel mailing list...

thanks,

greg k-h
