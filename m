Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbWBOBvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbWBOBvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 20:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWBOBvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 20:51:07 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:41174
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932448AbWBOBvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 20:51:06 -0500
From: Rob Landley <rob@landley.net>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Date: Tue, 14 Feb 2006 20:50:58 -0500
User-Agent: KMail/1.8.3
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <43D7C1DF.1070606@gmx.de> <200602141732.22712.rob@landley.net> <20060214233253.GB83161@dspnet.fr.eu.org>
In-Reply-To: <20060214233253.GB83161@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602142050.58687.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 6:32 pm, Olivier Galibert wrote:
> On Tue, Feb 14, 2006 at 05:32:22PM -0500, Rob Landley wrote:
> > On Tuesday 14 February 2006 5:40 am, Olivier Galibert wrote:
> > > Why not have udev and whatever comes after tell the kernel so that a
> > > symlink is done in sysfs?  The kernel not deciding policy do not
> > > prevent it from storing and giving back userland-provided information.
> >
> > That wouldn't help us.  If userspace generates the info, then userspace
> > can drop a note in /dev or something to keep it there.
>
> And all I've been saying is that userspace:
>
> 1- should drop a filesystem-level note, not require calling an
>    executable with a time-varying interface and no real reason to
>    think it will still be in use in a couple of years

If userspace is generating the info it can put it anywhere it wants.

> 2- should drop it in sysfs, because:

Bad idea.

The point of sysfs is to communicate between the kernel and userspace.  Not 
between userspace and userspace.

Specifically, sysfs exports the kernel's view of the machine's hardware 
layout, annotating it with information the kernel is already maintaining 
about that hardware, and allows userspace to poke at that hardware by writing 
new values to some of those fields.

It's not general purpose storage for information the kernel isn't going to 
use.  There _is_ general purpose storage.  This isn't it.

>    a- if it is there and cleanly defined, and "use this netlink
>       message to have a symlink created in sysfs pointing to the node you
>       just created" is clean and simple enough, all the concurrent
>       device-node generating tools will support it quickly (hotplug,
>       udev, mdev, maybe others, who knows)

If it's added, I guarantee you mdev will never set or use it.  It's not 
something we need, or want.

And who says there's only one /dev node for a given sysfs entry?  I've got 
scripts that set up a trivial chroot environment with /dev/null and friends 
all the time.  Nothing says that /dev/cdrom _has_ to be a symlink.

>    b- nothing requires at that point the devices to be in /dev

So what?  Then put the information in whatever directory or directories do 
contain the device nodes.  Or put it in /var/lib/mdev.

>    c- sysfs already manages all the directory hierarchy or naming you
>       need to define uniquely a device, why replicate it somewhere else?

It does not contain ownership or permission because only userspace knows or 
cares what users are in /etc/passwd.  That's not the kernel's business.  Why 
do you want it to contain persistent naming information that has to be 
calculated by userspace in the first place?  Again, it's not the kernel's 
business.

> At that point I guess I just need to make a patch for the kernel side
> and then we'll see.

I'm as happy to ignore a patch implementing a bad idea as I am to ignore the 
idea itself.

>   OG.

Rob
-- 
Never bet against the cheap plastic solution.
