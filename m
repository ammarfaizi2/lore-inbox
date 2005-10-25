Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbVJYFwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbVJYFwv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 01:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbVJYFwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 01:52:51 -0400
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:2056 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751459AbVJYFwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 01:52:51 -0400
To: viro@ftp.linux.org.uk
CC: bfields@fieldses.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <20051025043246.GL7992@ftp.linux.org.uk> (message from Al Viro on
	Tue, 25 Oct 2005 05:32:46 +0100)
Subject: Re: [PATCH 8/8] FUSE: per inode statfs
References: <E1EU5vx-0005yb-00@dorka.pomaz.szeredi.hu> <20051024172546.GA30782@fieldses.org> <E1EU7dX-00066t-00@dorka.pomaz.szeredi.hu> <20051025043246.GL7992@ftp.linux.org.uk>
Message-Id: <E1EUHix-0006tf-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Oct 2005 07:51:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > statistics based on path.  While breaks with the tradition of
> > > > homogeneous statistics per _local_ filesystem, however adds useful
> > > > ability to user to differentiate statistics from different _remote_
> > > > filesystem served by the same userspace server.
> > > 
> > > Wouldn't it make more sense to create more mountpoints (on demand, if
> > > necessary) to handle this case?
> > 
> > Only if
> > 
> >  a) it's possible to find out about remote mountpoints
> > 
> >  b) not prohibitively expensive to do so on each lookup
> 
> And finding the pathnames to call statfs() on is by some magic cheaper?

statfs() is called infrequently.  If it's expensive, it's expensive.
OTOH lookup is done for every operation.  The filesystem would have to
check for a remote mountpoint before doing _any_ operation, just so
that the occasional statfs() would return valid results.

Oh, and what if remote mountpoints go away, and the (unprivileged
userspace) server is not notified.  How will the local mount structure
always correctly reflect the remote one?

It's far simpler just to let statfs() return different results based
on path within the filesystem.  What's your problem with it?

Miklos
