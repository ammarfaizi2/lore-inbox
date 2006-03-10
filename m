Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbWCJBBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbWCJBBU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWCJBBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:01:20 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:1162 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932644AbWCJBBT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:01:19 -0500
Date: Thu, 9 Mar 2006 17:00:50 -0800
From: Greg KH <gregkh@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: Revenge of the sysfs maintainer! (was Re: [PATCH 8 of 20] ipath - sysfs support for core driver)
Message-ID: <20060310010050.GA9945@suse.de>
References: <ef8042c934401522ed3f.1141922821@localhost.localdomain> <adapskvfbqe.fsf@cisco.com> <1141947143.10693.40.camel@serpentine.pathscale.com> <20060310003513.GA17050@suse.de> <1141951589.10693.84.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141951589.10693.84.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 04:46:29PM -0800, Bryan O'Sullivan wrote:
> On Thu, 2006-03-09 at 16:35 -0800, Greg KH wrote:
> 
> > Grumble?  Oh come on, don't export binary structures through sysfs, it's
> > in the DOCUMENTATION THAT SYSFS IS FOR TEXT FILES ONLY!!!!
> 
> OK, fine.
> 
> > If you don't want to export a text file, then use something else other
> > than sysfs, it's that simple.
> 
> Use what?  Would a sysfs relay file, or whatever they're called now that
> relayfs is moving into sysfs, do the trick?  If so, what's a good place
> to pull those patches from so I can compile-test my changes?  Should I
> just grub through my archives and apply whatever Paul Mundt sent out a
> few weeks ago?

They are in the latest -mm tree if you wish to use them.  Unfortunatly
it might look like they will not work out, due to the per-cpu relay
files not working properly with Paul's patches at the moment.  But I
think he's still working on them.

What's wrong with debugfs?

> > sysfs binary files are for PASS-THROUGH things ONLY!
> 
> If there's any documentation on what sysfs binary files are for, I
> haven't seen it.  It's not in the include files, the source, or
> Documentation/filesystems.  

Fair enough, you are correct.  There is a serious dearth of sysfs and
kobject documentation lately, I'll work on fixing that up.

> > Ok, here's a new rule to help this from happening again in the future:
> > 
> >   If you want to add a new sysfs file to the kernel, it MUST be
> >   accompanied with full documentation that explains exactly what that
> >   file contains and what it is for.  No exceptions will be allowed.
> 
> I'm fine with this rule, but accompanied how?  In a comment in the code?
> In the patch description?  In the same way that sysfs binary files are
> documented? :-)

Touche :)

I referred to my prior lkml post:
	http://thread.gmane.org/gmane.linux.kernel/383717
which provides a structure for documenting the user<->kernel API, which
is what you are creating here.

> Also, I'd suggest that you put a similar requirement on directories and
> symlinks, if you're going to clamp down on files.

I completly agree, anything that is in sysfs falls under this
requirement.  Sorry, but I think of directories and symlinks as files,
as I've been spelunking through the vfs layer too many times :)

thanks,

greg k-h
