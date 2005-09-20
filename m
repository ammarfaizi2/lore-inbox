Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbVITThc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbVITThc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 15:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbVITThc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 15:37:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24762 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965098AbVITThc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 15:37:32 -0400
Date: Tue, 20 Sep 2005 12:37:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Ray Lee <ray@madrabbit.org>, John McCutchan <ttb@tentacle.dhs.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under
 load
In-Reply-To: <20050920182249.GP7992@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0509201234560.2553@g5.osdl.org>
References: <1127190971.18595.5.camel@vertex> <20050920044623.GD7992@ftp.linux.org.uk>
 <1127191992.19093.3.camel@vertex> <20050920045835.GE7992@ftp.linux.org.uk>
 <1127192784.19093.7.camel@vertex> <20050920051729.GF7992@ftp.linux.org.uk>
 <76677C3D-D5E0-4B5A-800F-9503DA09F1C3@tentacle.dhs.org>
 <20050920163848.GO7992@ftp.linux.org.uk> <1127238257.9940.14.camel@localhost>
 <Pine.LNX.4.58.0509201108120.2553@g5.osdl.org> <20050920182249.GP7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Sep 2005, Al Viro wrote:
> > 
> > I really think that the patch I sent out yesterday is as good as it gets.  
> > If you want immediate notification, you should ask for notification about
> > name changes in a particular directory. IN_DELETE_SELF notification on a
> > file simple is _not_ going to be immediate.
> 
> But then it's too early.  Note that with your patch we still get removal
> of _any_ link to our inode (even though it's alive and well and we'd never
> heard about the sodding link in the first place) terminating all events
> on it.

Yes. What is in the current 2.6.14-rc2 tree doesn't do that. It considers 
inodes "global". But it won't work reliably on networked filesystems, I 
think.

Anyway, I do believe that IN_DELETE_SELF is stupid, but that you migth 
re-arm it if you get it. 

		Linus
