Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289772AbSAOXuj>; Tue, 15 Jan 2002 18:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289769AbSAOXti>; Tue, 15 Jan 2002 18:49:38 -0500
Received: from aldebaran.sra.com ([163.252.31.31]:6017 "EHLO aldebaran.sra.com")
	by vger.kernel.org with ESMTP id <S289768AbSAOXtC>;
	Tue, 15 Jan 2002 18:49:02 -0500
From: David Garfield <garfield@irving.iisd.sra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15428.49056.652466.414438@irving.iisd.sra.com>
Date: Tue, 15 Jan 2002 18:47:44 -0500
To: Greg KH <greg@kroah.com>
Cc: David Garfield <garfield@irving.iisd.sra.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Query about initramfs and modules
In-Reply-To: <20020115233437.GC29020@kroah.com>
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com>
	<20020115233437.GC29020@kroah.com>
X-Mailer: VM 6.96 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:
 > On Tue, Jan 15, 2002 at 06:15:02PM -0500, David Garfield wrote:
 > > 
 > > Can/will the initramfs mechanism be made to implicitly load into the
 > > kernel the modules (or some of the modules) in the image?
 > 
 > Most of the mechanism for loading modules for physical devices will be
 > the /sbin/hotplug interface:
 > 	- when the pci core code scans the pci bus, and finds a new
 > 	  device, it calls out to /sbin/hotplug the pci device
 > 	  information.
 > 	- /sbin/hotplug looks up the pci device info and tries to match
 > 	  it up with a driver that will work for this device (see the
 > 	  linux-hotplug.sf.net site for more info on how this works.)
 > 	- if it finds a module for the device, it calls modprobe on the
 > 	  module, and now that pci device has a module loaded.
 > 
 > Repeat this process for the USB, IEEE1394, and other busses that support
 > MODULE_DEVICE_TABLE in the kernel tree.

Seems like a great idea *after* the system is fully running (or the
root partition is at least mounted).

Seems like overkill to boot most systems.

As I understand it, all that should need to go into the initramfs is
enough to mount the root partition.  Normally, this would probably be
a handful of drivers that are unconditionally known to be needed.  So
why go through several user-mode programs to make a decision that can
be made once and built in?

--David Garfield
