Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUHMPxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUHMPxa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 11:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUHMPxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 11:53:30 -0400
Received: from web14929.mail.yahoo.com ([216.136.225.94]:30363 "HELO
	web14929.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266014AbUHMPxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 11:53:12 -0400
Message-ID: <20040813155312.98961.qmail@web14929.mail.yahoo.com>
Date: Fri, 13 Aug 2004 08:53:11 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: legacy VGA device requirements (was: Exposing ROM's though sysfs)
To: Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200408031818.02836.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What should the API for this look like? We could add a VGA={0/1}
attribute to all the VGA devices in sysfs.

But then how do you:
1) list all of the conflicting VGA devices in a domain?
2) turn off all the VGA devices in a domain?

We could build a bus like directory structure in /sys/class

/sys/class/vga/domain1/vga1/(device/driver/enable)
/sys/class/vga/domain1/vga2/(device/driver/enable)
/sys/class/vga/domain2/vga1/(device/driver/enable)
/sys/class/vga/domain2/vga2/(device/driver/enable)

Then add an enable attribute in the domain directories that would shut
off all of the subdevices.

/sys/class/vga/domain1/enable
/sys/class/vga/domain2/enable

But the vga driver is not going to be attached to a device. Is there an
easy way to build this is sysfs?

--- Jesse Barnes <jbarnes@engr.sgi.com> wrote:

> On Tuesday, August 3, 2004 5:59 pm, Benjamin Herrenschmidt wrote:
> > All this could be very nicely dealt with by the kernel driver.
> 
> So what requirements have we collected so far?
> 
>   o device selection (presumably domain, bus, slot, function)
>     i.e. select the device you'd like to manipulate
>     ioctl?
>   o per-domain & device VGA enable/disable
>     need to disable VGA ports on cards in the same domain and/or bus
>     ioctl?
>   o legacy port I/O
>     for properly routing I/O in multi-domain machines and machines
> where the
>     kernel or firmware may need to trap master aborts
>     read/write?
>   o legacy memory mapping
>     for mapping the legacy VGA framebuffer, may fail
>     mmap?
> 
> Is that a complete list?  Of course, the interface mechanisms are up
> for 
> debate too.  We might be able to do it with per-bus or per-domain
> files in 
> sysfs for the legacy I/O and memory stuff, but that might not
> represent the 
> fact that legacy devices have interdependencies very well (e.g. VGA
> ports 
> must be disabled on device A before we poke device B, etc.).
> 
> Thanks,
> Jesse
> 

=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
