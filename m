Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbSKYXh3>; Mon, 25 Nov 2002 18:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbSKYXh3>; Mon, 25 Nov 2002 18:37:29 -0500
Received: from dp.samba.org ([66.70.73.150]:4840 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263991AbSKYXhZ>;
	Mon, 25 Nov 2002 18:37:25 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, perex@suse.cz,
       "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: [PATCH] Module alias and table support 
In-reply-to: Your message of "Mon, 25 Nov 2002 13:36:17 -0800."
             <20021125213617.GA25269@kroah.com> 
Date: Tue, 26 Nov 2002 10:42:14 +1100
Message-Id: <20021125234441.00C332C25F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021125213617.GA25269@kroah.com> you write:
> On Mon, Nov 25, 2002 at 10:34:16AM +1100, Rusty Russell wrote:
> > > > +        /* not matched against */
> > > > +        kernel_long     driver_info;
> > > 
> > > Or is it because of "kernel_long"?  I'm pretty sure this field is only
> > > used within the kernel, and userspace does not care at all about it.
> > 
> > It sucks to reproduce this, yes.  But you need to know the size of the
> > structure to grab it out of the object file.  At least this way it's
> > in the kernel source where we can change it.
> 
> But can't we still just use the structure from the kernel header and not
> have to retype it here?  If needed, we can change the type of
> driver_info into something more portable than what it is today.  That
> would be much easier in the long run.

Absolutely.  But I didn't want to mess with your headers.

> > 	Which will simply match the alias such as:
> > 		usb:v0506p4601dl*dh*dc*dsc*dp*ic*isc*ip*
> 
> Ah, you never told me about this plan :)

Oh, so I didn't explain the "clever" part of my clever plan?  Oops.

> Yes, that would be very nice to have, pushing the logic out of the
> /sbin/hotplug code and into modprobe doesn't bother me.  That just saved
> a _whole_ bunch of space in diethotplug, so you've made up for making
> the size smaller.
> 
> How would modprobe know which driver to load based on the above line?
> Are you going to scan all module files, or rely on something like the
> modules.*map files of today?

0.7 scans all the files (since it has no modules.dep and needs the
dependencies anyway).  0.8 reintroduces modules.dep (thanks Adam!)
which is where the alias info logically belongs ("stuff extracted from
modules").  Or maybe a separate file (implementation handwave).

> Just realize that if you pre-process the information like you are
> proposing to do, you can't get it back later, which changes the way
> things work.

Well, you could, by sucking out the aliases which start with "usb:"
(the post-processing just turns the tables into aliases, doesn't
delete them or anything).  You could also use the old-fashioned way
and suck it from the tables directly, but then you're back in
"intimate knowledge of kernel internals" land.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
