Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUBJSaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266030AbUBJS3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:29:46 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:141 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S266222AbUBJS3P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:29:15 -0500
Date: Tue, 10 Feb 2004 10:29:44 -0800
From: Mike Bell <kernel@mikebell.org>
To: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210182943.GO4421@tinyvaio.nome.ca>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <20040210172552.GB27779@kroah.com> <20040210174603.GL4421@tinyvaio.nome.ca> <20040210181242.GH28111@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210181242.GH28111@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 10:12:42AM -0800, Greg KH wrote:
> No, that is not true.  devfs exports the device node itself.  It does
> not just export the major:minor number.

That's a pretty minor difference, from the kernel's point of view. It's
basically putting the same numbers in different fields.

> devfs also does not export the position within the entire device tree,
> which sysfs does.  

devfs tried to do just that. sysfs does it better though. I don't see
what that has to do with my point.

> They are two completely different filesystems, doing two completely
> different things.  Please do not confuse them.

sysfs and devfs are very different. I said they both accomplish one
common goal, sysfs for udev and devfs for devfsd.

> But the main point is that udev is in userspace, and devfs is in the
> kernel.  You forgot that :)

No I didn't. udev is userspace, devfsd is userspace. devfs is kernel
space, sysfs is kernel space. They're the same.

> sysfs has no such "naming policy".  It merely exports the name that the
> kernel happened to give the device, using the LSB naming scheme.  It
> does not rely on driver substems to create subdirectories for their
> devices, nor export their own nested naming schemes.

But sysfs is still setting naming policy in the kernel. Because you
didn't write the kernelspace static names in question, they don't exist?

> sysfs merely exports the info that the kernel knows about a device, by
> which udev creates a device node.

devfs merely exports information the kernel knows, by which devfsd can
create device nodes.

> devfs exports the device node, and then lets devfsd override that node
> and create other stuff.

And sysfs exports files that are (from a kernel point of view) very
nearly a device node.

> Please also do not overlook the fragility of the devfs->devfsd
> interface.  It is binary, relies on 1 sender and 1 receiver, and doesn't
> allow any other programs to get this info.

Didn't say the current devfs was a good implementation of the concept.
Said I liked a devfs-like concept.

> But the point is that udev does not require such a interface as devfs to
> get the job done.  devfsd does.

Yes it does, it requires sysfs.

> Providing specific examples of what you find lacking in udev would be
> constructive.  Saying, "I don't like it as it doesn't feel right to me"
> is merely wanting to pick a fight.

udev tries to do the job without a devfs. I said that already. I think
there should be a kernel exported filesystem with kernel-created device
nodes, and that udev's role should continue to do something similar to what it
does now (manage permissions and user-supplied names), only on that
kernel-exported filesystem.
