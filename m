Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266632AbUAWSTW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266633AbUAWSTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:19:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:22226 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266632AbUAWSTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:19:19 -0500
Date: Fri, 23 Jan 2004 10:19:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
In-Reply-To: <20040123181106.GD23169@kroah.com>
Message-ID: <Pine.LNX.4.58.0401231017030.2151@home.osdl.org>
References: <Pine.LNX.4.44L0.0401231135400.856-100000@ida.rowland.org>
 <Pine.LNX.4.58.0401230939170.2151@home.osdl.org> <20040123181106.GD23169@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Jan 2004, Greg KH wrote:
> > 
> > So why would this not deadlock?
> 
> It will deadlock if the user does something braindead like:
> 	rmmod foo < /sys/class/foo_class/foo1/file

I don't much worry about things like that, since only root can rmmod 
anyway.

HOWEVER - I do worry when people start exporting interfaces that are 
basically _designed_ to deadlock. It's a bad interface. Don't export it. 
There is possibly just _one_ place that can do it, and it's the module 
unload part. Everything else would be a bug.

So do it in the one place. Don't make a function that does it and that 
others will start using because it's "simple".


		Linus
