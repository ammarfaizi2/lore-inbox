Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVKOMtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVKOMtF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 07:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVKOMtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 07:49:05 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:8202 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932439AbVKOMtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 07:49:04 -0500
To: neilb@suse.de
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
In-reply-to: <17273.47953.233462.316302@cse.unsw.edu.au> (message from Neil
	Brown on Tue, 15 Nov 2005 21:41:21 +1100)
Subject: Re: [PATCH ] Fix some problems with truncate and mtime semantics.
References: <20051115125657.9403.patches@notabene>
	<1051115020002.9459@suse.de>
	<E1Ebxp3-0003me-00@dorka.pomaz.szeredi.hu> <17273.47953.233462.316302@cse.unsw.edu.au>
Message-Id: <E1Ec0ET-0003tz-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 15 Nov 2005 13:48:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Finally, if vmtruncate succeeds, and ATTR_SIZE is the only change
> > > requested, we now fall-through and mark_inode_dirty.  If a filesystem
> > > did not have a ->truncate function, then vmtruncate will have changed
> > > i_size, without marking the inode as 'dirty', and I think this is wrong.
> > 
> > And if filesystem does not have a ->truncate() function and it caller
> > was [f]truncate(), ctime and mtime won't be set.
> > 
> > That's wrong too, isn't it?
> 
> I don't think that is a problem.  
> The filesystem would have had a ->setattr function which would have
> been told that the size had changed, and it would have had to change
> the inode, and so would have updated the ctime and probably mtime.

What if filesystem has neither ->truncate() nor ->setattr()?
E.g. ramfs and derivatives.

> Changing i_size without marking the inode dirty is an issue of
> consistency of common data structures and inode_setattr should be
> careful about that.
> 
> Changing ctime/mtime when the isize changes is an issue of filesystem
> correctness, and the filesystem callbacks should handle that.

Yes, but VFS should have a sane default when filesystem doesn't have
the methods.  It's the same with all the other methods.

Miklos

