Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265646AbUAGV4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265652AbUAGV4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:56:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:29879 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265646AbUAGV4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:56:24 -0500
Date: Wed, 7 Jan 2004 13:56:24 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Inconsistency in sysfs behavior?
Message-ID: <20040107215624.GC1083@kroah.com>
References: <20040107172750.GC31177@kroah.com> <Pine.LNX.4.44L0.0401071644220.1589-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0401071644220.1589-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 04:50:24PM -0500, Alan Stern wrote:
> On Wed, 7 Jan 2004, Greg KH wrote:
> 
> > Because it is very difficult to determine when a user goes into a
> > directory because we are using the ramfs/libfs code.  It also does not
> > cause any errors if the kobject is removed, as the vfs cleans up
> > properly.
> > 
> > Only when a file is opened does a kobject need to be pinned, due to
> > possible errors that could happen.
> 
> I had in mind approaching this the opposite way.  Instead of trying to 
> make open directories also pin a kobject, why not make open attribute 
> files not pin them?
> 
> It shouldn't be hard to avoid any errors; in fact I had a patch from some
> time ago that would do the trick (although in a hacked-up kind of way).  
> The main idea is to return -ENXIO instead of calling the show()/store()
> routines once the attribute has been removed.

And you can do this without adding another lock, race free?

greg k-h
