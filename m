Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbVITDsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbVITDsy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 23:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbVITDsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 23:48:54 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:19876 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964866AbVITDsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 23:48:51 -0400
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event
	under load
From: John McCutchan <ttb@tentacle.dhs.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
In-Reply-To: <20050920033355.GB7992@ftp.linux.org.uk>
References: <1127177337.15262.6.camel@vertex>
	 <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org>
	 <1127181641.16372.10.camel@vertex> <20050920033355.GB7992@ftp.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Sep 2005 23:50:25 -0400
Message-Id: <1127188225.17794.8.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-20 at 04:33 +0100, Al Viro wrote:
> On Mon, Sep 19, 2005 at 10:00:41PM -0400, John McCutchan wrote:
> > To quote you:
> > 
> > Instead of the broken fsnotify_unlink/fsnotify_rmdir functions, you can 
> > split this into two logically _different_ functions:
> > 
> >  - fsnotify_nameremove(dentry) - called when the dentry goes away
> >  - fsnotify_inoderemove(dentry) - called when the inode goes away
> > 
> > ...
> > 
> > The fsnotify_inoderemove() is called from dentry_iput(), and that's the 
> > one that specifies that an actual inode no longer exists.
> > 
> > 
> > ;)
> 
> That was wrong.  Just have *one* function (on link removal) and stuff
> i_mode and i_nlink of victim into event.

We have already locked down the ABI of the event structure. Hopefully
Linus's patch will fix this in a clean way.

-- 
John McCutchan <ttb@tentacle.dhs.org>
