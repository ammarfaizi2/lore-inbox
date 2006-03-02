Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751626AbWCBRaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWCBRaa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbWCBRaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:30:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41662 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750993AbWCBRa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:30:29 -0500
Date: Thu, 2 Mar 2006 09:28:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, torvalds@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Permit NFS superblock sharing [try #2]
Message-Id: <20060302092854.2818e98c.akpm@osdl.org>
In-Reply-To: <3718.1141299945@warthog.cambridge.redhat.com>
References: <20060301162113.774d1745.akpm@osdl.org>
	<20060301173617.16639.83553.stgit@warthog.cambridge.redhat.com>
	<3718.1141299945@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > The number of rejects gets into the "I'm not confident it'll work after
> > this" territory.
> > 
> > Here's Trond's current diff:
> 
> I assume this is you applying these patches to your -mm tree (which contains
> some of Trond's patches), rather than Linus's tree or Trond's tree.

Why do you assume that?  I guess I have some smallish NFS changes apart
from git-nfs.patch, but the great bulk of the skew is due to Trond's
pending stuff.

> Can you be more specific about which patches you've got problems with? Is it
> mainly that patch 5/5 and little bits of patch 2/5 don't apply?

Seems that way.

nfs-apply-mount-root-dentry-override-to-filesystems:
3 out of 10 hunks FAILED -- saving rejects to file fs/nfs/inode.c.rej

nfs-unify-nfs-superblocks-per-protocol-per-server:
5 out of 18 hunks FAILED -- saving rejects to file fs/nfs/inode.c.rej
1 out of 2 hunks FAILED -- saving rejects to file fs/nfs/nfs4proc.c.rej
1 out of 1 hunk FAILED -- saving rejects to file include/linux/nfs_fs_sb.h.rej

> There's a problem here in that your tree is incompatible with Linus's tree in
> various ways. I believe you've said before that you prefer the patches you're
> given to have been made against Linus's tree... is that right?

Ordinarily, yes.  But for something like this you should work against the
NFS development tree, not against mainline.  It's pretty unlikely that
Trond would want to preempt already-queued things with new work.  All the
patches in -mm which affect the subsystem trees are already based on those
subsystem trees, because that's how they'll find their way to mainline.


So I'd suggest that you base this work on
git://git.linux-nfs.org/pub/linux/nfs-2.6.git (Trond, please correct me if
that's not appropriate).  If there are a few nfs-related things only in -mm
which conflict with that, I'll sort them out.

> Also, do you yet have a git tree holding your patchset?

Nope - just the releases at
git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git.

> If not, have you
> considered using stacked git (StGIT) to provide one?

The problem is that the -mm patches often don't even apply,
let alone compile, let alone run.  It takes 6-8 hours to get it all
stabilised, fixed and tested and as soon as that window closes it's all
broken again.  If I made that lot available in realtime I don't think it'd
be much use to anyone and would be a net time-waster.

Which is why I encourage developers to develop against mainline.  Except in
this case that's not appropriate - you should develop against the relevant
subsystem tree.

