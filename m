Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285048AbSAGSwT>; Mon, 7 Jan 2002 13:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285118AbSAGSwJ>; Mon, 7 Jan 2002 13:52:09 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:7691 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S285062AbSAGSv6>;
	Mon, 7 Jan 2002 13:51:58 -0500
Date: Mon, 7 Jan 2002 10:50:02 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@suse.de>
Cc: Patrick Mochel <mochel@osdl.org>, Paul Jakma <paulj@alphyra.ie>,
        knobi@knobisoft.de, linux-kernel@vger.kernel.org
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
Message-ID: <20020107185001.GK7378@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0201070955480.867-100000@segfault.osdlab.org> <Pine.LNX.4.33.0201071908580.16327-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201071908580.16327-100000@Appserv.suse.de>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 10 Dec 2001 15:13:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 07:11:03PM +0100, Dave Jones wrote:
> On Mon, 7 Jan 2002, Patrick Mochel wrote:
> 
> > One of the ideas that I've kicked around with some people here and the
> > ACPI guys is the notion of trigger device enumeration from userspace
> > completely.
> >
> > During the initramfs stage, a program (say devmgr) figures out what type
> > of system you have, where the PCI buses are, etc. It tells the kernel this
> > information, which then probes for existence, then loads drivers.
> 
> Sounds remarkably like the work that Greg has been doing with hotplug
> support.

Yup :)

But I wanted to rely on the existing PCI and USB core code to do the
probing of the busses and devices, as it knows how to do this the best
right now.  Whenever it finds a new device it calls out to /sbin/hotplug
with the device info.  The userspace program at that location then loads
the proper driver for the device, if it knows about it.  This is the
same code and process that runs when the kernel is up and running today.
No code duplication is a good thing :)

And the /sbin/hotplug program knows about _all_ devices that the
currently compiled kernel can handle due to the MODULE_DEVICE_TABLE tags
in the drivers.

See the linux-hotplug project's documentation for more info on this:
	http://linux-hotplug.sf.net/
A paper and presentation about the linux-hotplug process:
	http://www.kroah.com/linux/

dietHotplug, a _very_ tiny implementation of /sbin/hotplug which is was
created exactly for the initramfs stage:
	http://www.kernel.org/pub/linux/utils/kernel/hotplug/diethotplug-0.3.tar.gz

thanks,

greg k-h
