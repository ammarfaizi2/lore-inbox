Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbWDMXPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWDMXPM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWDMXOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:14:52 -0400
Received: from ns1.suse.de ([195.135.220.2]:14024 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965032AbWDMXOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:14:42 -0400
Date: Thu, 13 Apr 2006 16:13:30 -0700
From: Greg KH <gregkh@suse.de>
To: tyler@agat.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kmod optimization
Message-ID: <20060413231330.GA6760@suse.de>
References: <20060413180345.GA10910@Starbuck> <20060413182401.GA26885@suse.de> <20060413183617.GB10910@Starbuck> <20060413185014.GA27130@suse.de> <20060413190412.GA30541@Starbuck>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413190412.GA30541@Starbuck>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 09:04:12PM +0200, tyler@agat.net wrote:
> On Thu, Apr 13, 2006 at 11:50:14AM -0700, Greg KH wrote:
> > On Thu, Apr 13, 2006 at 08:36:17PM +0200, tyler@agat.net wrote:
> > > On Thu, Apr 13, 2006 at 11:24:01AM -0700, Greg KH wrote:
> > > > On Thu, Apr 13, 2006 at 08:03:45PM +0200, tyler@agat.net wrote:
> > > > > Hi,
> > > > > 
> > > > > the request_mod functions try to load automatically a module by running
> > > > > a user mode process helper (modprobe).
> > > > > 
> > > > > The user process is launched even if the module is already loaded. I
> > > > > think it would be better to test if the module is already loaded.
> > > > 
> > > > Does this cause a problem somehow?  request_mod is called _very_
> > > > infrequently from a normal kernel these days, so I really don't think
> > > > this is necessary.
> > > 
> > > Yes I agree it _should_ be very infrequently called but it _will_ be very
> > > infrequently called just if the user space configuration is done properly.
> > 
> > What do you mean by this?  Almost all 2.6 distros use udev today, which
> > prevents this code from ever getting called.  So odds are, you are
> > optimising something that no one will ever use :)
> Well perhaps I don't understand the mechanism :) But let's take an
> example.
> On all kernels (even recent), if the module smbfs is loaded, it's not
> handled by udev and request_module could be called.
> 
> Let"s take another example to see to illustrate why I think
> it depends on the user configuration :
> module A depends on module B
> 
> if we have a script which do "insmod moduleA.ko ; insmod moduleB.ko",
> there will be a call to request_module.

No, that script will fail.  Try it out :)

The kernel will not call out to try to resolve the symbols, that's up to
userspace to handle.  Hint, try running 'modprobe moduleA.ko' instead,
it will handle the dependancies correctly.

I still don't see where this is really needed...

thanks,

greg k-h
