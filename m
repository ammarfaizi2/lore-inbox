Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268059AbUIKAtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268059AbUIKAtI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 20:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268060AbUIKAtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 20:49:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:2180 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268059AbUIKAsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 20:48:55 -0400
Date: Fri, 10 Sep 2004 17:48:27 -0700
From: Greg KH <greg@kroah.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Robert Love <rml@ximian.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040911004827.GA8139@kroah.com>
References: <20040831150645.4aa8fd27.akpm@osdl.org> <1093989924.4815.56.camel@betsy.boston.ximian.com> <20040902083407.GC3191@kroah.com> <1094142321.2284.12.camel@betsy.boston.ximian.com> <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <20040911001849.GA321@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911001849.GA321@hockin.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 05:18:49PM -0700, Tim Hockin wrote:
> On Fri, Sep 10, 2004 at 04:54:09PM -0700, Greg KH wrote:
> > To send an event, the user needs to pass the kobject, a optional
> > sysfs-attribute and the signal string to the following function:
> >   
> >   kobject_uevent(const char *signal,
> >                  struct kobject *kobj,
> >                  struct attribute *attr)
> 
> Sorry I missed the flare up of this topic.  What about events for which
> there is no associated kobject?

Tough, no event for them :)

> why is the kobject argument not first?  Seems weird..

Yeah, it is a bit "odd", but it follows my old kobject_hotplug() way.

> What happened to a formatted string argument?  The signal argument can 
> become the pre-formatted string, and someone can provide a wrapper
> that takes a printf() like format and args.
> 	kobject_uevent_printf(kobj, "something bad: 0x%08x", err);

Use an attribute, and have userspace read that formatted argument if
need be.  This keeps the kernel interface much simpler, and doesn't
allow you to abuse it for things it is not intended for (like error
reporting stuff...)

thanks,

greg k-h
