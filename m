Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbUKPGPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbUKPGPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 01:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbUKPGPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 01:15:39 -0500
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:26791 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261906AbUKPGP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 01:15:28 -0500
Date: Tue, 16 Nov 2004 01:13:15 -0500
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Tejun Heo <tj@home-tj.org>, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
Message-ID: <20041116061315.GG29574@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
	Tejun Heo <tj@home-tj.org>,
	Patrick Mochel <mochel@digitalimplant.org>
References: <20041109223729.GB7416@kroah.com> <d120d5000411091536115ac91b@mail.gmail.com> <20041110003323.GA8672@kroah.com> <200411092249.44561.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411092249.44561.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6+20040722i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 10:49:43PM -0500, Dmitry Torokhov wrote:
> On Tuesday 09 November 2004 07:33 pm, Greg KH wrote:
> > All we have to do is rework that rwsem lock.  It's been staring at us
> > since the beginning of the driver core work, and we knew it would have
> > to be fixed eventually.  So might as well do it now.
> > 
> ...
> > 
> > So, off to rework this mess...
> > 
> 
> Do you have any ideas here? For me it seems that the semaphore has a dual
> role - protecting bus's lists and ensuring that probe/remove routines are
> serialized across bus...
> 
> In the meantime, can I please have bind_mode patch applied? I believe
> it is useful regardless of which bind/unbind solution will be adopted
> and having them will allow me clean up serio bus implementaion quite a
> bit.
> 
> Pretty please...
> 

I'm not sure what your bind_mode patch includes, but I would like to start a
general discussion on the bind/unbind issue.

I appreciate the effort, and I agree that this feature is important.  However,
I would like to discuss a few issues.

1.) I don't think we should merge a patch that supports driver "unbind"
without also supporting driver "bind".

They're really very interelated, and we don't want to break userspace by
changing everything around when we discover a cleaner solution.

2.) I don't like having an "unbind" file.

This implies that we will have at least three seperate files controlling
driver binding when we really need only one or two at the most.  Consider
"bind", "unbind", and the link to the driver that is bound.


An Alternative Solution
=======================

Why not have a file named "bind".  We can write the name of the driver we want
bound to the device.  When we want to unbind the driver we could do something
like this:

# echo "" > bind
or
# echo 0 > bind

At least then we only have the link and the "bind" file to worry about.  I've
also been considering more inventive solutions (like deleting the symlink will
cause the driver to unbind).  But it could get complex very quickly.  Really,
we need to discuss this more.

I look forward to any comments.

Thanks,
Adam
