Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbVITEqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVITEqY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 00:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbVITEqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 00:46:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:18057 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932511AbVITEqY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 00:46:24 -0400
Date: Tue, 20 Sep 2005 05:46:23 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Message-ID: <20050920044623.GD7992@ftp.linux.org.uk>
References: <1127177337.15262.6.camel@vertex> <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org> <1127181641.16372.10.camel@vertex> <Pine.LNX.4.58.0509191909220.2553@g5.osdl.org> <1127188015.17794.6.camel@vertex> <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org> <20050920042456.GC7992@ftp.linux.org.uk> <1127190971.18595.5.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127190971.18595.5.camel@vertex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 12:36:11AM -0400, John McCutchan wrote:
> On Tue, 2005-09-20 at 05:24 +0100, Al Viro wrote:
> > On Mon, Sep 19, 2005 at 09:03:36PM -0700, Linus Torvalds wrote:
> > > One possibility is to mark the dentry deleted in d_flags. That would mean 
> > > something like this (against the just-pushed-put v2.6.14-rc2, which has 
> > > my previous hack).
> > > 
> > > Untested. Al?
> >  
> > Uhh...  I still don't understand which behaviour do you want.
> 
> 
> > 	* removal of this link, at the moment when it stops being accessible
> > [ none of the above, better done from vfs_...() ]
> 
> That is the behaviour we want, how does Linus's second patch not
> accomplish this? 

fd = open("foo", 0);
unlink("foo");
sleep for ten days
close(fd);

	Linus' patch will send event on close().  Ten days since the moment
when any lookups on foo would bring you -ENOENT.

	Could you please describe the semantics of your events?
