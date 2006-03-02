Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWCBATY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWCBATY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 19:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWCBATY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 19:19:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27303 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750811AbWCBATX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 19:19:23 -0500
Date: Wed, 1 Mar 2006 16:21:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, steved@redhat.com, trond.myklebust@fys.uio.no,
       aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Permit NFS superblock sharing [try #2]
Message-Id: <20060301162113.774d1745.akpm@osdl.org>
In-Reply-To: <20060301173617.16639.83553.stgit@warthog.cambridge.redhat.com>
References: <20060301173617.16639.83553.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> These patches make it possible to share NFS superblocks between related mounts,
> where "related" means on the same server.

The number of rejects gets into the "I'm not confident it'll work after
this" territory.

Here's Trond's current diff:

 fs/lockd/clntlock.c            |  112 +---
 fs/lockd/clntproc.c            |  328 +++++---------
 fs/lockd/host.c                |   12 
 fs/lockd/mon.c                 |   11 
 fs/lockd/svc4proc.c            |  157 ++----
 fs/lockd/svclock.c             |  287 ++++++------
 fs/lockd/svcproc.c             |  151 ++----
 fs/lockd/svcsubs.c             |    2 
 fs/lockd/xdr.c                 |   17 
 fs/lockd/xdr4.c                |   21 
 fs/locks.c                     |  106 ++--
 fs/namespace.c                 |   38 +
 fs/nfs/callback_xdr.c          |   28 -
 fs/nfs/dir.c                   |  104 +++-
 fs/nfs/direct.c                |  949 +++++++++++++++++++++++------------------
 fs/nfs/file.c                  |   43 +
 fs/nfs/idmap.c                 |   47 +-
 fs/nfs/inode.c                 |  201 ++++++--
 fs/nfs/iostat.h                |  163 +++++++
 fs/nfs/mount_clnt.c            |   17 
 fs/nfs/nfs2xdr.c               |    4 
 fs/nfs/nfs3acl.c               |   16 
 fs/nfs/nfs3proc.c              |  246 +++++-----
 fs/nfs/nfs3xdr.c               |    6 
 fs/nfs/nfs4proc.c              |   96 +---
 fs/nfs/nfs4xdr.c               |    2 
 fs/nfs/pagelist.c              |   10 
 fs/nfs/proc.c                  |  156 ++++--
 fs/nfs/read.c                  |  102 +++-
 fs/nfs/unlink.c                |    3 
 fs/nfs/write.c                 |  152 +++++-
 fs/nfsd/nfs4callback.c         |    2 
 fs/nfsd/nfs4state.c            |   13 
 fs/proc/base.c                 |   39 +
 include/linux/fs.h             |    7 
 include/linux/lockd/lockd.h    |   25 -
 include/linux/lockd/xdr.h      |    1 
 include/linux/nfs_fs.h         |   88 ---
 include/linux/nfs_fs_i.h       |    8 
 include/linux/nfs_fs_sb.h      |    6 
 include/linux/nfs_xdr.h        |    5 
 include/linux/sunrpc/clnt.h    |   19 
 include/linux/sunrpc/metrics.h |   77 +++
 include/linux/sunrpc/sched.h   |    9 
 include/linux/sunrpc/xprt.h    |   13 
 net/sunrpc/auth.c              |   16 
 net/sunrpc/auth_gss/auth_gss.c |    2 
 net/sunrpc/clnt.c              |   18 
 net/sunrpc/pmap_clnt.c         |   41 +
 net/sunrpc/rpc_pipe.c          |    9 
 net/sunrpc/sched.c             |    7 
 net/sunrpc/stats.c             |  115 ++++
 net/sunrpc/xprt.c              |   26 -
 net/sunrpc/xprtsock.c          |   49 ++
 54 files changed, 2518 insertions(+), 1664 deletions(-)

Please work against that.
