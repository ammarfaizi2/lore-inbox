Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWHaSE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWHaSE4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 14:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWHaSE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 14:04:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23447 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932430AbWHaSEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 14:04:55 -0400
Date: Thu, 31 Aug 2006 11:04:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: trond.myklebust@fys.uio.no, hch@infradead.org, torvalds@osdl.org,
       steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
 sharing [try #13]
Message-Id: <20060831110419.e2454964.akpm@osdl.org>
In-Reply-To: <11507.1157046128@warthog.cambridge.redhat.com>
References: <20060831102127.8fb9a24b.akpm@osdl.org>
	<20060830135503.98f57ff3.akpm@osdl.org>
	<20060830125239.6504d71a.akpm@osdl.org>
	<20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	<27414.1156970238@warthog.cambridge.redhat.com>
	<9849.1157018310@warthog.cambridge.redhat.com>
	<11507.1157046128@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006 18:42:08 +0100
David Howells <dhowells@redhat.com> wrote:

> > Your CONFIG_BLOCK patches did a decent job of trashing your
> > fs-cache-make-kafs-* patches, btw.  What's up with that?  OK, it's sensible
> > for people to work against mainline but the net effect of doing that is to
> > create a mess for other people to clean up.
> 
> Hmmm...  Jens wanted my block patches against his tree; you wanted my NFS
> patches against Trond's NFS tree.  I guess I should try stacking the whole
> lot, but against what?  And who carries the fixes?  A patch to fix this
> problem may well only apply to a tree that's the conjunction of both:-/

There is no easy solution, particularly with a patch like that one which
splatters itself all over the place.

The best time to do such things is against 2.6.x-rc1, when everyone is
maximally-merged-up.  The worst time is when we're at 2.6.x-rc5, when
everyone is maximally-unmerged-up.

If we're at -rc5 and one doesn't want to wait for a few weeks then one can
work against the -mm lineup, because then when we hit -rc1 and the
subsystems are merged up, the proposed patch will slot in nicely with
minimal breakage: no queue-jumping.

The exception to that rule is patches which move files around.  Because
even a single-line change in one of the affected files will cause the
move-things-around patch to break, and to need somewhat risky rework.  In
that case, simply waiting until -rc1 is the best approach
