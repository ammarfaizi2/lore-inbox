Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTDHBJI (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 21:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbTDHBJI (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 21:09:08 -0400
Received: from pat.uio.no ([129.240.130.16]:25241 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263759AbTDHBJG (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 21:09:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16018.9178.354140.998203@charged.uio.no>
Date: Tue, 8 Apr 2003 03:20:26 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK] NFS client updates for 2.5.67
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://nfsclient.bkbits.net/linux-2.5

This will update the following files:

 fs/nfs/Makefile           |    3 
 fs/nfs/dir.c              |   23 +
 fs/nfs/file.c             |   27 +
 fs/nfs/idmap.c            |  474 ++++++++++++++++++++++++++++++++++
 fs/nfs/inode.c            |   38 +-
 fs/nfs/nfs4proc.c         |  535 ++++++++++++++++++++++++++-------------
 fs/nfs/nfs4state.c        |  178 +++++++++++-
 fs/nfs/nfs4xdr.c          |  630 ++++++++++++++++++++++++++++++----------------
 include/linux/nfs4.h      |    4 
 include/linux/nfs_fs.h    |   73 ++++-
 include/linux/nfs_fs_sb.h |    1 
 include/linux/nfs_idmap.h |   69 +++++
 include/linux/nfs_xdr.h   |   77 +++++
 net/sunrpc/xprt.c         |   10 
 14 files changed, 1718 insertions(+), 424 deletions(-)

through these ChangeSets:

<marius@citi.umich.edu> (03/04/08 1.1054)
   Add hooks into the NFSv4 XDR code to make use of the new uid/gid
   mapper upcall mechanism.

<marius@citi.umich.edu> (03/04/08 1.1053)
   Add support for mapping NFSv4 remote user/group names into local
   unix-style uid/gids.
   
   Note that this makes use of the RPC client upcall mechanism
   (rpc_pipefs) to notify a userland daemon that does the actual mapping.
   The results are then cached in the kernel.
   The userland daemon can be downloaded from the CITI NFSv4 page at
   
        http://www.citi.umich.edu/projects/nfsv4/

<trond.myklebust@fys.uio.no> (03/04/08 1.1052)
   Make the NFSv4 write code use the stateid if it exists.

<trond.myklebust@fys.uio.no> (03/04/08 1.1051)
   Make NFSv4 'read' code use the cached stateid if it exists.

<trond.myklebust@fys.uio.no> (03/04/08 1.1050)
   Make NFSv4 'setattr()' method use the cached stateid if the file is
   already open.

<trond.myklebust@fys.uio.no> (03/04/08 1.1049)
   Setup code to tear down the NFSv4 state once we're done with a file.

<trond.myklebust@fys.uio.no> (03/04/08 1.1048)
   Implement stateful open() for NFSv4 as per RFC3010-bis.
   The resulting state is saved in the NFS-specific part of the
   struct inode.
   
   Initially we just start with 3 possible states:
     - open for read
     - open for write
     - open for read/write

<trond.myklebust@fys.uio.no> (03/04/08 1.1047)
   Prepare for the introduction of NFSv4 state code.
   
   Split out the open() method for regular files from that of
   directories.

<trond.myklebust@fys.uio.no> (03/04/08 1.1046)
   Remove bogus check on the size of NFSv4 'readdir' cookies.

<trond.myklebust@fys.uio.no> (03/04/08 1.1045)
   Fix a series of NFS read/readdir/readlink errors.
   
   Tightens consistency checks on the process of reading the reply skb in
   the SunRPC client. Reject a reply if we didn't succeed in reading the
   entire skb.

