Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266158AbUBJSQb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266146AbUBJSNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:13:46 -0500
Received: from mail.kroah.org ([65.200.24.183]:40846 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266063AbUBJSMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:12:43 -0500
Date: Tue, 10 Feb 2004 10:12:42 -0800
From: Greg KH <greg@kroah.com>
To: Mike Bell <kernel@mikebell.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210181242.GH28111@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <20040210172552.GB27779@kroah.com> <20040210174603.GL4421@tinyvaio.nome.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210174603.GL4421@tinyvaio.nome.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 09:46:04AM -0800, Mike Bell wrote:
> On Tue, Feb 10, 2004 at 09:25:52AM -0800, Greg KH wrote:
> > No that is not what sysfs is about at all.  sysfs exports the internal
> > device tree that the kernel knows so that userspace can use this
> > information for all sorts of different things (proper power management,
> > etc.)  Please go read all of the sysfs and driver model documentation
> > (and OLS and linux.conf.au papers) for more details about what sysfs and
> > the driver core is all about.
> 
> I think you still misunderstand what I'm saying. All I'm saying is that
> with either way, kernel is exporting three pieces of information (b/c,
> major, minor) to userspace through file(s) on an artificial filesystem.

No, that is not true.  devfs exports the device node itself.  It does
not just export the major:minor number.  devfs also does not export the
position within the entire device tree, which sysfs does.  

They are two completely different filesystems, doing two completely
different things.  Please do not confuse them.

> That's it. I know what sysfs is for, I like sysfs the way it is, I'm not
> saying sysfs should be changed in any way. I'm saying that to create a
> device with a given name, udev uses magic files exported by the kernel,
> and devfsd uses magic file(s) exported by the kernel, and in both cases
> they contain the same information. And hence in that sense devfs and
> udev are the same. That's it.

But the main point is that udev is in userspace, and devfs is in the
kernel.  You forgot that :)

> What I'm trying to explain by that point is that udev is no more "naming
> policy in the kernel" free than devfsd. devfsd relies on devfs, which
> has naming policy in the kernel. udev relies on sysfs, which has naming
> policy in the kernel. While devfs and sysfs are radically different,
> they serve the same purpose for devfsd/udev.

sysfs has no such "naming policy".  It merely exports the name that the
kernel happened to give the device, using the LSB naming scheme.  It
does not rely on driver substems to create subdirectories for their
devices, nor export their own nested naming schemes.

sysfs merely exports the info that the kernel knows about a device, by
which udev creates a device node.

devfs exports the device node, and then lets devfsd override that node
and create other stuff.

Please also do not overlook the fragility of the devfs->devfsd
interface.  It is binary, relies on 1 sender and 1 receiver, and doesn't
allow any other programs to get this info.

udev uses the hotplug interface, a well documented, ascii interface that
anyone can hook into by merely dropping a symlink into a subdirectory.

Vastly different.

> > And claiming udev as "a sort of ugly-hack devfsd" is pretty harsh.
> > Given that udev uses a documented, open interface, and easily allows
> > _any_ program to run from it, no matter what the language.  Try reading
> > the devfsd code some time, or getting it to run your perl script to name
> > a single type of device :)
> 
> That's something udev does pretty well, and not quite what I meant. I
> like devfs, defined for the time being as a working tree of device files
> exported by the kernel as a virtual filesystem. For managing
> permissions, user-space-dictated device names, and whatever else, I
> don't care if you call it devfsd or udev or whatever else. I don't like
> udev primarily because it tries to do the job without the help of a
> devfs, and I think trying to do that makes it ugly.

But the point is that udev does not require such a interface as devfs to
get the job done.  devfsd does.

> > If you like devfs, fine, use it.  If you don't, take a look at udev.
> 
> Which was the point of my email. "Hey, I like devfs over udev. Am I
> alone in this, or are there others?" As I stated at the start.

Providing specific examples of what you find lacking in udev would be
constructive.  Saying, "I don't like it as it doesn't feel right to me"
is merely wanting to pick a fight.

I'm done with this thread,

greg k-h
