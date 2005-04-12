Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVDLQfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVDLQfF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVDLQdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:33:52 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:25055 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262450AbVDLQbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:31:16 -0400
To: jamie@shareable.org
CC: 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050412160409.GH10995@mail.shareable.org> (message from Jamie
	Lokier on Tue, 12 Apr 2005 17:04:09 +0100)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <3S8oN-So-19@gated-at.bofh.it> <3S8oN-So-21@gated-at.bofh.it> <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it> <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org> <E1DLNAz-0001oI-00@dorka.pomaz.szeredi.hu> <20050412160409.GH10995@mail.shareable.org>
Message-Id: <E1DLOI6-0001ws-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Apr 2005 18:31:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I can accept that usually you are not interested in the stored
> > uid/gid.  But doubt that you want to lose permission information when
> > you mount a tar file.  Zip is a different kettle of fish since that
> > doesn't contain uid/gid/permissions.
> 
> It's not about being not interested.
> 
> It's because I'd want my programs, and other users, to have exactly
> the same access to the tgz contents through vfs as they have when
> accessing the tgz file directly.

OK, that makes sense, and it should be an option.

> Not some baroque combination of unobvious hard-coded permission
> rules, that aren't even visible through stat(), and which both
> increase permissions for the user and decrease it for others at the
> same time.

I look at it differently.  I want the tar filesystem to be analogous
to running tar.  When I run tar, other users are not notified of the
output, it's only for me.  If they want to run tar, they can too.

The same can be true for tarfs.  I mount it for my purpose, others can
mount it for theirs.  Since the daemon providing the filesystem asways
runs with the same capabilities as the user who did the mount, I and
others will always get the permissions that we have on the actual tar
file.

The end result in permission rules is the _same_ as with your
proposal.  There's nothing baroque in it.

Think of the "no permission for others" as "hiding", not as some
special permission rule.  And if this hiding can be nicely done with
namespaces, all the better, I'll happily drop this feature at that
instant.

> I see why you may want to hide certain things from other users
> sometimes - the sshfs example is a good one.  I daresay Al Viro could
> come up with a per-user or per-keyring mount point for those occasions :)

Yeah, maybe that's something worth exploring.

Thanks,
Miklos
