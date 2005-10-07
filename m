Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbVJGOhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbVJGOhj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbVJGOhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:37:39 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:7688 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1030211AbVJGOhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:37:39 -0400
To: viro@ftp.linux.org.uk
CC: akpm@osdl.org, trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
In-reply-to: <20051007143012.GC7992@ftp.linux.org.uk> (message from Al Viro on
	Fri, 7 Oct 2005 15:30:13 +0100)
Subject: Re: [PATCH] don't invalidate non-directory mountpoints
References: <E1ENqAg-0004bJ-00@dorka.pomaz.szeredi.hu> <20051007143012.GC7992@ftp.linux.org.uk>
Message-Id: <E1ENtKD-0005Dw-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 07 Oct 2005 16:35:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > d_invalidate allowed a non-directory mountpoint to be invalidated,
> > which is bad, since the mountpoint becomes unreachable.
> > 
> > I know it's racy wrt attaching/detaching mount, but AFAICS so is
> > everything else that unhashes the dentry.  This seems to be an
> > oversight when splitting out vfsmount_lock from dcache_lock.  To be
> > fixed.
> 
> NAK.  That's a wrong way to deal with the problem and it's much older
> than vfsmount_lock or dcache_lock (and affects directories too).

Sorry?

Directories are not invalidated if they have any other reference (like
a mount, or any subdirectories which may have mounts).

So how does it affect directories?

Miklos

