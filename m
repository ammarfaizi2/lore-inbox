Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289746AbSAOXih>; Tue, 15 Jan 2002 18:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289752AbSAOXi2>; Tue, 15 Jan 2002 18:38:28 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:48911 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289746AbSAOXiG>;
	Tue, 15 Jan 2002 18:38:06 -0500
Date: Tue, 15 Jan 2002 15:34:37 -0800
From: Greg KH <greg@kroah.com>
To: David Garfield <garfield@irving.iisd.sra.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Query about initramfs and modules
Message-ID: <20020115233437.GC29020@kroah.com>
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 18 Dec 2001 20:22:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 06:15:02PM -0500, David Garfield wrote:
> 
> Can/will the initramfs mechanism be made to implicitly load into the
> kernel the modules (or some of the modules) in the image?

Most of the mechanism for loading modules for physical devices will be
the /sbin/hotplug interface:
	- when the pci core code scans the pci bus, and finds a new
	  device, it calls out to /sbin/hotplug the pci device
	  information.
	- /sbin/hotplug looks up the pci device info and tries to match
	  it up with a driver that will work for this device (see the
	  linux-hotplug.sf.net site for more info on how this works.)
	- if it finds a module for the device, it calls modprobe on the
	  module, and now that pci device has a module loaded.

Repeat this process for the USB, IEEE1394, and other busses that support
MODULE_DEVICE_TABLE in the kernel tree.

> Doing so would allow the initramfs image to be composed solely of the
> modules to be loaded, which would reduce the need for the "klibc".  It
> would also eliminate the need for any sort of control script to be in
> the image.

klibc (or some libc) is needed to build /sbin/hotplug, and modprobe in
this scenario.

greg k-h
