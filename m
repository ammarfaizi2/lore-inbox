Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbUKQSPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUKQSPQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbUKQSLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:11:45 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:37509 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262477AbUKQSJF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:09:05 -0500
Date: Wed, 17 Nov 2004 09:53:59 -0800
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: ambx1@neo.rr.com, linux-kernel@vger.kernel.org, Tejun Heo <tj@home-tj.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
Message-ID: <20041117175359.GD28285@kroah.com>
References: <20041109223729.GB7416@kroah.com> <20041116061315.GG29574@neo.rr.com> <20041116201726.GA11069@kroah.com> <200411170207.14745.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411170207.14745.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 02:07:14AM -0500, Dmitry Torokhov wrote:
> On Tuesday 16 November 2004 03:17 pm, Greg KH wrote:
> > > 2.) I don't like having an "unbind" file.
> > 
> > Why?
> 
> I do not like interfaces accepting and encouraging writing garbage data. What
> value sould be written into "unbind"? Yes, any junk.

Ok, we restrict it to working only if you write a "1" into it.  That was
an easy fix :)

> > So, when a device is not bound to a driver, there will be no symlink, or
> > a "unbind" file, only a "bind" file. ?Really there is only 1 "control"
> > type file present at any single point in time.
> 
> Does that imply that I can not rebind device while it is bound to a driver?

Yes.  You must unbind it first.

> ("bind" would be missing it seems). And what about all other flavors of that
> operation - rescan, reconnect? Do we want to have separate attributes for
> them as well?

rescan is a bus specific thing, not a driver or device thing.
reconnect would be the same as "unbind" + "bind" and you can do that
with the scheme I posted.

thanks,

greg k-h
