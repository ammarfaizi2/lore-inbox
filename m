Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265547AbUAZGJo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 01:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265550AbUAZGJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 01:09:44 -0500
Received: from dp.samba.org ([66.70.73.150]:5256 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265547AbUAZGJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 01:09:41 -0500
Date: Mon, 26 Jan 2004 16:50:35 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: torvalds@osdl.org, stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
       mochel@digitalimplant.org
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and
 platform_device_unregister_wait() to the driver model core
Message-Id: <20040126165035.2fda1b3e.rusty@rustcorp.com.au>
In-Reply-To: <20040123181106.GD23169@kroah.com>
References: <Pine.LNX.4.44L0.0401231135400.856-100000@ida.rowland.org>
	<Pine.LNX.4.58.0401230939170.2151@home.osdl.org>
	<20040123181106.GD23169@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jan 2004 10:11:06 -0800
Greg KH <greg@kroah.com> wrote:

> On Fri, Jan 23, 2004 at 09:42:09AM -0800, Linus Torvalds wrote:
> > 
> > 
> > On Fri, 23 Jan 2004, Alan Stern wrote:
> > >
> > > Since I haven't seen any progress towards implementing the 
> > > class_device_unregister_wait() and platform_device_unregister_wait() 
> > > functions, here is my attempt.
> > 
> > So why would this not deadlock?
> 
> It will deadlock if the user does something braindead like:
> 	rmmod foo < /sys/class/foo_class/foo1/file

Um, if module foo exports a class, then why doesn't opening the class file
bump the owner count so the above will fail?

If you want to safely remove parts of the kernel, you have to maintain
reference counts.  At least with any sane scheme I've seen.

I know, I should go read the code...
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
