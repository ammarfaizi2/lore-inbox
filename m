Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266614AbUAWSLz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266620AbUAWSLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:11:52 -0500
Received: from mail.kroah.org ([65.200.24.183]:26792 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266614AbUAWSLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:11:10 -0500
Date: Fri, 23 Jan 2004 10:11:06 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core
Message-ID: <20040123181106.GD23169@kroah.com>
References: <Pine.LNX.4.44L0.0401231135400.856-100000@ida.rowland.org> <Pine.LNX.4.58.0401230939170.2151@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401230939170.2151@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 09:42:09AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 23 Jan 2004, Alan Stern wrote:
> >
> > Since I haven't seen any progress towards implementing the 
> > class_device_unregister_wait() and platform_device_unregister_wait() 
> > functions, here is my attempt.
> 
> So why would this not deadlock?

It will deadlock if the user does something braindead like:
	rmmod foo < /sys/class/foo_class/foo1/file

Now I know the network code can handle something like that, but they
have their own thread to handle issues like this...  It's not sane to
make every driver subsystem do that...

So in short, it's used to make sure that all references are dropped,
before allowing the module to be unloaded.

And Alan, I think Pat already has this in his tree, if only he would
send that to Linus one of these days...

thanks,

greg k-h
