Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265711AbUA0Wt7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 17:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265748AbUA0Wt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 17:49:59 -0500
Received: from mail.kroah.org ([65.200.24.183]:5548 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265711AbUA0Wt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 17:49:57 -0500
Date: Tue, 27 Jan 2004 14:22:43 -0800
From: Greg KH <greg@kroah.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 015 release
Message-ID: <20040127222243.GC28143@kroah.com>
References: <20040126215036.GA6906@kroah.com> <4015FC93.1060804@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4015FC93.1060804@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 12:52:19AM -0500, Chris Friesen wrote:
> Greg KH wrote:
> >I've released the 015 version of udev.  It can be found at:
> > 	kernel.org/pub/linux/utils/kernel/hotplug/udev-015.tar.gz
> 
> >Also in this release is the start of a udev daemon.  It's really in 3
> >pieces:
> >	udevsend - sends the hotplug message to the udev daemon
> >	udevd - the udev daemon, gets the hotplug messages, sorts them
> >		in proper order, and passes them off to the udev program
> >		to act apon them.
> >	udev - still the same.
> 
> I'm curious about the rationale behind breaking it up into multiple chunks.
> 
> udevsend being separate I assume is so that it can be easily called from 
> a script while still keeping something persistant?

Yes, it will be called from /sbin/hotplug.

> I'm not sure I see what separating udev and udevd into different 
> binaries actually buys you.  Wouldn't it be just as easy to make udev be 
> the daemon based on runtime options or something?

It should be faster this way.  We can send off udev to run for different
devices at the same time (blocking for any pending device changes for
any currently running udev instances.)

Take a look at the current code and let us know if you have any
questions (warning, the code is in quite a bit of flux, you might want
to look at the bk tree...)

thanks,

greg k-h
