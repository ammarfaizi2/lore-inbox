Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbVITEv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVITEv0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 00:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVITEv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 00:51:26 -0400
Received: from smtp104.rog.mail.re2.yahoo.com ([206.190.36.82]:23948 "HELO
	smtp104.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932517AbVITEvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 00:51:25 -0400
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event
	under load
From: John McCutchan <ttb@tentacle.dhs.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
In-Reply-To: <20050920044623.GD7992@ftp.linux.org.uk>
References: <1127177337.15262.6.camel@vertex>
	 <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org>
	 <1127181641.16372.10.camel@vertex>
	 <Pine.LNX.4.58.0509191909220.2553@g5.osdl.org>
	 <1127188015.17794.6.camel@vertex>
	 <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org>
	 <20050920042456.GC7992@ftp.linux.org.uk> <1127190971.18595.5.camel@vertex>
	 <20050920044623.GD7992@ftp.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Sep 2005 00:53:12 -0400
Message-Id: <1127191992.19093.3.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-20 at 05:46 +0100, Al Viro wrote:
> On Tue, Sep 20, 2005 at 12:36:11AM -0400, John McCutchan wrote:
> > On Tue, 2005-09-20 at 05:24 +0100, Al Viro wrote:
> > > On Mon, Sep 19, 2005 at 09:03:36PM -0700, Linus Torvalds wrote:
> > > > One possibility is to mark the dentry deleted in d_flags. That would mean 
> > > > something like this (against the just-pushed-put v2.6.14-rc2, which has 
> > > > my previous hack).
> > > > 
> > > > Untested. Al?
> > >  
> > > Uhh...  I still don't understand which behaviour do you want.
> > 
> > 
> > > 	* removal of this link, at the moment when it stops being accessible
> > > [ none of the above, better done from vfs_...() ]
> > 
> > That is the behaviour we want, how does Linus's second patch not
> > accomplish this? 
> 
> fd = open("foo", 0);
> unlink("foo");
> sleep for ten days
> close(fd);
> 
> 	Linus' patch will send event on close().  Ten days since the moment
> when any lookups on foo would bring you -ENOENT.
> 


Ahh, got it.

> 	Could you please describe the semantics of your events?

DELETE_SELF WD=X

The path you requested a watch on (inotify_add_watch(path,mask) returned
X) has been deleted.

-- 
John McCutchan <ttb@tentacle.dhs.org>
