Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUDADsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 22:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbUDADsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 22:48:37 -0500
Received: from netrider.rowland.org ([192.131.102.5]:27399 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S262114AbUDADsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 22:48:36 -0500
Date: Wed, 31 Mar 2004 22:48:35 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       David Brownell <david-b@pacbell.net>, <viro@math.psu.edu>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
In-Reply-To: <1080784568.1435.37.camel@gaston>
Message-ID: <Pine.LNX.4.44L0.0403312245460.30492-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004, Benjamin Herrenschmidt wrote:

> > But that is impossible as has already been pointed out by Alan Stern.
> > If a module creates a kobject, how can the module_exit() function ever
> > be called if that kobject incremented the module reference count?
> 
> I just had a loooong discussion with Rusty on that subject, it's
> indeed a nasty one. The problem is that the real solution is to
> change the module unload semantics. Regardless of the count, module
> exit should be called, and the actual unload (and eventually calling
> an additional module "release" function) then should only happen
> once the count is down to 0. That means that rmmod would block forever
> if the driver is opened, but that is just something that needs to be
> known.
> 
> But that's not something we'll do for 2.6. For that to work, it also
> need various subsystem unregister_* (netdev etc...) functions to not
> error when the device is opened, just prevent new opens, and operate
> asynchronously (freeing data structures on kobject release) etc...

There was another lengthy discussion about this back in January.  Read 
these threads:

http://marc.theaimsgroup.com/?t=107487731800002&r=1&w=2
http://marc.theaimsgroup.com/?t=107509479200002&r=1&w=2

Lots of back-and-forth, but Linus was basically against the idea.  For 
now at least.

Alan Stern

