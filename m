Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVDMR34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVDMR34 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 13:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVDMR3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 13:29:55 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:46308 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261160AbVDMR3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 13:29:48 -0400
To: jamie@shareable.org
CC: aia21@cam.ac.uk, 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050413170222.GJ12825@mail.shareable.org> (message from Jamie
	Lokier on Wed, 13 Apr 2005 18:02:22 +0100)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it> <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org> <Pine.LNX.4.60.0504122117010.26320@hermes-1.csi.cam.ac.uk> <20050412215220.GA23321@mail.shareable.org> <E1DLdwo-0004SE-00@dorka.pomaz.szeredi.hu> <20050413170222.GJ12825@mail.shareable.org>
Message-Id: <E1DLlgD-0004xe-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 13 Apr 2005 19:29:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have a little project to imlement a "userloop" filesystem, which
> > works just like "mount -o loop", but you don't need root privs.  This
> > is really simple to do with FUSE and UML.
> 
> That would be a nice way to implement those rarely used old
> filesystems that aren't really needed in the kernel source tree any
> more, but which it would be nice to have access to as legacy
> filesystem formats.
> 
> In other words, migrating old legacy filesystems out of the kernel
> tree, into FUSE.

Not much migration would be needed other than deleting from the
current kernel.  As long as the lagacy filesystem exists in a kernel
that has UML support it should just work.

> > I don't think that it's far feched, that in certain situations the
> > user _does_ have the right (and usefulness) to do otherwise privileged
> > filesystem operations.
> 
> It's really a matter of philosophy, as to whether the results of
> stat() are just handy information for the user, or are always defined
> to mean what you can/can't do with a file.

Yes, this is the very heart of the conflict between my and your
(Christoph's, etc) view.

I argue for more flexibilty, i.e. less policy in kernel, which is a
good thing generally.  

As long as it's secure, what is the problem with it?  If users are
confused, then they will chose the strict mode.  If somebody would
like to see more information in the filesystem, they use the relaxed
mode.

The key here is security IMO.  So if you find a security problem with
the relaxed mode (together with "hiding") then I bow my head.

Otherwise who cares if it confuses applications (haven't met any) or
users.  It doensn't matter.  If it confuses anything or anyone, the
filesystem writer can fix it.

> Local-ssh-into-UML makes more sense for this in some ways, because the
> uids/gids inside your tgz files or foreign loop filesystems are not
> related to the space of uids/gids of the host system.

Ssh into UML is awkward, because you don't necessary have all the
tools installed, have networking, etc.  And in UML the uid/gid won't
make any more sense either.

> Yet, the results from stat() don't distinguish the number spaces,
> and "ls" doesn't map the numbers to names properly in the wrong
> space.

Well you can use "ls -n".  It's up to the tools to present the
information you want in the way you want it.  If a tool can't do that,
tough, but you are not worse off than if the information is not
available _at_all_.

Thanks,
Miklos
