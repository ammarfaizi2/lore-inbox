Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbULUSxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbULUSxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 13:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbULUSxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 13:53:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:63169 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261834AbULUSw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 13:52:56 -0500
Date: Tue, 21 Dec 2004 10:52:36 -0800
From: Greg KH <greg@kroah.com>
To: Tomas Carnecky <tom@dbservice.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Is it possible to access sysfs from within the kernel?
Message-ID: <20041221185236.GA8656@kroah.com>
References: <41C48B3F.8010709@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C48B3F.8010709@dbservice.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2004 at 08:55:43PM +0100, Tomas Carnecky wrote:
> Why? Lets see.
> Sysfs describes the system with all its devices etc but is also an 
> interface to access kernel internal data.
> Sysfs data could easily be put into a hierarchical tree. (I think it 
> even is, but it's not so obvious, because it's done using the fs code 
> (inodes, dentries), maybe the kobjects do play a big role here, too).
> To access sysfs from an application, you have to use extensively open() 
> and close() for each file (attributes) and readdir for directories... or 
> use libsysfs which does these things for you.
> While the current design is good for users (cat /sys/.../.../attribute), 
> it's not very efficient for applications (due to the many syscalls).

Why not?  Do you have numbers showing that this is inefficient?  Have
you looked at using libsysfs to make it easier for your program to
access sysfs?

> IMO it would be much better (for the applications) to have a device node 
> in /dev which could be used to access the sysfs tree. No ioctl but using 
> simple packets.

No, please just use the filesystem.

> Besides the simple query/result things, you could register for recieving 
> events (now hotplug),

And netlink.

> with the difference that the current hotplug 
> (AFAIK) can inform (execute) only one application (/sbin/hotplug).

Not true.  Please read the /sbin/hotplug script to find out how your
program can get those notifications.

> Or even make it possible to recieve events only from certain 
> classes/devices/subsystems etc.

It does that already today.  Again, please read the documentation that
is already included in the program.

thanks,

greg k-h
