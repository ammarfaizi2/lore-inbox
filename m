Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932802AbVHTDeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802AbVHTDeX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 23:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932814AbVHTDeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 23:34:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:40084 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932802AbVHTDeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 23:34:23 -0400
Date: Fri, 19 Aug 2005 20:33:37 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Phillips <phillips@istop.com>
Cc: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permissions don't stick on ConfigFS attributes
Message-ID: <20050820033337.GA1173@kroah.com>
References: <200508201050.51982.phillips@istop.com> <20050820030117.GA775@kroah.com> <200508201323.29355.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508201323.29355.phillips@istop.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2005 at 01:23:29PM +1000, Daniel Phillips wrote:
> On Saturday 20 August 2005 13:01, Greg KH wrote:
> > On Sat, Aug 20, 2005 at 10:50:51AM +1000, Daniel Phillips wrote:
> > > So: Integrate with sysfs.
> >
> > No, don't.  Do you think that Joel would not have already worked with
> > the sysfs people prior to submitting this?  No, he did, and we all
> > agreed that it should be kept separate.
> 
> Would you care to recap the reasoning, please?

They do two different things, and people interact with them in two
different ways.  So, they should be two different file systems.

> > > Terminology skew.  It is a very bad idea to call your configfs files
> > > "attributes".
> >
> > That's what sysfs calls its files.  They used the same naming scheme
> > there.  This is nothing that a user ever cares about or sees.
> 
> It's wrrrrronnnggg.  The best you can defend this with is "it's entrenched".

Will a user ever see the word "attribute"?  Also, these files represent
attributes of the main object in which they are attached to.  Hence the
name.

> > > Memory requirements.  ConfigFS pins way too much kernel memory for inodes
> > > and dentries.
> >
> > configfs is not going to have that many nodes at all in memory (compared
> > to sysfs), so I don't think this is a big problem.
> 
> The current bloat is unconscionable, for the amount of data that is carried.  
> Are you arguing against fixing it?  And what makes you think configfs will 
> never have lots of nodes?

Doesn't it currently work the same way as sysfs with the backing store
being created on the fly?  If not, it should be pretty simple to convert
over if people are really worried about memory consumption, but again,
why don't we see how many nodes are really used on most systems (don't
want to add more complexity and kernel code if you never really need
it.)

thanks,

greg k-h
