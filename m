Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbUKPU0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbUKPU0l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbUKPUYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 15:24:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:21394 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261805AbUKPUYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 15:24:03 -0500
Date: Tue, 16 Nov 2004 12:17:26 -0800
From: Greg KH <greg@kroah.com>
To: ambx1@neo.rr.com, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org, Tejun Heo <tj@home-tj.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
Message-ID: <20041116201726.GA11069@kroah.com>
References: <20041109223729.GB7416@kroah.com> <d120d5000411091536115ac91b@mail.gmail.com> <20041110003323.GA8672@kroah.com> <200411092249.44561.dtor_core@ameritech.net> <20041116061315.GG29574@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116061315.GG29574@neo.rr.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 01:13:15AM -0500, Adam Belay wrote:
> 
> I'm not sure what your bind_mode patch includes, but I would like to start a
> general discussion on the bind/unbind issue.
> 
> I appreciate the effort, and I agree that this feature is important.  However,
> I would like to discuss a few issues.
> 
> 1.) I don't think we should merge a patch that supports driver "unbind"
> without also supporting driver "bind".
> 
> They're really very interelated, and we don't want to break userspace by
> changing everything around when we discover a cleaner solution.

How would we break userspace, when you can't do either thing today?
Just by adding one new feature, doesn't break anything :)

Anyway, I agree, but the core needs to have it's locking reworked in
order for this to work properly.  I'm working on this now.

> 2.) I don't like having an "unbind" file.

Why?

> This implies that we will have at least three seperate files controlling
> driver binding when we really need only one or two at the most.  Consider
> "bind", "unbind", and the link to the driver that is bound.

No.  Consider the fact that the "unbind" file will not be present if the
device is not bound to anything.  Once it is bound, the unbind file will
be created, and the symlink will be created.  The symlink matches other
parts of sysfs.  By trying to put the name of the driver in a file, that
makes userspace work a lot harder to try to figure out exactly what
driver is bound (consider the fact that I can have both a pci and a usb
driver with the same name in sysfs, and that's legal.)

So, when a device is not bound to a driver, there will be no symlink, or
a "unbind" file, only a "bind" file.  Really there is only 1 "control"
type file present at any single point in time.

Sound good?

thanks,

greg k-h
