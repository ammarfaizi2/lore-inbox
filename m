Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbRBTSNp>; Tue, 20 Feb 2001 13:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129377AbRBTSNf>; Tue, 20 Feb 2001 13:13:35 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:12786 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129227AbRBTSNY>; Tue, 20 Feb 2001 13:13:24 -0500
Date: Tue, 20 Feb 2001 13:12:28 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: <linux-kernel@vger.kernel.org>, <alan@redhat.com>
Subject: Re: [PATCH] make nfsroot accept server addresses from BOOTP root
In-Reply-To: <20010220104415.D3150@opus.bloom.county>
Message-ID: <Pine.LNX.4.30.0102201248290.1614-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, Tom Rini wrote:

> Er, say that again?  Right now, for bootp if you specify "sa=xxx.xxx.xxx.xxx"
> Linux uses that as the host for the NFS server (which does have the side
> effect of if TFTP server != NFS server, you don't boot).  Are you saying
> your patch takes "rp=xxx.xxx.xxx.xxx:/foo/root" ?  Just curious, since I
> don't know, whats the RFC say about this?

Yeah, that's the problem I was trying to work around, mostly because the
docs on dhcpd are sufficiently vague and obscure.  Personally, I don't
actually need tftp support, so I've just configured the system to now
point at the NFS server.  For anyone who cares, the last patch was wrong,
this one is right.

		-ben

diff -ur v2.4.1-ac18/fs/nfs/nfsroot.c work/fs/nfs/nfsroot.c
--- v2.4.1-ac18/fs/nfs/nfsroot.c	Mon Sep 25 16:13:53 2000
+++ work/fs/nfs/nfsroot.c	Tue Feb 20 01:59:32 2001
@@ -226,6 +226,7 @@
 	if (name[0] && strcmp(name, "default")) {
 		strncpy(buf, name, NFS_MAXPATHLEN-1);
 		buf[NFS_MAXPATHLEN-1] = 0;
+		root_nfs_parse_addr(buf);
 	}
 }


