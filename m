Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263263AbTECGWw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 02:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTECGWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 02:22:52 -0400
Received: from granite.he.net ([216.218.226.66]:46865 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263263AbTECGWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 02:22:51 -0400
Date: Fri, 2 May 2003 23:36:33 -0700
From: Greg KH <greg@kroah.com>
To: David Ford <david+cert@blue-labs.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       apcupsd-devel@apcupsd.org
Subject: Re: APC USB ups, Back-UPS ES series, 2.5.68
Message-ID: <20030503063632.GA2769@kroah.com>
References: <3EB331B5.4080306@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB331B5.4080306@blue-labs.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 11:04:21PM -0400, David Ford wrote:
> (Please cc: me on reply)
> 
> I'm wanting to get this new toy up and running.  I've installed apcupsd, 
> but it doesn't want to work well with my kernel (2.5.68) or somewhat.
> 
> When apcupsd tries to open the hiddev, open() gets an ENODEV.  Is 
> apcupsd doing something wrong or is 2.5.68 doing something wrong?
> 
> ~# dmesg
> hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
> hub 1-0:0: new USB device on port 1, assigned address 4
> usb 1-1: new device strings: Mfr=3, Product=1, SerialNumber=2
> usb 1-1: Product: Back-UPS ES 350 FW:800.e3.D USB FW:e3
> usb 1-1: Manufacturer: APC
> usb 1-1: SerialNumber: AB0238241677 
> usb 1-1: usb_new_device - registering interface 1-1:0
> hid 1-1:0: usb_device_probe
> hid 1-1:0: usb_device_probe - got id
> drivers/usb/core/file.c: asking for 1 minors, starting at 96
> drivers/usb/core/file.c: found a minor chunk free, starting at 96
> hiddev96: USB HID v1.10 Device [APC Back-UPS ES 350 FW:800.e3.D USB 
> FW:e3] on usb-00:07.2-1
> 
> 
> ~# ls -l /dev/usb/hid
> total 0
> crw-r--r--    1 root     root     180, 192 Dec 31  1969 hiddev96
> crw-r--r--    1 root     root     180, 193 Dec 31  1969 hiddev97

Huh?  /dev/usb/hiddev0 is major 180, minor 96.  So the kernel asked for
minor 96 and it got it.  Why are you trying to connect to minor number
192?

For a list of the USB minor numbers see:
	http://www.linux-usb.org/usb.devices.txt

It's a bit different from Documentation/devices.txt, I need to send the
updates to lanana.org someday...

thanks,

greg k-h
