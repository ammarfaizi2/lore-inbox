Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266587AbUAWSbN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUAWSbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:31:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:10927 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266587AbUAWSbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:31:09 -0500
Date: Fri, 23 Jan 2004 10:31:09 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Patrick Mochel <mochel@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core
Message-ID: <20040123183109.GG23169@kroah.com>
References: <Pine.LNX.4.44L0.0401231248510.856-100000@ida.rowland.org> <Pine.LNX.4.58.0401231008220.2151@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401231008220.2151@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 10:15:36AM -0800, Linus Torvalds wrote:
> 
> What is it with USB that makes people think so? Remember all the USB bugs 
> early on that were due to _exactly_ that thinking. 

Oh yeah, I remember :(

> It's wrong. YOU SHOULD NEVER WAIT FOR THE REFERNCE COUNT TO DROP TO ZERO!
> 
> You just ignore it. With proper memory management it doesn't matter.
> 
> For module unload, it's likely better to return an error than to wait. 
> Tell the super-user that you're busy.

That patch that Alan pointed to is wrong anyway, it dies a horrible
death, and was only a hack to try something.

I think it might be a better idea to just prevent the module unload of
the USB host controller until all drivers bound to devices owned by it
are also unbound in order to fix these kinds of problems.

thanks,

greg k-h
