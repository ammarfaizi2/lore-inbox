Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266596AbUAWS1N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266630AbUAWS1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:27:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:57261 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266596AbUAWS1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:27:12 -0500
Date: Fri, 23 Jan 2004 10:27:14 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core
Message-ID: <20040123182714.GF23169@kroah.com>
References: <Pine.LNX.4.44L0.0401231135400.856-100000@ida.rowland.org> <Pine.LNX.4.58.0401230939170.2151@home.osdl.org> <20040123181106.GD23169@kroah.com> <Pine.LNX.4.58.0401231017030.2151@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401231017030.2151@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 10:19:15AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 23 Jan 2004, Greg KH wrote:
> > > 
> > > So why would this not deadlock?
> > 
> > It will deadlock if the user does something braindead like:
> > 	rmmod foo < /sys/class/foo_class/foo1/file
> 
> I don't much worry about things like that, since only root can rmmod 
> anyway.

Yeah, that's why I didn't care very much either.

> HOWEVER - I do worry when people start exporting interfaces that are 
> basically _designed_ to deadlock. It's a bad interface. Don't export it. 
> There is possibly just _one_ place that can do it, and it's the module 
> unload part. Everything else would be a bug.
> 
> So do it in the one place. Don't make a function that does it and that 
> others will start using because it's "simple".

Ok, fair enough.  I'll make up a patch to remove that other
"unregister_wait" function in the driver core.

thanks,

greg k-h
