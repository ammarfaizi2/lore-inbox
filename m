Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932752AbVITRoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbVITRoZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932779AbVITRoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:44:25 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:57351 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S932752AbVITRoY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:44:24 -0400
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event
	under load
From: Ray Lee <ray@madrabbit.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
In-Reply-To: <20050920163848.GO7992@ftp.linux.org.uk>
References: <1127188015.17794.6.camel@vertex>
	 <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org>
	 <20050920042456.GC7992@ftp.linux.org.uk> <1127190971.18595.5.camel@vertex>
	 <20050920044623.GD7992@ftp.linux.org.uk> <1127191992.19093.3.camel@vertex>
	 <20050920045835.GE7992@ftp.linux.org.uk> <1127192784.19093.7.camel@vertex>
	 <20050920051729.GF7992@ftp.linux.org.uk>
	 <76677C3D-D5E0-4B5A-800F-9503DA09F1C3@tentacle.dhs.org>
	 <20050920163848.GO7992@ftp.linux.org.uk>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 10:44:17 -0700
Message-Id: <1127238257.9940.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.5.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-20 at 17:38 +0100, Al Viro wrote:
> I don't get it.  Could you please describe what your code is _supposed_
> to do?  I'm not even talking about implementation - it's on the level
> of "what do we want the watchers to see after the following operations".

I can't even talk to that level, but perhaps it'd help to know that some
(I think) are pinning their hopes on inotify as the foundation of a
userspace negative dentry cache (i.e., samba trying to prove a set of
filenames (case-insensitively) doesn't exist).

By that point of view:

> ln a b
> start watching b
> rm a
> chmod 400 b

...it's quite clearly important to continue to get b's events.

Continuing:
 
> >fd = open("foo", 0);
> >unlink("foo");
> >sleep for a day
> >fchmod(fd, 0400);
> >sleep for a day
> >close(fd);

...I'd say that providing the fchmod to userspace would be a good thing.
That fd may be available to multiple processes, and so those processes
could still be validly interested in events upon it. However, this is an
obscure case that could be handled by polling with fstat, so if it's
unreasonable for other reasons, toss the idea.

Ray

