Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264737AbTIJIJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 04:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264740AbTIJIJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 04:09:58 -0400
Received: from dp.samba.org ([66.70.73.150]:48534 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264737AbTIJIJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 04:09:55 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module 
In-reply-to: Your message of "Tue, 09 Sep 2003 21:11:22 MST."
             <20030910041122.GE9760@kroah.com> 
Date: Wed, 10 Sep 2003 18:07:35 +1000
Message-Id: <20030910080955.9318E2C0EB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030910041122.GE9760@kroah.com> you write:
> On Wed, Sep 10, 2003 at 01:31:02PM +1000, Rusty Russell wrote:
> > Because kobject does not have a "struct module *owner", we can't
> > simply add in the refcount.
> 
> Um, I don't understand.  There is no "struct module *owner in struct
> kobject.  There is one in struct attribute, but I don't set it, so it
> doesn't matter for this usage.

Your parser broke, I think 8)

> > The module reference count is defined to never go from zero to one
> > when the module is dying, which means callers must use
> > try_module_get().  I grab the reference on read/write, which means
> > opening the file won't hold the module, either.
> 
> read/write of what?  The attribute?  Sure, why not set the module
> attribute sysfs file to the module that way the reference count will be
> incremented if the sysfs file is opened.

Hmm, because there's one attribute: which module would own it?  You're
going to creation attributes per module later (for module parameters),
so when you do that it might make sense to do this too.

> But in looking at your patch, I don't see why you want to separate the
> module from the kobject?  What benefit does it have?

The lifetimes are separate, each controlled by their own reference
count.  I *know* this will work even if someone holds a reference to
the kobject (for some reason in the future) even as the module is
removed.

> > Were you intending to put all the info currently in /proc/modules
> > under sysfs?  Makes sense I think.  For the options you'll need a
> > subdir to avoid name clashes.
> 
> Yes, I was going to add it, this patch was more of a "test" to see how
> receptive you were to it.

More more! 8)

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

