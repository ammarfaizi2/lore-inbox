Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWBZQ6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWBZQ6s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 11:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWBZQ6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 11:58:48 -0500
Received: from d36-15-41.home1.cgocable.net ([24.36.15.41]:30909 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750811AbWBZQ6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 11:58:47 -0500
Subject: Re: udevd is killing file write performance.
From: John McCutchan <john@johnmccutchan.com>
Reply-To: john@johnmccutchan.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, holt@sgi.com, linux-kernel@vger.kernel.org,
       rml@novell.com, arnd@arndb.de, hch@lst.de, dipankar@in.ibm.com
In-Reply-To: <43FEB370.6030101@yahoo.com.au>
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com>
	 <1140626903.13461.5.camel@localhost.localdomain>
	 <20060222175030.GB30556@lnx-holt.americas.sgi.com>
	 <1140648776.1729.5.camel@localhost.localdomain>
	 <20060222151223.5c9061fd.akpm@osdl.org>
	 <1140651662.2985.2.camel@localhost.localdomain>
	 <20060223161425.4388540e.akpm@osdl.org>
	 <20060224054724.GA8593@johnmccutchan.com>
	 <20060223220053.2f7a977e.akpm@osdl.org>	<43FEB0BF.6080403@yahoo.com.au>
	 <20060223231621.0f5d5b8a.akpm@osdl.org>  <43FEB370.6030101@yahoo.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 26 Feb 2006 11:58:49 -0500
Message-Id: <1140973129.15634.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-24-02 at 18:19 +1100, Nick Piggin wrote:
> Andrew Morton wrote:
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > 
> >>@@ -538,7 +579,7 @@ void inotify_dentry_parent_queue_event(s
> >>  	struct dentry *parent;
> >>  	struct inode *inode;
> >>  
> >> -	if (!atomic_read (&inotify_watches))
> >> +	if (!(dentry->d_flags & DCACHE_INOTIFY_PARENT_WATCHED))
> > 
> > 
> > Yeah, I think that would work.  One would need to wire up d_move() also -
> > for when a file is moved from a watched to non-watched directory and
> > vice-versa.
> > 
> > 
> 
> Oh yeah of course, good catch. Are there any other cases missing?
> 
> ... I'll let the others on this thread digest before spitting out
> another patch.
> 
> John or Robert, is there some kind of inotify test suite around?

Unfortunately there isn't. In the past gamin's test suite was a good
start, but it hasn't been working for a while now. 
 
-- 
John McCutchan <john@johnmccutchan.com>
