Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTEWBbv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 21:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbTEWBbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 21:31:50 -0400
Received: from dp.samba.org ([66.70.73.150]:16833 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263573AbTEWBbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 21:31:47 -0400
Date: Fri, 23 May 2003 10:53:51 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: Displaying/modifying PCI device id tables via sysfs
Message-Id: <20030523105351.2ba4f9b2.rusty@rustcorp.com.au>
In-Reply-To: <20030303182553.GG16741@kroah.com>
References: <20BF5713E14D5B48AA289F72BD372D680392F82C-100000@AUSXMPC122.aus.amer.dell.com>
	<20030303182553.GG16741@kroah.com>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003 10:25:53 -0800
Greg KH <greg@kroah.com> wrote:

> On Mon, Mar 03, 2003 at 11:57:05AM -0600, Matt Domsch wrote:
> > A lot of PCI drivers today use the pci_device_id table model to specify 
> > what IDs the driver supports.  I'd like to be able to do 2 things with 
> > this information:
> > 1) display it in sysfs
> 
> That info is already exported to userspace through the modules.pcimap
> file.

Matt's patch just went into Linus' tree, so I'll comment on this.

More importantly, the modules now contain suitable aliases embedded within
them: modules.pcimap et al will vanish before 2.6 whenever Greg (hint hint)
updates the hotplug scripts to use them instead of modules.XXXmap.

So the question is, how do you add PCI IDs to a module which isn't loaded?
You can trivially add a new alias for it, which will cause modprobe to
find it, but the module won't know it can handle the new PCI ID, and
will fail to load.

Obvious options include:
	just update the damn module
	inserting the new PCI entry in the module (simple, but icky)
	adding a module param to say "add these IDs"

I agree with Alan (and Jeff Garzik who pointed this out to me before)
that it's neat to be able to update these tables on the fly, but that
is probably even more important for modules which aren't loaded.

Matt, do you have thoughts on this?

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
