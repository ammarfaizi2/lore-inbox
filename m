Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbUKQHHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbUKQHHX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 02:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUKQHHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 02:07:23 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:1154 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262219AbUKQHHR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 02:07:17 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
Date: Wed, 17 Nov 2004 02:07:14 -0500
User-Agent: KMail/1.6.2
Cc: ambx1@neo.rr.com, linux-kernel@vger.kernel.org, Tejun Heo <tj@home-tj.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20041109223729.GB7416@kroah.com> <20041116061315.GG29574@neo.rr.com> <20041116201726.GA11069@kroah.com>
In-Reply-To: <20041116201726.GA11069@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411170207.14745.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 November 2004 03:17 pm, Greg KH wrote:
> > 2.) I don't like having an "unbind" file.
> 
> Why?

I do not like interfaces accepting and encouraging writing garbage data. What
value sould be written into "unbind"? Yes, any junk.
 
> 
> > This implies that we will have at least three seperate files controlling
> > driver binding when we really need only one or two at the most.  Consider
> > "bind", "unbind", and the link to the driver that is bound.
> 
> No.  Consider the fact that the "unbind" file will not be present if the
> device is not bound to anything.  Once it is bound, the unbind file will
> be created, and the symlink will be created.  The symlink matches other
> parts of sysfs.  By trying to put the name of the driver in a file, that
> makes userspace work a lot harder to try to figure out exactly what
> driver is bound (consider the fact that I can have both a pci and a usb
> driver with the same name in sysfs, and that's legal.)

But not 2 drivers with the same name on the same bus so I don't think this
is a valid argument. Anyway, we already have this symlink.

> 
> So, when a device is not bound to a driver, there will be no symlink, or
> a "unbind" file, only a "bind" file.  Really there is only 1 "control"
> type file present at any single point in time.

Does that imply that I can not rebind device while it is bound to a driver?
("bind" would be missing it seems). And what about all other flavors of that
operation - rescan, reconnect? Do we want to have separate attributes for
them as well?

-- 
Dmitry
