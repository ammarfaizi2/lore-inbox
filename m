Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUBRIcG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 03:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUBRIcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 03:32:06 -0500
Received: from kempelen.iit.bme.hu ([152.66.241.120]:47528 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S263777AbUBRIcC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 03:32:02 -0500
Date: Wed, 18 Feb 2004 09:31:51 +0100 (MET)
Message-Id: <200402180831.i1I8VpE00710@kempelen.iit.bme.hu>
From: Miklos Szeredi <mszeredi@inf.bme.hu>
To: Rik van Riel <riel@redhat.com>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <Pine.LNX.4.44.0402171657070.25294-100000@chimarrao.boston.redhat.com>
	(message from Rik van Riel on Tue, 17 Feb 2004 16:59:25 -0500 (EST))
Subject: Re: [RFC] [PATCH] allowing user mounts
References: <Pine.LNX.4.44.0402171657070.25294-100000@chimarrao.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik van Riel wrote:
> On Tue, 17 Feb 2004, Miklos Szeredi wrote:
> 
> > This patch (against 2.6.3-rc4) allows the use of the mount syscall by
> > non-root users in a controlled, and secure (I hope) way.  I'd very
> > much appreciate any comments,
> 
> Just as a curiosity, why not do this in userspace ?

There's a simple enough reason: it can't be done securely.

The reason is, that the path lookup for the mountpoint is performed by
the mount syscall, so the permissions of the looked up inode can only
be checked in the mount syscall.

> You'll notice that /bin/mount already is a suid application,
> so you could just add your functionality there, or write your
> own suid mount application.

Yeah, it's been done (fusermount in FUSE), but it cannot be made truly
secure.

> As an added bonus, you'd be able to have a more flexible
> configuration framework then what would ever be accepted
> into the kernel, without needing to go through the effort
> of getting anything merged into the kernel.

But you don't need a configuration framework for simple filesystem
operations like mkdir, etc.  IMHO mount should be one of those simple
operations, since it's a very powerful addition to the other
filesystem tools.

My feeling that it really can be done simply without a lot of
framework in kernel.  I know Al Viro had some ideas about this (see
the #ifdef in mount_is_safe() in fs/namespace.c), but he seems to be
onto other things now, and doesn't care about the VFS any more ;-(.

Thanks for your comments,
Miklos
