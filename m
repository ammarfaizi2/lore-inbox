Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTLJIZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 03:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTLJIZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 03:25:35 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:52649
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263130AbTLJIZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 03:25:33 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Greg KH <greg@kroah.com>, Witukind <witukind@nsbm.kicks-ass.org>
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Date: Wed, 10 Dec 2003 02:24:53 -0600
User-Agent: KMail/1.5
Cc: recbo@nishanet.com, linux-kernel@vger.kernel.org
References: <200312081536.26022.andrew@walrond.org> <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org> <20031209075619.GA1698@kroah.com>
In-Reply-To: <20031209075619.GA1698@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312100224.53138.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 December 2003 01:56, Greg KH wrote:
> On Tue, Dec 09, 2003 at 06:17:28AM +0100, Witukind wrote:
> > From the udev FAQ:
> >
> > Q: But udev will not automatically load a driver if a /dev node is opened
> >    when it is not present like devfs will do.
> > A: If you really require this functionality, then use devfs.  It is still
> >    present in the kernel.
> >
> > Will it have this 'equivalent functionality' some day?
>
> Heh, no.  I really don't believe all of the people who keep asking me
> this.  I think I need to reword this answer to something like:
>   A:  That is correct.  If you really require this functionality, then
>       use devfs.  There is no way that udev can support this, and it
>       never will.
>
> That better?  :)
>
> thanks,
>
> greg k-h

I think another way of saying it is that we now have a hotplug infrastructure 
to load the driver on an insert event, so if you want to load the driver for 
something that A) isn't detected on startup, B) isn't detected on a hotplug 
event when it's inserted after startup, the way to do it is to call modprobe, 
not to mknod a random device node and then try to open it and hope some magic 
side effect of open loads the correct module with the right parameters to 
make things work.

The driver is now loaded while the device is attached to the system, not just 
while the device is in use.  (Less races that way, you get to save state 
between invocations, etc.)  The lifetime rules changed.

The old way of doing it assumes you have a device node for a device that has 
no driver loaded, which was the default under the old static /dev but not the 
case in a fully hotplug system.  You have /dev nodes for devices that are in 
the system (with drivers loaded), and you don't for ones that aren't.

Rob

(I could be completely wrong about all this, of course...)
