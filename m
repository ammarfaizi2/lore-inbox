Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269347AbUJFSU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269347AbUJFSU3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 14:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269352AbUJFSU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 14:20:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:23749 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269347AbUJFSUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 14:20:24 -0400
Date: Wed, 6 Oct 2004 11:19:58 -0700
From: Greg KH <greg@kroah.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041006181958.GB27300@kroah.com>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041006173823.GA26740@kroah.com> <20041006180421.GD10153@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006180421.GD10153@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 08:04:21PM +0200, J?rn Engel wrote:
> On Wed, 6 October 2004 10:38:23 -0700, Greg KH wrote:
> > On Tue, Oct 05, 2004 at 08:52:14PM +0200, J?rn Engel wrote:
> > > --- linux-2.6.8cow/init/main.c~console	2004-10-05 20:46:40.000000000 +0200
> > > +++ linux-2.6.8cow/init/main.c	2004-10-05 20:46:08.000000000 +0200
> > > @@ -695,8 +695,11 @@
> > >  	system_state = SYSTEM_RUNNING;
> > >  	numa_default_policy();
> > >  
> > > -	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
> > > +	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0) {
> > >  		printk("Warning: unable to open an initial console.\n");
> > > +		if (open("/dev/null", O_RDWR, 0) == 0)
> > > +			printk("         Falling back to /dev/null.\n");
> > > +	}
> > 
> > Your printk() calls need the proper KERN_* level.
> 
> As does the original one.  Which one would you like for both?

KERN_WARNING perhaps?

> > And what happens if you can't open /dev/null?
> 
> Same as before.
> 
> > (hint, udev enabled boxes
> > usually do not have a /dev/null this early in the boot process).  Does
> > this mean we should add a /dev/null to the initramfs image, like the
> > /dev/console node we currently have there?
> 
> Yes, that would fix the case.  Is this a problem?

I don't have a problem with doing that.

thanks,

greg k-h
