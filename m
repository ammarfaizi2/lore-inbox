Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129059AbRBNACf>; Tue, 13 Feb 2001 19:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129185AbRBNACZ>; Tue, 13 Feb 2001 19:02:25 -0500
Received: from pat.uio.no ([129.240.130.16]:18144 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S129059AbRBNACN>;
	Tue, 13 Feb 2001 19:02:13 -0500
To: Jakob Østergaard <jakob@unthought.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stale NFS handles on 2.4.1
In-Reply-To: <20010214002750.B11906@unthought.net>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Content-Type: text/plain; charset=US-ASCII
Date: 14 Feb 2001 01:02:05 +0100
In-Reply-To: Jakob Østergaard's message of "Wed, 14 Feb
 2001 00:27:50 +0100"
Message-ID: <shsitme169u.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == stergaard  <Jakob> writes:

     > What happens is that one machine will finish compiling, and
     > another machine will immediately thereafter do a "touch
     > some_output.o". This "touch" sometimes fails with a stale
     > handle message.

Does the appended patch change anything?

Cheers,
  Trond

--- linux-2.4.1/fs/nfs/inode.c.orig	Tue Dec 12 02:46:04 2000
+++ linux-2.4.1/fs/nfs/inode.c	Wed Feb 14 01:00:33 2001
@@ -100,6 +100,7 @@
 	inode->i_rdev = 0;
 	NFS_FILEID(inode) = 0;
 	NFS_FSID(inode) = 0;
+	NFS_FLAGS(inode) = 0;
 	INIT_LIST_HEAD(&inode->u.nfs_i.read);
 	INIT_LIST_HEAD(&inode->u.nfs_i.dirty);
 	INIT_LIST_HEAD(&inode->u.nfs_i.commit);
