Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUFVXwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUFVXwy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 19:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbUFVXwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 19:52:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:35719 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264530AbUFVXww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 19:52:52 -0400
Date: Tue, 22 Jun 2004 16:51:26 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core patches for 2.6.7
Message-ID: <20040622235126.GG13197@kroah.com>
References: <1087926108744@kroah.com> <200406221821.02128.dtor_core@ameritech.net> <20040622233139.GF13197@kroah.com> <200406221844.38299.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406221844.38299.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 06:44:38PM -0500, Dmitry Torokhov wrote:
> On Tuesday 22 June 2004 06:31 pm, Greg KH wrote:
> > On Tue, Jun 22, 2004 at 06:21:01PM -0500, Dmitry Torokhov wrote:
> > > On Tuesday 22 June 2004 12:41 pm, Greg KH wrote:
> > > 
> > > >  
> > > >  void class_unregister(struct class * cls)
> > > >  {
> > > >  	pr_debug("device class '%s': unregistering\n",cls->name);
> > > > +	remove_class_attrs(cls);
> > > >  	subsystem_unregister(&cls->subsys);
> > > >  }
> > > >  
> > > 
> > > Question: is it necessary to call remove_class_attrs? I thought that sysfs
> > > automatically destroys all children when parent is destroyed? Am I imagining
> > > things?
> > 
> > No, you aren't imagining things.  But it's considered "good form" to
> > remove them if you can, as this will probably change in 2.7, and it will
> > make my life easier trying to audit the whole tree at that time...
> > 
> 
> Is there any specific reason for such a change? I kinda like the idea of
> registering attributes and then having driver code do the bean counting
> for me.

Watch out if your driver is unloaded, but the device is still hanging
around.  If that could happen, you need to get rid of those attributes.

But the main reason is we want to split attributes out of sysfs to make
sysfs simpler, and provide the ability for other representations of the
driver tree other than sysfs.  But more about this at the kernel
summit...

> Btw, is there a chance for platform_device_register_simple that I sent to
> you earlier be included?

Yes, it's in my todo queue, trying to catch up on older patches still,
will get to it by the end of the week, sorry for the delay.

thanks,

greg k-h
