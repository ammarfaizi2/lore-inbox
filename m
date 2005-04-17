Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVDQSqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVDQSqH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 14:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVDQSqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 14:46:07 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:47745 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261406AbVDQSpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 14:45:54 -0400
To: ericvh@gmail.com
CC: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <a4e6962a050417110160a464d8@mail.gmail.com> (message from Eric
	Van Hensbergen on Sun, 17 Apr 2005 13:01:31 -0500)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <20050320151212.4f9c8f32.akpm@osdl.org>
	 <E1DE2D1-0005Ie-00@dorka.pomaz.szeredi.hu>
	 <20050325095838.GA9471@infradead.org>
	 <E1DEmYC-0008Qg-00@dorka.pomaz.szeredi.hu>
	 <20050331112427.GA15034@infradead.org>
	 <E1DH13O-000400-00@dorka.pomaz.szeredi.hu>
	 <20050331200502.GA24589@infradead.org>
	 <E1DJsH6-0004nv-00@dorka.pomaz.szeredi.hu>
	 <20050411114728.GA13128@infradead.org>
	 <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <a4e6962a050417110160a464d8@mail.gmail.com>
Message-Id: <E1DNElp-0005JD-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 17 Apr 2005 20:45:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> >   1) Only allow mount over a directory for which the user has write
> >      access (and is not sticky)
> > 
> >   2) Use nosuid,nodev mount options
> > 
> > [ parts deleted ]
> 
> Do these solve all the security concerns with unprivileged mounts, or
> are there other barriers/concerns?  Should there be ulimit (or rlimit)
> style restrictions on how many mounts/binds a user is allowed to have
> to prevent users from abusing mount privs?

Currently there is a (configurable) global limit for all non-root FUSE
mounts.  An additional per-user limit would be nice, but from the
security standpoint it doesn't matter.

> I was thinking about this a while back and thought having a user-mount
> permissions file might be the right way to address lots of these
> issues.  Essentially it would contain information about what
> users/groups were allowed to mount what sources to what destinations
> and with what mandatory options.

I haven't yet seen the need for such a great flexibility.  Debian
installs fusermount (the FUSE mount utility) "-rwsr-x--- root fuse",
so only users in the "fuse" group are allowed to use it.  This is sane
for a new technology, but I expect these limitations to be removed
once it establishes itsef as a secure solution.

> You can get the start of this with the user/users/etc. stuff in
> /etc/fstab, but I was envisioning something a bit more dynamic with
> regular expression based rules for sources and destinations.   So,
> something like:

[snip]

> Is this unnecessary?  Is this not enough?

Maybe it is necessary, but why bother until somebody actually wants
it?  I'm a great believer of the "lazy" development philosophy ;)

Thanks,
Miklos
