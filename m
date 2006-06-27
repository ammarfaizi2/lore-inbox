Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWF0Gbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWF0Gbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 02:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWF0Gbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 02:31:51 -0400
Received: from cantor2.suse.de ([195.135.220.15]:48287 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932118AbWF0Gbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 02:31:51 -0400
Date: Mon, 26 Jun 2006 23:28:32 -0700
From: Greg KH <greg@kroah.com>
To: Razvan Gavril <razvan.g@plutohome.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB & Sysfs Question ( posible issue )
Message-ID: <20060627062832.GA27942@kroah.com>
References: <44A002C3.9000807@plutohome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A002C3.9000807@plutohome.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 06:52:35PM +0300, Razvan Gavril wrote:
> If i had a usb-serial device in linux, i can/could find a symlink in 
> /sys/bus/usb-serial/devices named ttyUSBX that is/was pointing to 
> another sysfs directory, which is in /sys/device. The directory in the 
> /device looked something like this : 
> /devices/pci0000:00/0000:00:02.0/usb1/1-3/1-3:1.0/ttyUSBX . As far i 
> could figure out the '... usb1/1-3/...' part from the path means that 
> the device is connected to the port 3 of the 1st usb controler.

Close, but not quite, as you soon discover:

> I used this for a long of time to uniquely identify phisical usb ports 
> from a computer, when upgrading to 2.6.17, something strange started to 
> happen: even if i didn't remove the usb device from a specified port of 
> a the computer, sometimes when rebooting the usb controlers changed 
> their numbers in sysfs. A device that was before the reboot 
> '...usb1/1-3/...' can be now ' ...usb2/2-3...' or '...usb4/4-3...'.
> 
> The main idea is that an usb port can't no loger be identified only by 
> looking on it's sysfs path. Is this a normal behavior ? I'm asking this 
> as i didn't get this numbering change when using older 2.6 kernel.

The first number is just the number of the USB bus.  That bus number is
simply incremented based on a new USB bus being created.  So, if you
load the USB controller drivers into the kernel in a different order,
you get different bus numbering.

I suggest going one step further up the device chain to the PCI device
itself.  Use the pci device number, as that is bit of a more stable
number (but be aware that it can change across reboots, and bios
upgrades have a tendancy to reorder things, and then there's the mess of
pci hotplug systems...)

Ideally, to solve this problem the best, you would just look at the
unique serial number in your usb-serial device, but unfortunatly, a lot
of them are not unique.  Is this the case for yours?

thanks,

greg k-h
