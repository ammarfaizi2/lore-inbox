Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVB1XmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVB1XmC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 18:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVB1XmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 18:42:01 -0500
Received: from peabody.ximian.com ([130.57.169.10]:21200 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261825AbVB1XlD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 18:41:03 -0500
Subject: Re: [RFC] PCI bridge driver rewrite
From: Adam Belay <abelay@novell.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       Jesse Barnes <jbarnes@sgi.com>, len.brown@intel.com
In-Reply-To: <9e4733910502232325118c9ff3@mail.gmail.com>
References: <1109226122.28403.44.camel@localhost.localdomain>
	 <9e473391050223224532239c9d@mail.gmail.com>
	 <1109228638.28403.71.camel@localhost.localdomain>
	 <9e4733910502232325118c9ff3@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 18:39:46 -0500
Message-Id: <1109633986.28403.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 02:25 -0500, Jon Smirl wrote: 
> When you start writing the PCI root bridge driver you'll run into the
> AGP drivers that are already attached to the bridge. I was surprised
> by this since I expected AGP to be attached to the AGP bridge but now
> I learned that it is a root bridge function.

I'm going to have the PCI root bridge driver bind to a device on the
primary side of the bridge.  The device could be enumerated by ACPI or
created manually when the bridge is detected.  It will not, however, be
a PCI device.

> 
> An ISA LPC bridge driver would be nice too. It would let you turn off
> serial ports, etc and let other systems know how many ports there are.
> No real need for this, just a nice toy.

I think this would make a lot of sense.  ACPI could be used to enumerate
child devices for this bridge.  I'd like to begin work on a generic ISA
bus driver soon.

> 
> Does this work to cause a probe based on PCI class?
> static struct pci_device_id p2p_id_tbl[] = {
>        { PCI_DEVICE_CLASS(PCI_CLASS_BRIDGE_PCI << 8, 0xffff00) },
>        { 0 },
> };

Yes, the macro is used when matching against only a class of device.

> 
> I would like to install a driver that gets called whenever new
> CLASS_VGA hardware shows up via hotplug. It won't attach to the
> device, it will just add some sysfs attributes. The framebuffer
> drivers need to attach the device. If I add attributes this way how
> can I remove them?

It would be possible, but probably not a clean solution.  Ideally we
want one driver to bind to the graphics controller and remain bound.  It
will then create class devices for each graphics subsystem, such as
framebuffer.  Much work remains to be done before this can happen.

Thanks,
Adam


