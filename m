Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751855AbWCIL16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbWCIL16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbWCIL16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:27:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47514 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751850AbWCIL15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:27:57 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1141858122.11378.15.camel@lade.trondhjem.org> 
References: <1141858122.11378.15.camel@lade.trondhjem.org>  <20060308203018.25493.23720.stgit@warthog.cambridge.redhat.com> <20060308203028.25493.84121.stgit@warthog.cambridge.redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       steved@redhat.com, aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] NFS: Unify NFS superblocks per-protocol per-server [try #7] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 09 Mar 2006 11:27:40 +0000
Message-ID: <23847.1141903660@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> > The attached patch makes NFS share superblocks between mounts from the same
> > server over the same protocol.
> 
> We want to make NFS share superblocks on a per-filesystem basis, rather
> than forcing it into a per-server basis.

By "per-filesystem", I presume you mean per-server-mounted-filesystem?
Something like what the kAFS client tries to do. As it happens the current NFS
code doesn't do this either, but it has occurred to me that this would be
useful, just not necessarily easy...

> Cachefs may like the latter, but POSIX does not like a filesystem where
> inode numbers are not guaranteed to be unique.

I don't like it either, but the situation is already present.

Note that CacheFS would be happy with the former too, just as long as the keys
it is given don't end up aliasing.

> A unique per-server superblock also makes it hard to support features
> like failover onto replicated filesystems and/or migration of individual
> filesystems onto another server.

So you want these patches dropping?

Note that you can't necessarily do what you want with the current code either.

David
