Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbUDYCu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUDYCu2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 22:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUDYCu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 22:50:28 -0400
Received: from mail.kroah.org ([65.200.24.183]:21419 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262129AbUDYCuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 22:50:21 -0400
Date: Sat, 24 Apr 2004 19:49:00 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-usb-devel@lists.sourceforge.net, vojtech@suse.cz,
       Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Simon Kelley <simon@thekelleys.org.uk>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Message-ID: <20040425024900.GA13971@kroah.com>
References: <200404230142.46792.dtor_core@ameritech.net> <20040423171953.GB13835@kroah.com> <20040423180342.GA14533@kroah.com> <200404240144.05004.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404240144.05004.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2004 at 01:44:04AM -0500, Dmitry Torokhov wrote:
> On Friday 23 April 2004 01:03 pm, Greg KH wrote:
> > On Fri, Apr 23, 2004 at 10:19:53AM -0700, Greg KH wrote:
> > > On Fri, Apr 23, 2004 at 08:31:11AM -0700, Greg KH wrote:
> > > > 
> > > > No, we need to oops, as that's a real bug.  Can you post the whole oops
> > > > that was generated with this usb problem?  I can't seem to duplicate
> > > > this here.
> > > 
> > > Nevermind I dug up a device here that causes this problem.  I'll track
> > > it down...
> > 
> > Ok, here's a patch that fixes it for me.  I was waiting for a good
> > reason to finally get rid of this fake usb_interface structure, and now
> > I have it :)
> > 
> 
> Yes, it does fix it for me, thanks a lot!
> Now if somebody could fix the following oops...

When does that oops happen?  With my patch applied?  Are you yanking out
a device that currently has a userspace progam attached to it?  What
kind of device is it?

Hm, this might solve the problem, can you try the patch below?  It's on
top of my previous patch.

thanks,

greg k-h


--- a/drivers/usb/input/hiddev.c	Fri Apr 23 10:59:52 2004
+++ b/drivers/usb/input/hiddev.c	Sat Apr 24 19:46:29 2004
@@ -233,8 +233,8 @@
 static struct usb_class_driver hiddev_class;
 static void hiddev_cleanup(struct hiddev *hiddev)
 {
-	usb_deregister_dev(hiddev->hid->intf, &hiddev_class);
 	hiddev_table[hiddev->minor] = NULL;
+	usb_deregister_dev(hiddev->hid->intf, &hiddev_class);
 	kfree(hiddev);
 }
 
