Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVEKKn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVEKKn1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 06:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVEKKn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 06:43:27 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:63250 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261156AbVEKKnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 06:43:21 -0400
To: hch@infradead.org
CC: bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <20050511090002.GC24841@infradead.org> (message from Christoph
	Hellwig on Wed, 11 May 2005 10:00:02 +0100)
Subject: Re: [PATCH] private mounts
References: <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <E1DPofK-0000Yu-00@localhost> <20050425071047.GA13975@vagabond> <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu> <20050430083516.GC23253@infradead.org> <E1DRoDm-0002G9-00@dorka.pomaz.szeredi.hu> <20050511090002.GC24841@infradead.org>
Message-Id: <E1DVofz-0001dC-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 May 2005 12:42:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > I can't write a script that reads your mind. But I sure can
> > > > > write a script that finds out what you mounted in the other
> > > > > shells (with help of a little wrapper around the mount
> > > > > command).
> > > > 
> > > > How do you bind mount it from a different namespace?  You _do_
> > > > need bind mount, since a new mount might require password
> > > > input, etc...
> > > 
> > > Not nessecarily.  The filesystem gets called into ->get_sb for
> > > every mount, and can then decided whether to return an existing
> > > superblock instance or setup a new one.  If the credentials for
> > > the new mount match an old one it can just reuse it.  (e.g. for
> > > block based filesystem it will always reuse right now)
> > 
> > And if the credentials are checked in userspace (sshfs)?
> 
> The it needs to call to userspace in ->get_sb..

That's clear.

What I don't get is what's the point in adding complexity to the
kernel and userspace programs, when it can be done without _any_
changes, just by doing a bind mount.

It's not just calling ->get_sb.  It's finding the right filesystem
daemon, that has been started with the exact same command line
arguments, environment etc.

It's just not practical.

Miklos
